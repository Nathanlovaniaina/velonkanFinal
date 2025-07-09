package org.example.repository;

import java.time.LocalDate;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.stereotype.Repository;

@Repository
public class SuiviDepensesRepository {

    @PersistenceContext
    private EntityManager entityManager;

    @SuppressWarnings("unchecked")
    public List<Object[]> getDepensesParComposant(LocalDate startDate, LocalDate endDate, 
                                              Long categorieId, Long composantId) {
        StringBuilder sql = new StringBuilder("""
            SELECT 
                c.id AS id_composant,
                c.nom AS composant,
                tc.nom AS categorie,
                u.nom AS unite,
                u.symbol AS symbole_unite,
                SUM(ms.quantite) AS quantite_totale,
                SUM(ms.quantite * ms.prix_unitaire) AS montant_total,
                ROUND(AVG(ms.prix_unitaire), 2) AS prix_moyen_unitaire
            FROM 
                mvt_stock ms
            JOIN 
                stock s ON ms.id_stock = s.id
            JOIN 
                composant c ON s.id_composant = c.id
            JOIN 
                type_composant tc ON c.id_type = tc.id
            JOIN 
                unite u ON c.id_unite = u.id
            WHERE 
                ms.type_mvt = 0
                AND ms.date_mvt BETWEEN :startDate AND :endDate
                AND ms.prix_unitaire > 0
        """);

        // Filtres optionnels
        if (categorieId != null) {
            sql.append(" AND tc.id = :categorieId");
        }
        if (composantId != null) {
            sql.append(" AND c.id = :composantId");
        }

        // Group by et order by
        sql.append("""
            GROUP BY 
                c.id, c.nom, tc.nom, u.nom, u.symbol
            ORDER BY 
                montant_total DESC
        """);

        var query = entityManager.createNativeQuery(sql.toString());
        query.setParameter("startDate", startDate);
        query.setParameter("endDate", endDate);

        if (categorieId != null) {
            query.setParameter("categorieId", categorieId);
        }
        if (composantId != null) {
            query.setParameter("composantId", composantId);
        }

        return query.getResultList();
    }

    @SuppressWarnings("unchecked")
    public List<Object[]> getEvolutionDepensesMensuelles(LocalDate startDate, LocalDate endDate) {
        String sql = """
            SELECT 
                EXTRACT(YEAR FROM ms.date_mvt) AS annee,
                EXTRACT(MONTH FROM ms.date_mvt) AS mois,
                SUM(ms.quantite * ms.prix_unitaire) AS depenses_mensuelles,
                LAG(SUM(ms.quantite * ms.prix_unitaire)) OVER (ORDER BY EXTRACT(YEAR FROM ms.date_mvt), EXTRACT(MONTH FROM ms.date_mvt)) AS depenses_mois_precedent,
                ROUND((SUM(ms.quantite * ms.prix_unitaire) - LAG(SUM(ms.quantite * ms.prix_unitaire)) OVER (ORDER BY EXTRACT(YEAR FROM ms.date_mvt), EXTRACT(MONTH FROM ms.date_mvt))) / 
                      NULLIF(LAG(SUM(ms.quantite * ms.prix_unitaire)) OVER (ORDER BY EXTRACT(YEAR FROM ms.date_mvt), EXTRACT(MONTH FROM ms.date_mvt)), 0) * 100, 2) AS evolution_pct
            FROM 
                mvt_stock ms
            JOIN
                stock s ON ms.id_stock = s.id
            WHERE 
                ms.type_mvt = 0
                AND ms.date_mvt BETWEEN :startDate AND :endDate
            GROUP BY 
                annee, mois
            ORDER BY 
                annee, mois
        """;
    
        var query = entityManager.createNativeQuery(sql);
        query.setParameter("startDate", startDate);
        query.setParameter("endDate", endDate);
    
        return query.getResultList();
    }

    @SuppressWarnings("unchecked")
    public List<Object[]> getTopComposantsPlusCouteux(LocalDate startDate, LocalDate endDate, int limit) {
        String sql = """
            SELECT 
                c.nom AS composant,
                SUM(ms.quantite * ms.prix_unitaire) AS montant_total,
                SUM(ms.quantite) AS quantite_totale,
                ROUND(SUM(ms.quantite * ms.prix_unitaire) / SUM(ms.quantite), 2) AS prix_moyen
            FROM 
                mvt_stock ms
            JOIN 
                stock s ON ms.id_stock = s.id
            JOIN 
                composant c ON s.id_composant = c.id
            WHERE 
                ms.type_mvt = 0
                AND ms.date_mvt BETWEEN :startDate AND :endDate
            GROUP BY 
                c.nom
            ORDER BY 
                montant_total DESC
            LIMIT :limit
        """;
    
        var query = entityManager.createNativeQuery(sql);
        query.setParameter("startDate", startDate);
        query.setParameter("endDate", endDate);
        query.setParameter("limit", limit);
    
        return query.getResultList();
    }

    @SuppressWarnings("unchecked")
    public List<Object[]> getDepensesParCategorie(LocalDate startDate, LocalDate endDate) {
        String sql = """
            SELECT 
                tc.nom AS categorie,
                SUM(ms.quantite * ms.prix_unitaire) AS montant_total,
                COUNT(DISTINCT c.id) AS nombre_composants
            FROM 
                mvt_stock ms
            JOIN 
                stock s ON ms.id_stock = s.id
            JOIN 
                composant c ON s.id_composant = c.id
            JOIN 
                type_composant tc ON c.id_type = tc.id
            WHERE 
                ms.type_mvt = 0
                AND ms.date_mvt BETWEEN :startDate AND :endDate
            GROUP BY 
                tc.nom
            ORDER BY 
                montant_total DESC
        """;
    
        var query = entityManager.createNativeQuery(sql);
        query.setParameter("startDate", startDate);
        query.setParameter("endDate", endDate);
    
        return query.getResultList();
    }

    @SuppressWarnings("unchecked")
    public List<Object[]> getComparaisonConsommation(LocalDate dateDebut, LocalDate dateFin) {
        String sql = """
            WITH consommation_theorique AS (
                SELECT 
                    dp.id_composant,
                    SUM(dc.quantite * dp.quantite) AS quantite_theorique
                FROM 
                    commandes cmd
                JOIN detail_commande dc ON cmd.id = dc.id_commande
                JOIN details_plat dp ON dc.id_plat = dp.id_plat
                WHERE 
                    cmd.date_heure_prevue BETWEEN :dateDebut AND :dateFin
                GROUP BY 
                    dp.id_composant
            ),
            consommation_reelle AS (
                SELECT 
                    s.id_composant,
                    SUM(ms.quantite) AS quantite_reelle
                FROM 
                    mvt_stock ms
                JOIN
                    stock s ON ms.id_stock = s.id
                WHERE 
                    ms.type_mvt = 1
                    AND ms.date_mvt BETWEEN :dateDebut AND :dateFin
                GROUP BY 
                    s.id_composant
            )
            SELECT 
                c.id,
                c.nom AS composant,
                u.nom AS unite,
                u.symbol AS symbole_unite,
                COALESCE(ct.quantite_theorique, 0) AS quantite_theorique,
                COALESCE(cr.quantite_reelle, 0) AS quantite_reelle,
                COALESCE(ct.quantite_theorique, 0) - COALESCE(cr.quantite_reelle, 0) AS difference,
                CASE 
                    WHEN COALESCE(ct.quantite_theorique, 0) = 0 THEN NULL
                    ELSE ROUND((COALESCE(cr.quantite_reelle, 0) / COALESCE(ct.quantite_theorique, 0)) * 100, 2)
                END AS pourcentage_ecart
            FROM 
                composant c
            JOIN unite u ON c.id_unite = u.id
            LEFT JOIN consommation_theorique ct ON c.id = ct.id_composant
            LEFT JOIN consommation_reelle cr ON c.id = cr.id_composant
            ORDER BY 
                ABS(COALESCE(ct.quantite_theorique, 0) - COALESCE(cr.quantite_reelle, 0)) DESC
        """;

        var query = entityManager.createNativeQuery(sql);
        query.setParameter("dateDebut", dateDebut);
        query.setParameter("dateFin", dateFin);

        return query.getResultList();
    }
}
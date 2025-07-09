package org.example.repository;

import java.time.LocalDate;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.stereotype.Repository;

@Repository
public class SuiviRecetteRepository {

    @PersistenceContext
    private EntityManager entityManager;

    @SuppressWarnings("unchecked")
    public List<Object[]> getRevenuMensuelParAnnee(LocalDate startDate, LocalDate endDate, 
                                              Long entrepriseId, Long platId) {
        StringBuilder sql = new StringBuilder("""
            SELECT 
                EXTRACT(MONTH FROM f.date_emission) AS mois,
                EXTRACT(YEAR FROM f.date_emission) AS annee,
                SUM(f.montant_total) AS revenu_mensuel,
                COUNT(DISTINCT f.id) AS nombre_factures
            FROM 
                facture f
            JOIN 
                commandes c ON c.id = f.id_commandes
            WHERE 
                f.date_emission BETWEEN :startDate AND :endDate
                AND f.statut = 'Paye'
        """);

        if (entrepriseId != null) {
            sql.append(" AND f.id_entreprise = :entrepriseId");
        }
        if (platId != null) {
            sql.append("""
                AND EXISTS (
                    SELECT 1 FROM detail_commande dc 
                    WHERE dc.id_commande = c.id 
                    AND dc.id_plat = :platId
                )
            """);
        }

        sql.append("""
            GROUP BY 
                mois, annee
            ORDER BY 
                annee, mois
        """);

        javax.persistence.Query query = entityManager.createNativeQuery(sql.toString());
        query.setParameter("startDate", startDate);
        query.setParameter("endDate", endDate);

        if (entrepriseId != null) {
            query.setParameter("entrepriseId", entrepriseId);
        }
        if (platId != null) {
            query.setParameter("platId", platId);
        }

        return query.getResultList();
    }

    @SuppressWarnings("unchecked")
    public List<Object[]> getRevenuParEntreprise(LocalDate startDate, LocalDate endDate) {
        String sql = """
            SELECT 
                e.nom AS entreprise,
                SUM(f.montant_total) AS revenu_entreprise,
                COUNT(DISTINCT f.id_commandes) AS nombre_total_commandes,
                (
                    SELECT SUM(dc.quantite) 
                    FROM detail_commande dc 
                    JOIN commandes cmd ON dc.id_commande = cmd.id
                    JOIN facture fact ON cmd.id = fact.id_commandes
                    WHERE fact.id_entreprise = e.id
                    AND fact.date_emission BETWEEN :startDate AND :endDate
                    AND fact.statut = 'Paye'
                ) AS nombre_total_plats
            FROM 
                facture f
            JOIN 
                entreprise e ON f.id_entreprise = e.id
            WHERE 
                f.date_emission BETWEEN :startDate AND :endDate
                AND f.statut = 'Paye'
            GROUP BY 
                e.id, e.nom
            ORDER BY 
                revenu_entreprise DESC
        """;

        javax.persistence.Query query = entityManager.createNativeQuery(sql);
        query.setParameter("startDate", startDate);
        query.setParameter("endDate", endDate);

        return query.getResultList();
    }

    @SuppressWarnings("unchecked")
    public List<Object[]> getRevenuJournalierEtEvolution(LocalDate startDate, LocalDate endDate) {
        String sql = """
            SELECT 
                date_emission,
                revenu_journalier,
                LAG(revenu_journalier) OVER (ORDER BY date_emission) AS revenu_veille,
                (revenu_journalier - LAG(revenu_journalier) OVER (ORDER BY date_emission)) AS evolution
            FROM (
                SELECT 
                    f.date_emission,
                    SUM(f.montant_total) AS revenu_journalier
                FROM 
                    facture f
                WHERE 
                    f.date_emission BETWEEN :startDate AND :endDate
                    AND f.statut = 'Paye'
                GROUP BY 
                    f.date_emission
            ) AS journalier
            ORDER BY 
                date_emission
        """;
    
        javax.persistence.Query query = entityManager.createNativeQuery(sql);
        query.setParameter("startDate", startDate);
        query.setParameter("endDate", endDate);
    
        return query.getResultList();
    }

    @SuppressWarnings("unchecked")
    public List<Object[]> getFacturesEnRetard(LocalDate startDate, LocalDate endDate) {
        String sql = """
            SELECT 
                f.id AS id_facture,
                e.nom AS entreprise,
                f.montant_total,
                f.date_emission,
                CASE
                    WHEN f.date_paiement IS NULL THEN CURRENT_DATE - f.date_emission
                    ELSE f.date_paiement - f.date_emission
                END AS jours_retard
            FROM 
                facture f
            JOIN 
                entreprise e ON f.id_entreprise = e.id
            WHERE 
                (f.statut = 'En retard' OR f.statut = 'En attente')
                AND f.date_emission BETWEEN :startDate AND :endDate
            ORDER BY 
                jours_retard DESC
        """;
    
        javax.persistence.Query query = entityManager.createNativeQuery(sql);
        query.setParameter("startDate", startDate);
        query.setParameter("endDate", endDate);
    
        return query.getResultList();
    }
}
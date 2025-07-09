package org.example.repository;

import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import java.time.LocalDate;
import java.util.List;

@Repository
public class SuiviBeneficesRepository {

    @PersistenceContext
    private EntityManager entityManager;

    // 1. Revenu total sur une période
    @SuppressWarnings("unchecked")
    public List<Object[]> getRevenuTotal(LocalDate startDate, LocalDate endDate) {
        String sql = """
            SELECT 
                SUM(dc.quantite * dc.prix_unitaire) AS revenu_total
            FROM 
                detail_commande dc
            JOIN commandes c ON dc.id_commande = c.id
            WHERE 
                c.date_heure_prevue BETWEEN :startDate AND :endDate
        """;
        var query = entityManager.createNativeQuery(sql);
        query.setParameter("startDate", startDate);
        query.setParameter("endDate", endDate);
        return query.getResultList();
    }

    // 2. Coût total des plats vendus
    @SuppressWarnings("unchecked")
    public List<Object[]> getCoutTotal(LocalDate startDate, LocalDate endDate) {
        String sql = """
            SELECT 
                SUM(dc.quantite * dp.quantite * ms.prix_unitaire) AS cout_total
            FROM 
                detail_commande dc
            JOIN details_plat dp ON dc.id_plat = dp.id_plat
            JOIN stock s ON s.id_composant = dp.id_composant
            JOIN mvt_stock ms ON ms.id_stock = s.id
            JOIN commandes c ON dc.id_commande = c.id
            WHERE 
                c.date_heure_prevue BETWEEN :startDate AND :endDate
                AND ms.date_mvt = (
                    SELECT MAX(ms2.date_mvt)
                    FROM mvt_stock ms2
                    JOIN stock s2 ON ms2.id_stock = s2.id
                    WHERE s2.id_composant = s.id_composant
                      AND ms2.date_mvt <= c.date_heure_prevue
                )
        """;
        var query = entityManager.createNativeQuery(sql);
        query.setParameter("startDate", startDate);
        query.setParameter("endDate", endDate);
        return query.getResultList();
    }

    // 3. Bénéfice net sur une période
    @SuppressWarnings("unchecked")
    public List<Object[]> getBeneficeNet(LocalDate startDate, LocalDate endDate) {
        String sql = """
            WITH revenu AS (
                SELECT SUM(dc.quantite * dc.prix_unitaire) AS total_revenu
                FROM detail_commande dc
                JOIN commandes c ON dc.id_commande = c.id
                WHERE c.date_heure_prevue BETWEEN :startDate AND :endDate
            ),
            cout AS (
                SELECT SUM(dc.quantite * dp.quantite * ms.prix_unitaire) AS total_cout
                FROM detail_commande dc
                JOIN details_plat dp ON dc.id_plat = dp.id_plat
                JOIN stock s ON s.id_composant = dp.id_composant
                JOIN mvt_stock ms ON ms.id_stock = s.id
                JOIN commandes c ON dc.id_commande = c.id
                WHERE c.date_heure_prevue BETWEEN :startDate AND :endDate
                AND ms.date_mvt = (
                    SELECT MAX(ms2.date_mvt)
                    FROM mvt_stock ms2
                    JOIN stock s2 ON ms2.id_stock = s2.id
                    WHERE s2.id_composant = s.id_composant
                      AND ms2.date_mvt <= c.date_heure_prevue
                )
            )
            SELECT 
                total_revenu,
                total_cout,
                total_revenu - total_cout AS benefice_net
            FROM revenu, cout
        """;
        var query = entityManager.createNativeQuery(sql);
        query.setParameter("startDate", startDate);
        query.setParameter("endDate", endDate);
        return query.getResultList();
    }

    // 4. Revenus par entreprise
    @SuppressWarnings("unchecked")
    public List<Object[]> getRevenusParEntreprise(LocalDate startDate, LocalDate endDate) {
        String sql = """
            SELECT 
                e.nom AS entreprise,
                SUM(dc.quantite * dc.prix_unitaire) AS revenu
            FROM 
                commandes c
            JOIN entreprise e ON c.id_entreprise = e.id
            JOIN detail_commande dc ON c.id = dc.id_commande
            WHERE 
                c.date_heure_prevue BETWEEN :startDate AND :endDate
            GROUP BY e.nom
            ORDER BY revenu DESC
        """;
        var query = entityManager.createNativeQuery(sql);
        query.setParameter("startDate", startDate);
        query.setParameter("endDate", endDate);
        return query.getResultList();
    }

    // 5. Bénéfice par plat
    @SuppressWarnings("unchecked")
    public List<Object[]> getBeneficesParPlat(LocalDate startDate, LocalDate endDate) {
        String sql = """
            SELECT 
                p.intitule,
                SUM(dc.quantite) AS total_vendus,
                SUM(dc.quantite * dc.prix_unitaire) AS revenu_total,
                SUM(dc.quantite * dp.quantite * ms.prix_unitaire) AS cout_total,
                SUM(dc.quantite * dc.prix_unitaire) - SUM(dc.quantite * dp.quantite * ms.prix_unitaire) AS benefice
            FROM 
                detail_commande dc
            JOIN plat p ON p.id = dc.id_plat
            JOIN details_plat dp ON dp.id_plat = p.id
            JOIN stock s ON s.id_composant = dp.id_composant
            JOIN mvt_stock ms ON ms.id_stock = s.id
            JOIN commandes c ON dc.id_commande = c.id
            WHERE 
                c.date_heure_prevue BETWEEN :startDate AND :endDate
                AND ms.date_mvt = (
                    SELECT MAX(ms2.date_mvt)
                    FROM mvt_stock ms2
                    JOIN stock s2 ON ms2.id_stock = s2.id
                    WHERE s2.id_composant = s.id_composant
                      AND ms2.date_mvt <= c.date_heure_prevue
                )
            GROUP BY p.intitule
            ORDER BY benefice DESC
        """;
        var query = entityManager.createNativeQuery(sql);
        query.setParameter("startDate", startDate);
        query.setParameter("endDate", endDate);
        return query.getResultList();
    }

    // 6. Salaire total versé
    @SuppressWarnings("unchecked")
    public List<Object[]> getSalairesVerses(LocalDate startDate, LocalDate endDate) {
        String sql = """
            SELECT 
                SUM(somme) AS total_salaire
            FROM 
                paiement_salaire
            WHERE 
                date_paie BETWEEN :startDate AND :endDate
        """;
        var query = entityManager.createNativeQuery(sql);
        query.setParameter("startDate", startDate);
        query.setParameter("endDate", endDate);
        return query.getResultList();
    }

    // 7. Répartition journalière revenu/cout/benefice
    @SuppressWarnings("unchecked")
    public List<Object[]> getBilanJournalier(LocalDate startDate, LocalDate endDate) {
        String sql = """
            SELECT 
                DATE(c.date_heure_prevue) AS jour,
                SUM(dc.quantite * dc.prix_unitaire) AS revenu_journalier,
                SUM(dc.quantite * dp.quantite * ms.prix_unitaire) AS cout_journalier,
                SUM(dc.quantite * dc.prix_unitaire) - SUM(dc.quantite * dp.quantite * ms.prix_unitaire) AS benefice_journalier
            FROM 
                detail_commande dc
            JOIN commandes c ON dc.id_commande = c.id
            JOIN details_plat dp ON dc.id_plat = dp.id_plat
            JOIN stock s ON s.id_composant = dp.id_composant
            JOIN mvt_stock ms ON ms.id_stock = s.id
            WHERE 
                c.date_heure_prevue BETWEEN :startDate AND :endDate
                AND ms.date_mvt = (
                    SELECT MAX(ms2.date_mvt)
                    FROM mvt_stock ms2
                    JOIN stock s2 ON ms2.id_stock = s2.id
                    WHERE s2.id_composant = s.id_composant
                      AND ms2.date_mvt <= c.date_heure_prevue
                )
            GROUP BY jour
            ORDER BY jour
        """;
        var query = entityManager.createNativeQuery(sql);
        query.setParameter("startDate", startDate);
        query.setParameter("endDate", endDate);
        return query.getResultList();
    }
}
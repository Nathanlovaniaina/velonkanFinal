package org.example.repository;

import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

@Repository
public class CommandeRepositoryScript {

    @PersistenceContext
    private EntityManager entityManager;

    @Transactional
    public Long creerCommandeComplete(Long idEntreprise, LocalDateTime dateLivraison, 
                                    List<Map<String, String>> platsCommandes, 
                                    String commentaires, int prixTotal) {
        
        // 1. Insertion de la commande principale
        String insertCommande = """
            INSERT INTO commandes (id_entreprise, prix_total, date_heure_prevue)
            VALUES (:idEntreprise, :prixTotal, :dateHeurePrevue)
            RETURNING id
        """;
        
        Number result = (Number) entityManager.createNativeQuery(insertCommande)
            .setParameter("idEntreprise", idEntreprise)
            .setParameter("prixTotal", prixTotal)
            .setParameter("dateHeurePrevue", dateLivraison)
            .getSingleResult();
        Long commandeId = result.longValue();

        // 2. Insertion des détails de commande pour chaque plat
        String insertDetail = """
            INSERT INTO detail_commande (id_commande, id_plat, quantite, prix_unitaire)
            VALUES (:idCommande, :idPlat, :quantite, 
                   (SELECT prix FROM plat WHERE id = :idPlat))
        """;
        
        for (Map<String, String> plat : platsCommandes) {
            String idStr = plat.get("id");
            String quantiteStr = plat.get("quantite");
            if (idStr == null || idStr.isEmpty() || quantiteStr == null || quantiteStr.isEmpty()) {
                continue; // Ignore ce plat invalide
            }
            entityManager.createNativeQuery(insertDetail)
                .setParameter("idCommande", commandeId)
                .setParameter("idPlat", Long.parseLong(idStr))
                .setParameter("quantite", Integer.parseInt(quantiteStr))
                .executeUpdate();
        }

        // 3. Insertion du statut initial "Prêt"
        String insertStatut = """
            INSERT INTO mvt_statut_livraison_commande (id_commande, id_statut, date_heure_modification)
            VALUES (:idCommande, 1, NOW())
        """;
        
        entityManager.createNativeQuery(insertStatut)
            .setParameter("idCommande", commandeId)
            .executeUpdate();

        // 4. Insertion de la facture
        String insertFacture = """
            INSERT INTO facture (id_commandes, id_entreprise, date_emission, montant_total, statut)
            VALUES (:idCommandes, :idEntreprise, CURRENT_DATE, :montantTotal, 'En attente')
        """;
        
        entityManager.createNativeQuery(insertFacture)
            .setParameter("idCommandes", commandeId)
            .setParameter("idEntreprise", idEntreprise)
            .setParameter("montantTotal", prixTotal)
            .executeUpdate();


        return commandeId;
    }

}
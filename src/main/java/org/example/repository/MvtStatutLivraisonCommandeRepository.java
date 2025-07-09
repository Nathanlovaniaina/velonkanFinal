package org.example.repository;

import java.util.Optional;

import org.example.entity.MvtStatutLivraisonCommande;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;


@Repository
public interface MvtStatutLivraisonCommandeRepository extends JpaRepository<MvtStatutLivraisonCommande, Integer> {
    @Query("SELECT m.statut FROM MvtStatutLivraisonCommande m " +
       "WHERE m.commande.id = :idCommande " +
       "ORDER BY m.dateHeureModification DESC")
    Optional<Integer> findDernierStatutByCommandeId(@Param("idCommande") int idCommande);

}

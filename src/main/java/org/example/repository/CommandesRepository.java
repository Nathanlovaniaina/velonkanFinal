    
package org.example.repository;

import org.example.entity.Commandes;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Date;
import java.util.List;
import java.util.Optional;

public interface CommandesRepository extends JpaRepository<Commandes, Integer> {
    @Query("SELECT c FROM Commandes c JOIN FETCH c.entreprise LEFT JOIN FETCH c.details d JOIN FETCH d.plat")
    List<Commandes> findAllWithDetails();

    @Query("SELECT c FROM Commandes c JOIN FETCH c.entreprise LEFT JOIN FETCH c.details d JOIN FETCH d.plat WHERE c.dateHeurePrevue BETWEEN :dateDebut AND :dateFin")
    List<Commandes> findByDateRange(@Param("dateDebut") Date dateDebut, @Param("dateFin") Date dateFin);

    @Query("SELECT c FROM Commandes c JOIN FETCH c.entreprise LEFT JOIN FETCH c.details d JOIN FETCH d.plat WHERE c.id = :id")
    Optional<Commandes> findByIdWithDetails(@Param("id") Integer id);

    @Query("SELECT COALESCE(SUM(dc.quantite), 0) FROM DetailCommande dc")
    Integer getTotalPortions();

    @Query("SELECT COALESCE(SUM(dc.quantite), 0) FROM DetailCommande dc JOIN dc.commande c WHERE c.dateHeurePrevue BETWEEN :dateDebut AND :dateFin")
    Integer getTotalPortionsByDateRange(@Param("dateDebut") Date dateDebut, @Param("dateFin") Date dateFin);
}
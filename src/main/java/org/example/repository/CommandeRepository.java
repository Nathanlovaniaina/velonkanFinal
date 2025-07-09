package org.example.repository;

import org.example.entity.Commande;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

public interface CommandeRepository extends JpaRepository<Commande, Integer> {
    @Query("SELECT COUNT(c) FROM Commande c WHERE c.dateHeurePrevue IS NOT NULL AND DATE(c.dateHeurePrevue) = :date")
    long countByDate(@Param("date") LocalDate date);

   @Query(value = """
    SELECT DATE(date_heure_prevue) AS order_date, COUNT(*) AS nombre_commandes
    FROM commandes
    WHERE date_heure_prevue IS NOT NULL 
      AND DATE(date_heure_prevue) BETWEEN :startDate AND :endDate
    GROUP BY DATE(date_heure_prevue)
    ORDER BY order_date
    """, nativeQuery = true)
    List<Object[]> countByDateRange(@Param("startDate") LocalDate startDate, @Param("endDate") LocalDate endDate);

    @Query("SELECT DISTINCT c FROM Commande c " +
       "LEFT JOIN FETCH c.details d " +  
       "LEFT JOIN FETCH d.plat p " +    
       "LEFT JOIN FETCH c.entreprise " +
       "WHERE c.dateHeurePrevue BETWEEN :start AND :end " +
       "ORDER BY c.dateHeurePrevue")
List<Commande> findByDateRangeWithDetailsAndPlats(@Param("start") LocalDateTime start,@Param("end") LocalDateTime end);
}
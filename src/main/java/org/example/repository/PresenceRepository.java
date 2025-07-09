package org.example.repository;

import java.time.LocalDate;
import java.util.List;

import org.example.entity.Presence;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface PresenceRepository extends JpaRepository<Presence, Integer> {

   @Query("SELECT COUNT(p) FROM Presence p WHERE p.employe.id = :idEmp AND FUNCTION('EXTRACT', YEAR FROM p.datePres) = :annee AND FUNCTION('EXTRACT', MONTH FROM p.datePres) = :mois")
    Integer getNbJoursPresence(@Param("idEmp") Integer idEmp, @Param("mois") int mois, @Param("annee") int annee);

    // Dans PresenceRepository.java
@Query("SELECT p FROM Presence p WHERE p.datePres = :date")
List<Presence> findByDatePresence(@Param("date") LocalDate date);

    //@Query("SELECT p FROM Presence p JOIN FETCH p.employe")
    //List<Presence> findAllWithEmploye();

    @Query(" SELECT p FROM Presence p JOIN FETCH p.employe e JOIN FETCH e.poste")
    List<Presence> findAllWithEmployeWithPoste();

}

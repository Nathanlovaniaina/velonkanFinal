package org.example.repository;

import org.example.entity.Employe;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.data.jpa.repository.JpaRepository;

public interface EmployeRepository extends JpaRepository<Employe, Integer> {
    // Méthodes pour obtenir le salaire d'un Employe
    @Query("SELECT e.poste.salaire FROM Employe e WHERE e.id = :id")
    Double getSalaireBrut(@Param("id") Integer id);

}

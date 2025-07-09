package org.example.repository;

import org.example.entity.Plat;

import java.time.LocalDate;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

// import java.util.Optional;  // <-- Manquait cet import

public interface PlatRepository extends JpaRepository<Plat, Integer> {
   List<Plat> findByIntitule(String intitule); // liste au lieu d'Optional/unique
   @Query("SELECT DISTINCT p FROM Plat p LEFT JOIN FETCH p.compositions dp JOIN FETCH dp.composant c JOIN FETCH c.unite")
    List<Plat> findAllWithCompositions();

    @Query("SELECT DISTINCT p FROM Plat p LEFT JOIN FETCH p.compositions dp JOIN FETCH dp.composant c JOIN FETCH c.unite WHERE p.dateCreation >= :date")
    List<Plat> findByDateCreationGreaterThanEqualWithCompositions(@Param("date") LocalDate date);

    @Query("SELECT p FROM Plat p LEFT JOIN FETCH p.compositions dp JOIN FETCH dp.composant c JOIN FETCH c.unite WHERE p.id = :id")
    Plat findByIdWithCompositions(@Param("id") Integer id);
}

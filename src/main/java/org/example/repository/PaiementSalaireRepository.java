package org.example.repository;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.data.jpa.repository.JpaRepository;
import org.example.entity.PaiementSalaire;

public interface PaiementSalaireRepository extends JpaRepository<PaiementSalaire, Integer> {

    @Query(value = """
        SELECT COALESCE(SUM(somme), 0)
        FROM paiement_salaire
        WHERE id_emp = :id
          AND EXTRACT(YEAR FROM date_paie) = :annee
          AND EXTRACT(MONTH FROM date_paie) = :mois
        """, nativeQuery = true)
    Double getTotalSalairePaye(@Param("id") Integer id, @Param("mois") int mois, @Param("annee") int annee);
}

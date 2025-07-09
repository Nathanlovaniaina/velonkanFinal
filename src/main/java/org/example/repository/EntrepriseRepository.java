package org.example.repository;

import org.example.entity.Entreprise;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.Optional;

public interface EntrepriseRepository extends JpaRepository<Entreprise, Integer> {
    Optional<Entreprise> findByNom(String nom);
}
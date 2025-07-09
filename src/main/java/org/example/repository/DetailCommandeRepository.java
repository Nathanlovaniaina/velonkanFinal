package org.example.repository;

import org.example.entity.DetailCommande;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface DetailCommandeRepository extends JpaRepository<DetailCommande, Integer> {
    List<DetailCommande> findByCommandeId(Integer commandeId);
}
package org.example.repository;

import org.example.entity.Tache;
import org.springframework.data.jpa.repository.JpaRepository;

public interface TacheRepository extends JpaRepository<Tache, Integer> {
    
}
package org.example.repository;

import org.example.entity.Poste;
import org.springframework.data.jpa.repository.JpaRepository;

public interface PosteRepository extends JpaRepository<Poste, Integer> {
}

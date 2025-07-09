package org.example.repository;

import org.example.entity.TachePlat;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface TachePlatRepository extends JpaRepository<TachePlat, Integer> {
    List<TachePlat> findByPlatId(Integer platId);
} 

package org.example.repository;

import org.example.entity.DetailsPlat;
import org.example.entity.Plat;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface DetailsPlatRepository extends JpaRepository<DetailsPlat, Integer> {
    List<DetailsPlat> findByPlatId(Integer platId);
    List<DetailsPlat> findByPlat(Plat plat);

}

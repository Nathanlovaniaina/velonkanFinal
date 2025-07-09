package org.example.repository;

import org.example.entity.DistributionTache;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface DistributionTacheRepository extends JpaRepository<DistributionTache, Integer> {

    Optional<DistributionTache> findByTachePlatId(Integer idTachePlat);
}

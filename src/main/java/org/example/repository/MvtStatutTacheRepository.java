package org.example.repository;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

import org.example.entity.MvtStatutTache;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

@Repository
public interface MvtStatutTacheRepository extends JpaRepository<MvtStatutTache, Integer> {

    @Query("""
        SELECT m
        FROM MvtStatutTache m
        JOIN m.distributionTache dt
        JOIN dt.tachePlat tp
        WHERE tp.plat.id = :platId
    """)
    List<MvtStatutTache> findAllByPlatId(@Param("platId") Integer platId);

    @Query("""
        SELECT m 
        FROM MvtStatutTache m
        WHERE m.distributionTache.tachePlat.id = :idTachePlat
          AND m.distributionTache.dateTache = :date
    """)
    List<MvtStatutTache> findAllByTachePlatIdAndDate(@Param("idTachePlat") Integer idTachePlat,@Param("date") LocalDate date);

}

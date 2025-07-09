package org.example.repository;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.Date;
import java.util.List;

import org.example.entity.MvtStock;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface MvtStockRepository extends JpaRepository<MvtStock, Long> {
    List<MvtStock> findByStockId(Long stockId);

    @Query("SELECT SUM(m.quantite) FROM MvtStock m WHERE m.stock.id = :stockId AND m.typeMvt = 1")
    BigDecimal totalEntree(Long stockId);

    @Query("SELECT SUM(m.quantite) FROM MvtStock m WHERE m.stock.id = :stockId AND m.typeMvt = 0")
    BigDecimal totalSortie(Long stockId);

    List<MvtStock> findByTypeMvt(Integer typeMvt);

    List<MvtStock> findByDateMvtBetween(LocalDate start, LocalDate end);

    List<MvtStock> findByTypeMvtAndDateMvtBetween(Integer typeMvt, LocalDate start, LocalDate end);

    @Query("SELECT m FROM MvtStock m WHERE m.stock.composant.id = :composantId")
    List<MvtStock> findByComposantId(@Param("composantId") Integer composantId);
}

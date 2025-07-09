package org.example.service;

import org.example.entity.MvtStock;
import org.example.entity.Stock;
import org.example.repository.MvtStockRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.Date;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class MvtStockService {

    @Autowired
    private MvtStockRepository mvtStockRepository;

    public List<MvtStock> findAll() {
        return mvtStockRepository.findAll();
    }

    public List<MvtStock> findByType(Integer typeMvt) {
        if (typeMvt == null) return findAll();
        return mvtStockRepository.findByTypeMvt(typeMvt);
    }

    public Optional<MvtStock> findById(Long stockId) {
        return mvtStockRepository.findById(stockId);
    }

    public MvtStock save(MvtStock mvt) {
        return mvtStockRepository.save(mvt);
    }

    public void deleteById(Long id) {
        mvtStockRepository.deleteById(id);
    }

    public BigDecimal calculStockActuel(Long stockId) {
        BigDecimal entrees = mvtStockRepository.totalEntree(stockId);
        BigDecimal sorties = mvtStockRepository.totalSortie(stockId);

        if (entrees == null) entrees = BigDecimal.ZERO;
        if (sorties == null) sorties = BigDecimal.ZERO;

        return entrees.subtract(sorties);
    }

    public List<MvtStock> findByDates(LocalDate debut, LocalDate fin) {
    if (debut == null || fin == null) { 
        return mvtStockRepository.findAll();
    }
    return mvtStockRepository.findByDateMvtBetween(debut, fin);
    }

    public List<MvtStock> findByTypeAndDates(Integer type, LocalDate debut, LocalDate fin) {
    if (type == null) return findByDates(debut, fin);
    if (debut == null || fin == null) return mvtStockRepository.findByTypeMvt(type);
    return mvtStockRepository.findByTypeMvtAndDateMvtBetween(type, debut, fin);
    }

    public List<MvtStock> findRecentByComposantId(Integer composantId) {
        // Récupère tous les mouvements pour ce composant
        List<MvtStock> mouvements = mvtStockRepository.findByComposantId(composantId);
        
        // Filtre pour ne garder que les entrées (type_mvt = 1) avec date de péremption
        return mouvements.stream()
                .filter(mvt -> mvt.getTypeMvt() == 1 && mvt.getDatePeremption() != null)
                .sorted((m1, m2) -> {
                    // Trie par date de péremption croissante (les plus proches en premier)
                    if (m1.getDatePeremption() == null && m2.getDatePeremption() == null) return 0;
                    if (m1.getDatePeremption() == null) return 1;
                    if (m2.getDatePeremption() == null) return -1;
                    return m1.getDatePeremption().compareTo(m2.getDatePeremption());
                })
                .collect(Collectors.toList());
    }

    
}

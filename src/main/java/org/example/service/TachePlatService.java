package org.example.service;

import org.example.entity.MvtStatutTache;
import org.example.entity.TachePlat;
import org.example.repository.MvtStatutTacheRepository;
import org.example.repository.TachePlatRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestParam;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Service
public class TachePlatService {

    private final TachePlatRepository tachePlatRepository;
    private final MvtStatutTacheRepository mvtStatutTacheRepository;

    public TachePlatService(MvtStatutTacheRepository mvtStatutTacheRepository, TachePlatRepository tachePlatRepository) {
        this.mvtStatutTacheRepository = mvtStatutTacheRepository;
        this.tachePlatRepository=tachePlatRepository;
    }

    public TachePlat saveOrUpdate(TachePlat tachePlat) {
        return tachePlatRepository.save(tachePlat);
    }

    public List<TachePlat> findAll() {
        return tachePlatRepository.findAll();
    }

    public Optional<TachePlat> findById(Integer id) {
        return tachePlatRepository.findById(id);
    }

    @Transactional
    public void deleteById(Integer id) {
        tachePlatRepository.findById(id).ifPresent(tache -> {
            tachePlatRepository.delete(tache);
        });
    }

    public boolean existsById(Integer id) {
        return tachePlatRepository.existsById(id);
    }

    public List<TachePlat> findByPlatId(Integer platId) {
        return tachePlatRepository.findByPlatId(platId);
    }

    @Transactional
    public List<TachePlat> getTachesParPlat(@RequestParam("platId") Integer platId) {
        return tachePlatRepository.findByPlatId(platId);
    }
    public Optional<Integer> getStatutGlobalParTachePlatParDate(Integer idTachePlat,LocalDate date) {
        List<MvtStatutTache> mouvements = mvtStatutTacheRepository.findAllByTachePlatIdAndDate(idTachePlat,date);

        if (mouvements.isEmpty()) {
            return Optional.empty();
        }

        int statutGlobal;

            if (mouvements.stream().anyMatch(m -> m.getStatut() == 1)) {
                statutGlobal = 1;
            } else if (mouvements.stream().allMatch(m -> m.getStatut() == 0)) {
                statutGlobal = 0;
            } else if (mouvements.stream().allMatch(m -> m.getStatut() == 2)) {
                statutGlobal = 2;
            } else {
                statutGlobal = 1;
            }
        return Optional.of(statutGlobal);
    }
    
}

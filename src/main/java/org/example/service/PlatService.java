package org.example.service;

import org.example.entity.Plat;
import org.example.entity.TachePlat;
import org.example.repository.PlatRepository;
import org.example.repository.TachePlatRepository;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Service
public class PlatService {
    private final PlatRepository platRepository;
    private final TachePlatRepository tachePlatRepository;
    private final TachePlatService tachePlatService;

    public PlatService(PlatRepository platRepository, TachePlatRepository tachePlatRepository, TachePlatService tachePlatService) {
        this.platRepository = platRepository;
        this.tachePlatRepository = tachePlatRepository;
        this.tachePlatService = tachePlatService;
    }

    public List<Plat> findAll() {
        return platRepository.findAll();
    }

    public Optional<Plat> findById(Integer id) {
        return platRepository.findById(id);
    }

    public Plat save(Plat plat) {
        return platRepository.save(plat);
    }

    public void deleteById(Integer id) {
        platRepository.deleteById(id);
    }

    public List<Plat> findByIntitule(String intitule) {
        return platRepository.findByIntitule(intitule);
    }

    public List<Plat> findPlatsSinceDate(LocalDate date) {
        return platRepository.findByDateCreationGreaterThanEqualWithCompositions(date);
    }

    public long countPlatsSinceDate(LocalDate date) {
        return platRepository.findByDateCreationGreaterThanEqualWithCompositions(date).size();
    }

    public Optional<Integer> getStatutGlobalParPlatParDate(Integer idPlat, LocalDate date) {
        List<TachePlat> tachesPlat = tachePlatRepository.findByPlatId(idPlat);

        if (tachesPlat.isEmpty()) {
            return Optional.empty();
        }

        int statutGlobal = 0;

        for (TachePlat tachePlat : tachesPlat) {
            Optional<Integer> statutTache = tachePlatService.getStatutGlobalParTachePlatParDate(tachePlat.getId(), date);
            if (statutTache.isPresent()) {
                statutGlobal = Math.max(statutGlobal, statutTache.get());
            }
        }

        return Optional.of(statutGlobal);
    }
}
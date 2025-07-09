package org.example.service;

import org.example.entity.MvtStatutTache;
import org.example.repository.MvtStatutTacheRepository;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;

import java.time.LocalDate;
import java.util.List;

@Service
public class MvtStatutTacheService {
    private final MvtStatutTacheRepository mvtStatutRepo;

    public MvtStatutTacheService(MvtStatutTacheRepository mvt) {
        this.mvtStatutRepo = mvt;
    }

    @Transactional
    public void modifierStatutTacheParIdTachePlat(int idTachePlat, int newStatut, LocalDate date) throws Exception {
        if (idTachePlat == 0) {
            throw new Exception("id_tache_plat introuvable.");
        }

        List<MvtStatutTache> mouvements = mvtStatutRepo.findAllByTachePlatIdAndDate(idTachePlat, date);

        for (MvtStatutTache m : mouvements) {
            m.setStatut(newStatut);
        }

        mvtStatutRepo.saveAll(mouvements);
    }

}

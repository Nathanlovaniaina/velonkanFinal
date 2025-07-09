package org.example.service;

import org.example.entity.DistributionTache;
import org.example.entity.Employe;
import org.example.entity.TachePlat;
import org.example.entity.Plat;
import org.example.entity.MvtStatutTache;
import org.example.repository.DistributionTacheRepository;
import org.example.repository.MvtStatutTacheRepository;
import org.springframework.stereotype.Service;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;


@Service
public class DisributionTacheService {
    private final DistributionTacheRepository distributionrepo;
    private final MvtStatutTacheRepository mvtStatutrepo;
    
    public DisributionTacheService(DistributionTacheRepository distribution,MvtStatutTacheRepository mvt) {
        distributionrepo=distribution;
        mvtStatutrepo=mvt;

    }

    public void distribuerTacheSimple(DistributionTache distribution) throws Exception {
        LocalDate now=LocalDate.now();
        Employe e=distribution.getEmploye();
        TachePlat t=distribution.getTachePlat();
        MvtStatutTache mvt = new MvtStatutTache();
        mvt.setDistributionTache(distribution);
        mvt.setDateHeureModification(LocalDateTime.now());
        mvt.setStatut(0);
        if(e==null) {
            throw new Exception("Employe inexistant");
        } 
        if(t==null) {
            throw new Exception("Tache inexistante");
        } 
        if(now.isBefore(distribution.getDateTache())) {
            distributionrepo.save(distribution);
            mvtStatutrepo.save(mvt);
        }
        else {
            throw new Exception("Date invalide");
        }
    }

    public void distribuerTaches(List <DistributionTache> distributions) throws Exception {
        for(DistributionTache d : distributions) {
            this.distribuerTacheSimple(d);
        }
    }

}


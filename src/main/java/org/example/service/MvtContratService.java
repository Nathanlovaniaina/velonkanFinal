package org.example.service;

import org.example.entity.Entreprise;
import org.example.entity.MvtContrat;
import org.example.repository.MvtContratRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;
import java.util.Date;

@Service
public class MvtContratService {

    private final MvtContratRepository mvtContratRepository;

    public MvtContratService(MvtContratRepository mvtContratRepository) {
        this.mvtContratRepository = mvtContratRepository;
    }

    public List<MvtContrat> findAll() {
        return mvtContratRepository.findAll();
    }

    public List<MvtContrat> findByEntrepriseId(Integer entrepriseId) {
        return mvtContratRepository.findByEntrepriseId(entrepriseId);
    }

    public Optional<MvtContrat> findById(Integer id) {
        return mvtContratRepository.findById(id);
    }

    public MvtContrat save(MvtContrat mvtContrat) {
        return mvtContratRepository.save(mvtContrat);
    }

    public void deleteById(Integer id) {
        mvtContratRepository.deleteById(id);
    }
    public List<Entreprise> findEntreprisesWithActiveContracts(Date fromDate) {
        List<MvtContrat> startMovements = mvtContratRepository.findStartMovementsFromDate(fromDate);
        List<MvtContrat> allMvtContrats = mvtContratRepository.findAll();
        return startMovements.stream()
                .filter(mvt -> allMvtContrats.stream()
                        .noneMatch(fin -> fin.getEntreprise().getId().equals(mvt.getEntreprise().getId())
                                && fin.getTypeMvt() == 1
                                && fin.getDateMvt().compareTo(mvt.getDateMvt()) >= 0))
                .map(MvtContrat::getEntreprise)
                .distinct()
                .collect(Collectors.toList());
    }
}

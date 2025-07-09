package org.example.service;

import org.example.entity.Employe;
import org.example.entity.Penalite;
import org.example.entity.Poste;
import org.example.repository.EmployeRepository;
import org.example.repository.PresenceRepository;
import org.example.repository.PenaliteRepository;
import org.example.repository.PosteRepository;
import org.example.repository.PaiementSalaireRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.time.*;

@Service
public class EmployeService {

    private final EmployeRepository employeRepository;
    private final PaiementSalaireRepository paiementSalaireRepository;
    private final PresenceRepository presenceRepository;
    private final PenaliteRepository penaliteRepository;
    private PosteRepository posteRepository;

    public EmployeService(EmployeRepository employeRepository, PaiementSalaireRepository paiementSalaireRepository, PresenceRepository presenceRepository, PenaliteRepository penaliteRepository, PosteRepository posteRepository) {
        this.employeRepository = employeRepository;
        this.paiementSalaireRepository = paiementSalaireRepository;
        this.presenceRepository = presenceRepository;
        this.penaliteRepository = penaliteRepository;
        this.posteRepository = posteRepository;
    }

    // Liste tous les employés
    public List<Employe> findAll() {
        return employeRepository.findAll();
    }

    // Trouve un employé par id
    public Optional<Employe> findById(Integer id) {
        return employeRepository.findById(id);
    }
    
    public void saveOrUpdate(Employe emp) {
        employeRepository.save(emp);
    }

    // Supprimer un employé
    public void deleteById(Integer id) {
        employeRepository.deleteById(id);
    }

    // Gestion de salaire
    public Double getSalaireBrut(Integer idEmp) {
        return employeRepository.getSalaireBrut(idEmp);
    }

    public Double getTotalSalairePaye(Integer idEmp, int mois, int annee) {
        return paiementSalaireRepository.getTotalSalairePaye(idEmp, mois, annee);
    }

    public Double getResteSalaire(Integer idEmp, int mois, int annee) {
        Double potentiel = getReelSalaire(idEmp, mois, annee);
        Double paye = getTotalSalairePaye(idEmp, mois, annee);
        return potentiel - paye;
    }

    public Double getReelSalaire(Integer idEmp, int mois, int annee) {
        Double salaireBrut = getSalaireBrut(idEmp);
        int nbPresence = presenceRepository.getNbJoursPresence(idEmp, mois, annee);

        int joursTotal = YearMonth.of(annee, mois).lengthOfMonth();
        int nbAbsences = joursTotal - nbPresence;

        Penalite penalite = penaliteRepository.findAll().stream().findFirst().orElse(null);
        if (penalite == null || nbAbsences < penalite.getNbJour()) return salaireBrut;

        Double reduction = penalite.getPourcentage() / 100.0;
        return salaireBrut * (1 - reduction);
    }

    public boolean moisPaie(Integer idEmp, int mois, int annee){
        if(getTotalSalairePaye(idEmp, mois, annee) == getReelSalaire(idEmp, mois, annee)) {
            return true;
        } 
        return false;
    }

    public List<Poste> getAllPostes() {
    return posteRepository.findAll();
}
}

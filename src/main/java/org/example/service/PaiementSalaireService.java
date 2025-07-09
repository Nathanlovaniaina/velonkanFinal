package org.example.service;

import org.example.entity.PaiementSalaire;
import org.example.repository.PaiementSalaireRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PaiementSalaireService {

    private final PaiementSalaireRepository paiementSalaireRepository;

    public PaiementSalaireService(PaiementSalaireRepository paiementSalaireRepository) {
        this.paiementSalaireRepository = paiementSalaireRepository;
    }

    // Sauvegarde un paiement de salaire
    public PaiementSalaire save(PaiementSalaire paiement) {
        return paiementSalaireRepository.save(paiement);
    }

    // Liste tous les paiements
    public List<PaiementSalaire> findAll() {
        return paiementSalaireRepository.findAll();
    }

    // Recherche par id (optionnel)
    public PaiementSalaire findById(Integer id) {
        return paiementSalaireRepository.findById(id).orElse(null);
    }
}

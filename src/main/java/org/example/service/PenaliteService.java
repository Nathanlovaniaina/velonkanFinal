package org.example.service;

import org.example.entity.Penalite;
import org.example.repository.PenaliteRepository;
import org.springframework.stereotype.Service;

import java.util.Optional;
import java.util.List;

@Service
public class PenaliteService {

    private final PenaliteRepository penaliteRepository;

    public PenaliteService(PenaliteRepository penaliteRepository) {
        this.penaliteRepository = penaliteRepository;
    }

    // Récupérer la pénalité unique (si on suppose qu'une seule pénalité est active à la fois)
    public Optional<Penalite> getPenaliteActive() {
        return penaliteRepository.findAll().stream().findFirst();
    }

    public List<Penalite> findAll() {
        return penaliteRepository.findAll();
    }

    // Ajouter ou modifier la pénalité
    public Penalite saveOrUpdate(Penalite penalite) {
        return penaliteRepository.save(penalite);
    }

    public Optional<Penalite> findById(Integer id) {
        return penaliteRepository.findById(id);
    }

    // Supprimer
    public void delete(Integer id) {
        penaliteRepository.deleteById(id);
    }
}

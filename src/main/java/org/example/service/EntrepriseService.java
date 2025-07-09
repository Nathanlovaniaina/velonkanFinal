package org.example.service;

import org.example.entity.Entreprise;
import org.example.repository.EntrepriseRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class EntrepriseService {

    private final EntrepriseRepository entrepriseRepository;

    public EntrepriseService(EntrepriseRepository entrepriseRepository) {
        this.entrepriseRepository = entrepriseRepository;
    }

    public List<Entreprise> findAll() {
        return entrepriseRepository.findAll();
    }

    public Optional<Entreprise> findById(Integer id) {
        return entrepriseRepository.findById(id);
    }

    public Entreprise save(Entreprise entreprise) {
        return entrepriseRepository.save(entreprise);
    }

    public void deleteById(Integer id) {
        entrepriseRepository.deleteById(id);
    }

    public Optional<Entreprise> findByNom(String nom){
        return entrepriseRepository.findByNom(nom);
    }
}
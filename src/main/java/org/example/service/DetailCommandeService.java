package org.example.service;

import org.example.entity.DetailCommande;
import org.example.repository.DetailCommandeRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class DetailCommandeService {

    private final DetailCommandeRepository detailCommandeRepository;

    public DetailCommandeService(DetailCommandeRepository detailCommandeRepository) {
        this.detailCommandeRepository = detailCommandeRepository;
    }

    public List<DetailCommande> findAll() {
        return detailCommandeRepository.findAll();
    }

    public Optional<DetailCommande> findById(Integer id) {
        return detailCommandeRepository.findById(id);
    }

    public List<DetailCommande> findByCommandeId(Integer commandeId) {
        return detailCommandeRepository.findByCommandeId(commandeId);
    }

    public DetailCommande saveOrUpdate(DetailCommande detailCommande) {
        return detailCommandeRepository.save(detailCommande);
    }

    public void delete(Integer id) {
        detailCommandeRepository.deleteById(id);
    }
}
package org.example.service;

import org.example.entity.Unite;
import org.example.repository.UniteRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
public class UniteService {

    private final UniteRepository uniteRepository;

    public UniteService(UniteRepository uniteRepository) {
        this.uniteRepository = uniteRepository;
    }

    public Unite saveOrUpdate(Unite unite) {
        return uniteRepository.save(unite);
    }

    public List<Unite> findAll() {
        return uniteRepository.findAll();
    }

    public Optional<Unite> findById(Integer id) {
        return uniteRepository.findById(id);
    }

    @Transactional
    public void deleteById(Integer id) {
        uniteRepository.findById(id).ifPresent(unite -> {
            uniteRepository.delete(unite);
        });
    }

    public boolean existsById(Integer id) {
        return uniteRepository.existsById(id);
    }
}
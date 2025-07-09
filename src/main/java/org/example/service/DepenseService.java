package org.example.service;

import org.example.entity.Depense;
import org.example.repository.DepenseRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class DepenseService {

    private final DepenseRepository depenseRepository;

    public DepenseService(DepenseRepository depenseRepository) {
        this.depenseRepository = depenseRepository;
    }

    public Depense saveOrUpdate(Depense depense) {
        return depenseRepository.save(depense);
    }

    public List<Depense> findAll() {
        return depenseRepository.findAll();
    }

    public Optional<Depense> findById(Integer id) {
        return depenseRepository.findById(id);
    }

    public void deleteById(Integer id) {
        depenseRepository.deleteById(id);
    }
}

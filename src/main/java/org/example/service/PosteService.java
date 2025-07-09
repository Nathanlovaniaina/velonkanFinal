package org.example.service;

import org.example.entity.Poste;
import org.example.repository.PosteRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class PosteService {

    private final PosteRepository posteRepository;

    public PosteService(PosteRepository posteRepository) {
        this.posteRepository = posteRepository;
    }

    public List<Poste> findAll() {
        return posteRepository.findAll();
    }

    public Optional<Poste> findById(Integer id) {
        return posteRepository.findById(id);
    }

    public Poste saveOrUpdate(Poste poste) {
        return posteRepository.save(poste);
    }

    public void deleteById(Integer id) {
        posteRepository.deleteById(id);
    }
}

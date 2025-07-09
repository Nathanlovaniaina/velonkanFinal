package org.example.service;

import org.example.entity.DetailsPlat;
import org.example.entity.Plat;
import org.example.repository.DetailsPlatRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DetailsPlatService {

    private final DetailsPlatRepository repository;

    public DetailsPlatService(DetailsPlatRepository repository) {
        this.repository = repository;
    }

    public DetailsPlat save(DetailsPlat detailsPlat) {
        return repository.save(detailsPlat);
    }

    public List<DetailsPlat> findAll() {
        return repository.findAll();
    }

    public List<DetailsPlat> findByPlatId(Integer platId) {
        return repository.findByPlatId(platId);
    }

    public List<DetailsPlat> findByPlat(Plat plat) {
        return repository.findByPlat(plat);
    }
}

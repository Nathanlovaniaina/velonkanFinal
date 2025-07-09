package org.example.service;

import org.example.entity.TypeComposant;
import org.example.repository.TypeComposantRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
public class TypeComposantService {

    private final TypeComposantRepository typeComposantRepository;

    public TypeComposantService(TypeComposantRepository typeComposantRepository) {
        this.typeComposantRepository = typeComposantRepository;
    }

    public TypeComposant saveOrUpdate(TypeComposant typeComposant) {
        return typeComposantRepository.save(typeComposant);
    }

    public List<TypeComposant> findAll() {
        return typeComposantRepository.findAll();
    }

    public Optional<TypeComposant> findById(Integer id) {
        return typeComposantRepository.findById(id);
    }

    @Transactional
    public void deleteById(Integer id) {
        typeComposantRepository.findById(id).ifPresent(unite -> {
            typeComposantRepository.delete(unite);
        });
    }

    public boolean existsById(Integer id) {
        return typeComposantRepository.existsById(id);
    }
}
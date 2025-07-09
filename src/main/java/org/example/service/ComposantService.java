package org.example.service;

import org.example.entity.Composant;
import org.example.entity.dto.ComposantUsageDTO;
import org.example.repository.ComposantRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;
import java.util.Date;

@Service
public class ComposantService {

    private final ComposantRepository composantRepository;

    public ComposantService(ComposantRepository composantRepository) {
        this.composantRepository = composantRepository;
    }

    public Composant saveOrUpdate(Composant composant) {
        return composantRepository.save(composant);
    }

    public List<Composant> findAll() {
        return composantRepository.findAll();
    }

    public Optional<Composant> findById(Integer id) {
        return composantRepository.findById(id);
    }

    @Transactional
    public void deleteById(Integer id) {
        composantRepository.findById(id).ifPresent(unite -> {
            composantRepository.delete(unite);
        });
    }

    public boolean existsById(Integer id) {
        return composantRepository.existsById(id);
    }

    public void deleteByTypeComposantId(Integer id) {
        composantRepository.deleteByTypeComposantId(id);
    }

    public void deleteByUniteId(Integer id) {
        composantRepository.deleteByUniteId(id);
    }

    public List<Composant> findByUniteId(Integer uniteId) {
        return composantRepository.findByUniteId(uniteId);
    }

    public List<Composant> findByTypeComposantId(Integer typeComposantId) {
        return composantRepository.findByTypeComposantId(typeComposantId);
    }

    public List<Composant> findAllById(List<Integer> ids) {
        return composantRepository.findByIdIn(ids);
    }

    public List<ComposantUsageDTO> findMostUsedComposants(LocalDateTime dateDebut, LocalDateTime dateFin, Integer typeId) {

    Date dateDebutConverted = Timestamp.valueOf(dateDebut);
    Date dateFinConverted = Timestamp.valueOf(dateFin);

    // Appel au repository avec les dates converties
    return composantRepository.findMostUsedComposants(dateDebutConverted, dateFinConverted, typeId)
            .stream()
            .map(row -> new ComposantUsageDTO((String) row[0], ((Number) row[1]).doubleValue()))
            .collect(Collectors.toList());
}


}
package org.example.service;

import org.example.entity.PublicationPlat;
import org.example.repository.PublicationPlatRepository;
import org.springframework.stereotype.Service;

@Service
public class PublicationPlatService {
    private final PublicationPlatRepository publicationPlatRepository;

    public PublicationPlatService(PublicationPlatRepository publicationPlatRepository) {
        this.publicationPlatRepository = publicationPlatRepository;
    }

    public PublicationPlat save(PublicationPlat publicationPlat) {
        return publicationPlatRepository.save(publicationPlat);
    }

    public java.util.List<PublicationPlat> findByDatePublicationBetween(java.time.LocalDate start, java.time.LocalDate end) {
        return publicationPlatRepository.findByDatePublicationBetween(start, end);
    }

    public java.util.List<PublicationPlat> findByDatePublication(java.time.LocalDate date) {
        return publicationPlatRepository.findByDatePublication(date);
    }

    public java.util.List<PublicationPlat> findWithCompositionsByDatePublicationBetween(java.time.LocalDate start, java.time.LocalDate end) {
        return publicationPlatRepository.findWithCompositionsByDatePublicationBetween(start, end);
    }

    public void delete(PublicationPlat publicationPlat) {
        publicationPlatRepository.delete(publicationPlat);
    }
} 
package org.example.service;

import java.time.LocalDate;
import java.util.List;

import org.example.repository.SuiviRecetteRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class SuiviRecetteService {

    @Autowired
    private final SuiviRecetteRepository suiviRecetteRepository;

    public SuiviRecetteService() {
        this.suiviRecetteRepository = new SuiviRecetteRepository();
    }

    public List<Object[]> getRevenuMensuelParAnnee(LocalDate startDate, LocalDate endDate,Long entrepriseId, Long platId) {
        try {
            validateDates(startDate, endDate);
            return suiviRecetteRepository.getRevenuMensuelParAnnee(startDate,endDate, entrepriseId,  platId);
        } catch (IllegalArgumentException e) {
            System.err.println("Erreur de validation des dates : " + e.getMessage());
            return List.of();  // Retourne une liste vide en cas d'erreur de validation
        } catch (Exception e) {
            System.err.println("Erreur lors de la récupération du revenu mensuel : " + e.getMessage());
            return List.of();
        }
    }

    public List<Object[]> getRevenuParEntreprise(LocalDate startDate, LocalDate endDate) {
        try {
            validateDates(startDate, endDate);
            return suiviRecetteRepository.getRevenuParEntreprise(startDate, endDate);
        } catch (IllegalArgumentException e) {
            System.err.println("Erreur de validation des dates : " + e.getMessage());
            return List.of();
        } catch (Exception e) {
            System.err.println("Erreur lors de la récupération du revenu par entreprise : " + e.getMessage());
            return List.of();
        }
    }

    public List<Object[]> getRevenuJournalierEtEvolution(LocalDate startDate, LocalDate endDate) {
        try {
            validateDates(startDate, endDate);
            return suiviRecetteRepository.getRevenuJournalierEtEvolution(startDate, endDate);
        } catch (IllegalArgumentException e) {
            System.err.println("Erreur de validation des dates : " + e.getMessage());
            return List.of();
        } catch (Exception e) {
            System.err.println("Erreur lors de la récupération du revenu journalier : " + e.getMessage());
            return List.of();
        }
    }

    public List<Object[]> getFacturesEnRetard(LocalDate startDate, LocalDate endDate) {
        try {
            validateDates(startDate, endDate);
            return suiviRecetteRepository.getFacturesEnRetard(startDate, endDate);
        } catch (IllegalArgumentException e) {
            System.err.println("Erreur de validation des dates : " + e.getMessage());
            return List.of();
        } catch (Exception e) {
            System.err.println("Erreur lors de la récupération des factures en retard : " + e.getMessage());
            return List.of();
        }
    }

    /**
     * Validation des dates : aucune ne doit être nulle et startDate doit être <= endDate
     */
    private void validateDates(LocalDate startDate, LocalDate endDate) {
        if (startDate == null || endDate == null) {
            throw new IllegalArgumentException("Les dates de début et de fin ne peuvent pas être nulles.");
        }
        if (startDate.isAfter(endDate)) {
            throw new IllegalArgumentException("La date de début doit être antérieure ou égale à la date de fin.");
        }
    }


}
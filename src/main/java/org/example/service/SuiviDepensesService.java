package org.example.service;

import java.time.LocalDate;
import java.util.List;

import org.example.repository.SuiviDepensesRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class SuiviDepensesService {

    @Autowired
    private final SuiviDepensesRepository suiviDepensesRepository;

    public SuiviDepensesService(SuiviDepensesRepository suiviDepensesRepository) {
        this.suiviDepensesRepository = suiviDepensesRepository;
    }

    public List<Object[]> getDepensesParComposant(LocalDate startDate, LocalDate endDate, 
                                                Long categorieId, Long composantId) {
        try {
            validateDates(startDate, endDate);
            return suiviDepensesRepository.getDepensesParComposant(startDate, endDate, categorieId, composantId);
        } catch (IllegalArgumentException e) {
            System.err.println("Erreur de validation des dates : " + e.getMessage());
            return List.of();
        } catch (Exception e) {
            System.err.println("Erreur lors de la récupération des dépenses par composant : " + e.getMessage());
            return List.of();
        }
    }

    public List<Object[]> getEvolutionDepensesMensuelles(LocalDate startDate, LocalDate endDate) {
        try {
            validateDates(startDate, endDate);
            return suiviDepensesRepository.getEvolutionDepensesMensuelles(startDate, endDate);
        } catch (IllegalArgumentException e) {
            System.err.println("Erreur de validation des dates : " + e.getMessage());
            return List.of();
        } catch (Exception e) {
            System.err.println("Erreur lors de la récupération de l'évolution des dépenses : " + e.getMessage());
            return List.of();
        }
    }

    public List<Object[]> getTopComposantsPlusCouteux(LocalDate startDate, LocalDate endDate, int limit) {
        try {
            validateDates(startDate, endDate);
            validateLimit(limit);
            return suiviDepensesRepository.getTopComposantsPlusCouteux(startDate, endDate, limit);
        } catch (IllegalArgumentException e) {
            System.err.println("Erreur de validation : " + e.getMessage());
            return List.of();
        } catch (Exception e) {
            System.err.println("Erreur lors de la récupération des composants les plus coûteux : " + e.getMessage());
            return List.of();
        }
    }

    public List<Object[]> getDepensesParCategorie(LocalDate startDate, LocalDate endDate) {
        try {
            validateDates(startDate, endDate);
            return suiviDepensesRepository.getDepensesParCategorie(startDate, endDate);
        } catch (IllegalArgumentException e) {
            System.err.println("Erreur de validation des dates : " + e.getMessage());
            return List.of();
        } catch (Exception e) {
            System.err.println("Erreur lors de la récupération des dépenses par catégorie : " + e.getMessage());
            return List.of();
        }
    }

    public List<Object[]> getComparaisonConsommation(LocalDate dateDebut, LocalDate dateFin) {
    try {
        validateDates(dateDebut, dateFin);
        return suiviDepensesRepository.getComparaisonConsommation(dateDebut, dateFin);
    } catch (IllegalArgumentException e) {
        System.err.println("Erreur de validation des dates : " + e.getMessage());
        return List.of();
    } catch (Exception e) {
        System.err.println("Erreur lors de la récupération de la comparaison de la consommation : " + e.getMessage());
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

    /**
     * Validation du paramètre limit (doit être positif)
     */
    private void validateLimit(int limit) {
        if (limit <= 0) {
            throw new IllegalArgumentException("Le paramètre 'limit' doit être un entier positif.");
        }
    }
}
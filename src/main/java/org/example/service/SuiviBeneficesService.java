package org.example.service;

import java.time.LocalDate;
import java.util.List;

import org.example.repository.SuiviBeneficesRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class SuiviBeneficesService {

    @Autowired
    private final SuiviBeneficesRepository suiviBeneficesRepository;

    public SuiviBeneficesService(SuiviBeneficesRepository suiviBeneficesRepository) {
        this.suiviBeneficesRepository = suiviBeneficesRepository;
    }

    public List<Object[]> getRevenuTotal(LocalDate startDate, LocalDate endDate) {
        try {
            validateDates(startDate, endDate);
            return suiviBeneficesRepository.getRevenuTotal(startDate, endDate);
        } catch (Exception e) {
            System.err.println("Erreur lors de la récupération du revenu total : " + e.getMessage());
            return List.of();
        }
    }

    public List<Object[]> getCoutTotal(LocalDate startDate, LocalDate endDate) {
        try {
            validateDates(startDate, endDate);
            return suiviBeneficesRepository.getCoutTotal(startDate, endDate);
        } catch (Exception e) {
            System.err.println("Erreur lors de la récupération du coût total : " + e.getMessage());
            return List.of();
        }
    }

    public List<Object[]> getBeneficeNet(LocalDate startDate, LocalDate endDate) {
        try {
            validateDates(startDate, endDate);
            return suiviBeneficesRepository.getBeneficeNet(startDate, endDate);
        } catch (Exception e) {
            System.err.println("Erreur lors de la récupération du bénéfice net : " + e.getMessage());
            return List.of();
        }
    }

    public List<Object[]> getRevenusParEntreprise(LocalDate startDate, LocalDate endDate) {
        try {
            validateDates(startDate, endDate);
            return suiviBeneficesRepository.getRevenusParEntreprise(startDate, endDate);
        } catch (Exception e) {
            System.err.println("Erreur lors de la récupération des revenus par entreprise : " + e.getMessage());
            return List.of();
        }
    }

    public List<Object[]> getBeneficesParPlat(LocalDate startDate, LocalDate endDate) {
        try {
            validateDates(startDate, endDate);
            return suiviBeneficesRepository.getBeneficesParPlat(startDate, endDate);
        } catch (Exception e) {
            System.err.println("Erreur lors de la récupération des bénéfices par plat : " + e.getMessage());
            return List.of();
        }
    }

    public List<Object[]> getSalairesVerses(LocalDate startDate, LocalDate endDate) {
        try {
            validateDates(startDate, endDate);
            return suiviBeneficesRepository.getSalairesVerses(startDate, endDate);
        } catch (Exception e) {
            System.err.println("Erreur lors de la récupération des salaires versés : " + e.getMessage());
            return List.of();
        }
    }

    public List<Object[]> getBilanJournalier(LocalDate startDate, LocalDate endDate) {
        try {
            validateDates(startDate, endDate);
            return suiviBeneficesRepository.getBilanJournalier(startDate, endDate);
        } catch (Exception e) {
            System.err.println("Erreur lors de la récupération du bilan journalier : " + e.getMessage());
            return List.of();
        }
    }

    // Validation des dates
    private void validateDates(LocalDate startDate, LocalDate endDate) {
        if (startDate == null || endDate == null) {
            throw new IllegalArgumentException("Les dates de début et de fin ne peuvent pas être nulles.");
        }
        if (startDate.isAfter(endDate)) {
            throw new IllegalArgumentException("La date de début doit être antérieure ou égale à la date de fin.");
        }
    }
}

package org.example.service;

import org.example.entity.Commandes;
import org.example.entity.DetailCommande;
import org.example.entity.Entreprise;
import org.example.entity.Plat;
import org.example.repository.CommandesRepository;
import org.example.repository.EntrepriseRepository;
import org.example.repository.PlatRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;
import java.util.Optional;

@Service
public class CommandesService {

    private final CommandesRepository commandeRepository;
    private final EntrepriseRepository entrepriseRepository;
    private final PlatRepository platRepository;

    public CommandesService(CommandesRepository commandeRepository,
                          EntrepriseRepository entrepriseRepository,
                          PlatRepository platRepository) {
        this.commandeRepository = commandeRepository;
        this.entrepriseRepository = entrepriseRepository;
        this.platRepository = platRepository;
    }

    public List<Commandes> findAll() {
        return commandeRepository.findAllWithDetails();
    }

    public void deleteById(Integer id) {
        commandeRepository.deleteById(id);
    }

    public Optional<Commandes> findById(Integer id) {
        return commandeRepository.findByIdWithDetails(id);
    }

    public List<Commandes> findByDateRange(Date dateDebut, Date dateFin) {
        return commandeRepository.findByDateRange(dateDebut, dateFin);
    }

    public Integer getTotalPortions(Date dateDebut, Date dateFin) {
        if (dateDebut != null && dateFin != null) {
            return commandeRepository.getTotalPortionsByDateRange(dateDebut, dateFin);
        }
        return commandeRepository.getTotalPortions();
    }

    public List<Entreprise> findAllEntreprises() {
        return entrepriseRepository.findAll();
    }

    public List<Plat> findAllPlats() {
        return platRepository.findAll();
    }

    @Transactional
    public void updateCommande(Commandes commande) {
        Commandes existingCommande = commandeRepository.findByIdWithDetails(commande.getId())
                .orElseThrow(() -> new IllegalArgumentException("Commande non trouvée"));

        // Mettre à jour l'entreprise
        Entreprise entreprise = entrepriseRepository.findById(commande.getEntreprise().getId())
                .orElseThrow(() -> new IllegalArgumentException("Entreprise non trouvée"));
        existingCommande.setEntreprise(entreprise);

        // Mettre à jour la date/heure prévue
        if (commande.getDateHeurePrevue() == null) {
            throw new IllegalArgumentException("Date et heure prévues requises");
        }
        existingCommande.setDateHeurePrevue(commande.getDateHeurePrevue());

        // Mettre à jour les détails
        existingCommande.getDetails().clear();
        for (DetailCommande detail : commande.getDetails()) {
            if (detail.getPlat() == null || detail.getPlat().getId() == null) {
                throw new IllegalArgumentException("Plat non spécifié pour un détail");
            }
            Plat plat = platRepository.findById(detail.getPlat().getId())
                    .orElseThrow(() -> new IllegalArgumentException("Plat non trouvé avec ID : " + detail.getPlat().getId()));
            detail.setCommande(existingCommande);
            detail.setPlat(plat);
            existingCommande.getDetails().add(detail);
        }

        // Calculer le prix total
        int prixTotal = existingCommande.getDetails().stream()
                .mapToInt(d -> d.getQuantite() * d.getPrixUnitaire())
                .sum();
        existingCommande.setPrixTotal(prixTotal);

        commandeRepository.save(existingCommande);
    }
}
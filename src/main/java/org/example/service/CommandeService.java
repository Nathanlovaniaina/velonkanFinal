package org.example.service;

import org.example.repository.CommandeRepositoryScript;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

@Service
public class CommandeService {

    private final CommandeRepositoryScript commandeRepositoryscr;

    public CommandeService(CommandeRepositoryScript commandeRepositoryscr) {
        this.commandeRepositoryscr = commandeRepositoryscr;
    }

    @Transactional
    public Long creerCommande(Long idEntreprise, LocalDateTime dateLivraison, 
                            List<Map<String, String>> platsCommandes, 
                            String commentaires, int prixTotal) {
        return commandeRepositoryscr.creerCommandeComplete(
            idEntreprise, 
            dateLivraison, 
            platsCommandes, 
            commentaires, 
            prixTotal
        );
    }
}
package org.example.controller;

import org.example.entity.Commande;
import org.example.entity.DetailCommande;
import org.example.service.MvtLivraisonService;
import org.example.repository.CommandeRepository;
import org.example.service.PlatService;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.*;

@Controller
@RequestMapping("/suivi")
public class SuiviEtatCommandeController {

    private final CommandeRepository commandeRepository;
    private final PlatService platService;
    private final MvtLivraisonService mvtLivraisonService;

    public SuiviEtatCommandeController(CommandeRepository commandeRepository,
                                       PlatService platService,
                                       MvtLivraisonService mvtLivraisonService) {
        this.commandeRepository = commandeRepository;
        this.platService = platService;
        this.mvtLivraisonService = mvtLivraisonService;
    }

    @GetMapping
    public String listerCommandes(
            @RequestParam(value = "dateHeure", required = false)
            @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME)
            LocalDateTime dateHeure,
            Model model) {

        if (dateHeure == null) {
            dateHeure = LocalDateTime.now();
        }

        LocalDate jour = dateHeure.toLocalDate();
        LocalDateTime start = jour.atStartOfDay();
        LocalDateTime end = start.plusDays(1);

        List<Commande> commandes = commandeRepository.findByDateRangeWithDetailsAndPlats(start, end);
        List<Map<String, Object>> commandeViews = new ArrayList<>();

        for (Commande commande : commandes) {
            Map<String, Object> map = new HashMap<>();
            map.put("entreprise", commande.getEntreprise().getNom());
            map.put("heure", commande.getDateHeurePrevue().toLocalTime().toString().substring(0, 5));

            List<Map<String, Object>> plats = new ArrayList<>();
            boolean tousStatutsDeux = true;

            for (DetailCommande detail : commande.getDetails()) {
                Map<String, Object> platMap = new HashMap<>();
                platMap.put("nom", detail.getPlat().getIntitule());
                platMap.put("quantite", detail.getQuantite());

                Optional<Integer> statutOpt = platService.getStatutGlobalParPlatParDate(
                        detail.getPlat().getId(), jour
                );
                Integer statut = statutOpt.orElse(null);
                String statutTexte;
                if (statut == null) {
                    statutTexte = "Inconnu";
                } else {
                    switch (statut) {
                        case 0 -> statutTexte = "Non commencé";
                        case 1 -> statutTexte = "En cours";
                        case 2 -> statutTexte = "Terminé";
                        default -> statutTexte = "Inconnu";
                    }
                }

                platMap.put("statut", statutTexte);

                if (statut == null || statut != 2) {
                    tousStatutsDeux = false;
                }

                plats.add(platMap);
            }

            map.put("plats", plats);
            map.put("livrable", tousStatutsDeux);
            map.put("idCommande", commande.getId());


            Optional<Integer> lastStatut = mvtLivraisonService.getDernierStatut(commande.getId());
            map.put("lastStatut", lastStatut.orElse(-1));

            commandeViews.add(map);
        }

        model.addAttribute("commandes", commandeViews);
        model.addAttribute("dateHeure", dateHeure);

        return "suivi_commandes";
    }


    @PostMapping("/livrer")
    public String livrerCommande(@RequestParam("idCommande") int idCommande,
                                 @RequestParam("statut") int statut,
                                 @RequestParam(value = "dateHeure", required = false)
                                 @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME)
                                 LocalDateTime dateHeure) {
        try {
            mvtLivraisonService.modifierStatutCommande(idCommande, statut);
        } catch (Exception e) {
            e.printStackTrace(); 
        }

        return "redirect:/suivi?dateHeure=" + dateHeure;
    }
}

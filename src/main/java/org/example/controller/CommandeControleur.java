package org.example.controller;

import org.example.entity.Entreprise;
import org.example.entity.Plat;
import org.example.service.CommandeService;
import org.example.service.EntrepriseService;
import org.example.service.PlatService;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.transaction.Transactional;
import javax.servlet.http.HttpSession;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/commande")
public class CommandeControleur {

    private final EntrepriseService entrepriseService;
    private final PlatService platService;
    private final CommandeService commandeService;

    public CommandeControleur(EntrepriseService entrepriseService, PlatService platService, CommandeService commandeService) {
        this.entrepriseService = entrepriseService;
        this.platService = platService;
        this.commandeService = commandeService;
    }

    @GetMapping("/form")
    @Transactional
    public String getForm(Model model, HttpSession session) {
        model.addAttribute("entreprises", entrepriseService.findAll());
        // Gestion d'un éventuel message d'erreur en session
        String error = (String) session.getAttribute("error");
        if (error != null) {
            model.addAttribute("error", error);
            session.removeAttribute("error");
        }
        return "Commande/form";
    }

   @GetMapping("/api/getPlat")
@ResponseBody 
public List<Map<String, Object>> getAllPlats() {
    List<Plat> plats = platService.findAll();
    List<Map<String, Object>> response = new ArrayList<>();
    
    for (Plat plat : plats) {
        Map<String, Object> platMap = new HashMap<>();
        platMap.put("id", plat.getId());
        platMap.put("intitule", plat.getIntitule());
        platMap.put("prix", plat.getPrix());
        platMap.put("dateCreation", plat.getDateCreation().toString());
        response.add(platMap);
    }
    
    return response;
}

    @PostMapping("/importCsvCommande")
public String importerCommandeCSV(
        @RequestParam("file") MultipartFile file,
        HttpSession session) {

    if (file == null || file.isEmpty()) {
        session.setAttribute("error", "Fichier CSV manquant ou vide.");
        return "redirect:/commande/form";
    }

    try (BufferedReader reader = new BufferedReader(new InputStreamReader(file.getInputStream(), StandardCharsets.UTF_8))) {
        String line = reader.readLine(); // entête
        if (line == null || line.trim().isEmpty()) {
            session.setAttribute("error", "Fichier CSV vide.");
            return "redirect:/commande/form";
        }

        List<Map<String, String>> platsCommandes = new ArrayList<>();
        Entreprise entreprise = null;
        LocalDateTime dateLivraison = null;
        String commentaires = "Aucun";
        int prixTotal = 0;
        int totalPlats = 0;
        int lineNumber = 1;

        List<Plat> plats = platService.findAll();

        while ((line = reader.readLine()) != null) {
            lineNumber++;
            if (line.trim().isEmpty()) continue;

            String[] parts = line.split(",");
            if (parts.length != 4) {
                session.setAttribute("error", "Ligne " + lineNumber + " : le fichier CSV doit contenir exactement 4 colonnes : nomPlat, quantite, dateLivraison, entreprise.");
                return "redirect:/commande/form";
            }

            String nomPlat = parts[0].trim();
            String quantiteStr = parts[1].trim();
            String dateLivraisonStr = parts[2].trim();
            String nomEntreprise = parts[3].trim();

            // Validation quantité
            int quantite;
            try {
                quantite = Integer.parseInt(quantiteStr);
                if (quantite <= 0) throw new NumberFormatException();
            } catch (NumberFormatException e) {
                session.setAttribute("error", "Ligne " + lineNumber + " : quantité invalide : " + quantiteStr);
                return "redirect:/commande/form";
            }

            // Validation date livraison (on prend la première date pour la commande)
            if (dateLivraison == null) {
                try {
                    dateLivraison = LocalDateTime.parse(dateLivraisonStr);
                } catch (DateTimeParseException e) {
                    session.setAttribute("error", "Ligne " + lineNumber + " : date de livraison invalide (format attendu : yyyy-MM-dd'T'HH:mm) : " + dateLivraisonStr);
                    return "redirect:/commande/form";
                }
            }

            // Recherche entreprise par nom (on prend la première entreprise pour la commande)
            if (entreprise == null) {
                entreprise = entrepriseService.findByNom(nomEntreprise).orElse(null);
                if (entreprise == null) {
                    session.setAttribute("error", "Ligne " + lineNumber + " : entreprise introuvable : " + nomEntreprise);
                    return "redirect:/commande/form";
                }
            }

            // Recherche plat par nom
            Plat platTrouve = null;
            for (Plat p : plats) {
                if (p.getIntitule().equalsIgnoreCase(nomPlat)) {
                    platTrouve = p;
                    break;
                }
            }
            if (platTrouve == null) {
                session.setAttribute("error", "Ligne " + lineNumber + " : plat introuvable : " + nomPlat);
                return "redirect:/commande/form";
            }

            Map<String, String> platMap = new HashMap<>();
            platMap.put("id", platTrouve.getId().toString());
            platMap.put("nom", platTrouve.getIntitule());
            platMap.put("quantite", String.valueOf(quantite));
            platsCommandes.add(platMap);

            prixTotal += platTrouve.getPrix() * quantite;
            totalPlats++;
        }

        if (platsCommandes.isEmpty()) {
            session.setAttribute("error", "Aucune donnée trouvée dans le fichier CSV.");
            return "redirect:/commande/form";
        }

        // Préparation données commande pour session
        Map<String, Object> commandeData = new HashMap<>();
        commandeData.put("entreprise", entreprise);
        commandeData.put("dateLivraison", dateLivraison.format(DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm")));
        commandeData.put("commentaires", commentaires);
        commandeData.put("plats", platsCommandes);
        commandeData.put("totalPlats", totalPlats);

        session.setAttribute("commande", commandeData);
        session.setAttribute("prixTotal", prixTotal);

        return "redirect:/commande/confirmation";

    } catch (Exception e) {
        session.setAttribute("error", "Erreur lors de la lecture du fichier CSV : " + e.getMessage());
        return "redirect:/commande/form";
    }
}


   @PostMapping("/CreerCommande")
    public String creerCommande(
            @RequestParam("idEntreprise") Long idEntreprise,
            @RequestParam("dateLivraison") @DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm") LocalDateTime dateLivraison,
            @RequestParam Map<String, String> allParams,
            @RequestParam(value = "commentaires", required = false) String commentaires,
            HttpSession session) {

        // Validation
        if (idEntreprise == null || dateLivraison == null) {
            session.setAttribute("error", "Les champs obligatoires sont manquants");
            return "redirect:/commande/form";
        }

        // Extraction des plats
        List<Map<String, String>> platsCommandes = new ArrayList<>();
        int platCount = 0;
        int prixTotal = 0;
        List<Plat> listPlats = platService.findAll();
        while (allParams.containsKey("plats[" + platCount + "].id")) {
            Map<String, String> plat = new HashMap<>();
            String platIdStr = allParams.get("plats[" + platCount + "].id");
            String quantiteStr = allParams.get("plats[" + platCount + "].quantite");
            plat.put("id", platIdStr);
            plat.put("nom", allParams.get("plats[" + platCount + "].nom"));
            plat.put("quantite", quantiteStr);
            if (platIdStr != null) {
                platsCommandes.add(plat);
                for (Plat plat2 : listPlats) {
                    if (plat2.getId().toString().equalsIgnoreCase(platIdStr)) {        
                        prixTotal += plat2.getPrix() * Integer.parseInt(quantiteStr);
                        System.out.println("Prix unitaire du plat est:"+plat2.getPrix());
                        break;
                    }
                }
                platCount++;
            }
            
        }

        // Récupération complète de l'entreprise
        Entreprise entreprise = entrepriseService.findById(Integer.parseInt(idEntreprise.toString()))
                .orElseThrow(() -> new IllegalArgumentException("Entreprise introuvable"));

        // Préparation des données
        Map<String, Object> commandeData = new HashMap<>();
        commandeData.put("entreprise", entreprise); // Objet complet maintenant
        commandeData.put("dateLivraison", dateLivraison.format(DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm")));
        commandeData.put("commentaires", commentaires != null ? commentaires : "Aucun");
        commandeData.put("plats", platsCommandes);
        commandeData.put("totalPlats", platCount);

        session.setAttribute("commande", commandeData);
        session.setAttribute("prixTotal", prixTotal);
        return "redirect:/commande/confirmation";
    }

    @SuppressWarnings("unchecked")
    @GetMapping("/confirmation")
    public String afficherConfirmation(HttpSession session, Model model) {
        Map<String, Object> commandeData = (Map<String, Object>) session.getAttribute("commande");
        int prixTotal = (int) session.getAttribute("prixTotal");
        System.out.println("Le prix total est :"+prixTotal);

        if (commandeData == null) {
            return "redirect:/commande/form";
        }

        model.addAllAttributes(commandeData); // Transfert vers le modèle
        return "Commande/confirmation";
    }

    @GetMapping("/insert")
    public String insertionCommande(HttpSession session, Model model) {
        @SuppressWarnings("unchecked")
        Map<String, Object> commandeData = (Map<String, Object>) session.getAttribute("commande");
        Integer prixTotal = (Integer) session.getAttribute("prixTotal");

        if (commandeData == null || prixTotal == null) {
            session.setAttribute("error", "Aucune commande à valider.");
            return "redirect:/commande/form";
        }

        try {
            // Extraction des données nécessaires
            Entreprise entreprise = (Entreprise) commandeData.get("entreprise");
            String dateLivraisonStr = (String) commandeData.get("dateLivraison");
            @SuppressWarnings("unchecked")
            List<Map<String, String>> platsCommandes = (List<Map<String, String>>) commandeData.get("plats");
            String commentaires = (String) commandeData.get("commentaires");
        
            // Conversion de la date
            LocalDateTime dateLivraison = LocalDateTime.parse(dateLivraisonStr, java.time.format.DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm"));
        
            // Appel du service avec les vraies valeurs
            commandeService.creerCommande(
                entreprise.getId().longValue(),
                dateLivraison,
                platsCommandes,
                commentaires,
                prixTotal
            );
            session.removeAttribute("commande");
            model.addAllAttributes(commandeData); 
            return "Commande/confirmation";
        } catch (Exception e) {
            session.setAttribute("error", "Erreur lors de la validation de la commande : " + e.getMessage());
            return "redirect:/commande/confirmation";
        }
    }
}
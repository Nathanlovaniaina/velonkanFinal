package org.example.controller;

import org.example.entity.Commandes;
import org.example.entity.DetailCommande;
import org.example.entity.Entreprise;
import org.example.entity.Plat;
import org.example.service.CommandesService;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;

import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.Locale;

@Controller
@RequestMapping("/commande")
public class CommandeController {

    private final CommandesService commandeService;

    public CommandeController(CommandesService commandeService) {
        this.commandeService = commandeService;
        
    }

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
        dateFormat.setLenient(false);
        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
    }

    @GetMapping("/")
    public String toPayement(Model model,
                             @RequestParam(value = "dateDebut", required = false) String dateDebut,
                             @RequestParam(value = "dateFin", required = false) String dateFin,
                             @RequestParam(value = "succes", required = false) String succes) {
        try {
            LocalDate today = LocalDate.now();
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("EEEE, d MMMM yyyy", new Locale("fr", "FR"));
            model.addAttribute("currentDate", today.format(formatter));

            if (succes != null) {
                model.addAttribute("succes", succes);
            }

            if (dateDebut != null && dateFin != null && !dateDebut.isEmpty() && !dateFin.isEmpty()) {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                Date startDate = sdf.parse(dateDebut);
                Date endDate = sdf.parse(dateFin);
                model.addAttribute("commandes", commandeService.findByDateRange(startDate, endDate));
                model.addAttribute("totalPortions", commandeService.getTotalPortions(startDate, endDate));
                model.addAttribute("dateDebut", dateDebut);
                model.addAttribute("dateFin", dateFin);
            } else {
                model.addAttribute("commandes", commandeService.findAll());
                model.addAttribute("totalPortions", commandeService.getTotalPortions(null, null));
            }
        } catch (Exception e) {
            model.addAttribute("commandes", commandeService.findAll());
            model.addAttribute("totalPortions", commandeService.getTotalPortions(null, null));
        }
        return "listeCommande";
    }

    @GetMapping("/delete")
    public String supprimerCommande(@RequestParam("id") Integer id,
                                   @RequestParam(value = "dateDebut", required = false) String dateDebut,
                                   @RequestParam(value = "dateFin", required = false) String dateFin) {
        commandeService.deleteById(id);
        if (dateDebut != null && dateFin != null && !dateDebut.isEmpty() && !dateFin.isEmpty()) {
            return "redirect:/commande/?dateDebut=" + dateDebut + "&dateFin=" + dateFin + "&succes=Commande supprimée";
        }
        return "redirect:/commande/?succes=Commande supprimée";
    }

    @GetMapping("/edit")
    public String editCommande(@RequestParam("id") Integer id,
                              @RequestParam(value = "dateDebut", required = false) String dateDebut,
                              @RequestParam(value = "dateFin", required = false) String dateFin,
                              Model model) {
        Commandes commande = commandeService.findById(id)
                .orElseThrow(() -> new RuntimeException("Commande introuvable"));
        model.addAttribute("commande", commande);
        model.addAttribute("entreprises", commandeService.findAllEntreprises());
        model.addAttribute("plats", commandeService.findAllPlats());
        model.addAttribute("dateDebut", dateDebut);
        model.addAttribute("dateFin", dateFin);
        return "editCommande";
    }

    @PostMapping("/update")
    public String updateCommande(@ModelAttribute("commande") Commandes commande,
                                @RequestParam("idEntreprise") Integer idEntreprise,
                                @RequestParam(value = "details[0].idPlat", required = false) Integer[] idPlats,
                                @RequestParam(value = "dateDebut", required = false) String dateDebut,
                                @RequestParam(value = "dateFin", required = false) String dateFin,
                                Model model) {
        try {
           
            commande.setEntreprise(new Entreprise());
            commande.getEntreprise().setId(idEntreprise);

            
            if (commande.getDetails() != null && idPlats != null) {
                for (int i = 0; i < commande.getDetails().size() && i < idPlats.length; i++) {
                    DetailCommande detail = commande.getDetails().get(i);
                    if (detail != null) {
                        if (idPlats[i] == null) {
                            throw new IllegalArgumentException("Plat non spécifié pour un détail");
                        }
                        detail.setPlat(new Plat());
                        detail.getPlat().setId(idPlats[i]);
                        if (detail.getQuantite() == null || detail.getQuantite() <= 0) {
                            throw new IllegalArgumentException("Quantité invalide");
                        }
                        if (detail.getPrixUnitaire() == null || detail.getPrixUnitaire() < 0) {
                            throw new IllegalArgumentException("Prix unitaire invalide");
                        }
                    }
                }
            } else {
                throw new IllegalArgumentException("Aucun détail de commande fourni");
            }

            commandeService.updateCommande(commande);
            String redirectUrl = "/commande/?succes=Commande mise à jour";
            if (dateDebut != null && dateFin != null && !dateDebut.isEmpty() && !dateFin.isEmpty()) {
                redirectUrl += "&dateDebut=" + dateDebut + "&dateFin=" + dateFin;
            }
            return "redirect:" + redirectUrl;
        } catch (Exception e) {
            model.addAttribute("error", "Erreur lors de la mise à jour : " + e.getMessage());
            model.addAttribute("commande", commande);
            model.addAttribute("entreprises", commandeService.findAllEntreprises());
            model.addAttribute("plats", commandeService.findAllPlats());
            model.addAttribute("dateDebut", dateDebut);
            model.addAttribute("dateFin", dateFin);
            return "editCommande";
        }
    }
}
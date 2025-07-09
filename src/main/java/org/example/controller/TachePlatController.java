package org.example.controller;

import org.example.entity.TachePlat;
import org.example.service.TachePlatService;
import org.example.service.PlatService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/taches_plat")
public class TachePlatController {
    private final TachePlatService tachePlatService;
    private final PlatService platService;

    public TachePlatController(TachePlatService tachePlatService, PlatService platService) {
        this.tachePlatService = tachePlatService;
        this.platService = platService;
    }

    @GetMapping("/")
    public String showForm(@RequestParam(value = "id", required = false) Integer id, Model model) {
        TachePlat tachePlat = new TachePlat();
        if (id != null) {
            tachePlat = tachePlatService.findById(id).orElse(new TachePlat());
        }
        
        // Récupérer toutes les tâches et les regrouper par plat
        List<TachePlat> allTaches = tachePlatService.findAll();
        Map<Integer, List<TachePlat>> tachesGroupeesParPlat = allTaches.stream()
            .collect(Collectors.groupingBy(tache -> tache.getPlat().getId()));
        
        model.addAttribute("tachePlat", tachePlat);
        model.addAttribute("tachesPlats", allTaches);
        model.addAttribute("tachesGroupeesParPlat", tachesGroupeesParPlat);
        model.addAttribute("plats", platService.findAll());
        return "taches_plat";
    }

    @PostMapping("/save")
    public String saveTachePlat(
            @RequestParam("nom") String nom,
            @RequestParam("platId") Integer platId,
            @RequestParam("order") Integer ordre,
            @RequestParam(value = "id", required = false) Integer id,
            RedirectAttributes redirectAttributes) {
        
        TachePlat tachePlat = (id != null) ? tachePlatService.findById(id).orElse(new TachePlat()) : new TachePlat();
        tachePlat.setNom(nom);
        tachePlat.setPlat(platService.findById(platId).orElse(null));
        tachePlat.setOrdre(ordre);

        tachePlatService.saveOrUpdate(tachePlat);

        // redirectAttributes.addFlashAttribute("message", "Tâche Plat enregistrée avec succès !");

        return "redirect:/taches_plat/";
    }

    @GetMapping("/ajout")
    public String showAjoutForm(@RequestParam(value = "platId", required = false) Integer platId, Model model) {
        model.addAttribute("plats", platService.findAll());
        model.addAttribute("selectedPlatId", platId);
        
        // Si un plat est sélectionné, récupérer ses tâches
        if (platId != null) {
            List<TachePlat> tachesPlat = tachePlatService.findByPlatId(platId);
            model.addAttribute("tachesPlat", tachesPlat);
        }
        
        return "ajout_taches";
    }

    // Sauvegarder une tâche depuis la page d'ajout
    @PostMapping("/ajout/save")
    public String saveTacheFromAjout(
            @RequestParam("nom") String nom,
            @RequestParam("platId") Integer platId,
            @RequestParam("order") Integer ordre,
            @RequestParam(value = "id", required = false) Integer id,
            RedirectAttributes redirectAttributes) {
        
        TachePlat tachePlat = (id != null) ? tachePlatService.findById(id).orElse(new TachePlat()) : new TachePlat();
        tachePlat.setNom(nom);
        tachePlat.setPlat(platService.findById(platId).orElse(null));
        tachePlat.setOrdre(ordre);

        tachePlatService.saveOrUpdate(tachePlat);

        // redirectAttributes.addFlashAttribute("message", "Tâche ajoutée avec succès !");
        
        return "redirect:/taches_plat/ajout?platId=" + platId;
    }

    // Supprimer une tâche depuis la page d'ajout
    @GetMapping("/ajout/delete/{id}")
    public String deleteTacheFromAjout(@PathVariable("id") Integer id, RedirectAttributes redirectAttributes) {
        Integer platId = null;
        
        try {
            // Récupérer le platId avant suppression
            Optional<TachePlat> tache = tachePlatService.findById(id);
            if (tache.isPresent()) {
                platId = tache.get().getPlat().getId();
            }
            
            if (tachePlatService.existsById(id)) {
                tachePlatService.deleteById(id);
                // redirectAttributes.addFlashAttribute("message", "Tâche supprimée avec succès !");
            } else {
                redirectAttributes.addFlashAttribute("error", "Tâche non trouvée !");
            }
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Erreur lors de la suppression : " + e.getMessage());
        }

        return "redirect:/taches_plat/ajout" + (platId != null ? "?platId=" + platId : "");
    }

    @GetMapping("/delete/{id}")
    public String deleteTachePlat(@PathVariable("id") Integer id, RedirectAttributes redirectAttributes) {
        try{
            if(tachePlatService.existsById(id)) {
                tachePlatService.deleteById(id);
                // redirectAttributes.addFlashAttribute("message", "Tâche Plat supprimée avec succès !");
            } else {
                redirectAttributes.addFlashAttribute("error", "Tâche Plat non trouvée !");
            } 
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Erreur lors de la suppression de la Tâche Plat : " + e.getMessage());
        }
        return "redirect:/taches_plat/";
    }

    @GetMapping("/edit")
    public String editTachePlat(@RequestParam("id") Integer id, Model model) {
        TachePlat tachePlat = (id != null) ? tachePlatService.findById(id).orElse(new TachePlat()) : new TachePlat();
        
        // Récupérer toutes les tâches et les regrouper par plat
        List<TachePlat> allTaches = tachePlatService.findAll();
        Map<Integer, List<TachePlat>> tachesGroupeesParPlat = allTaches.stream()
            .collect(Collectors.groupingBy(tache -> tache.getPlat().getId()));
        
        model.addAttribute("tachePlat", tachePlat);
        model.addAttribute("tachesPlats", allTaches);
        model.addAttribute("tachesGroupeesParPlat", tachesGroupeesParPlat);
        model.addAttribute("plats", platService.findAll());
        return "taches_plat";
    }
}
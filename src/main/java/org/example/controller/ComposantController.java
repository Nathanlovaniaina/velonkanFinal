package org.example.controller;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

import org.example.entity.Composant;
import org.example.entity.TypeComposant;
import org.example.entity.dto.ComposantUsageDTO;
import org.example.service.ComposantService;
import org.example.service.TypeComposantService;
import org.example.service.UniteService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/composant")
public class ComposantController {

    private final ComposantService composantService;
    private final TypeComposantService typeComposantService;
    private final UniteService uniteService;

    public ComposantController(ComposantService composantService, 
                             TypeComposantService typeComposantService,
                             UniteService uniteService) {
        this.composantService = composantService;
        this.typeComposantService = typeComposantService;
        this.uniteService = uniteService;
    }

    @GetMapping("/")
    public String showForm(@RequestParam(value = "id", required = false) Integer id, Model model) {
        Composant composant = new Composant();
        if (id != null) {
            composant = composantService.findById(id).orElse(new Composant());
        }
        model.addAttribute("composant", composant);
        model.addAttribute("composants", composantService.findAll());
        model.addAttribute("typesComposant", typeComposantService.findAll());
        model.addAttribute("unites", uniteService.findAll());
        return "composant";
    }

    @PostMapping("/save")
    public String saveComposant(
            @RequestParam("nom") String nom,
            @RequestParam("idType") Integer idType,
            @RequestParam("idUnite") Integer idUnite,
            @RequestParam(value = "id", required = false) Integer id,
            RedirectAttributes redirectAttributes) {  

        Composant composant = (id != null) ? composantService.findById(id).orElse(new Composant()) : new Composant();
        composant.setNom(nom);
        composant.setTypeComposant(typeComposantService.findById(idType).orElse(null));
        composant.setUnite(uniteService.findById(idUnite).orElse(null));
        
        composantService.saveOrUpdate(composant);

        redirectAttributes.addFlashAttribute("succes",  "Composant enregistré !");
        
        return "redirect:/composant/";  
    }

    @GetMapping("/edit")
    public String editerComposant(@RequestParam("id") Integer id, Model model) {
        Composant composant = (id != null) ? composantService.findById(id).orElse(new Composant()) : new Composant();

        model.addAttribute("composant", composant);
        model.addAttribute("composants", composantService.findAll());
        model.addAttribute("typesComposant", typeComposantService.findAll());
        model.addAttribute("unites", uniteService.findAll());
        return "composant";
    }

    @GetMapping("/delete")
    public String delete(@RequestParam("id") Integer id, Model model) {
        try {
            if (composantService.existsById(id)) {
                composantService.deleteById(id);
                model.addAttribute("succes", "Composant supprimé avec succès");
            } else {
                model.addAttribute("avertissement", "Le composant avait déjà été supprimé");
            }
        } catch (Exception e) {
            model.addAttribute("erreur", "Erreur technique lors de la suppression");
        }
        
        model.addAttribute("composants", composantService.findAll());
        model.addAttribute("typesComposant", typeComposantService.findAll());
        model.addAttribute("unites", uniteService.findAll());
        return "composant";
    }

    @GetMapping("/most-used")
public String afficherComposantsPlusUtilises(
        @RequestParam(value = "dateDebut", required = false) String dateDebut,
        @RequestParam(value = "dateFin", required = false) String dateFin,
        @RequestParam(value = "typeId", required = false) Integer typeId,
        Model model) {
    
    // Conversion des dates
    LocalDate debutDate = dateDebut != null && !dateDebut.isEmpty() ? LocalDate.parse(dateDebut) : LocalDate.now().minusDays(30);
    LocalDate finDate = dateFin != null && !dateFin.isEmpty() ? LocalDate.parse(dateFin) : LocalDate.now();
    LocalDateTime debut = debutDate.atStartOfDay();
    LocalDateTime fin = finDate.atTime(23, 59, 59);

    // Récupération des données
    List<ComposantUsageDTO> composantUsages = composantService.findMostUsedComposants(debut, fin, typeId);
    List<TypeComposant> types = typeComposantService.findAll();

    // Log dans la console Tomcat
    System.out.println("\n=== COMPOSANTS LES PLUS UTILISÉS ===");
    System.out.println("Période du " + debut + " au " + fin);
    if (typeId != null) {
        System.out.println("Filtre type ID: " + typeId);
    }
    
    System.out.println("\nRésultats:");
    composantUsages.forEach(usage -> {
        System.out.println(String.format(
            "- %s (ID: %d): %d utilisations", 
            usage.getNom(),
            usage.getTotalUtilise()
        ));
    });
    System.out.println("===============================\n");

    // Ajout au modèle
    model.addAttribute("composantUsages", composantUsages);
    model.addAttribute("types", types);
    model.addAttribute("selectedDateDebut", dateDebut);
    model.addAttribute("selectedDateFin", dateFin);
    model.addAttribute("selectedTypeId", typeId);
    
    return "calendrier";
}
}
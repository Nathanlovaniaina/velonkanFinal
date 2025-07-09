package org.example.controller;

import org.example.entity.Composant;
import org.example.entity.DetailsPlat;
import org.example.entity.Employe;
import org.example.entity.Plat;
import org.example.service.ComposantService;
import org.example.service.DetailsPlatService;
import org.example.service.PlatService;
import org.example.service.TypeComposantService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;

import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.Date;
import java.util.List;
import java.util.Optional;
import java.util.Map;

@Controller
@RequestMapping("/plats")
public class PlatController {

    private final TypeComposantService typeComposantService;
    private final ComposantService composantService;
    private final DetailsPlatService detailsPlatService;

    public PlatController(TypeComposantService typeComposantService, ComposantService composantService, DetailsPlatService detailsPlatService) {
        this.typeComposantService = typeComposantService;
        this.composantService = composantService;
        this.detailsPlatService = detailsPlatService;
    }

    @Autowired
    private PlatService platService;

    @GetMapping
    public String getAllPlats(Model model) {
        List<Plat> plats = platService.findAll();
        for (Plat plat : plats) {
            System.out.println("Le plat "+plat.getIntitule()+" prix "+plat.getPrix()+" date "+plat.getDateCreation().toString());
        }
        model.addAttribute("plats", plats);
        return "plats";  // Ta vue Thymeleaf par exemple : src/main/resources/templates/plats/list.html
    }

    @GetMapping("/{id}")
    public String getPlatById(@PathVariable int id, Model model) {
        Optional<Plat> plat = platService.findById(id);
        plat.ifPresent(value -> model.addAttribute("plat", value));
        return "plats/detail";  // Exemple de vue détail
    }

    @GetMapping("/new")
    public String showCreateForm(Model model) {
        model.addAttribute("plat", new Plat());
        return "plats/create";  // Formulaire pour créer un plat
    }

    @PostMapping("/save")
    public String savePlat(
            @RequestParam(value = "id", required = false) Integer id,
            @RequestParam("intitule") String intitule,
            @RequestParam("prix") Integer prix,
            @RequestParam("dateCreation") @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate dateCreation,
            Model model
            ) {
        
        Plat plat = (id != null) ? platService.findById(id).orElse(new Plat()) : new Plat();
        plat.setIntitule(intitule);
        plat.setPrix(prix);
        plat.setDateCreation(dateCreation);

        platService.save(plat);
        model.addAttribute("plats", platService.findAll());

        return "plats";
    }

    @GetMapping("/delete/{id}")
    public String deletePlat(@PathVariable("id") Integer id, Model model) {
        platService.deleteById(id);
        model.addAttribute("succes", "Plat supprimé !");
        model.addAttribute("plats", platService.findAll());
        return "plats";
    }

    @GetMapping("/edit")
    public String modifierPlat(@RequestParam("id") Integer id, Model model) {
        Plat plat = platService.findById(id).orElse(new Plat());
        model.addAttribute("succes", "modification de plat  " + plat.getIntitule() + " !");
        model.addAttribute("plat", plat);
        model.addAttribute("employes", platService.findAll());
        model.addAttribute("plats", platService.findAll());
        return "plats";  // Formulaire pour modifier un plat
    }

    @GetMapping("/creer_plat")
    public String afficherFormulaire(@RequestParam(value = "typeComposantId", required = false) Integer typeId, Model model) {
        model.addAttribute("typesComposant", typeComposantService.findAll());

        if (typeId != null) {
            model.addAttribute("composants", composantService.findByTypeComposantId(typeId));
        } else {
            model.addAttribute("composants", composantService.findAll());
        }

        return "plat/creer_plat";
    }



    // CORRECTION : Mapping pour choix_quantite.jsp (GET et POST)
    @GetMapping("/choix_quantite")
    public String versChoixQuantite(@RequestParam(value = "composants", required = false) List<Integer> ids, Model model) {
        model.addAttribute("plats_montree", platService.findAll());
        if (ids == null || ids.isEmpty()) {
            model.addAttribute("composants", null);
        } else {
            List<Composant> composants = composantService.findAllById(ids); // <-- Méthode à bien créer dans le service
            model.addAttribute("composants", composants);
        }
        return "plat/choix_quantite";
    }

    // @PostMapping("/inserer_details_plat")
    // public String insererDetailsPlat(@RequestParam("nomPlat") String nomPlat,
    //                                 @RequestParam("composantsSelectionnes") List<Integer> composantsIds,
    //                                 @RequestParam Map<String, String> allParams,
    //                                 Model model) {

    //     Plat plat = platService.findByIntitule(nomPlat);
    //     if (plat == null) {
    //         model.addAttribute("erreur", "Le plat spécifié n'existe pas.");
    //         return "redirect:/plats/creer_plat";
    //     }

    //     for (Integer compoId : composantsIds) {
    //         String quantiteKey = "quantite_" + compoId;
    //         String quantiteStr = allParams.get(quantiteKey);

    //         if (quantiteStr != null && !quantiteStr.isEmpty()) {
    //             try {
    //                 double quantite = Double.parseDouble(quantiteStr);

    //                 DetailsPlat dp = new DetailsPlat();
    //                 dp.setPlat(plat);
    //                 dp.setComposant(composantService.findById(compoId).orElse(null));
    //                 dp.setQuantite(quantite);
    //                 detailsPlatService.save(dp);

    //             } catch (NumberFormatException e) {
    //                 // ignore ou log
    //             }
    //         }
    //     }

    //     model.addAttribute("succes", "Les composants ont bien été ajoutés au plat.");
    //     return "redirect:/plats";
    // }


    @GetMapping("/since-date")
    public String afficherPlatsDepuisDate(@RequestParam(value = "date", required = false) String date, Model model) {
        if (date != null && !date.isEmpty()) {
            LocalDate localDate = LocalDate.parse(date);
            List<Plat> plats = platService.findPlatsSinceDate(localDate);
            model.addAttribute("plats", plats);
            model.addAttribute("totalPlats", plats.size());
            model.addAttribute("selectedDate", date);
        } else {
            model.addAttribute("plats", platService.findAll());
            model.addAttribute("totalPlats", platService.findAll().size());
        }
        model.addAttribute("plat", new Plat());
        model.addAttribute("composants", composantService.findAll());
        return "plat";
    }


   
}
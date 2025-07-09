package org.example.controller;

import org.example.entity.Composant;
import org.example.entity.DetailsPlat;
import org.example.entity.Plat;
import org.example.service.ComposantService;
import org.example.service.DetailsPlatService;
import org.example.service.PlatService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;
import java.util.Optional;

@Controller
@RequestMapping("/plats")
public class DetailsPlatController {

    @Autowired
    private DetailsPlatService detailsPlatService;

    @Autowired
    private PlatService platService;

    @Autowired
    private ComposantService composantService;

   @PostMapping("/inserer_details_plat")
    public String insererDetailsPlat(@RequestParam("nomPlat") String nomPlat,
                                    @RequestParam("composantsSelectionnes") List<Integer> composantsIds,
                                    @RequestParam Map<String, String> allParams,
                                    Model model) {


        List<Plat> plats = platService.findByIntitule(nomPlat);
        Plat plat;

        if (plats == null || plats.isEmpty()) {
            plat = new Plat();
            plat.setIntitule(nomPlat);
            platService.save(plat);
        } else {

            plat = plats.get(0);
        }

        // Traitement des composants sélectionnés
        for (Integer compoId : composantsIds) {
            String quantiteKey = "quantite_" + compoId;
            String uniteKey = "unite_" + compoId;

            String quantiteStr = allParams.get(quantiteKey);
            String unite = allParams.get(uniteKey);

            if (quantiteStr != null && !quantiteStr.isEmpty()) {
                try {
                    double quantite = Double.parseDouble(quantiteStr);

                    Optional<Composant> optComposant = composantService.findById(compoId);
                    if (optComposant.isPresent()) {
                        Composant composant = optComposant.get();

                        DetailsPlat dp = new DetailsPlat();
                        dp.setPlat(plat);
                        dp.setComposant(composant);
                        dp.setQuantite(quantite);
                        dp.setUnite(unite);
                        detailsPlatService.save(dp);
                    }

                } catch (NumberFormatException e) {
                    // Log optionnel ici si besoin
                    continue;
                }
            }
        }

        // Charger et afficher les détails déjà enregistrés
        List<DetailsPlat> detailsPlats = detailsPlatService.findByPlat(plat);
        model.addAttribute("detailsPlats", detailsPlats);

        return "plat/choix_quantite";
    }



}

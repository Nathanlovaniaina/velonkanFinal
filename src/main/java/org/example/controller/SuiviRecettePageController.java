package org.example.controller;

import java.util.List;

import org.example.entity.Composant;
import org.example.entity.TypeComposant;
import org.example.service.ComposantService;
import org.example.service.TypeComposantService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/suivi")
public class SuiviRecettePageController {

    private final TypeComposantService typeComposantService;
    private final ComposantService composantService;

    public SuiviRecettePageController(TypeComposantService typeComposantService, ComposantService composantService) {
        this.typeComposantService = typeComposantService;
        this.composantService = composantService;
    }

    @GetMapping("/recette")
    public String showDashboardRecette() {
        return "Dashboard/recette";
    }

    @GetMapping("/benefice")
    public String showDashboardBenefice() {
        return "Dashboard/benefice";
    }

    @GetMapping("/depense")
    public String showDashboardDepense(Model model) {
        List<Composant> composants = composantService.findAll();
        List<TypeComposant> typeComposants = typeComposantService.findAll();
        model.addAttribute("categories", typeComposants);
        model.addAttribute("composants", composants);
        return "Dashboard/depense";
    }
}

package org.example.controller;

import org.example.entity.TypeComposant;
import org.example.service.TypeComposantService;
import org.example.service.ComposantService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/type_composant")
public class TypeComposantController {

    private final TypeComposantService typeComposantService;
    private final ComposantService composantService;

    public TypeComposantController(TypeComposantService typeComposantService, ComposantService composantService) {
        this.typeComposantService = typeComposantService;
        this.composantService = composantService;
    }

    @GetMapping("/")
    public String showForm(@RequestParam(value = "id", required = false) Integer id, Model model) {
        TypeComposant typeComposant = new TypeComposant();
        if (id != null) {
            typeComposant = typeComposantService.findById(id).orElse(new TypeComposant());
        }
        model.addAttribute("typeComposant", typeComposant);
        model.addAttribute("typesComposant", typeComposantService.findAll());
        return "type_composant";
    }

    @PostMapping("/save")
    public String saveTypeComposant(
            @RequestParam("nom") String nom,
            @RequestParam(value = "id", required = false) Integer id,
            RedirectAttributes redirectAttributes) {  

        TypeComposant typeComposant = (id != null) ? typeComposantService.findById(id).orElse(new TypeComposant()) : new TypeComposant();
        typeComposant.setNom(nom);
        
        typeComposantService.saveOrUpdate(typeComposant);

        redirectAttributes.addFlashAttribute("succes",  "Type de composant enregistré !");
        
        return "redirect:/type_composant/";  
    }

    @GetMapping("/edit")
    public String editerTypeComposant(@RequestParam("id") Integer id, Model model) {
        TypeComposant typeComposant = (id != null) ? typeComposantService.findById(id).orElse(new TypeComposant()) : new TypeComposant();

        model.addAttribute("typeComposant", typeComposant);
        model.addAttribute("typesComposant", typeComposantService.findAll());
        return "type_composant";
    }

    @GetMapping("/delete")
    public String delete(@RequestParam("id") Integer id, Model model) {
        try {
            if (typeComposantService.existsById(id)) {
                composantService.deleteByTypeComposantId(id);
                typeComposantService.deleteById(id);
                model.addAttribute("succes", "Type composant supprimé avec succès");
            } else {
                model.addAttribute("avertissement", "Le type de composant avait déjà été supprimé");
            }
        } catch (Exception e) {
            model.addAttribute("erreur", "Erreur technique lors de la suppression");
        }
        
        model.addAttribute("typesComposant", typeComposantService.findAll());
        return "type_composant";
    }
}
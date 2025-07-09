package org.example.controller;

import org.example.entity.Unite;
import org.example.service.UniteService;
import org.example.service.ComposantService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/unite")
public class UniteController {

    private final UniteService uniteService;
    private final ComposantService composantService;

    public UniteController(UniteService uniteService, ComposantService composantService) {
        this.uniteService = uniteService;
        this.composantService = composantService;
    }

    @GetMapping("/")
    public String showForm(@RequestParam(value = "id", required = false) Integer id, Model model) {
        Unite unite = new Unite();
        if (id != null) {
            unite = uniteService.findById(id).orElse(new Unite());
        }
        model.addAttribute("unite", unite);
        model.addAttribute("unites", uniteService.findAll());
        return "unite";
    }

    @PostMapping("/save")
    public String saveUnite(
            @RequestParam("nom") String nom,
            @RequestParam("symbol") String symbol,
            @RequestParam(value = "id", required = false) Integer id,
            RedirectAttributes redirectAttributes) {  // Utilisez RedirectAttributes

        Unite unite = (id != null) ? uniteService.findById(id).orElse(new Unite()) : new Unite();
        unite.setNom(nom);
        unite.setSymbol(symbol);

        uniteService.saveOrUpdate(unite);

        redirectAttributes.addFlashAttribute("succes", "Unité enregistrée !");
        
        return "redirect:/unite/";  // Redirection GET vers l'affichage
    }

    @GetMapping("/edit")
    public String editerUnite(@RequestParam("id") Integer id, Model model) {
        Unite unite = (id != null) ? uniteService.findById(id).orElse(new Unite()) : new Unite();

        model.addAttribute("unite", unite);
        model.addAttribute("unites", uniteService.findAll());
        return "unite";
    }

    @GetMapping("/delete")
    public String delete(@RequestParam("id") Integer id, Model model) {
        try {
            if (uniteService.existsById(id)) {
                composantService.deleteByUniteId(id);
                uniteService.deleteById(id);
                model.addAttribute("succes", "Unité supprimée avec succès");
            } else {
                model.addAttribute("avertissement", "L'unité avait déjà été supprimée");
            }
        } catch (Exception e) {
            model.addAttribute("erreur", "Erreur technique lors de la suppression");
        }
        
        model.addAttribute("unites", uniteService.findAll());
        return "unite";
    }
}
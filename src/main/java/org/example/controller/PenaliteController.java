package org.example.controller;

import org.example.entity.Penalite;
import org.example.service.PenaliteService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/penalite")
public class PenaliteController {

    private final PenaliteService penaliteService;

    public PenaliteController(PenaliteService penaliteService) {
        this.penaliteService = penaliteService;
    }

    @GetMapping("/")
    public String afficherPenalites(Model model) {
        model.addAttribute("penalites", penaliteService.findAll());
        model.addAttribute("penalite", new Penalite());
        return "penalite";
    }

    @GetMapping("/edit")
    public String editerPenalite(@RequestParam("id") Integer id, Model model) {
        Penalite pen = penaliteService.findById(id).orElse(new Penalite());

        model.addAttribute("penalite", pen);
        model.addAttribute("penalites", penaliteService.findAll());
        return "penalite";
    }

    @PostMapping("/save")
    public String enregistrerPenalite(
            @RequestParam(value = "id", required = false) Integer id,
            @RequestParam("nb_jour") Integer nbJour,
            @RequestParam("pourcent") Integer pourcent,
            Model model) {

        Penalite pen = (id != null) ? penaliteService.findById(id).orElse(new Penalite()) : new Penalite();
        pen.setNbJour(nbJour);
        pen.setPourcentage(pourcent);
        penaliteService.saveOrUpdate(pen);

        model.addAttribute("succes", "Pénalité enregistrée avec succès");
        model.addAttribute("penalites", penaliteService.findAll());
        model.addAttribute("penalite", new Penalite());
        return "penalite";
    }

    @GetMapping("/delete")
    public String supprimerPenalite(@RequestParam("id") Integer id, Model model) {
        penaliteService.delete(id);
        model.addAttribute("succes", "Pénalité supprimée avec succès");
        model.addAttribute("penalites", penaliteService.findAll());
        model.addAttribute("penalite", new Penalite());
        return "penalite";
    }
}

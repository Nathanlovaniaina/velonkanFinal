package org.example.controller;

import org.example.entity.Poste;
import org.example.service.PosteService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/poste")
public class PosteController {

    private final PosteService posteService;

    public PosteController(PosteService posteService) {
        this.posteService = posteService;
    }

    @GetMapping("/")
    public String showForm(@RequestParam(value = "id", required = false) Integer id, Model model) {
        Poste poste = new Poste();
        if (id != null) {
            poste = posteService.findById(id).orElse(new Poste());
        }

        model.addAttribute("poste", poste);
        model.addAttribute("postes", posteService.findAll());
        return "poste";
    }

    @PostMapping("/save")
    public String savePoste(
            @RequestParam("nom") String nom,
            @RequestParam("salaire") Double salaire,
            @RequestParam(value = "id", required = false) Integer id,
            Model model) {

        Poste poste = (id != null) ? posteService.findById(id).orElse(new Poste()) : new Poste();
        poste.setNom(nom);
        poste.setSalaire(salaire);
        posteService.saveOrUpdate(poste);

        model.addAttribute("succes", "Poste enregistré !");
        model.addAttribute("poste", new Poste());
        model.addAttribute("postes", posteService.findAll());
        return "poste";
    }

    @GetMapping("edit")
    public String editerPoste(@RequestParam("id") Integer id, Model model) {
        Poste poste = (id != null) ? posteService.findById(id).orElse(new Poste()) : new Poste();

        model.addAttribute("poste", poste);
        model.addAttribute("postes", posteService.findAll());
        return "poste";
    }

    @GetMapping("/delete")
    public String delete(@RequestParam("id") Integer id, Model model) {
        posteService.deleteById(id);
        model.addAttribute("succes", "Poste supprimé !");
        model.addAttribute("poste", new Poste());
        model.addAttribute("postes", posteService.findAll());
        return "poste";
    }
}

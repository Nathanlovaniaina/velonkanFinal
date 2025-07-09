package org.example.controller;

import org.example.entity.Depense;
import org.example.service.DepenseService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Date;

@Controller
@RequestMapping("/depense")
public class DepenseController {

    private final DepenseService depenseService;

    public DepenseController(DepenseService depenseService) {
        this.depenseService = depenseService;
    }

    @GetMapping("/")
    public String showForm(@RequestParam(value = "id", required = false) Integer id, Model model) {
        Depense depense = new Depense();
        if (id != null) {
            depense = depenseService.findById(id).orElse(new Depense());
        }
        model.addAttribute("depense", depense);
        model.addAttribute("depenses", depenseService.findAll());
        return "depense";
    }

    @GetMapping("/save")
    public String saveDepense(
            @RequestParam("description") String description,
            @RequestParam("somme") Double somme,
            @RequestParam(value = "id", required = false) Integer id,
            Model model) {

        Depense depense = (id != null) ? depenseService.findById(id).orElse(new Depense()) : new Depense();
        depense.setDescription(description);
        depense.setSomme(somme);
        depense.setDateCreation(new Date());

        depenseService.saveOrUpdate(depense);

        model.addAttribute("succes", "Dépense enregistrée !");
        model.addAttribute("depenses", depenseService.findAll());
        model.addAttribute("depense", new Depense());

        return "depense";
    }

    @GetMapping("/edit")
    public String editerDepense(@RequestParam("id") Integer id, Model model) {
        Depense depense = (id != null) ? depenseService.findById(id).orElse(new Depense()) : new Depense();

        model.addAttribute("depense", depense);
        model.addAttribute("depenses", depenseService.findAll());
        return "depense";
    }

    @GetMapping("/delete")
    public String delete(@RequestParam("id") Integer id, Model model) {
        depenseService.deleteById(id);
        model.addAttribute("succes", "Dépense supprimée !");
        model.addAttribute("depenses", depenseService.findAll());
        model.addAttribute("depense", new Depense());
        return "depense";
    }
}

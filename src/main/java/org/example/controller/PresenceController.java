package org.example.controller;

import org.example.entity.Employe;
import org.example.entity.Presence;
import org.example.service.EmployeService;
import org.example.service.PresenceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.Date;
import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("/presences")
public class PresenceController {

    @Autowired
    private final PresenceService presenceService;
    @Autowired
    private final EmployeService employeService;

    public PresenceController(PresenceService presenceService, EmployeService employeService) {
        this.presenceService = presenceService;
        this.employeService = employeService;
    }

    @GetMapping("/presence/list")
    public String listPresences(Model model) {
        model.addAttribute("presences", presenceService.findAll());
        return "/presence/presence_list";
    }

    @GetMapping("/presence/add")
    public String formAjout(Model model) {
        model.addAttribute("presence", new Presence());
        model.addAttribute("employes", employeService.findAll());
        return "/presence/presence_form";
    }

    @PostMapping("/presence/save")
    public String enregistrer(@RequestParam("id_emp") Integer id,
                            Model model) {
        
        Optional<Employe> employeOpt = employeService.findById(id);
        if(employeOpt.isPresent()){
        Presence presence = new Presence();
        presence.setEmploye(employeOpt.get());
        presence.setDatePres(LocalDate.now());
        presenceService.save(presence);
        }
        return "redirect:/presences/presence/list";
    }

    @GetMapping("/search")
    public String rechercherParDate(@RequestParam("date") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate date,
                                    Model model) {
        List<Presence> resultats = presenceService.findByDate(date);
        model.addAttribute("presences", resultats);
        return "presence/list";
    }

    @GetMapping("/presence/delete/{id}")
    public String supprimer(@PathVariable Long id) {
        presenceService.deleteById(id);
        return "redirect:/presences/presence/presence_list";
    }
}
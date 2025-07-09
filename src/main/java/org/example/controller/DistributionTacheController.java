package org.example.controller;

import org.example.entity.DistributionTache;
import org.example.entity.Employe;
import org.example.entity.Plat;
import org.example.entity.Tache;
import org.example.entity.TachePlat;
import org.example.repository.EmployeRepository;
import org.example.repository.PublicationPlatRepository;
import org.example.repository.TachePlatRepository;
import org.example.repository.TacheRepository;
import org.example.repository.MvtStatutTacheRepository;
import org.example.service.DisributionTacheService;
import org.example.service.TachePlatService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.Calendar;
import java.util.List;

@Controller
@RequestMapping("/taches")
public class DistributionTacheController {

    @Autowired
    private DisributionTacheService distributionService;

    @Autowired
    private EmployeRepository employeRepository;

    @Autowired
    private TacheRepository tacheRepository;

    @Autowired
    private TachePlatRepository tachePlatRepository;

    @Autowired 
    private TachePlatService tachePlatService;


    @Autowired
    private PublicationPlatRepository ppRepository;

    @Autowired
    private MvtStatutTacheRepository mvtTacheRepository;


    @GetMapping("/taches-par-plat")
    @ResponseBody
    public List<TachePlat> getTachesParPlat(@RequestParam("platId") Integer platId) {
        return tachePlatService.getTachesParPlat(platId);
    }

    @RequestMapping("/calendrier")
    public String afficherCalendrier(@RequestParam(name="month" ,defaultValue = "-1") int month,
                                    @RequestParam(name="year",defaultValue = "-1") int year,
                                    Model model) {
        LocalDate now = LocalDate.now();
        if (month == -1) month = now.getMonthValue();
        if (year == -1) year = now.getYear();

        Calendar cal = Calendar.getInstance();
        cal.set(Calendar.YEAR, year);
        cal.set(Calendar.MONTH, month - 1); 

        model.addAttribute("month", month);
        model.addAttribute("year", year);
        model.addAttribute("cal", cal);

        return "tache/calendar";
    }



    @GetMapping("/form")
    public String afficherFormulaireDistribution(
            @RequestParam(value = "date", required = false)
            @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate date,
            Model model) {

        if (date == null) {
            date = LocalDate.now();
        }

        List<Employe> employes = employeRepository.findAll();
        List<Plat> plats = ppRepository.findPlatsByPublicationDate(date);
        List<Tache> taches = tacheRepository.findAll();

        model.addAttribute("distribution", new DistributionTache());
        model.addAttribute("employes", employes);
        model.addAttribute("plats", plats);
        model.addAttribute("taches", taches);
        model.addAttribute("date", date);

        return "tache/distribution_tache";
    }

    @PostMapping("/submit")
    public String distribuerTachesMultiples(
            @RequestParam("employeIds") List<Integer> employeIds,
            @RequestParam("date_tache") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate dateTache,
            @RequestParam(value = "tache.id", required = false) Integer tacheId,
            @RequestParam(value = "tachePlat.id", required = false) Integer tachePlatId,
            Model model
    ) {
        try {
            boolean hasTache = tacheId != null;
            boolean hasTachePlat = tachePlatId != null;
            System.out.println("Date reçue: " + dateTache);

            if (hasTache && hasTachePlat) {
                throw new IllegalArgumentException("Vous ne pouvez pas sélectionner une tâche manuelle ET une tâche de plat en même temps.");
            }

            if (!hasTache && !hasTachePlat) {
                throw new IllegalArgumentException("Vous devez sélectionner une tâche manuelle ou une tâche liée à un plat.");
            }

            List<DistributionTache> liste = new java.util.ArrayList<>();

            for (Integer employeId : employeIds) {
                DistributionTache d = new DistributionTache();
                d.setDateTache(dateTache);
                d.setEmploye(employeRepository.findById(employeId).orElseThrow());

                if (hasTache) {
                    d.setTache(tacheRepository.findById(tacheId).orElseThrow());
                } else {
                    d.setTachePlat(tachePlatRepository.findById(tachePlatId).orElseThrow());
                }

                liste.add(d);
            }

            distributionService.distribuerTaches(liste);
            model.addAttribute("message", "Tâches distribuées à plusieurs employés avec succès !");
        } catch (Exception e) {
            model.addAttribute("erreur", e.getMessage());
        }

        model.addAttribute("distribution", new DistributionTache());
        model.addAttribute("employes", employeRepository.findAll());
        model.addAttribute("plats", ppRepository.findPlatsByPublicationDate(dateTache));
        model.addAttribute("taches", tacheRepository.findAll());
        model.addAttribute("date", dateTache);

        return "tache/distribution_tache";
    }

}
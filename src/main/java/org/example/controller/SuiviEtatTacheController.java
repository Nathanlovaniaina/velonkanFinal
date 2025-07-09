package org.example.controller;

import org.example.entity.Plat;
import org.example.entity.TachePlat;
import org.example.service.MvtStatutTacheService;
import org.example.service.PlatService;
import org.example.service.TachePlatService;
import org.example.repository.PublicationPlatRepository;
import org.example.repository.TachePlatRepository;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.*;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/suivi/taches")
public class SuiviEtatTacheController {

    private final PublicationPlatRepository publicationPlatRepository;
    private final TachePlatRepository tachePlatRepository;
    private final TachePlatService tachePlatService;
    private final PlatService platService;
    private final MvtStatutTacheService mvtStatutTacheService;

    public SuiviEtatTacheController(
            PublicationPlatRepository publicationPlatRepository,
            TachePlatRepository tachePlatRepository,
            TachePlatService tachePlatService,
            PlatService platService,
            MvtStatutTacheService mvtStatutTacheService
    ) {
        this.publicationPlatRepository = publicationPlatRepository;
        this.tachePlatRepository = tachePlatRepository;
        this.tachePlatService = tachePlatService;
        this.platService = platService;
        this.mvtStatutTacheService = mvtStatutTacheService;
    }

    @GetMapping
    public String afficherSuivi(
            @RequestParam(value = "date", required = false)
            @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate date,
            Model model) {

        if (date == null) {
            date = LocalDate.now();
        }

        final LocalDate finalDate = date;
        List<Plat> plats = publicationPlatRepository.findPlatsByPublicationDate(finalDate);

        List<Map<String, Object>> platsAvecTaches = plats.stream().map(plat -> {
            Map<String, Object> platMap = new HashMap<>();
            platMap.put("plat", plat);

            Optional<Integer> statutGlobalPlat = platService.getStatutGlobalParPlatParDate(plat.getId(), finalDate);
            platMap.put("statutGlobal", statutGlobalPlat.orElse(0));

            List<TachePlat> taches = tachePlatRepository.findByPlatId(plat.getId());
            List<Map<String, Object>> tachesAvecStatut = taches.stream().map(tache -> {
                Map<String, Object> tacheMap = new HashMap<>();
                tacheMap.put("tache", tache);
                tacheMap.put("statut", tachePlatService.getStatutGlobalParTachePlatParDate(tache.getId(), finalDate).orElse(0));
                return tacheMap;
            }).collect(Collectors.toList());

            platMap.put("taches", tachesAvecStatut);
            return platMap;
        }).collect(Collectors.toList());

        model.addAttribute("date", date);
        model.addAttribute("platsAvecTaches", platsAvecTaches);
        return "suivi_etat_tache";
    }

    @PostMapping("/modifier-tache")
    public String modifierTache(
            @RequestParam("idTachePlat") int idTachePlat,
            @RequestParam("newStatut") int newStatut,
            @RequestParam("date") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate date
    ) throws Exception {
        mvtStatutTacheService.modifierStatutTacheParIdTachePlat(idTachePlat, newStatut, date);
        return "redirect:/suivi/taches?date=" + date;
    }
}

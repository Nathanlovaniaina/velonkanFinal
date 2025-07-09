package org.example.controller;

import org.example.service.SuiviRecetteService;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/suiviRecette")
public class SuiviRecetteRestController {

    private final SuiviRecetteService suiviRecetteService;

    public SuiviRecetteRestController(SuiviRecetteService suiviRecetteService) {
        this.suiviRecetteService = suiviRecetteService;
    }

    @GetMapping("/revenu_mensuel")
    public List<Map<String, Object>> getRevenuMensuel(
            @RequestParam("startDate") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate startDate,
            @RequestParam("endDate") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate endDate,
            @RequestParam(value = "entrepriseId", required = false) Long entrepriseId,
            @RequestParam(value = "platId", required = false) Long platId) {

        System.out.println("Les donnees recue sont :"+entrepriseId +"   " +platId);
            
        List<Object[]> data = suiviRecetteService.getRevenuMensuelParAnnee(startDate,endDate, entrepriseId,  platId);

        return data.stream().map(row -> {
            Map<String, Object> map = new HashMap<>();
            map.put("mois", ((Number) row[0]).intValue());
            map.put("annee", ((Number) row[1]).intValue());
            map.put("revenuMensuel", ((Number) row[2]).doubleValue());

            // Ajout des nouvelles colonnes si elles existent
            if (row.length > 3) map.put("nombreFactures", ((Number) row[3]).intValue());
            if (row.length > 4) map.put("nombreEntreprises", ((Number) row[4]).intValue());
            if (row.length > 5) map.put("totalPlatsVendus", ((Number) row[5]).intValue());

            return map;
        }).toList();
    }

    @GetMapping("/revenu_par_entreprise")
    public List<Map<String, Object>> getRevenuParEntreprise(
            @RequestParam("startDate") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate startDate,
            @RequestParam("endDate") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate endDate) {

        List<Object[]> data = suiviRecetteService.getRevenuParEntreprise(startDate, endDate);

        return data.stream().map(row -> {
            Map<String, Object> map = new HashMap<>();
            map.put("entreprise", (String) row[0]);
            map.put("revenuEntreprise", ((Number) row[1]).doubleValue());
            map.put("nombre_total_commandes", ((Number) row[2]).doubleValue());
            map.put("nombre_total_plats", ((Number) row[3]).doubleValue());
            return map;
        }).toList();
    }

    @GetMapping("/revenu_journalier")
    public List<Map<String, Object>> getRevenuJournalierEtEvolution(
            @RequestParam("startDate") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate startDate,
            @RequestParam("endDate") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate endDate) {

        List<Object[]> data = suiviRecetteService.getRevenuJournalierEtEvolution(startDate, endDate);

        return data.stream().map(row -> {
            Map<String, Object> map = new HashMap<>();

            // Conversion propre de la date
            if (row[0] instanceof java.sql.Date) {
                map.put("date_emission", ((java.sql.Date) row[0]).toLocalDate().toString());
            } else if (row[0] instanceof java.time.LocalDate) {
                map.put("date_emission", row[0].toString());
            } else {
                map.put("date_emission", String.valueOf(row[0]));
            }

            // Revenu journalier
            map.put("revenu_journalier", row[1] != null ? ((Number) row[1]).doubleValue() : 0.0);

            // Revenu veille
            map.put("revenu_veille", row[2] != null ? ((Number) row[2]).doubleValue() : 0.0);

            // Evolution
            map.put("evolution", row[3] != null ? ((Number) row[3]).doubleValue() : 0.0);

            return map;
        }).toList();
    }

    @GetMapping("/factures_retard")
    public List<Map<String, Object>> getFacturesEnRetard(
            @RequestParam("startDate") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate startDate,
            @RequestParam("endDate") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate endDate) {
            
        List<Object[]> data = suiviRecetteService.getFacturesEnRetard(startDate, endDate);
            
        return data.stream().map(row -> {
            Map<String, Object> map = new HashMap<>();
            map.put("facture", ((Number) row[0]).intValue());
            map.put("entreprise", (String) row[1]);
            map.put("montant_total", ((Number) row[2]).doubleValue());
            map.put("date_emission", row[3].toString());
            map.put("jours_retard", ((Number) row[4]).intValue());
            return map;
        }).toList();
    }




}

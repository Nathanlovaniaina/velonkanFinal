package org.example.controller;

import org.example.service.SuiviDepensesService;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/suiviDepenses")
public class SuiviDepensesRestController {

    private final SuiviDepensesService suiviDepensesService;

    public SuiviDepensesRestController(SuiviDepensesService suiviDepensesService) {
        this.suiviDepensesService = suiviDepensesService;
    }

    @GetMapping("/depenses-par-composant")
    public List<Map<String, Object>> getDepensesParComposant(
            @RequestParam("startDate") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate startDate,
            @RequestParam("endDate") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate endDate,
            @RequestParam(value = "categorieId", required = false) Long categorieId,
            @RequestParam(value = "composantId", required = false) Long composantId) {

        List<Object[]> data = suiviDepensesService.getDepensesParComposant(startDate, endDate, categorieId, composantId);

        return data.stream().map(row -> {
            Map<String, Object> map = new HashMap<>();
            map.put("id_composant", ((Number) row[0]).longValue());
            map.put("composant", (String) row[1]);
            map.put("categorie", (String) row[2]);
            map.put("unite", (String) row[3]);
            map.put("symbole_unite", (String) row[4]);
            map.put("quantite_totale", ((Number) row[5]).doubleValue());
            map.put("montant_total", ((Number) row[6]).doubleValue());
            map.put("prix_moyen_unitaire", ((Number) row[7]).doubleValue());
            return map;
        }).toList();
    }

    @GetMapping("/evolution-depenses-mensuelles")
    public List<Map<String, Object>> getEvolutionDepensesMensuelles(
            @RequestParam("startDate") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate startDate,
            @RequestParam("endDate") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate endDate) {

        List<Object[]> data = suiviDepensesService.getEvolutionDepensesMensuelles(startDate, endDate);

        return data.stream().map(row -> {
            Map<String, Object> map = new HashMap<>();
            map.put("annee", ((Number) row[0]).intValue());
            map.put("mois", ((Number) row[1]).intValue());
            map.put("depenses_mensuelles", ((Number) row[2]).doubleValue());
            map.put("depenses_mois_precedent", row[3] != null ? ((Number) row[3]).doubleValue() : 0.0);
            map.put("evolution_pct", row[4] != null ? ((Number) row[4]).doubleValue() : 0.0);
            return map;
        }).toList();
    }

    @GetMapping("/top-composants-couteux")
    public List<Map<String, Object>> getTopComposantsPlusCouteux(
            @RequestParam("startDate") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate startDate,
            @RequestParam("endDate") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate endDate,
            @RequestParam(value = "limit", defaultValue = "10") int limit) {

        List<Object[]> data = suiviDepensesService.getTopComposantsPlusCouteux(startDate, endDate, limit);

        return data.stream().map(row -> {
            Map<String, Object> map = new HashMap<>();
            map.put("composant", (String) row[0]);
            map.put("montant_total", ((Number) row[1]).doubleValue());
            map.put("quantite_totale", ((Number) row[2]).doubleValue());
            map.put("prix_moyen", ((Number) row[3]).doubleValue());
            return map;
        }).toList();
    }

    @GetMapping("/depenses-par-categorie")
    public List<Map<String, Object>> getDepensesParCategorie(
            @RequestParam("startDate") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate startDate,
            @RequestParam("endDate") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate endDate) {

        List<Object[]> data = suiviDepensesService.getDepensesParComposant(startDate, endDate, null, null);

        // Regroupement par catégorie
        Map<String, Map<String, Object>> categories = new HashMap<>();
        
        data.forEach(row -> {
            String categorie = (String) row[2];
            double montant = ((Number) row[6]).doubleValue();
            
            categories.computeIfAbsent(categorie, k -> {
                Map<String, Object> map = new HashMap<>();
                map.put("categorie", categorie);
                map.put("montant_total", 0.0);
                map.put("nombre_composants", 0);
                return map;
            });
            
            Map<String, Object> categorieMap = categories.get(categorie);
            categorieMap.put("montant_total", ((Number) categorieMap.get("montant_total")).doubleValue() + montant);
            categorieMap.put("nombre_composants", ((Number) categorieMap.get("nombre_composants")).intValue() + 1);
        });

        return List.copyOf(categories.values());
    }

    @GetMapping("/comparaison-consommation")
    public List<Map<String, Object>> getComparaisonConsommation(
            @RequestParam("startDate") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate startDate,
            @RequestParam("endDate") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate endDate) {
            
        List<Object[]> data = suiviDepensesService.getComparaisonConsommation(startDate, endDate);
            
        return data.stream().map(row -> {
            Map<String, Object> map = new HashMap<>();
            map.put("id_composant", ((Number) row[0]).longValue());
            map.put("composant", (String) row[1]);
            map.put("unite", (String) row[2]);
            map.put("symbole_unite", (String) row[3]);
            map.put("quantite_theorique", ((Number) row[4]).doubleValue());
            map.put("quantite_reelle", ((Number) row[5]).doubleValue());
            map.put("difference", ((Number) row[6]).doubleValue());
            map.put("pourcentage_ecart", row[7] != null ? ((Number) row[7]).doubleValue() : null);
            return map;
        }).toList();
    }

}
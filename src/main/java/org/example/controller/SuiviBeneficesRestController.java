package org.example.controller;

import org.example.service.SuiviBeneficesService;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/suiviBenefices")
public class SuiviBeneficesRestController {

    private final SuiviBeneficesService suiviBeneficesService;

    public SuiviBeneficesRestController(SuiviBeneficesService suiviBeneficesService) {
        this.suiviBeneficesService = suiviBeneficesService;
    }

    @GetMapping("/revenu-total")
    public List<Map<String, Object>> getRevenuTotal(
            @RequestParam("startDate") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate startDate,
            @RequestParam("endDate")   @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate endDate) {

        List<Object[]> data = suiviBeneficesService.getRevenuTotal(startDate, endDate);

        return data.stream().map(row -> {
            Map<String, Object> map = new HashMap<>();
            // revenu_total peut être null si pas de donnée
            map.put("revenu_total", row[0] != null ? ((Number) row[0]).doubleValue() : 0.0);
            return map;
        }).toList();
    }

    @GetMapping("/cout-total")
    public List<Map<String, Object>> getCoutTotal(
            @RequestParam("startDate") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate startDate,
            @RequestParam("endDate")   @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate endDate) {

        List<Object[]> data = suiviBeneficesService.getCoutTotal(startDate, endDate);

        return data.stream().map(row -> {
            Map<String, Object> map = new HashMap<>();
            map.put("cout_total", row[0] != null ? ((Number) row[0]).doubleValue() : 0.0);
            return map;
        }).toList();
    }

    @GetMapping("/benefice-net")
    public List<Map<String, Object>> getBeneficeNet(
            @RequestParam("startDate") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate startDate,
            @RequestParam("endDate")   @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate endDate) {

        List<Object[]> data = suiviBeneficesService.getBeneficeNet(startDate, endDate);

        return data.stream().map(row -> {
            Map<String, Object> map = new HashMap<>();
            map.put("total_revenu", row[0] != null ? ((Number) row[0]).doubleValue() : 0.0);
            map.put("total_cout", row[1] != null ? ((Number) row[1]).doubleValue() : 0.0);
            map.put("benefice_net", row[2] != null ? ((Number) row[2]).doubleValue() : 0.0);
            return map;
        }).toList();
    }

    @GetMapping("/revenus-par-entreprise")
    public List<Map<String, Object>> getRevenusParEntreprise(
            @RequestParam("startDate") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate startDate,
            @RequestParam("endDate")   @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate endDate) {

        List<Object[]> data = suiviBeneficesService.getRevenusParEntreprise(startDate, endDate);

        return data.stream().map(row -> {
            Map<String, Object> map = new HashMap<>();
            map.put("entreprise", (String) row[0]);
            map.put("revenu", row[1] != null ? ((Number) row[1]).doubleValue() : 0.0);
            return map;
        }).toList();
    }

    @GetMapping("/benefices-par-plat")
    public List<Map<String, Object>> getBeneficesParPlat(
            @RequestParam("startDate") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate startDate,
            @RequestParam("endDate")   @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate endDate) {

        List<Object[]> data = suiviBeneficesService.getBeneficesParPlat(startDate, endDate);

        return data.stream().map(row -> {
            Map<String, Object> map = new HashMap<>();
            map.put("plat", (String) row[0]);
            map.put("total_vendus", row[1] != null ? ((Number) row[1]).intValue() : 0);
            map.put("revenu_total", row[2] != null ? ((Number) row[2]).doubleValue() : 0.0);
            map.put("cout_total", row[3] != null ? ((Number) row[3]).doubleValue() : 0.0);
            map.put("benefice", row[4] != null ? ((Number) row[4]).doubleValue() : 0.0);
            return map;
        }).toList();
    }

    @GetMapping("/salaires-verses")
    public List<Map<String, Object>> getSalairesVerses(
            @RequestParam("startDate") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate startDate,
            @RequestParam("endDate")   @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate endDate) {

        List<Object[]> data = suiviBeneficesService.getSalairesVerses(startDate, endDate);

        return data.stream().map(row -> {
            Map<String, Object> map = new HashMap<>();
            map.put("total_salaire", row[0] != null ? ((Number) row[0]).doubleValue() : 0.0);
            return map;
        }).toList();
    }

    @GetMapping("/bilan-journalier")
    public List<Map<String, Object>> getBilanJournalier(
            @RequestParam("startDate") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate startDate,
            @RequestParam("endDate")   @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate endDate) {

        List<Object[]> data = suiviBeneficesService.getBilanJournalier(startDate, endDate);

        return data.stream().map(row -> {
            Map<String, Object> map = new HashMap<>();
            map.put("jour", row[0]);
            map.put("revenu_journalier", row[1] != null ? ((Number) row[1]).doubleValue() : 0.0);
            map.put("cout_journalier", row[2] != null ? ((Number) row[2]).doubleValue() : 0.0);
            map.put("benefice_journalier", row[3] != null ? ((Number) row[3]).doubleValue() : 0.0);
            return map;
        }).toList();
    }
}

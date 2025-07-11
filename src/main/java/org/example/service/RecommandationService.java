package org.example.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.example.entity.Plat;
import org.example.entity.DetailsPlat;
import org.example.entity.MvtStock;
import org.example.entity.Composant;
import java.util.*;
import java.time.LocalDate;
import org.example.entity.DetailCommande;
import org.example.entity.Stock;

@Service
public class RecommandationService {
    @Autowired
    private PlatService platService;
    @Autowired
    private DetailCommandeService detailCommandeService;
    @Autowired
    private DetailsPlatService detailsPlatService;
    @Autowired
    private MvtStockService mvtStockService;
    @Autowired
    private StockService stockService;

    public List<Map<String, Object>> recommanderPlats(String dateStr) {
        LocalDate date = LocalDate.parse(dateStr);
        List<Plat> plats = platService.findAll();
        List<Map<String, Object>> result = new ArrayList<>();

        for (Plat plat : plats) {
            List<DetailsPlat> details = detailsPlatService.findByPlatId(plat.getId());
            double minDays = Double.MAX_VALUE;

            for (DetailsPlat dp : details) {
                Integer composantId = dp.getComposant() != null ? dp.getComposant().getId() : null;
                if (composantId != null) {
                    List<MvtStock> mouvements = mvtStockService.findRecentByComposantId(composantId);
                    for (MvtStock mvt : mouvements) {
                        if (mvt.getDatePeremption() != null) {
                            long days = java.time.temporal.ChronoUnit.DAYS.between(date, mvt.getDatePeremption());
                            if (days >= 0 && days < minDays) minDays = days;
                        }
                    }
                }
            }

            double score = (minDays == Double.MAX_VALUE) ? 0 : 1.0 / (1 + minDays);

            Map<String, Object> map = new HashMap<>();
            map.put("intitule", plat.getIntitule());
            map.put("score", score);
            map.put("id", plat.getId());
            result.add(map);
        }

        // Trier par score décroissant
        result.sort((a, b) -> Double.compare((Double)b.get("score"), (Double)a.get("score")));

        return result;
    }
}
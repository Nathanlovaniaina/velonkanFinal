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

    public List<Map<String, Object>> recommanderPlats(String dateStr) {
        LocalDate date = LocalDate.parse(dateStr);
        List<Plat> plats = platService.findAll();
        List<DetailCommande> commandes = detailCommandeService.findAll();
        
        // 1. Calcul de la popularité des plats
        Map<Integer, Integer> popularite = new HashMap<>();
        int maxCmd = 1; // Évite la division par zéro
        
        for (DetailCommande dc : commandes) {
            if (dc.getPlat() != null) {
                int platId = dc.getPlat().getId();
                popularite.put(platId, popularite.getOrDefault(platId, 0) + dc.getQuantite());
                if (popularite.get(platId) > maxCmd) {
                    maxCmd = popularite.get(platId);
                }
            }
        }

        // 2. Calcul du score de péremption
        Map<Integer, Double> peremptionScore = new HashMap<>();
        
        for (Plat plat : plats) {
            List<DetailsPlat> details = detailsPlatService.findByPlatId(plat.getId());
            double minDays = Double.MAX_VALUE;
            
            for (DetailsPlat dp : details) {
                Composant composant = dp.getComposant();
                if (composant != null) {
                    // Récupérer les mouvements de stock les plus récents pour ce composant
                    List<MvtStock> mouvements = mvtStockService.findRecentByComposantId(composant.getId());
                    
                    for (MvtStock mvt : mouvements) {
                        if (mvt.getDatePeremption() != null) {
                            long days = java.time.temporal.ChronoUnit.DAYS.between(date, mvt.getDatePeremption());
                            if (days >= 0 && days < minDays) {
                                minDays = days;
                            }
                        }
                    }
                }
            }
            
            // Calcul du score (plus la date est proche, plus le score est élevé)
            double score = (minDays == Double.MAX_VALUE) ? 0 : Math.exp(-minDays/7.0); // Décroissance exponentielle sur une semaine
            peremptionScore.put(plat.getId(), score);
        }

        // 3. Calcul du score global et construction du résultat
        List<Map<String, Object>> result = new ArrayList<>();
        
        for (Plat plat : plats) {
            double scorePop = (double)popularite.getOrDefault(plat.getId(), 0) / maxCmd;
            double scorePer = peremptionScore.getOrDefault(plat.getId(), 0.0);
            
            // Pondération des scores (ajustable selon vos besoins)
            double score = 0.4 * scorePop + 0.6 * scorePer;
            
            Map<String, Object> map = new HashMap<>();
            map.put("id", plat.getId());
            map.put("intitule", plat.getIntitule());
            map.put("prix", plat.getPrix());
            map.put("score", score);
            map.put("score_popularite", scorePop);
            map.put("score_peremption", scorePer);
            
            result.add(map);
        }

        // Tri par score décroissant
        result.sort((a, b) -> Double.compare((Double)b.get("score"), (Double)a.get("score")));
        
        return result;
    }
}
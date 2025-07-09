package org.example.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import java.util.*;
import java.util.Map;
import java.util.List;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.TreeMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.example.service.RecommandationService;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.example.service.PublicationPlatService;
import org.example.entity.PublicationPlat;
import org.example.entity.Plat;
import java.time.LocalDate;
import javax.servlet.http.HttpServletResponse;
import com.lowagie.text.*;
import com.lowagie.text.pdf.PdfWriter;
import com.lowagie.text.pdf.PdfPTable;

import java.awt.Color;

import com.lowagie.text.pdf.PdfPCell;

@Controller
public class RecommandationController {
    @Autowired
    private RecommandationService recommandationService;
    @Autowired
    private PublicationPlatService publicationPlatService;
    @Autowired
    private org.example.service.PlatService platService;

    @GetMapping(value = "/api/recommandation", produces = "application/json")
    @ResponseBody
    public Map<String, Object> getRecommandations(@RequestParam("date") String date) {
        System.out.println("DEBUG: API recommandation appelée pour la date: " + date);
        Map<String, Object> result = new HashMap<>();
        List<Map<String, Object>> plats = recommandationService.recommanderPlats(date);
        System.out.println("DEBUG: Plats recommandés: " + plats);
        result.put("plats", plats);
        return result;
    }

    @PostMapping(value = "/api/publication_plat", consumes = "application/json")
    @ResponseBody
    public Map<String, Object> publierPlats(@RequestBody Map<String, Object> payload) {
        String dateStr = (String) payload.get("date");
        java.util.List<Integer> platIds = (java.util.List<Integer>) payload.get("plats");
        LocalDate date = LocalDate.parse(dateStr);
        Map<String, Object> result = new HashMap<>();
        boolean ok = true;

        // Vérifier le nombre de publications existantes pour la date
        java.util.List<PublicationPlat> existantes = publicationPlatService.findByDatePublication(date);
        if (existantes.size() == 2 && platIds.size() > 2) {
            result.put("success", false);
            result.put("message", "Il y a déjà 2 plats publiés pour cette date.");
            return result;
        }
        // Si on modifie (update), supprimer les anciennes publications pour la date
        if (!existantes.isEmpty()) {
            for (PublicationPlat pub : existantes) {
                publicationPlatService.delete(pub);
            }
        }
        // Insérer les nouvelles publications
        for (Integer platId : platIds) {
            Plat plat = platService.findById(platId).orElse(null);
            if (plat != null) {
                PublicationPlat pub = new PublicationPlat();
                pub.setPlat(plat);
                pub.setDatePublication(date);
                publicationPlatService.save(pub);
            } else {
                ok = false;
            }
        }
        result.put("success", ok);
        return result;
    }

    @GetMapping(value = "/api/publications", produces = "application/json")
    @ResponseBody
    public java.util.List<Map<String, Object>> getPublications(
        @RequestParam("start") String start,
        @RequestParam("end") String end
    ) {
        LocalDate startDate = LocalDate.parse(start.substring(0, 10));
        LocalDate endDate = LocalDate.parse(end.substring(0, 10));
        java.util.List<org.example.entity.PublicationPlat> pubs = publicationPlatService.findByDatePublicationBetween(startDate, endDate);
        java.util.List<Map<String, Object>> result = new ArrayList<>();
        for (org.example.entity.PublicationPlat pub : pubs) {
            Map<String, Object> map = new HashMap<>();
            map.put("date", pub.getDatePublication().toString());
            map.put("plat", pub.getPlat().getIntitule());
            map.put("id", pub.getPlat().getId());
            result.add(map);
        }
        return result;
    }

    @GetMapping("/api/publications/pdf")
    public void exportPublicationsPdf(@RequestParam("start") String start,
                                      @RequestParam("end") String end,
                                      HttpServletResponse response) throws Exception {
        java.time.LocalDate startDate = java.time.LocalDate.parse(start);
        java.time.LocalDate endDate = java.time.LocalDate.parse(end);
        java.util.List<org.example.entity.PublicationPlat> pubs = publicationPlatService.findWithCompositionsByDatePublicationBetween(startDate, endDate);
        // Préparer les données groupées par date
        Map<java.time.LocalDate, java.util.List<org.example.entity.PublicationPlat>> pubsByDate = new TreeMap<>();
        for (org.example.entity.PublicationPlat pub : pubs) {
            pubsByDate.computeIfAbsent(pub.getDatePublication(), k -> new ArrayList<>()).add(pub);
        }
        // Préparer la réponse HTTP
        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment; filename=publications.pdf");
        // Générer le PDF
        Document document = new Document(PageSize.A4, 40, 40, 60, 50);
        PdfWriter writer = PdfWriter.getInstance(document, response.getOutputStream());
        document.open();

        // Ajouter le logo
        try {
            String logoPath = "C:/Users/lovan/Documents/S4/Projet_Md_Baovola/Gith/Velokan/src/main/webapp/resources/img/photos/velokan.png";
            Image logo = Image.getInstance(logoPath);
            logo.scaleToFit(100, 100);
            logo.setAlignment(Image.ALIGN_CENTER);
            document.add(logo);
        } catch (Exception e) {
            // Si le logo n'est pas trouvé, on continue sans planter
        }

        // Titre stylé
        Font titleFont = new Font(Font.HELVETICA, 22, Font.BOLD, new Color(76, 175, 80)); // #4CAF50
        Paragraph title = new Paragraph("Velokan - Export des publications de plats", titleFont);
        title.setAlignment(Element.ALIGN_CENTER);
        title.setSpacingAfter(10);
        document.add(title);

        // Période et date d'édition
        Font infoFont = new Font(Font.HELVETICA, 12, Font.NORMAL, Color.DARK_GRAY);
        Paragraph periode = new Paragraph("Période : " + start + " au " + end, infoFont);
        periode.setAlignment(Element.ALIGN_CENTER);
        periode.setSpacingAfter(5);
        document.add(periode);
        Paragraph edition = new Paragraph("Date d'édition : " + java.time.LocalDate.now(), infoFont);
        edition.setAlignment(Element.ALIGN_CENTER);
        edition.setSpacingAfter(15);
        document.add(edition);

        // Pour chaque date, afficher un tableau
        Font dateFont = new Font(Font.HELVETICA, 14, Font.BOLD, new Color(76, 175, 80));
        Font headerFont = new Font(Font.HELVETICA, 12, Font.BOLD, new Color(76, 175, 80));
        Font cellFont = new Font(Font.HELVETICA, 12, Font.NORMAL, Color.BLACK);
        for (Map.Entry<java.time.LocalDate, java.util.List<org.example.entity.PublicationPlat>> entry : pubsByDate.entrySet()) {
            Paragraph datePara = new Paragraph("Date : " + entry.getKey(), dateFont);
            datePara.setSpacingBefore(10);
            datePara.setSpacingAfter(5);
            document.add(datePara);
            PdfPTable table = new PdfPTable(2);
            table.setWidthPercentage(100);
            table.setSpacingBefore(5);
            table.setSpacingAfter(10);
            table.setWidths(new float[]{2, 3});
            // En-têtes
            PdfPCell cell1 = new PdfPCell(new Phrase("Plat", headerFont));
            cell1.setBackgroundColor(new Color(232, 245, 233)); // vert très clair
            cell1.setHorizontalAlignment(Element.ALIGN_CENTER);
            cell1.setPadding(8);
            table.addCell(cell1);
            PdfPCell cell2 = new PdfPCell(new Phrase("Composition", headerFont));
            cell2.setBackgroundColor(new Color(232, 245, 233));
            cell2.setHorizontalAlignment(Element.ALIGN_CENTER);
            cell2.setPadding(8);
            table.addCell(cell2);

            // Grouper les publications par plat (pour éviter les doublons)
            java.util.Map<Integer, org.example.entity.Plat> platsMap = new java.util.LinkedHashMap<>();
            for (org.example.entity.PublicationPlat pub : entry.getValue()) {
                org.example.entity.Plat plat = pub.getPlat();
                platsMap.put(plat.getId(), plat); // Unicité par id
            }
            for (org.example.entity.Plat plat : platsMap.values()) {
                PdfPCell platCell = new PdfPCell(new Phrase(plat.getIntitule(), cellFont));
                platCell.setPadding(6);
                table.addCell(platCell);
                // Récupérer la composition du plat (liste des ingrédients)
                String composition = "";
                try {
                    
                    java.util.List<org.example.entity.DetailsPlat> details = plat.getCompositions();
                    if (details != null && !details.isEmpty()) {
                        java.util.List<String> compoList = new java.util.ArrayList<>();
                        for (org.example.entity.DetailsPlat dp : details) {
                            if (dp.getComposant() != null) {
                                compoList.add(dp.getComposant().getNom());
                            }
                        }
                        composition = String.join(", ", compoList);
                    }
                } catch (Exception e) {
                    composition = "-";
                }
                PdfPCell compoCell = new PdfPCell(new Phrase(composition, cellFont));
                compoCell.setPadding(6);
                table.addCell(compoCell);
            }
            document.add(table);
        }

        // Pied de page
        Font footerFont = new Font(Font.HELVETICA, 10, Font.ITALIC, Color.GRAY);
        Paragraph footer = new Paragraph("Velokan – Export PDF généré automatiquement", footerFont);
        footer.setAlignment(Element.ALIGN_CENTER);
        footer.setSpacingBefore(20);
        document.add(footer);

        document.close();
    }
} 
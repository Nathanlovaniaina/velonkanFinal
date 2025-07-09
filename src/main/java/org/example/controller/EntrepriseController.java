package org.example.controller;

import org.example.entity.Entreprise;
import org.example.repository.EntrepriseRepository;
import org.example.service.MvtContratService;
import org.locationtech.jts.geom.Coordinate;
import org.locationtech.jts.geom.GeometryFactory;
import org.locationtech.jts.geom.Point;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/entreprise")
public class EntrepriseController {

    private static final Logger logger = LoggerFactory.getLogger(EntrepriseController.class);
    private final EntrepriseRepository entrepriseRepository;
    private final MvtContratService mvtContratService;
    private final GeometryFactory geometryFactory = new GeometryFactory();

    public EntrepriseController(EntrepriseRepository entrepriseRepository, MvtContratService mvtContratService) {
        this.entrepriseRepository = entrepriseRepository;
        this.mvtContratService = mvtContratService;
    }

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        dateFormat.setLenient(false);
        binder.registerCustomEditor(Date.class, new java.beans.PropertyEditorSupport() {
            @Override
            public void setAsText(String text) throws IllegalArgumentException {
                try {
                    if (text != null && !text.trim().isEmpty()) {
                        setValue(dateFormat.parse(text));
                    } else {
                        setValue(null);
                    }
                } catch (Exception e) {
                    throw new IllegalArgumentException("Invalid date format for debutDateContrat: " + text);
                }
            }
        });
    }

    @GetMapping({"/list", "/gestion"})
    public String listEntreprises(Model model, @RequestParam(name = "tab", defaultValue = "list") String tab) {
        List<Entreprise> entreprises = entrepriseRepository.findAll();
        model.addAttribute("entreprises", entreprises);
        model.addAttribute("tab", tab);
        return "entreprise/gestion";
    }

    @GetMapping("/create")
    public String showCreateForm(Model model) {
        model.addAttribute("entreprise", new Entreprise());
        model.addAttribute("tab", "create");
        return "entreprise/gestion";
    }

    @PostMapping("/save")
    public String saveEntreprise(
        @RequestParam("nom") String nom,
        @RequestParam("adresse") String adresse,
        @RequestParam(value = "latitude", required = false) Double latitude,
        @RequestParam(value = "longitude", required = false) Double longitude,
        @RequestParam(value = "quartier", required = false) String quartier,
        @RequestParam(value = "debutDateContrat", required = false) Date debutDateContrat,
        RedirectAttributes redirectAttributes) {

        try {
            // Validation simple
            if (nom == null || nom.trim().isEmpty() || adresse == null || adresse.trim().isEmpty()) {
                throw new IllegalArgumentException("Nom et adresse sont obligatoires");
            }

            Entreprise entreprise = new Entreprise();
            entreprise.setNom(nom);
            entreprise.setAdresse(adresse);
            entreprise.setLatitude(latitude);
            entreprise.setLongitude(longitude);
            entreprise.setQuartier(quartier);
            entreprise.setDebutDateContrat(debutDateContrat);

            // Création du point géométrique
            if (latitude != null && longitude != null) {
                Point point = geometryFactory.createPoint(new Coordinate(longitude, latitude));
                point.setSRID(4326);
                entreprise.setGeom(point);
            }

            entrepriseRepository.save(entreprise);
            redirectAttributes.addFlashAttribute("message", "Entreprise créée avec succès");
            return "redirect:/entreprise/list";

        } catch (Exception e) {
            logger.error("Erreur création entreprise", e);
            redirectAttributes.addFlashAttribute("message", "Erreur: " + e.getMessage());
            return "redirect:/entreprise/create";
        }
    }

    @PostMapping("/update")
    public String updateEntreprise(
        @RequestParam("id") Integer id,
        @RequestParam("nom") String nom,
        @RequestParam("adresse") String adresse,
        @RequestParam(value = "latitude", required = false) Double latitude,
        @RequestParam(value = "longitude", required = false) Double longitude,
        @RequestParam(value = "quartier", required = false) String quartier,
        @RequestParam(value = "debutDateContrat", required = false) Date debutDateContrat,
        RedirectAttributes redirectAttributes) {

        try {
            Entreprise entreprise = entrepriseRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Entreprise non trouvée"));

            // Validation
            if (nom == null || nom.trim().isEmpty() || adresse == null || adresse.trim().isEmpty()) {
                throw new IllegalArgumentException("Nom et adresse sont obligatoires");
            }

            entreprise.setNom(nom);
            entreprise.setAdresse(adresse);
            entreprise.setLatitude(latitude);
            entreprise.setLongitude(longitude);
            entreprise.setQuartier(quartier);
            entreprise.setDebutDateContrat(debutDateContrat);

            // Mise à jour du point géométrique
            if (latitude != null && longitude != null) {
                Point point = geometryFactory.createPoint(new Coordinate(longitude, latitude));
                point.setSRID(4326);
                entreprise.setGeom(point);
            } else {
                entreprise.setGeom(null);
            }

            entrepriseRepository.save(entreprise);
            redirectAttributes.addFlashAttribute("message", "Entreprise mise à jour avec succès");
            return "redirect:/entreprise/list";

        } catch (Exception e) {
            logger.error("Erreur mise à jour entreprise", e);
            redirectAttributes.addFlashAttribute("message", "Erreur: " + e.getMessage());
            return "redirect:/entreprise/edit/" + id;
        }
    }

    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable("id") Integer id, Model model) {
        Entreprise entreprise = entrepriseRepository.findById(id)
            .orElseThrow(() -> new IllegalArgumentException("ID entreprise invalide"));
        model.addAttribute("entreprise", entreprise);
        model.addAttribute("tab", "create");
        return "entreprise/gestion";
    }

    @GetMapping("/delete/{id}")
    public String deleteEntreprise(@PathVariable("id") Integer id, RedirectAttributes redirectAttributes) {
        try {
            if (!mvtContratService.findByEntrepriseId(id).isEmpty()) {
                redirectAttributes.addFlashAttribute("message", "Erreur: Entreprise a des mouvements associés");
            } else {
                entrepriseRepository.deleteById(id);
                redirectAttributes.addFlashAttribute("message", "Entreprise supprimée");
            }
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("message", "Erreur: " + e.getMessage());
        }
        return "redirect:/entreprise/list";
    }
}
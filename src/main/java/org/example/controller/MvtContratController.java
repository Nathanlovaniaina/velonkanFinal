package org.example.controller;

import org.example.entity.Entreprise;
import org.example.entity.MvtContrat;
import org.example.repository.EntrepriseRepository;
import org.example.service.MvtContratService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import java.util.List;
import java.util.Date;
import java.util.Optional;

@Controller
@RequestMapping("/mvtcontrat")
public class MvtContratController {

    private static final Logger logger = LoggerFactory.getLogger(MvtContratController.class);

    private final MvtContratService mvtContratService;
    private final EntrepriseRepository entrepriseRepository;

    public MvtContratController(MvtContratService mvtContratService, EntrepriseRepository entrepriseRepository) {
        this.mvtContratService = mvtContratService;
        this.entrepriseRepository = entrepriseRepository;
    }

    @GetMapping({"/list", "/gestion"})
public String listMvtContrats(Model model,
                              @RequestParam(name = "tab", defaultValue = "list") String tab,
                              @RequestParam(name = "entrepriseId", required = false) Integer entrepriseId,
                              @RequestParam(name = "fromDate", required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") Date fromDate) {
    logger.info("Accessing listMvtContrats with tab={}, entrepriseId={}, fromDate={}", tab, entrepriseId, fromDate);
    List<MvtContrat> mvtContrats;
    Entreprise entreprise = null;

    if (entrepriseId != null) {
        mvtContrats = mvtContratService.findByEntrepriseId(entrepriseId);
        entreprise = entrepriseRepository.findById(entrepriseId)
                .orElseThrow(() -> new IllegalArgumentException("Invalid entreprise Id: " + entrepriseId));
    } else {
        mvtContrats = mvtContratService.findAll();
    }

    List<Entreprise> activeEntreprises = null;
    if (fromDate != null) {
        logger.info("Fetching active entreprises for fromDate: {}", fromDate);
        activeEntreprises = mvtContratService.findEntreprisesWithActiveContracts(fromDate);
        logger.info("Active entreprises found: {}", activeEntreprises.size());
    }

    model.addAttribute("mvtContrats", mvtContrats);
    model.addAttribute("entreprises", entrepriseRepository.findAll());
    model.addAttribute("activeEntreprises", activeEntreprises);
    model.addAttribute("entreprise", entreprise);
    model.addAttribute("tab", tab);
    model.addAttribute("fromDate", fromDate);
    if (entrepriseRepository.findAll().isEmpty()) {
        model.addAttribute("message", "Aucune entreprise enregistrée. Veuillez créer une entreprise d'abord.");
        return "redirect:/entreprise/create";
    }
    return "mvtcontrat/gestion";
}

    @GetMapping("/create")
    public String showCreateForm(Model model, @RequestParam(name = "entrepriseId", required = false) Integer entrepriseId) {
        logger.info("Accessing showCreateForm with entrepriseId={}", entrepriseId);
        MvtContrat mvtContrat = new MvtContrat();
        Entreprise entreprise = null;
        if (entrepriseId != null) {
            entreprise = entrepriseRepository.findById(entrepriseId)
                    .orElseThrow(() -> new IllegalArgumentException("Invalid entreprise Id: " + entrepriseId));
            mvtContrat.setEntreprise(entreprise);
        }
        model.addAttribute("mvtContrat", mvtContrat);
        model.addAttribute("entreprises", entrepriseRepository.findAll());
        model.addAttribute("entreprise", entreprise);
        model.addAttribute("tab", "create");
        if (entrepriseRepository.findAll().isEmpty()) {
            model.addAttribute("message", "Aucune entreprise enregistrée. Veuillez créer une entreprise d'abord.");
            return "redirect:/entreprise/create";
        }
        return "mvtcontrat/gestion";
    }


    @PostMapping("/save")
    public String saveMvtContrat(
        @RequestParam(value = "id", required = false) Integer id,
        @RequestParam("entrepriseNom") String entrepriseNom,
        @RequestParam("typeMvt") Integer typeMvt,
        @RequestParam("dateMvt") @DateTimeFormat(pattern = "yyyy-MM-dd") Date dateMvt,
        RedirectAttributes redirectAttributes) {
    
        // Trouver l'entreprise par son nom
        Optional<Entreprise> entrepriseOpt = entrepriseRepository.findByNom(entrepriseNom);
        
        if (!entrepriseOpt.isPresent()) {
            redirectAttributes.addFlashAttribute("message", "Erreur: Entreprise non trouvée - " + entrepriseNom);
            return "redirect:/mvtcontrat/create";
        }
    
        try {
            MvtContrat mvt = new MvtContrat();
            if (id != null) {
                mvt.setId(id);
            }
            
            mvt.setEntreprise(entrepriseOpt.get());
            mvt.setTypeMvt(typeMvt);
            mvt.setDateMvt(dateMvt);
            
            mvtContratService.save(mvt);
            
            redirectAttributes.addFlashAttribute("message", "Mouvement enregistré avec succès");
            return "redirect:/mvtcontrat/list";
            
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("message", "Erreur système: " + e.getMessage());
            return "redirect:/mvtcontrat/create";
        }
    }


    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable("id") Integer id, 
                             @RequestParam(name = "entrepriseId", required = false) Integer entrepriseId,
                             Model model) {
        logger.info("Accessing showEditForm with id={}, entrepriseId={}", id, entrepriseId);
        
        return mvtContratService.findById(id)
            .map(mvt -> {
                model.addAttribute("mvtContrat", mvt);
                model.addAttribute("entreprises", entrepriseRepository.findAll());
                model.addAttribute("entreprise", entrepriseId != null ? 
                    entrepriseRepository.findById(entrepriseId).orElse(null) : null);
                model.addAttribute("tab", "create");
                return "mvtcontrat/gestion";
            })
            .orElseGet(() -> {
                model.addAttribute("message", "Mouvement de contrat non trouvé");
                return "redirect:/mvtcontrat/list" + (entrepriseId != null ? "?entrepriseId=" + entrepriseId : "");
            });
    }

    @PostMapping("/update")
    public String updateMvtContrat(
        @ModelAttribute("mvtContrat") MvtContrat mvtContrat,
        @RequestParam(name = "entrepriseNom", required = false) String entrepriseNom,
        @RequestParam(name = "entrepriseId", required = false) Integer entrepriseId,
        RedirectAttributes redirectAttributes) {

        try {
            // Validation des données
            if (mvtContrat.getTypeMvt() == null || mvtContrat.getDateMvt() == null) {
                throw new IllegalArgumentException("Type de mouvement et date sont obligatoires");
            }

            // Gestion de l'entreprise
            if (entrepriseNom != null) {
                Entreprise entreprise = entrepriseRepository.findByNom(entrepriseNom)
                    .orElseThrow(() -> new IllegalArgumentException("Entreprise non trouvée"));
                mvtContrat.setEntreprise(entreprise);
            } else if (entrepriseId != null) {
                Entreprise entreprise = entrepriseRepository.findById(entrepriseId)
                    .orElseThrow(() -> new IllegalArgumentException("Entreprise non trouvée"));
                mvtContrat.setEntreprise(entreprise);
            } else {
                throw new IllegalArgumentException("Aucune entreprise spécifiée");
            }

            mvtContratService.save(mvtContrat);
            redirectAttributes.addFlashAttribute("message", "Mouvement mis à jour avec succès");
            
        } catch (Exception e) {
            logger.error("Erreur lors de la mise à jour", e);
            redirectAttributes.addFlashAttribute("message", "Erreur: " + e.getMessage());
        }

        return "redirect:/mvtcontrat/list" + (entrepriseId != null ? "?entrepriseId=" + entrepriseId : "");
    }

    @GetMapping("/delete/{id}")
    public String deleteMvtContrat(@PathVariable("id") Integer id,
                                 @RequestParam(name = "entrepriseId", required = false) Integer entrepriseId,
                                 RedirectAttributes redirectAttributes) {
        logger.info("Processing deleteMvtContrat with id={}, entrepriseId={}", id, entrepriseId);
        
        try {
            mvtContratService.deleteById(id);
            redirectAttributes.addFlashAttribute("message", "Mouvement supprimé avec succès");
        } catch (Exception e) {
            logger.error("Error deleting: {}", e.getMessage());
            redirectAttributes.addFlashAttribute("message", "Erreur: " + e.getMessage());
        }
        
        return "redirect:/mvtcontrat/list" + (entrepriseId != null ? "?entrepriseId=" + entrepriseId : "");
    }

   
}
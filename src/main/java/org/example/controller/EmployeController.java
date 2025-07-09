package org.example.controller;

import org.example.entity.Employe;
import org.example.service.EmployeService;
import org.example.entity.PaiementSalaire;
import org.example.service.PaiementSalaireService;
import org.example.service.PosteService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;
import java.util.Calendar;

@Controller
@RequestMapping("/employe")
public class EmployeController {

    private final EmployeService employeService;
    private final PaiementSalaireService paiementSalaireService;
    private final PosteService posteService;

    public EmployeController(EmployeService employeService, PaiementSalaireService paiementSalaireService, PosteService posteService) {
        this.employeService = employeService;
        this.paiementSalaireService = paiementSalaireService;
        this.posteService = posteService;
    }

    @GetMapping("/paiement_salaire")
    public String toPayement(Model model) {
        model.addAttribute("employes", employeService.findAll());
        return "paiement_salaire";
    }

    @PostMapping("/t_paiement_salaire")
    public String traiterPaiement(
            @RequestParam("id_employe") Integer idEmploye,
            @RequestParam("montant") Double montant,
            Model model) {

        String message = null;

        var employeOpt = employeService.findById(idEmploye);
        if (employeOpt.isEmpty()) message = "Employé non trouvé";
        else if (montant == null || montant <= 0) message = "Montant invalide";
        else {
            Date now = new Date();
            Calendar cal = Calendar.getInstance();
            cal.setTime(now);
            int mois = cal.get(Calendar.MONTH) + 1;
            int annee = cal.get(Calendar.YEAR);

            double reste = employeService.getResteSalaire(idEmploye, mois, annee);
            if (reste <= 0) message = "Salaire déjà totalement payé pour ce mois";
            else if (montant > reste) message = "Montant trop élevé (reste : " + reste + " Ar)";
            else {
                PaiementSalaire paiement = new PaiementSalaire();
                paiement.setEmploye(employeOpt.get());
                paiement.setDatePaie(now);
                paiement.setSomme(montant);
                paiementSalaireService.save(paiement);

                model.addAttribute("succes", "Paiement effectué avec succès");
            }
        }

        if (message != null)
            model.addAttribute("erreur", message);

        model.addAttribute("employes", employeService.findAll());
        return "paiement_salaire";
    }

    @GetMapping("/")
    public String afficherEmployes(@RequestParam(value = "id", required = false) Integer id, Model model) {
        Employe employe = new Employe();
        if (id != null) {
            employe = employeService.findById(id).orElse(new Employe());
        }
        model.addAttribute("employes", employeService.findAll());
        model.addAttribute("employe", employe);
        model.addAttribute("postes", employeService.getAllPostes()); // suppose que cette méthode existe
        return "employe";
    }

    @PostMapping("/save")
    public String enregistrerEmploye(
            @RequestParam(value = "id", required = false) Integer id,
            @RequestParam("id_poste") Integer idPoste,
            @RequestParam("num_identification") String numIdentification,
            @RequestParam("nom") String nom,
            @RequestParam("prenom") String prenom,
            @RequestParam("date_naissance") @DateTimeFormat(pattern = "yyyy-MM-dd") Date dateNaissance,
            @RequestParam("contact") String contact,
            @RequestParam("date_embauche") @DateTimeFormat(pattern = "yyyy-MM-dd") Date dateEmbauche,
            Model model) {
        
        var posteOpt = posteService.findById(idPoste);
        Employe employe = (id != null) ? employeService.findById(id).orElse(new Employe()) : new Employe();
        employe.setPoste(posteOpt.get());
        employe.setNumIdentification(numIdentification);
        employe.setNom(nom);
        employe.setPrenom(prenom);
        employe.setDateNaissance(dateNaissance);
        employe.setContact(contact);
        employe.setDateEmbauche(dateEmbauche);

        employeService.saveOrUpdate(employe);

        model.addAttribute("succes", "Employé enregistré !");
        model.addAttribute("employes", employeService.findAll());
        model.addAttribute("employe", new Employe());
        model.addAttribute("postes", employeService.getAllPostes());
        return "employe";
    }

    @GetMapping("/edit")
    public String modifierEmploye(@RequestParam("id") Integer id, Model model) {
        Employe employe = employeService.findById(id).orElse(new Employe());

        model.addAttribute("succes", "modification de l'employé " + employe.getNom() + " !");
        model.addAttribute("employe", employe);
        model.addAttribute("employes", employeService.findAll());
        model.addAttribute("postes", employeService.getAllPostes());
        return "employe";
    }

    @GetMapping("/delete")
    public String supprimerEmploye(@RequestParam("id") Integer id, Model model) {
        employeService.deleteById(id);
        model.addAttribute("succes", "Employé supprimé !");
        model.addAttribute("employe", new Employe());
        model.addAttribute("employes", employeService.findAll());
        model.addAttribute("postes", employeService.getAllPostes());
        return "employe";
    }


}
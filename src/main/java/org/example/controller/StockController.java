package org.example.controller;

import org.example.controller.StockController.MouvementsWrapper;
import org.example.entity.Composant;
import org.example.entity.MvtStock;
import org.example.entity.Stock;
import org.example.repository.MvtStockRepository;
import org.example.repository.StockRepository;
import org.example.service.ComposantService;
import org.example.service.MvtStockService;
import org.example.service.StockService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/stock")
public class StockController {

    @Autowired
    private StockService stockService;

    @Autowired
    private MvtStockService mvtStockService;

    @Autowired 
    private ComposantService composantService;

    @GetMapping("/Stock/listeStoc")
    public String listStock(Model model) {
        List<Stock> stocks = stockService.findAll();
        List<Composant> composants = composantService.findAll();
        model.addAttribute("composants", composants);
        model.addAttribute("stock", stocks);
        return "/Stock/listStock";
    }
//
    @GetMapping("/Stock/create")
    public String showCreateForm(Model model, HttpSession session) {
        List<Composant> composants = composantService.findAll();
        model.addAttribute("stocks", stockService.findAll());
        model.addAttribute("composants", composants);
        return "/Stock/createVraiStock";
    }
//
    @PostMapping("/Stock/save")
    public String saveMultipleStocks(
        @RequestParam("id_composant") List<Integer> idComposants,
        @RequestParam("qtte_stock") List<BigDecimal> quantites,
        Model model
        ) {
    int nbStocks = idComposants.size();
    for (int i = 0; i < nbStocks; i++) {
        Optional<Composant> composantOpt = composantService.findById(idComposants.get(i));
        if (composantOpt.isPresent()) {
            Stock stock = new Stock();
            stock.setComposant(composantOpt.get());
            stock.setQtteStock(quantites.get(i));
            stockService.saveStock(stock);
        }
     }

    return "redirect:/stock/Stock/listStock";
}

    @GetMapping("/Stock/delete")
    public String deleteStock(@RequestParam("id") Long id) {
        stockService.deleteById(id);
        return "redirect:/stock/Stock/listStock";
    }

    @GetMapping("/Stock/update")
    public String showUpdateForm(@RequestParam("id") Long id, Model model) {
        Optional<Stock> stockOpt = stockService.findById(id);
        if (stockOpt.isPresent()) {
            model.addAttribute("stock", stockOpt.get());
            model.addAttribute("composants", composantService.findAll());
            return "/Stock/createVraiStock";
      }
        return "redirect:/stock/Stock/listStock";
    }

    @PostMapping("/Stock/update")
    public String updateStock(
            @RequestParam("id") Long id,
            @RequestParam("id_composant") Integer idComposant,
            @RequestParam("qtte_stock") BigDecimal qtte) {
        Optional<Stock> stockOpt = stockService.findById(id);
        if (stockOpt.isPresent()) {
            var composantOpt = composantService.findById(idComposant);
            Stock stock = stockOpt.get();
            stock.setComposant(composantOpt.get());
            stock.setQtteStock(qtte);
            stockService.saveStock(stock);
        }
        return "redirect:/stock/Stock/listStock";
    }
    @GetMapping("/Stock/form")
    public String formulaire(Model model) {
        model.addAttribute("mvt", new MvtStock());
        model.addAttribute("stocks", stockService.findAll());
        return "/Stock/createStock";
    }

    @PostMapping("/Stock/ajouter")
public String enregistrer(@ModelAttribute("mouvements") MouvementsWrapper wrapper) {
    stockService.enregistrerMouvements(wrapper.getListeMvt());
    return "redirect:/stock/Stock/list";
}


    @GetMapping("/Stock/list")
    public String historique(@RequestParam(value = "type", required = false) Integer typeMvt,
                            @RequestParam(value="debut",required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate debut,
                            @RequestParam(value="fin",required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate fin,
                            Model model) {
        if (typeMvt != null && debut == null && fin == null) {
            List<MvtStock> mouvements = mvtStockService.findByType(typeMvt);
            model.addAttribute("mouvements", mouvements);
            return "/Stock/historique";
        }
        if (debut != null && fin != null && typeMvt == null) {
            List<MvtStock> mouvements = mvtStockService.findByDates(debut, fin);
            model.addAttribute("mouvements", mouvements);
            model.addAttribute("selectedType", typeMvt);
            return "/Stock/historique";
        }
        if (debut != null && fin != null && typeMvt != null) {
            List<MvtStock> mouvements = mvtStockService.findByTypeAndDates(typeMvt, debut, fin);
            model.addAttribute("mouvements", mouvements);
            model.addAttribute("selectedType", typeMvt);
            return "/Stock/historique";
        }
        
        else { 
            List<MvtStock> mouvements = mvtStockService.findAll();
            model.addAttribute("mouvements", mouvements);
            return "/Stock/historique";
        } 
        
    }

 
    public static class MouvementsWrapper {
    private List<MvtStock> listeMvt;

    public MouvementsWrapper() {
    }

    public MouvementsWrapper(List<MvtStock> listeMvt) {
        this.listeMvt = listeMvt;
    }

    public List<MvtStock> getListeMvt() {
        return listeMvt;
    }

    public void setListeMvt(List<MvtStock> listeMvt) {
        this.listeMvt = listeMvt;
    }
}

    
}
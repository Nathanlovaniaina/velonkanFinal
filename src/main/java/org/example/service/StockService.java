package org.example.service;

import org.example.entity.Composant;
import org.example.entity.MvtStock;
import org.example.entity.Stock;
import org.example.repository.ComposantRepository;
import org.example.repository.MvtStockRepository;
import org.example.repository.StockRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Service
public class StockService {

    @Autowired
    private StockRepository stockRepository;
    @Autowired
    private ComposantRepository composantRepository;
    @Autowired
    private MvtStockRepository mvtRepo;

    public StockService(StockRepository stockRepository, ComposantRepository composantRepository, MvtStockRepository mvtRepo) {
        this.stockRepository = stockRepository;
        this.composantRepository = composantRepository;
        this.mvtRepo = mvtRepo;
    }

    // Récupérer tous les stocks
    public List<Stock> findAll() {
        return stockRepository.findAll();
    }

    // Récupérer un stock par ID
    public Optional<Stock> findById(Long id) {
        return stockRepository.findById(id);
    }

    public void saveStock(Stock s) {
        stockRepository.save(s);
    }


    // Supprimer un stock
    @Transactional
    public void deleteById(Long id) {
        stockRepository.deleteById(id);
    }

    public List<Composant> getAllComposant() {
    return composantRepository.findAll();
    }
    
    public void enregistrerMouvements(List<MvtStock> mouvements) {
    for (MvtStock mvt : mouvements) {
        Long stockId = mvt.getStock().getId(); // Seulement l'id est reçu depuis le formulaire
        Stock stock = stockRepository.findById(stockId)
                          .orElseThrow(() -> new IllegalArgumentException("Stock non trouvé"));

        BigDecimal quantite = mvt.getQuantite();

        if (mvt.getTypeMvt() == 1) {
            stock.setQtteStock(stock.getQtteStock().add(quantite));
        } else {
            stock.setQtteStock(stock.getQtteStock().subtract(quantite));
        }

        // Tu n'enregistres QUE la quantité mise à jour
        stockRepository.save(stock);

        mvt.setStock(stock); // réinjecte l’objet complet (avec composant)

        if (mvt.getDateMvt() == null) {
            mvt.setDateMvt(LocalDate.now());
        }

        if (mvt.getNombreJourConservation() != null) {
            mvt.setDatePeremption(mvt.getDateMvt().plusDays(mvt.getNombreJourConservation()));
        }

        mvtRepo.save(mvt);
    }
}

    public List<Stock> findByComposantId(Integer composantId) {
        return stockRepository.findByComposant_Id(composantId);
    }
}
package org.example.service;

import org.example.entity.Commande;
import org.example.entity.MvtStatutLivraisonCommande;
import org.example.repository.MvtStatutLivraisonCommandeRepository;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.time.LocalDateTime;
import java.util.Optional;

@Service
public class MvtLivraisonService {

    private final MvtStatutLivraisonCommandeRepository mvtRepo;

    public MvtLivraisonService(MvtStatutLivraisonCommandeRepository mvtRepo) {
        this.mvtRepo = mvtRepo;
    }

    @Transactional
    public void modifierStatutCommande(int idCommande, int statut) throws Exception {
        if (idCommande <= 0) {
            throw new Exception("ID de commande invalide");
        }
        if (statut != 0 && statut != 1) {
            throw new Exception("Statut invalide : doit être 0 ou 1");
        }


        Commande commande = new Commande();
        commande.setId(idCommande);


        MvtStatutLivraisonCommande mvt = new MvtStatutLivraisonCommande();
        mvt.setCommande(commande); 
        mvt.setStatut(statut);
        mvt.setDateHeureModification(LocalDateTime.now());

        mvtRepo.save(mvt);
    }

    public Optional<Integer> getDernierStatut(int idCommande) {
        return mvtRepo.findDernierStatutByCommandeId(idCommande);
    }
}

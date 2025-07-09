package org.example.entity;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "mvt_statut_livraison_commande")
public class MvtStatutLivraisonCommande {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne(optional = false)
    @JoinColumn(name = "id_commande", nullable = false)
    private Commande commande;

    @Column(nullable = false)
    private Integer statut; 

    @Column(name = "date_heure_modification", nullable = false)
    private LocalDateTime dateHeureModification;


    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Commande getCommande() {
        return commande;
    }

    public void setCommande(Commande commande) {
        this.commande = commande;
    }

    public Integer getStatut() {
        return statut;
    }

    public void setStatut(Integer statut) {
        this.statut = statut;
    }

    public LocalDateTime getDateHeureModification() {
        return dateHeureModification;
    }

    public void setDateHeureModification(LocalDateTime dateHeureModification) {
        this.dateHeureModification = dateHeureModification;
    }
}

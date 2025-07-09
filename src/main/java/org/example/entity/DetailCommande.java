
package org.example.entity;

import javax.persistence.*;

@Entity
@Table(name = "detail_commande")
public class DetailCommande {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "id_commande", nullable = false)
    private Commandes commande;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "id_plat", nullable = false)
    private Plat plat;

    @Column(name = "quantite", nullable = false)
    private Integer quantite;

    @Column(name = "prix_unitaire", nullable = false)
    private Integer prixUnitaire;

    // Getters and Setters
    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public Commandes getCommande() { return commande; }
    public void setCommande(Commandes commande) { this.commande = commande; }

    public Plat getPlat() { return plat; }
    public void setPlat(Plat plat) { this.plat = plat; }

    public Integer getQuantite() { return quantite; }
    public void setQuantite(Integer quantite) { this.quantite = quantite; }

    public Integer getPrixUnitaire() { return prixUnitaire; }
    public void setPrixUnitaire(Integer prixUnitaire) { this.prixUnitaire = prixUnitaire; }
}
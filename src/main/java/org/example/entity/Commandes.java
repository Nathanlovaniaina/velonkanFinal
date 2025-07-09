package org.example.entity;

import javax.persistence.*;
import java.util.Date;
import java.util.List;

@Entity
@Table(name = "commandes")
public class Commandes {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "id_entreprise", nullable = false)
    private Entreprise entreprise;

    @Column(name = "prix_total")
    private Integer prixTotal;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "date_heure_prevue", nullable = false)
    private Date dateHeurePrevue;

    @OneToMany(mappedBy = "commande", fetch = FetchType.EAGER, cascade = CascadeType.ALL)
    private List<DetailCommande> details;

    // Getters and Setters
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Entreprise getEntreprise() {
        return entreprise;
    }

    public void setEntreprise(Entreprise entreprise) {
        this.entreprise = entreprise;
    }

    public Integer getPrixTotal() {
        return prixTotal;
    }

    public void setPrixTotal(Integer prixTotal) {
        this.prixTotal = prixTotal;
    }

    public Date getDateHeurePrevue() {
        return dateHeurePrevue;
    }

    public void setDateHeurePrevue(Date dateHeurePrevue) {
        this.dateHeurePrevue = dateHeurePrevue;
    }

    public List<DetailCommande> getDetails() {
        return details;
    }

    public void setDetails(List<DetailCommande> details) {
        this.details = details;
    }
}
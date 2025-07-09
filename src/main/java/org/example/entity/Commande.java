package org.example.entity;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.util.List;

@Entity
@Table(name = "commandes")
public class Commande {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne(optional = false)
    @JoinColumn(name = "id_entreprise", nullable = false)
    private Entreprise entreprise;

    

    @Column(name = "prix_total")
    private Integer prixTotal;

    @Column(name = "date_heure_prevue")
    private LocalDateTime dateHeurePrevue;


    @OneToMany(mappedBy = "commande", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<DetailCommande> details;
    
    public List<DetailCommande> getDetails() {
        return details;
    }

    public void setDetails(List<DetailCommande> details) {
        this.details = details;
    }

    // Getters and Setters
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getIdEntreprise() {
        return this.entreprise.getId();
    }

    public void setIdEntreprise(Integer idEntreprise) {
        this.entreprise.setId(idEntreprise);
    }

    public Integer getPrixTotal() {
        return prixTotal;
    }

    public void setPrixTotal(Integer prixTotal) {
        this.prixTotal = prixTotal;
    }

    public LocalDateTime getDateHeurePrevue() {
        return dateHeurePrevue;
    }

    public void setDateHeurePrevue(LocalDateTime dateHeurePrevue) {
        this.dateHeurePrevue = dateHeurePrevue;
    }

    public Entreprise getEntreprise() {
        return entreprise;
    }

    public void setEntreprise(Entreprise entreprise) {
        this.entreprise = entreprise;
    }
}
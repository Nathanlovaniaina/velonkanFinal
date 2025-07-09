package org.example.entity;

import javax.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.Date;
import java.util.List;

@Entity
@Table(name = "mvt_stock")
public class MvtStock {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    // Association avec Stock
    @ManyToOne
    @JoinColumn(name = "id_stock", nullable = false)
    private Stock stock;

    // 0 = entrée, 1 = sortie
    @Column(name = "type_mvt", nullable = false)
    private Integer typeMvt;

    @Column(name = "quantite", precision = 10, scale = 2)
    private BigDecimal quantite;

    @Column(name = "date_mvt", nullable = false)
    private LocalDate dateMvt;

    @Column(name = "prix_unitaire", precision = 10, scale = 2)
    private BigDecimal prixUnitaire;

    @Column(name = "nombre_jour_conservation")
    private Integer nombreJourConservation;

    @Column(name = "date_peremption")
    private LocalDate datePeremption;


    // Constructeurs
    public MvtStock() {}

    public MvtStock(Stock stock, Integer typeMvt, BigDecimal quantite, LocalDate dateMvt, BigDecimal prixUnitaire, Integer nombreJourConservation, LocalDate datePeremption) {
        this.stock = stock;
        this.typeMvt = typeMvt;
        this.quantite = quantite;
        this.dateMvt = dateMvt;
        this.prixUnitaire = prixUnitaire;
        this.nombreJourConservation = nombreJourConservation;
        this.datePeremption = datePeremption;
    }

    // Getters et Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Stock getStock() {
        return stock;
    }

    public void setStock(Stock stock) {
        this.stock = stock;
    }

    public Integer getTypeMvt() {
        return typeMvt;
    }

    public void setTypeMvt(Integer typeMvt) {
        this.typeMvt = typeMvt;
    }

    public BigDecimal getQuantite() {
        return quantite;
    }

    public void setQuantite(BigDecimal quantite) {
        this.quantite = quantite;
    }

    public LocalDate getDateMvt() {
        return dateMvt;
    }

    public void setDateMvt(LocalDate dateMvt) {
        this.dateMvt = dateMvt;
    }

    public BigDecimal getPrixUnitaire() {
        return prixUnitaire;
    }

    public void setPrixUnitaire(BigDecimal prixUnitaire) {
        this.prixUnitaire = prixUnitaire;
    }

    public Integer getNombreJourConservation() {
        return nombreJourConservation;
    }
    
    public void setNombreJourConservation(Integer nombreJourConservation) {
        this.nombreJourConservation = nombreJourConservation;
    }

    public LocalDate getDatePeremption() {
        return datePeremption;
    }

    public void setDatePeremption(LocalDate datePeremption) {
        this.datePeremption = datePeremption;
    }
}
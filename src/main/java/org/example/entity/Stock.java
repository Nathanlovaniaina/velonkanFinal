package org.example.entity;

import javax.persistence.*;

import java.math.BigDecimal;

@Entity
@Table(name = "stock")
public class Stock {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "id_composant", nullable = false)
    private Composant composant;

    @Column(name = "qtte_stock")
    private BigDecimal qtteStock;

    public Stock() {}

    public Stock(Composant composant, BigDecimal qtteStock) {
        this.composant = composant;
        this.qtteStock = qtteStock;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Composant getComposant() {
        return composant;
    }

    public void setComposant(Composant composant) {
        this.composant = composant;
    }

    public BigDecimal getQtteStock() {
        return qtteStock;
    }

    public void setQtteStock(BigDecimal qtteStock) {
        this.qtteStock = qtteStock;
    }

    //@Transient
    //public boolean isExpire() {
    //    if (dateCreation == null || nombre_jour_conservation == null) return false;
//
    //    Calendar cal = Calendar.getInstance();
    //    cal.setTime(dateCreation);
    //    cal.add(Calendar.DAY_OF_YEAR, nombre_jour_conservation);
//
    //    Date expirationDate = cal.getTime();
    //    return new Date().after(expirationDate);
    //}
//
    //@Transient
    //public boolean isNotExpire() {
    //    if (dateCreation == null || nombre_jour_conservation == null) return false;
//
    //    Calendar cal = Calendar.getInstance();
    //    cal.setTime(dateCreation);
    //    cal.add(Calendar.DAY_OF_YEAR, nombre_jour_conservation);
//
    //    Date expirationDate = cal.getTime();
    //    return new Date().before(expirationDate);
    //}

    //@Transient
    //public boolean isPresqueExpire() {
    //    if (dateCreation == null || nombre_jour_conservation == null) return false;
//
    //    int seuilPresqueExpire = 4; // Nombre de jours avant expiration pour être considéré comme presque expiré
    //    Calendar cal = Calendar.getInstance();
    //    cal.setTime(dateCreation);
    //    cal.add(Calendar.DAY_OF_YEAR, nombre_jour_conservation - seuilPresqueExpire);
//
    //    Date expirationDate = cal.getTime();
    //    return new Date().before(expirationDate);
    //}

}
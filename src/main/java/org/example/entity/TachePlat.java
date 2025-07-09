package org.example.entity;

import javax.persistence.*;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name = "taches_plat")
public class TachePlat {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne
    @JsonIgnore
    @JoinColumn(name = "id_plat", nullable = false)
    private Plat plat;

    @Column(length = 30)
    private String nom;

    @Column(nullable = false)
    private Integer ordre;

    // Getters & Setters
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public Plat getPlat() {
        return plat;
    }
    public void setPlat(Plat plat) {
        this.plat = plat;
    }

    public Integer getOrdre() {
        return ordre;
    }
    
    public void setOrdre(Integer ordre) {
        this.ordre = ordre;
    }
}

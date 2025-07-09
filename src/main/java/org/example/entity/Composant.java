package org.example.entity;

import javax.persistence.*;

import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

@Entity
@Table(name = "composant")
public class Composant {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "id_type", nullable = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    private TypeComposant typeComposant;

    @Column(length = 100)
    private String nom;

    @ManyToOne
    @JoinColumn(name = "id_unite", nullable = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    private Unite unite;

    // Getters & Setters
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public TypeComposant getTypeComposant() {
        return typeComposant;
    }

    public void setTypeComposant(TypeComposant typeComposant) {
        this.typeComposant = typeComposant;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public Unite getUnite() {
        return unite;
    }

    public void setUnite(Unite unite) {
        this.unite = unite;
    }
}
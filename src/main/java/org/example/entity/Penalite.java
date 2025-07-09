package org.example.entity;

import javax.persistence.*;

@Entity
@Table(name = "penalite")
public class Penalite {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "nb_jour")
    private Integer nbJour;

    @Column(name = "pourcentage")
    private Integer pourcentage;

    // Getters et setters
    public Integer getId() { return id; }

    public Integer getNbJour() { return nbJour; }

    public void setNbJour(Integer nbJour) { this.nbJour = nbJour; }

    public Integer getPourcentage() { return pourcentage; }

    public void setPourcentage(Integer pourcentage) { this.pourcentage = pourcentage; }
}

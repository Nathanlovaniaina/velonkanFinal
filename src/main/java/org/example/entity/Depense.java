package org.example.entity;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "depense")
public class Depense {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(columnDefinition = "TEXT")
    private String description;

    @Temporal(TemporalType.DATE)
    @Column(name = "date_creation")
    private Date dateCreation;

    private Double somme;

    // Getters & Setters
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Date getDateCreation() {
        return dateCreation;
    }

    public void setDateCreation(Date dateCreation) {
        this.dateCreation = dateCreation;
    }

    public Double getSomme() {
        return somme;
    }

    public void setSomme(Double somme) {
        this.somme = somme;
    }
}

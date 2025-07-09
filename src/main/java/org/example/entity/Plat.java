package org.example.entity;

import javax.persistence.*;

import com.fasterxml.jackson.annotation.JsonFormat;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

@Entity
@Table(name = "plat")
public class Plat {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Integer id;

    @Column(name = "intitule", nullable = false, length = 100)
    private String intitule;

    @Column(name = "prix", nullable = false)
    private Integer prix;

    @Column(name = "date_creation")
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd")
    private LocalDate dateCreation;

    @OneToMany(mappedBy = "plat", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<DetailsPlat> compositions = new ArrayList<>();

    public List<DetailsPlat> getCompositions() {
        return compositions;
    }

    public void setCompositions(List<DetailsPlat> compositions) {
        this.compositions = compositions;
    }

    // Constructeurs
    public Plat() {
    }

    public Plat(String intitule, Integer prix) {
        this.intitule = intitule;
        this.prix = prix;
    }

    // Getters et Setters
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getIntitule() {
        return intitule;
    }

    public void setIntitule(String intitule) {
        this.intitule = intitule;
    }

    public Integer getPrix() {
        return prix;
    }

    public void setPrix(Integer prix) {
        this.prix = prix;
    }

    public LocalDate getDateCreation() {
        return dateCreation;
    }

    public void setDateCreation(LocalDate dateCreation) {
        this.dateCreation = dateCreation;
    }

    // Equals et HashCode
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Plat plat = (Plat) o;
        return Objects.equals(id, plat.id) && 
               Objects.equals(intitule, plat.intitule) && 
               Objects.equals(prix, plat.prix);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, intitule, prix);
    }

    // ToString
    @Override
    public String toString() {
        return "Plat{" +
               "id=" + id +
               ", intitule='" + intitule + '\'' +
               ", prix=" + prix +
               '}';
    }
}
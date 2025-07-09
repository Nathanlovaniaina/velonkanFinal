package org.example.entity.dto;

public class ComposantUsageDTO {
    private String nom;
    private Double totalUtilise;

    public ComposantUsageDTO(String nom, Double totalUtilise) {
        this.nom = nom;
        this.totalUtilise = totalUtilise;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public Double getTotalUtilise() {
        return totalUtilise;
    }

    public void setTotalUtilise(Double totalUtilise) {
        this.totalUtilise = totalUtilise;
    }
}
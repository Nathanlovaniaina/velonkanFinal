package org.example.entity;

import javax.persistence.*;
import org.locationtech.jts.geom.Point;
import java.util.Date;
import java.util.List;

@Entity
@Table(name = "entreprise")
public class Entreprise {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
  
    public Entreprise(Integer id) {
        this.id = id;
    }
    public Entreprise(){
        
    }


    @Column(nullable = false)
    private String nom;

    @Column(nullable = false)
    private String adresse;

    @Column
    private Double latitude;

    @Column
    private Double longitude;

    @Column
    private String quartier;

    @Column(columnDefinition = "geometry(Point, 4326)")
    private Point geom;

    @Column(name = "debut_date_contrat")
    @Temporal(TemporalType.DATE)
    private Date debutDateContrat;

    @OneToMany(mappedBy = "entreprise", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<MvtContrat> mvtContrats;

    // Getters and Setters
    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }
    public String getNom() { return nom; }
    public void setNom(String nom) { this.nom = nom; }
    public String getAdresse() { return adresse; }
    public void setAdresse(String adresse) { this.adresse = adresse; }
    public Double getLatitude() { return latitude; }
    public void setLatitude(Double latitude) { this.latitude = latitude; }
    public Double getLongitude() { return longitude; }
    public void setLongitude(Double longitude) { this.longitude = longitude; }
    public String getQuartier() { return quartier; }
    public void setQuartier(String quartier) { this.quartier = quartier; }
    public Point getGeom() { return geom; }
    public void setGeom(Point geom) { this.geom = geom; }
    public Date getDebutDateContrat() { return debutDateContrat; }
    public void setDebutDateContrat(Date debutDateContrat) { this.debutDateContrat = debutDateContrat; }
    public List<MvtContrat> getMvtContrats() { return mvtContrats; }
    public void setMvtContrats(List<MvtContrat> mvtContrats) { this.mvtContrats = mvtContrats; }

 
}
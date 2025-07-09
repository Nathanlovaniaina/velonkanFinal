package org.example.entity;

import javax.persistence.*;
import java.util.Date;
import java.util.List;

@Entity
@Table(name = "employe")
public class Employe {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "id_poste", nullable = false)
    private Poste poste;

    @Column(name = "num_identification", length = 10)
    private String numIdentification;

    @Column(length = 30)
    private String nom;

    @Column(length = 30)
    private String prenom;

    @Temporal(TemporalType.DATE)
    @Column(name = "date_naissance")
    private Date dateNaissance;

    @Column(length = 20)
    private String contact;

    @Temporal(TemporalType.DATE)
    @Column(name = "date_embauche", nullable = false)
    private Date dateEmbauche;

    @OneToMany(mappedBy = "employe", cascade = CascadeType.ALL)
    private List<PaiementSalaire> paiements;

    // Getters & Setters
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Poste getPoste() {
        return poste;
    }

    public void setPoste(Poste poste) {
        this.poste = poste;
    }

    public String getNumIdentification() {
        return numIdentification;
    }

    public void setNumIdentification(String numIdentification) {
        this.numIdentification = numIdentification;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getPrenom() {
        return prenom;
    }

    public void setPrenom(String prenom) {
        this.prenom = prenom;
    }

    public Date getDateNaissance() {
        return dateNaissance;
    }

    public void setDateNaissance(Date dateNaissance) {
        this.dateNaissance = dateNaissance;
    }

    public String getContact() {
        return contact;
    }

    public void setContact(String contact) {
        this.contact = contact;
    }

    public Date getDateEmbauche() {
        return dateEmbauche;
    }

    public void setDateEmbauche(Date dateEmbauche) {
        this.dateEmbauche = dateEmbauche;
    }

    public List<PaiementSalaire> getPaiements() {
        return paiements;
    }

    public void setPaiements(List<PaiementSalaire> paiements) {
        this.paiements = paiements;
    }
}

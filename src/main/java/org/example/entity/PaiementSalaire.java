package org.example.entity;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "paiement_salaire")
public class PaiementSalaire {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "id_emp", nullable = false)
    private Employe employe;

    @Temporal(TemporalType.DATE)
    @Column(name = "date_paie", nullable = false)
    private Date datePaie;

    @Column(name = "somme")
    private Double somme;

    // Getters & Setters
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Employe getEmploye() {
        return employe;
    }

    public void setEmploye(Employe employe) {
        this.employe = employe;
    }

    public Date getDatePaie() {
        return datePaie;
    }

    public void setDatePaie(Date datePaie) {
        this.datePaie = datePaie;
    }

    public Double getSomme() {
        return somme;
    }

    public void setSomme(Double somme) {
        this.somme = somme;
    }
}

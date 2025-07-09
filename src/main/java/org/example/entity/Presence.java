package org.example.entity;

import javax.persistence.*;

import java.time.LocalDate;
import java.util.Date;

@Entity
@Table(name = "presence")
public class Presence {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "id_emp", nullable = false)
    private Employe employe;

    @Column(name = "date_pres")
    private LocalDate datePres;

    public LocalDate getDatePres() {
        return datePres;
    }

    public void setDatePres(LocalDate datePres) {
        this.datePres = datePres;
    }

    // Getters / Setters
    public Integer getId() { return id; }

    public Employe getEmploye() { return employe; }

    public void setEmploye(Employe employe) { this.employe = employe; }

}

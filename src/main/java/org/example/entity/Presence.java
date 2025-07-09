package org.example.entity;

import javax.persistence.*;
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

    @Temporal(TemporalType.DATE)
    @Column(name = "date_pres")
    private Date datePres;

    // Getters / Setters
    public Integer getId() { return id; }

    public Employe getEmploye() { return employe; }

    public void setEmploye(Employe employe) { this.employe = employe; }

    public Date getDatePres() { return datePres; }

    public void setDatePres(Date datePres) { this.datePres = datePres; }
}

package org.example.entity;

import javax.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name = "publication_plat")
public class PublicationPlat {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "id_plat", nullable = false)
    private Plat plat;

    @Column(name = "date_publication")
    private LocalDate datePublication;

    public Integer getId() {
        return id;
    }
    public void setId(Integer id) {
        this.id = id;
    }
    public Plat getPlat() {
        return plat;
    }
    public void setPlat(Plat plat) {
        this.plat = plat;
    }
    public LocalDate getDatePublication() {
        return datePublication;
    }
    public void setDatePublication(LocalDate datePublication) {
        this.datePublication = datePublication;
    }
} 
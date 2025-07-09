package org.example.entity;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "mvt_statut_tache")
public class MvtStatutTache {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "id_distribution_tache")
    private DistributionTache distributionTache;

    @Column(name = "date_heure_modification")
    private LocalDateTime dateHeureModification;


    @Column(name = "statut")
    private Integer statut;


    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public DistributionTache getDistributionTache() {
        return distributionTache;
    }

    public void setDistributionTache(DistributionTache distributionTache) {
        this.distributionTache = distributionTache;
    }

    public LocalDateTime getDateHeureModification() {
        return dateHeureModification;
    }

    public void setDateHeureModification(LocalDateTime dateHeureModification) {
        this.dateHeureModification = dateHeureModification;
    }

    public Integer getStatut() {
        return statut;
    }

    public void setStatut(Integer statut) {
        this.statut = statut;
    }
}

package org.example.entity;

import javax.persistence.*;
import java.time.LocalDate;
import java.util.List;

@Entity
@Table(name = "distribution_tache")
public class DistributionTache {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    // Choix entre tâche libre ou tâche-plat
    @ManyToOne
    @JoinColumn(name = "id_tache")
    private Tache tache;

    @ManyToOne
    @JoinColumn(name = "id_tache_plat")
    private TachePlat tachePlat;

    @ManyToOne
    @JoinColumn(name = "id_emp", nullable = false)
    private Employe employe;

    @OneToMany(mappedBy = "distributionTache", fetch = FetchType.LAZY)
    @OrderBy("dateHeureModification DESC")
    private List<MvtStatutTache> mvtStatutTaches;

    @Column(name = "date_tache")
    private LocalDate dateTache;

    // Getters et Setters
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Tache getTache() {
        return tache;
    }

    public void setTache(Tache tache) {
        this.tache = tache;
    }

    public TachePlat getTachePlat() {
        return tachePlat;
    }

    public void setTachePlat(TachePlat tachePlat) {
        this.tachePlat = tachePlat;
    }

    public Employe getEmploye() {
        return employe;
    }

    public void setEmploye(Employe employe) {
        this.employe = employe;
    }

    public LocalDate getDateTache() {
        return dateTache;
    }

    public void setDateTache(LocalDate dateTache) {
        this.dateTache = dateTache;
    }

    public List<MvtStatutTache> getMvtStatutTaches() {
        return mvtStatutTaches;
    }

    public void setMvtStatutTaches(List<MvtStatutTache> mvtStatutTaches) {
        this.mvtStatutTaches = mvtStatutTaches;
    }


}

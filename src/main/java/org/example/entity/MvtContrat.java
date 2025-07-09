package org.example.entity;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "mvt_contrat")
public class MvtContrat {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "id_entreprise", nullable = false)
    private Entreprise entreprise;

    @Column(name = "type_mvt", nullable = false)
    private Integer typeMvt;

    @Column(name = "date_mvt", nullable = false)
    @Temporal(TemporalType.DATE)
    private Date dateMvt;

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }
    public Entreprise getEntreprise() { return entreprise; }
    public void setEntreprise(Entreprise entreprise) { this.entreprise = entreprise; }
    public Integer getTypeMvt() { return typeMvt; }
    public void setTypeMvt(Integer typeMvt) { this.typeMvt = typeMvt; }
    public Date getDateMvt() { return dateMvt; }
    public void setDateMvt(Date dateMvt) { this.dateMvt = dateMvt; }
}

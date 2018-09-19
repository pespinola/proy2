/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo;

import java.io.Serializable;
import java.util.List;
import javax.persistence.Basic;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author Acer
 */
@Entity
@Table(name = "ventana")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Ventana.findAll", query = "SELECT v FROM Ventana v"),
    @NamedQuery(name = "Ventana.findByIdVentana", query = "SELECT v FROM Ventana v WHERE v.idVentana = :idVentana"),
    @NamedQuery(name = "Ventana.findByNivel", query = "SELECT v FROM Ventana v WHERE v.nivel = :nivel"),
    @NamedQuery(name = "Ventana.findByIdVentanaSuperior", query = "SELECT v FROM Ventana v WHERE v.idVentanaSuperior = :idVentanaSuperior"),
    @NamedQuery(name = "Ventana.findByNombre", query = "SELECT v FROM Ventana v WHERE v.nombre = :nombre")})
public class Ventana implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id_ventana")
    private Integer idVentana;
    @Basic(optional = false)
    @NotNull
    @Column(name = "nivel")
    private int nivel;
    @Column(name = "id_ventana_superior")
    private Integer idVentanaSuperior;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 2147483647)
    @Column(name = "nombre")
    private String nombre;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "idVentana")
    private List<Permiso> permisoList;

    public Ventana() {
    }

    public Ventana(Integer idVentana) {
        this.idVentana = idVentana;
    }

    public Ventana(Integer idVentana, int nivel, String nombre) {
        this.idVentana = idVentana;
        this.nivel = nivel;
        this.nombre = nombre;
    }

    public Integer getIdVentana() {
        return idVentana;
    }

    public void setIdVentana(Integer idVentana) {
        this.idVentana = idVentana;
    }

    public int getNivel() {
        return nivel;
    }

    public void setNivel(int nivel) {
        this.nivel = nivel;
    }

    public Integer getIdVentanaSuperior() {
        return idVentanaSuperior;
    }

    public void setIdVentanaSuperior(Integer idVentanaSuperior) {
        this.idVentanaSuperior = idVentanaSuperior;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    @XmlTransient
    public List<Permiso> getPermisoList() {
        return permisoList;
    }

    public void setPermisoList(List<Permiso> permisoList) {
        this.permisoList = permisoList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idVentana != null ? idVentana.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Ventana)) {
            return false;
        }
        Ventana other = (Ventana) object;
        if ((this.idVentana == null && other.idVentana != null) || (this.idVentana != null && !this.idVentana.equals(other.idVentana))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "modelo.Ventana[ idVentana=" + idVentana + " ]";
    }
    
}

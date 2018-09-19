/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo;

import java.io.Serializable;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.util.List;
import javax.persistence.Basic;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
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
@Table(name = "clase")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Clase.findAll", query = "SELECT c FROM Clase c"),
    @NamedQuery(name = "Clase.findByNroClase", query = "SELECT c FROM Clase c WHERE c.nroClase = :nroClase"),
    @NamedQuery(name = "Clase.findByDescripcion", query = "SELECT c FROM Clase c WHERE c.descripcion = :descripcion"),
    @NamedQuery(name = "Clase.findByVersion", query = "SELECT c FROM Clase c WHERE c.version = :version")})
public class Clase implements Serializable {

    private static final long serialVersionUID = 1L;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "nro_clase")
    private BigDecimal nroClase;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 2147483647)
    @Column(name = "descripcion")
    private String descripcion;
    @Basic(optional = false)
    @NotNull
    @Column(name = "version")
    private BigInteger version;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "nroClase")
    private List<Expediente> expedienteList;

    public Clase() {
    }

    public Clase(BigDecimal nroClase) {
        this.nroClase = nroClase;
    }

    public Clase(BigDecimal nroClase, String descripcion, BigInteger version) {
        this.nroClase = nroClase;
        this.descripcion = descripcion;
        this.version = version;
    }

    public BigDecimal getNroClase() {
        return nroClase;
    }

    public void setNroClase(BigDecimal nroClase) {
        this.nroClase = nroClase;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public BigInteger getVersion() {
        return version;
    }

    public void setVersion(BigInteger version) {
        this.version = version;
    }

    @XmlTransient
    public List<Expediente> getExpedienteList() {
        return expedienteList;
    }

    public void setExpedienteList(List<Expediente> expedienteList) {
        this.expedienteList = expedienteList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (nroClase != null ? nroClase.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Clase)) {
            return false;
        }
        Clase other = (Clase) object;
        if ((this.nroClase == null && other.nroClase != null) || (this.nroClase != null && !this.nroClase.equals(other.nroClase))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "modelo.Clase[ nroClase=" + nroClase + " ]";
    }
    
}

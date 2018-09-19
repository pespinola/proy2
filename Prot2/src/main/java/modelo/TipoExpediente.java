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
@Table(name = "tipo_expediente")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "TipoExpediente.findAll", query = "SELECT t FROM TipoExpediente t"),
    @NamedQuery(name = "TipoExpediente.findByIdTipoExpediente", query = "SELECT t FROM TipoExpediente t WHERE t.idTipoExpediente = :idTipoExpediente"),
    @NamedQuery(name = "TipoExpediente.findByDescripcion", query = "SELECT t FROM TipoExpediente t WHERE t.descripcion = :descripcion")})
public class TipoExpediente implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id_tipo_expediente")
    private Integer idTipoExpediente;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 2147483647)
    @Column(name = "descripcion")
    private String descripcion;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "tipoExpediente")
    private List<Expediente> expedienteList;

    public TipoExpediente() {
    }

    public TipoExpediente(Integer idTipoExpediente) {
        this.idTipoExpediente = idTipoExpediente;
    }

    public TipoExpediente(Integer idTipoExpediente, String descripcion) {
        this.idTipoExpediente = idTipoExpediente;
        this.descripcion = descripcion;
    }

    public Integer getIdTipoExpediente() {
        return idTipoExpediente;
    }

    public void setIdTipoExpediente(Integer idTipoExpediente) {
        this.idTipoExpediente = idTipoExpediente;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
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
        hash += (idTipoExpediente != null ? idTipoExpediente.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof TipoExpediente)) {
            return false;
        }
        TipoExpediente other = (TipoExpediente) object;
        if ((this.idTipoExpediente == null && other.idTipoExpediente != null) || (this.idTipoExpediente != null && !this.idTipoExpediente.equals(other.idTipoExpediente))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "modelo.TipoExpediente[ idTipoExpediente=" + idTipoExpediente + " ]";
    }
    
}

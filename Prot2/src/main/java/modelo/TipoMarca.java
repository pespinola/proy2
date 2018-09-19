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
@Table(name = "tipo_marca")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "TipoMarca.findAll", query = "SELECT t FROM TipoMarca t"),
    @NamedQuery(name = "TipoMarca.findByIdTipoMarca", query = "SELECT t FROM TipoMarca t WHERE t.idTipoMarca = :idTipoMarca"),
    @NamedQuery(name = "TipoMarca.findByDescripcion", query = "SELECT t FROM TipoMarca t WHERE t.descripcion = :descripcion")})
public class TipoMarca implements Serializable {

    /*Numero de idDenminativo usado por el sistema*/
    private static int nroIdDenominativo = 1;
    public int getNroIdDenominativo(){
        return nroIdDenominativo;
    }
    
    
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id_tipo_marca")
    private Integer idTipoMarca;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 2147483647)
    @Column(name = "descripcion")
    private String descripcion;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "idTipoMarca")
    private List<Marca> marcaList;

    public TipoMarca() {
    }

    public TipoMarca(Integer idTipoMarca) {
        this.idTipoMarca = idTipoMarca;
    }

    public TipoMarca(Integer idTipoMarca, String descripcion) {
        this.idTipoMarca = idTipoMarca;
        this.descripcion = descripcion;
    }

    public Integer getIdTipoMarca() {
        return idTipoMarca;
    }

    public void setIdTipoMarca(Integer idTipoMarca) {
        this.idTipoMarca = idTipoMarca;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    @XmlTransient
    public List<Marca> getMarcaList() {
        return marcaList;
    }

    public void setMarcaList(List<Marca> marcaList) {
        this.marcaList = marcaList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idTipoMarca != null ? idTipoMarca.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof TipoMarca)) {
            return false;
        }
        TipoMarca other = (TipoMarca) object;
        if ((this.idTipoMarca == null && other.idTipoMarca != null) || (this.idTipoMarca != null && !this.idTipoMarca.equals(other.idTipoMarca))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "modelo.TipoMarca[ idTipoMarca=" + idTipoMarca + " ]";
    }
    
}

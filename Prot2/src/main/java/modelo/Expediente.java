/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo;

import java.io.Serializable;
import java.math.BigInteger;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import javax.persistence.Basic;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author Acer
 */
@Entity
@Table(name = "expediente")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Expediente.findAll", query = "SELECT e FROM Expediente e"),
    @NamedQuery(name = "Expediente.findByIdExpediente", query = "SELECT e FROM Expediente e WHERE e.idExpediente = :idExpediente"),
    @NamedQuery(name = "Expediente.findByNroExpediente", query = "SELECT e FROM Expediente e WHERE e.nroExpediente = :nroExpediente"),
    @NamedQuery(name = "Expediente.findByFechaSolicitud", query = "SELECT e FROM Expediente e WHERE e.fechaSolicitud = :fechaSolicitud"),
    @NamedQuery(name = "Expediente.findByFechaEstado", query = "SELECT e FROM Expediente e WHERE e.fechaEstado = :fechaEstado"),
    @NamedQuery(name = "Expediente.findByProducto", query = "SELECT e FROM Expediente e WHERE e.producto = :producto"),
    @NamedQuery(name = "Expediente.findByObservacion", query = "SELECT e FROM Expediente e WHERE e.observacion = :observacion")})
public class Expediente implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id_expediente")
    private Integer idExpediente;
    @Basic(optional = false)
    @NotNull
    @Column(name = "nro_expediente")
    private BigInteger nroExpediente;
    @Basic(optional = false)
    @NotNull
    @Column(name = "fecha_solicitud")
    @Temporal(TemporalType.DATE)
    private Date fechaSolicitud;
    @Column(name = "fecha_estado")
    @Temporal(TemporalType.DATE)
    private Date fechaEstado;
    @Size(max = 2147483647)
    @Column(name = "producto")
    private String producto;
    @Size(max = 2147483647)
    @Column(name = "observacion")
    private String observacion;
    @JoinColumn(name = "id_abogado", referencedColumnName = "id_abogado")
    @ManyToOne(optional = false)
    private Abogado idAbogado;
    @JoinColumn(name = "nro_clase", referencedColumnName = "nro_clase")
    @ManyToOne(optional = false)
    private Clase nroClase;
    @JoinColumn(name = "id_cliente", referencedColumnName = "id_cliente")
    @ManyToOne(optional = false)
    private Cliente idCliente;
    @JoinColumn(name = "id_estado", referencedColumnName = "id_estado")
    @ManyToOne
    private EstadoMarca idEstado;
    @JoinColumn(name = "id_marca", referencedColumnName = "id_marca")
    @ManyToOne(optional = false)
    private Marca idMarca;
    @JoinColumn(name = "tipo_expediente", referencedColumnName = "id_tipo_expediente")
    @ManyToOne(optional = false)
    private TipoExpediente tipoExpediente;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "idExpediente")
    private List<Documento> documentoList;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "idExpediente")
    private List<Evento> eventoList;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "idExpediente")
    private List<Historial> historialList;

    public Expediente() {
    }

    public Expediente(Integer idExpediente) {
        this.idExpediente = idExpediente;
    }

    public Expediente(Integer idExpediente, BigInteger nroExpediente, Date fechaSolicitud) {
        this.idExpediente = idExpediente;
        this.nroExpediente = nroExpediente;
        this.fechaSolicitud = fechaSolicitud;
    }

    public Integer getIdExpediente() {
        return idExpediente;
    }

    public void setIdExpediente(Integer idExpediente) {
        this.idExpediente = idExpediente;
    }

    public BigInteger getNroExpediente() {
        return nroExpediente;
    }

    public void setNroExpediente(BigInteger nroExpediente) {
        this.nroExpediente = nroExpediente;
    }

    public Date getFechaSolicitud() {
        return fechaSolicitud;
    }

    public void setFechaSolicitud(Date fechaSolicitud) {
        this.fechaSolicitud = fechaSolicitud;
    }

    public Date getFechaEstado() {
        return fechaEstado;
    }

    public void setFechaEstado(Date fechaEstado) {
        this.fechaEstado = fechaEstado;
    }

    public String getProducto() {
        return producto;
    }

    public void setProducto(String producto) {
        this.producto = producto;
    }

    public String getObservacion() {
        return observacion;
    }

    public void setObservacion(String observacion) {
        this.observacion = observacion;
    }

    public Abogado getIdAbogado() {
        return idAbogado;
    }

    public void setIdAbogado(Abogado idAbogado) {
        this.idAbogado = idAbogado;
    }

    public Clase getNroClase() {
        return nroClase;
    }

    public void setNroClase(Clase nroClase) {
        this.nroClase = nroClase;
    }

    public Cliente getIdCliente() {
        return idCliente;
    }

    public void setIdCliente(Cliente idCliente) {
        this.idCliente = idCliente;
    }

    public EstadoMarca getIdEstado() {
        return idEstado;
    }

    public void setIdEstado(EstadoMarca idEstado) {
        this.idEstado = idEstado;
    }

    public Marca getIdMarca() {
        return idMarca;
    }

    public void setIdMarca(Marca idMarca) {
        this.idMarca = idMarca;
    }

    public TipoExpediente getTipoExpediente() {
        return tipoExpediente;
    }

    public void setTipoExpediente(TipoExpediente tipoExpediente) {
        this.tipoExpediente = tipoExpediente;
    }

    @XmlTransient
    public List<Documento> getDocumentoList() {
        return documentoList;
    }

    public void setDocumentoList(List<Documento> documentoList) {
        this.documentoList = documentoList;
    }

    @XmlTransient
    public List<Evento> getEventoList() {
        return eventoList;
    }

    public void setEventoList(List<Evento> eventoList) {
        this.eventoList = eventoList;
    }

    @XmlTransient
    public List<Historial> getHistorialList() {
        return historialList;
    }

    public void setHistorialList(List<Historial> historialList) {
        this.historialList = historialList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idExpediente != null ? idExpediente.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Expediente)) {
            return false;
        }
        Expediente other = (Expediente) object;
        if ((this.idExpediente == null && other.idExpediente != null) || (this.idExpediente != null && !this.idExpediente.equals(other.idExpediente))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "" + nroExpediente + "\n"+
                   idCliente + "\n"+
                   idAbogado + "\n"+
                   idEstado + "\n"+
                fechaEstado + "\n"+
                idMarca + "\n"+
                nroClase + "\n"+
                fechaSolicitud + "\n"+
                tipoExpediente + "\n"+
                producto + "\n"+
                observacion + "\n";
                
    }
    
    public String getStringFechaEstado(){
        String fecha = new SimpleDateFormat("dd-MM-yyyy").format(this.fechaEstado);
        return fecha;  
    }
    
    public String getStringFechaSolicitud(){
        String fecha = new SimpleDateFormat("dd-MM-yyyy").format(this.fechaSolicitud);
        return fecha;  
    }
    
}

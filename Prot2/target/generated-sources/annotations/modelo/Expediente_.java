package modelo;

import java.math.BigInteger;
import java.util.Date;
import javax.annotation.Generated;
import javax.persistence.metamodel.ListAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;
import modelo.Abogado;
import modelo.Clase;
import modelo.Cliente;
import modelo.Documento;
import modelo.EstadoMarca;
import modelo.Evento;
import modelo.Historial;
import modelo.Marca;
import modelo.TipoExpediente;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2018-09-14T23:44:37")
@StaticMetamodel(Expediente.class)
public class Expediente_ { 

    public static volatile ListAttribute<Expediente, Documento> documentoList;
    public static volatile SingularAttribute<Expediente, Date> fechaSolicitud;
    public static volatile SingularAttribute<Expediente, Integer> idExpediente;
    public static volatile SingularAttribute<Expediente, TipoExpediente> tipoExpediente;
    public static volatile ListAttribute<Expediente, Evento> eventoList;
    public static volatile SingularAttribute<Expediente, String> producto;
    public static volatile SingularAttribute<Expediente, Clase> nroClase;
    public static volatile SingularAttribute<Expediente, Date> fechaEstado;
    public static volatile SingularAttribute<Expediente, EstadoMarca> idEstado;
    public static volatile SingularAttribute<Expediente, BigInteger> nroExpediente;
    public static volatile SingularAttribute<Expediente, Cliente> idCliente;
    public static volatile ListAttribute<Expediente, Historial> historialList;
    public static volatile SingularAttribute<Expediente, Abogado> idAbogado;
    public static volatile SingularAttribute<Expediente, Marca> idMarca;
    public static volatile SingularAttribute<Expediente, String> observacion;

}
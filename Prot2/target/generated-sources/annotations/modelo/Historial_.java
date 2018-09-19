package modelo;

import java.util.Date;
import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;
import modelo.Abogado;
import modelo.Expediente;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2018-09-14T23:44:37")
@StaticMetamodel(Historial.class)
public class Historial_ { 

    public static volatile SingularAttribute<Historial, Date> fecha;
    public static volatile SingularAttribute<Historial, Expediente> idExpediente;
    public static volatile SingularAttribute<Historial, String> operacion;
    public static volatile SingularAttribute<Historial, Abogado> idAbogado;
    public static volatile SingularAttribute<Historial, Integer> idHistorial;
    public static volatile SingularAttribute<Historial, String> detalle;

}
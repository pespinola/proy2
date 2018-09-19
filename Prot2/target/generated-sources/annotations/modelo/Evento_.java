package modelo;

import java.util.Date;
import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;
import modelo.Expediente;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2018-09-14T23:44:37")
@StaticMetamodel(Evento.class)
public class Evento_ { 

    public static volatile SingularAttribute<Evento, String> descripcion;
    public static volatile SingularAttribute<Evento, Date> fecha;
    public static volatile SingularAttribute<Evento, Expediente> idExpediente;
    public static volatile SingularAttribute<Evento, Integer> idEvento;
    public static volatile SingularAttribute<Evento, String> nombre;

}
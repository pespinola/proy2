package modelo;

import java.math.BigDecimal;
import java.math.BigInteger;
import javax.annotation.Generated;
import javax.persistence.metamodel.ListAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;
import modelo.Expediente;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2018-09-14T23:44:37")
@StaticMetamodel(Clase.class)
public class Clase_ { 

    public static volatile SingularAttribute<Clase, String> descripcion;
    public static volatile SingularAttribute<Clase, BigDecimal> nroClase;
    public static volatile ListAttribute<Clase, Expediente> expedienteList;
    public static volatile SingularAttribute<Clase, BigInteger> version;

}
package modelo;

import javax.annotation.Generated;
import javax.persistence.metamodel.ListAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;
import modelo.Permiso;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2018-09-14T23:44:37")
@StaticMetamodel(Ventana.class)
public class Ventana_ { 

    public static volatile SingularAttribute<Ventana, Integer> idVentana;
    public static volatile SingularAttribute<Ventana, Integer> nivel;
    public static volatile SingularAttribute<Ventana, String> nombre;
    public static volatile SingularAttribute<Ventana, Integer> idVentanaSuperior;
    public static volatile ListAttribute<Ventana, Permiso> permisoList;

}
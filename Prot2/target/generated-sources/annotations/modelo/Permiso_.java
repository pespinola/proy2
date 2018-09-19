package modelo;

import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;
import modelo.Rol;
import modelo.Ventana;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2018-09-14T23:44:37")
@StaticMetamodel(Permiso.class)
public class Permiso_ { 

    public static volatile SingularAttribute<Permiso, Rol> idRol;
    public static volatile SingularAttribute<Permiso, Integer> idPermiso;
    public static volatile SingularAttribute<Permiso, Ventana> idVentana;

}
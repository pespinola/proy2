package modelo;

import javax.annotation.Generated;
import javax.persistence.metamodel.ListAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;
import modelo.Expediente;
import modelo.Historial;
import modelo.Usuario;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2018-09-14T23:44:37")
@StaticMetamodel(Abogado.class)
public class Abogado_ { 

    public static volatile SingularAttribute<Abogado, String> registroProfesional;
    public static volatile SingularAttribute<Abogado, Long> ci;
    public static volatile SingularAttribute<Abogado, String> apellido;
    public static volatile SingularAttribute<Abogado, Usuario> idUsuario;
    public static volatile SingularAttribute<Abogado, String> direccion;
    public static volatile ListAttribute<Abogado, Historial> historialList;
    public static volatile SingularAttribute<Abogado, Integer> idAbogado;
    public static volatile SingularAttribute<Abogado, String> telefono;
    public static volatile ListAttribute<Abogado, Expediente> expedienteList;
    public static volatile SingularAttribute<Abogado, String> nombre;

}
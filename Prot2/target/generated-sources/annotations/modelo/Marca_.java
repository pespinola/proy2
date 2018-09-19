package modelo;

import javax.annotation.Generated;
import javax.persistence.metamodel.ListAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;
import modelo.Expediente;
import modelo.Pais;
import modelo.TipoMarca;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2018-09-14T23:44:37")
@StaticMetamodel(Marca.class)
public class Marca_ { 

    public static volatile SingularAttribute<Marca, TipoMarca> idTipoMarca;
    public static volatile SingularAttribute<Marca, String> denominacion;
    public static volatile SingularAttribute<Marca, Pais> idPais;
    public static volatile SingularAttribute<Marca, byte[]> imagenMarca;
    public static volatile SingularAttribute<Marca, Integer> idMarca;
    public static volatile ListAttribute<Marca, Expediente> expedienteList;

}
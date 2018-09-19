package modelo;

import javax.annotation.Generated;
import javax.persistence.metamodel.ListAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;
import modelo.Marca;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2018-09-14T23:44:37")
@StaticMetamodel(TipoMarca.class)
public class TipoMarca_ { 

    public static volatile SingularAttribute<TipoMarca, String> descripcion;
    public static volatile SingularAttribute<TipoMarca, Integer> idTipoMarca;
    public static volatile ListAttribute<TipoMarca, Marca> marcaList;

}
package modelo;

import java.math.BigDecimal;
import javax.annotation.Generated;
import javax.persistence.metamodel.ListAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;
import modelo.Marca;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2018-09-14T23:44:37")
@StaticMetamodel(Pais.class)
public class Pais_ { 

    public static volatile SingularAttribute<Pais, BigDecimal> idPais;
    public static volatile SingularAttribute<Pais, String> iso2;
    public static volatile ListAttribute<Pais, Marca> marcaList;
    public static volatile SingularAttribute<Pais, String> pais;

}
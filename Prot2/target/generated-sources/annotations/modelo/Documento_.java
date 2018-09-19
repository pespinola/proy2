package modelo;

import java.math.BigInteger;
import java.util.Date;
import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;
import modelo.Expediente;
import modelo.TipoDocumento;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2018-09-14T23:44:37")
@StaticMetamodel(Documento.class)
public class Documento_ { 

    public static volatile SingularAttribute<Documento, String> descripcion;
    public static volatile SingularAttribute<Documento, Date> fecha;
    public static volatile SingularAttribute<Documento, Integer> idDocumento;
    public static volatile SingularAttribute<Documento, Expediente> idExpediente;
    public static volatile SingularAttribute<Documento, String> nombreDocumento;
    public static volatile SingularAttribute<Documento, TipoDocumento> idTipoDocumento;
    public static volatile SingularAttribute<Documento, byte[]> documento;
    public static volatile SingularAttribute<Documento, BigInteger> orden;

}
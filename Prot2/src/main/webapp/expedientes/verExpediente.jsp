<%-- 
    Document   : verExpediente
    Created on : 26-ago-2018, 15:14:31
    Author     : Acer
--%>

<%@page import="java.util.Base64"%>
<%@page import="modelo.Expediente"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="modeloMng.ExpedienteJpaController"%>  
<%response.setHeader("Cache-Control", "no-cache");
%>
<!DOCTYPE html>
<html>
    <head>
        <title>Expediente - Ta'angapp</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="//WEB-INF/paginaCabecera.jsp" %>
    </head>
    <body>
        <%
            Integer idExp = null;
            
            
            if(request.getParameter("idExpediente") != null){
                //Cambio de expediente
                idExp  = Integer.parseInt(request.getParameter("idExpediente"));
                request.getSession().setAttribute("idExpediente", idExp);
                
            }else{
                //Estamos en el mismo expediente
                idExp = (Integer)(request.getSession().getAttribute("idExpediente")); 
            }
             
            ExpedienteJpaController expControl = new ExpedienteJpaController();
            Expediente expediente = expControl.findExpediente(idExp);
            
        
            %> 

        <%@include file="//WEB-INF/menuCabecera.jsp" %>
        <br>
        
        <div class="container">
           <%@include file="//WEB-INF/menuExpediente.jsp" %>     
        </div>

        <div class="container form-control"> 
            <h2 class="text-justify">Expediente</h2> 
            <br>
            
            <div class="row form-group">
                <div class="col-3">
                    <label>Número de Expediente:</label>
                </div>
                <div class="col-6 form-control">
                    <%=expediente.getNroExpediente()%>
                </div> 
            </div>
            
            <div class="row form-group">
                <div class="col-3">
                    <label>Clase:</label>
                </div>
                <div class="col-6">
                    <div class="row form-group">
                        <div class="col-2 form-control">
                            <%=expediente.getNroClase().getNroClase()%>
                        </div>
                    </div>
                    <div class="row form-group">
                        <div class="col form-control">
                            <%=expediente.getNroClase().getDescripcion()%> 
                        </div>
                    </div>  
                </div>
            </div>
            
            <div class="row form-group">
                <div class="col-3">
                        <label>Estado:</label>
                </div>
                <div class="col-6 form-control">
                    <%=expediente.getIdEstado().getDescripcion()%>
                </div>
            </div>
                        
            <div class="row form-group">
                <div class="col-3">
                    <label>Agente:</label>
                </div>
                <div class="col-6 form-control">
                    <%=expediente.getIdAbogado().getNombreApellido()%>
                </div>
            </div>  
            
            <div class="row form-group">
                <div class="col-3">
                    <label>Fecha Status:</label>
                </div>
                <div class="col-6 form-control">
                    <%=expediente.getStringFechaEstado()%>
                </div>
            </div>
                
            <div class="row form-group">
                <div class="col-3">
                        <label>Fecha Solicitud:</label>
                </div>
                <div class="col-6 form-control">
                    <%=expediente.getStringFechaSolicitud()%>
                </div>
            </div>
               
            <div class="row form-group">
                <div class="col-3">
                    <label>Tipo de trámite:</label>
                </div>
                <div class="col-6 form-control">
                    <%=expediente.getTipoExpediente().getDescripcion()%>
                </div>
            </div>
             
            <div class="row form-group">
                <div class="col-3">
                    <label>Signo:</label>
                </div>
                <div class="col-6 form-control">
                    <%=expediente.getIdMarca().getIdTipoMarca().getDescripcion()%> 
                </div>
            </div>
            
            <div class="row form-group">
                <div class="col-3">
                    <label>Denominación:</label>
                </div>
                <div class="col-6 form-control">
                    <%=expediente.getIdMarca().getDenominacion()%>  
                </div>
            </div>
            
            <div class="row form-group">
                <div class="col-3">
                    <label>Producto:</label>
                </div>
                <div class="col-6 form-control">
                    <%=expediente.getProducto()%>
                </div>
            </div>
                
            <div class="row form-group">
                <div class="col-3">
                    <label>Titular:</label>
                </div>
                <div class="col-6 form-control">
                    <%=expediente.getIdCliente().getNombreCliente()%> 
                </div>
            </div>
                
            <div class="row form-group">
                <div class="col-3">
                    <label>Dirección Titular:</label>
                </div>
                <div class="col-6 form-control">
                    <%=expediente.getIdCliente().getDireccion()%> 
                </div>
            </div>
             
            <div class="row form-group">
                <div class="col-3">
                    <label>País de origen:</label>
                </div>
                <div class="col-6 form-control">
                    <%=expediente.getIdMarca().getIdPais().getPais()%>   
                </div>
            </div>
                
            <%if(expediente.getIdMarca().getImagenMarca() != null){
                String imageBase64 = new String(Base64.getEncoder().encode(expediente.getIdMarca().getImagenMarca()));
            %>
                <div class="row form-group">
                    <div class="col-3">
                        <label>Imagen:</label>
                    </div>
                    <div class="col-6 form-control form-inline justify-content-center">
                        <img  src="data:image/jpg;base64,<%=imageBase64%>" >    
                    </div>
                </div>
            <%}%>
            
            <div class="row form-group">
                <div class="col-3">
                    <label>Observación:</label>
                </div>
                <div class="col-6 form-control">
                    <%=expediente.getObservacion()%> 
                </div>
            </div>
          
        </div>
        <br>
        <style>
            img {
                position: static;
                width:  auto;
                height: 200px;
                background-position: 50% 50%;
                background-repeat:   no-repeat;
                background-size:     cover;
            }
        </style>
    </body>
</html>

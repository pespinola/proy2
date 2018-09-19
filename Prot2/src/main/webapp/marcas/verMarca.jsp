<%--  
    Document   : verMarca
    Created on : 20-ago-2018, 22:23:44
    Author     : Acer
--%>

<%@page import="java.util.Base64"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="modelo.Marca"%> 
<%@page import="modelo.Pais"%> 
<%@page import="modelo.TipoMarca"%>  
<%@page import="modeloMng.MarcaJpaController"%> 
<%response.setHeader("Cache-Control", "no-cache");
%>
<!DOCTYPE html>
<html>
    <head>
        <title>Marca - Ta'angapp</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="//WEB-INF/paginaCabecera.jsp" %>
    </head>

    <body>
        <%
            
            Integer idMarca = Integer.parseInt(request.getParameter("idMarca"));
            MarcaJpaController marcaControl = new MarcaJpaController();
            Marca marca = marcaControl.findMarca(idMarca);

        %>
        <%@include file="//WEB-INF/menuCabecera.jsp" %>
        <br>
        
        <div class ="container form-control">
            
            <h2 class="text-justify">Marca</h2>
            <br>
           
            <div class="row form-group">
                <div class="col-3">
                    <label>Código de marca:</label>
                </div>
                <div class="col-6 form-control">
                    <%=marca.getIdMarca()%>
                </div> 
            </div>
                
            <div class="row form-group">
                <div class="col-3">
                    <label>Denominación:</label>
                </div>
                <div class="col-6 form-control">
                    <%=marca.getDenominacion()%>
                </div> 
            </div>
                
            <div class="row form-group">
                <div class="col-3">
                    <label>Signo:</label>
                </div>
                <div class="col-6 form-control">
                    <%=marca.getIdTipoMarca().getDescripcion()%>
                </div> 
            </div>
                
            <div class="row form-group">
                <div class="col-3">
                    <label>País de origen:</label>
                </div>
                <div class="col-6 form-control">
                    <%=marca.getIdPais().getPais()%>
                </div> 
            </div>

            <% if (marca.getImagenMarca() != null) {
                    String imageBase64 = new String(Base64.getEncoder().encode(marca.getImagenMarca()));
            %>
                <div class="row form-group">
                    <div class="col-3">
                        <label>Imagen de la Marca:</label>
                    </div>
                    <div class="col-6 form-control form-inline justify-content-center">
                        <img  src="data:image/jpg;base64,<%=imageBase64%>" >    
                    </div>
                </div>
            <%}%>
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


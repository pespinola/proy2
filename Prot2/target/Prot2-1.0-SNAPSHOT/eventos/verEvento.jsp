<%-- 
    Document   : agregarDocumento
    Created on : 27-ago-2018, 16:19:36
    Author     : Acer
--%>


<%@page import="java.util.List"%>
<%@page import="modelo.Evento"%>
<%@page import="modeloMng.EventoJpaController"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Evento - Ta'angapp</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="//WEB-INF/paginaCabecera.jsp" %>
    </head>
    <body>
        <%
            
            Integer idEvento = Integer.parseInt(request.getParameter("idEvento"));
            Evento evento = new EventoJpaController().findEvento(idEvento);

        %>

        <%@include file="//WEB-INF/menuCabecera.jsp" %>
        <br>
        
        <div class="container">
           <%@include file="//WEB-INF/menuExpediente.jsp" %>     
        </div>
        
        <div class="container form-control">
            <h2 class="text-justify">Evento</h2> 
            <br>

            <div class="row form-group">
                <div class="col-3">
                    <label>Número de Expediente:</label>
                </div>
                <div class="col-6 form-control" id="nroExp">
                    <%=evento.getIdExpediente().getNroExpediente()%>   
                </div>
            </div>

            <div class="row form-group">    
                <div class="col-3">
                    <label>Nombre del Evento:</label>
                </div>
                <div class="col-6 form-control" id="nombre">
                    <%=evento.getNombre()%>  
                </div>
            </div>

            <div class="row form-group">
                <div class="col-3">
                    <label>Fecha del Evento: </label>
                </div>
                <div class="col-6 form-control" id="fecha">
                    <%=evento.getStringFecha()%>   
                </div>
            </div>

            <div class="row form-group">
                <div class="col-3">
                    <label>Descripción:</label>
                </div>
                <div class="col-6 form-control" id="descripcion">
                    <%=evento.getDescripcion()%>
                </div>
            </div>
        </div>
        <br>
    </body>
</html>

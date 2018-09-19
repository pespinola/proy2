<%-- 
    Document   : verAbogado
    Created on : 11-sep-2018, 16:04:01
    Author     : Acer
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="modelo.Abogado"%>   
<%@page import="modeloMng.AbogadoJpaController"%> 
<%response.setHeader("Cache-Control", "no-cache");
%>
<!DOCTYPE html>
<html>
    <head>
        <title>Agente - Ta'angapp</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="//WEB-INF/paginaCabecera.jsp" %>
    </head>

    <body>
        <%
            
            Integer idAbogado = Integer.parseInt(request.getParameter("idAbogado"));
            Abogado abogado = new AbogadoJpaController().findAbogado(idAbogado);
     
        %>
        <%@include file="//WEB-INF/menuCabecera.jsp" %>
        <br>
        
        <div class ="container form-control">
            
            <h2 class="text-justify">Agente</h2>
            <br>
           
            <div class="row form-group">
                <div class="col-3">
                    <label>C.I.Nº:</label>
                </div>
                <div class="col-6 form-control">
                    <%=abogado.getCi()%> 
                </div> 
            </div>
                
            <div class="row form-group">
                <div class="col-3">
                    <label>Nombre:</label>
                </div>
                <div class="col-6 form-control">
                    <%=abogado.getNombre()%>
                </div> 
            </div>
                
            <div class="row form-group">
                <div class="col-3">
                    <label>Apellido:</label>
                </div>
                <div class="col-6 form-control">
                    <%=abogado.getApellido()%> 
                </div> 
            </div>
                
            <div class="row form-group">
                <div class="col-3">
                    <label>Dirección:</label>
                </div>
                <div class="col-6 form-control">
                    <%=abogado.getDireccion()%>
                </div> 
            </div>
                
            <div class="row form-group">
                <div class="col-3">
                    <label>Teléfono:</label>
                </div>
                <div class="col-6 form-control">
                    <%=abogado.getTelefono()%>
                </div> 
            </div>
                
            <div class="row form-group">
                <div class="col-3">
                    <label>Registro Profesional:</label>
                </div>
                <div class="col-6 form-control">
                    <%=abogado.getRegistroProfesional()%> 
                </div> 
            </div>
                
            <div class="row form-group">
                <div class="col-3">
                    <label>Cuenta de Usuario:</label>
                </div>
                <div class="col-6 form-control">
                    <%=abogado.getIdUsuario().getCuenta()%> 
                </div> 
            </div>
        </div>
        <br>
    </body>
</html>
<%-- 
    Document   : verUsuario
    Created on : 13-sep-2018, 12:28:24
    Author     : Acer
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="modelo.Usuario"%>   
<%@page import="modeloMng.UsuarioJpaController"%> 
<%response.setHeader("Cache-Control", "no-cache");
%>
<!DOCTYPE html>
<html>
    <head>
        <title>Usuario - Ta'angapp</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="//WEB-INF/paginaCabecera.jsp" %>
    </head>

    <body>
        <%
            
            Integer idUsuario = Integer.parseInt(request.getParameter("idUsuario"));
            Usuario usu = new UsuarioJpaController().findUsuario(idUsuario);
     
        %>
        <%@include file="//WEB-INF/menuCabecera.jsp" %>
        <br>
        
        <div class ="container form-control">
            
            <h2 class="text-justify">Usuario</h2>
            <br>
           
            <div class="row form-group">
                <div class="col-3">
                    <label>Código de Usuario:</label>
                </div>
                <div class="col-6 form-control">
                    <%=usu.getIdUsuario()%> 
                </div> 
            </div>
                
            <div class="row form-group">
                <div class="col-3">
                    <label>Cuenta:</label>
                </div>
                <div class="col-6 form-control">
                    <%=usu.getCuenta()%>
                </div> 
            </div>
                
            <div class="row form-group">
                <div class="col-3">
                    <label>Rol:</label>
                </div>
                <div class="col-6 form-control">
                    <%=usu.getIdRol().getDescripcion()%> 
                </div> 
            </div>
                
                <div class="row form-group">
                <div class="col-3">
                    <label>Estado:</label>
                </div>
                <div class="col-6 form-control">
                    <%=usu.getEstado()%> 
                </div> 
            </div>

        </div>
        <br>
    </body>
</html>
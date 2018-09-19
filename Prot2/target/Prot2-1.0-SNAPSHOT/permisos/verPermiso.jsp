<%-- 
    Document   : verPermiso
    Created on : 14-sep-2018, 11:59:23
    Author     : Acer
--%>
<%@page import="modeloMng.RolJpaController"%>
<%@page import="modelo.Rol"%>
<%@page import="modeloMng.PermisoJpaController"%>
<%@page import="java.util.List"%>
<%@page import="modelo.Permiso"%> 
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%response.setHeader("Cache-Control", "no-cache");
%>
<!DOCTYPE html>
<html>
    <head>
        <title>Permiso - Ta'angapp</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="//WEB-INF/paginaCabecera.jsp" %>
    </head>
    <body>
        <%
            Integer idRol = Integer.parseInt(request.getParameter("idRol"));
            Rol rol = new RolJpaController().findRol(idRol);
            
            PermisoJpaController permisoControl = new PermisoJpaController();
            
            List<Permiso> lista = permisoControl.getPermisoRol(idRol);
            
        %>
        <%@include file="//WEB-INF/menuCabecera.jsp"%>
        <br>
         
        <div class ="container form-control">
        
            <h2 class="text-justify"> Permiso para <%=rol.getDescripcion()%></h2> 
            <br> 
            <%for(int i=0; i<lista.size();i++){%>
                <div class="row form-group">
                    <div class="col-3">
                        
                    </div>
                    <div class="col-6 form-control">
                        <%=lista.get(i).getIdVentana().getNombre()%>  
                    </div> 
                </div>
            <%}%>
        </div>
    </body>
</html>

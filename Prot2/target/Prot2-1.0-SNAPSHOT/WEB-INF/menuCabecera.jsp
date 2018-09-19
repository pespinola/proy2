<%-- 
    Document   : menuCabecera
    Created on : 12-ago-2018, 16:02:30
    Author     : Acer
--%>

<%@page import="modeloMng.PermisoJpaController"%>
<%@page import="modelo.Rol"%>
<%@page import="modelo.Usuario"%>
<link href="<%=request.getContextPath()%>/css/menu.css" rel="stylesheet">
<% Usuario usuario = (Usuario) request.getSession().getAttribute("usuario");
   
   Integer rolUsuarioConectado = usuario.getIdRol().getIdRol();
   PermisoJpaController permisoControlAcceso = new PermisoJpaController();
%>
<div class="container-fluid">
    <br>
    <div class="row">
        <div class="col-10"></div>
        <div class="col">
            <div class="text-center">
                <i class="fa fa-user-circle"></i>
                <% if (usuario != null) {%>

                <p> <%= usuario.getCuenta()%>

                    <br>
                    <a href="<%=request.getContextPath()%>/LoginServlet?desconectar=true">Salir</a>
                </p>
                <%}%>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col" id="linea1" ></div>
        <div class="col-9" id="linea2">
            <ul class="nav nav-tabs" >
                
                <%if(permisoControlAcceso.permisoRolVentana(rolUsuarioConectado, 1)){%>
                    <li class="nav-item" >
                        <a class="nav-link" href="<%=request.getContextPath()%>/marcas.jsp">Marcas</a>
                    </li>
                <%}%>
                
                <%if(permisoControlAcceso.permisoRolVentana(rolUsuarioConectado, 6)){%>
                    <li class="nav-item">
                        <a class="nav-link" href="<%=request.getContextPath()%>/expedientes.jsp">Expedientes</a>
                    </li>
                <%}%>
                
                <%if(permisoControlAcceso.permisoRolVentana(rolUsuarioConectado, 21)){%> 
                    <li class="nav-item">
                        <a class="nav-link" href="<%=request.getContextPath()%>/abogados.jsp">Agentes</a>
                    </li>
                <%}%>
                
                <%if(permisoControlAcceso.permisoRolVentana(rolUsuarioConectado,26)){%> 
                    <li class="nav-item">
                        <a class="nav-link" href="<%=request.getContextPath()%>/clientes.jsp">Titulares</a>
                    </li>
                <%}%>    
                    
                <%if(permisoControlAcceso.permisoRolVentana(rolUsuarioConectado,31)){%>
                    <li class="nav-item">
                        <a class="nav-link" href="<%=request.getContextPath()%>/usuarios.jsp">Usuarios</a>
                    </li>
                <%}%>
                
                <%if(permisoControlAcceso.permisoRolVentana(rolUsuarioConectado,36)){%>
                    <li class="nav-item">
                        <a class="nav-link" href="<%=request.getContextPath()%>/roles.jsp">Roles</a>
                    </li>
                <%}%>
                
                <%if(permisoControlAcceso.permisoRolVentana(rolUsuarioConectado,40)){%>
                    <li class="nav-item">
                        <a class="nav-link" href="<%=request.getContextPath()%>/permisos.jsp">Permisos</a>
                    </li>
                <%}%>
            </ul>
        </div>
    </div>
</div>
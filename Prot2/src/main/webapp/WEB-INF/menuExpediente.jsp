<%@page import="modeloMng.PermisoJpaController"%>
<%@page import="modelo.Rol"%>
<%@page import="modelo.Usuario"%>
<link href="<%=request.getContextPath()%>/css/menu.css" rel="stylesheet">
<% Usuario usuarioExp = (Usuario) request.getSession().getAttribute("usuario");
   Integer rolUsuarioConectadoExp = usuarioExp.getIdRol().getIdRol();  
   PermisoJpaController permisoControlAccesoExp = new PermisoJpaController();
%>

<ul class="nav nav-tabs" >
    <li class="nav-item">
        <a class="nav-link" 
           href="<%=request.getContextPath()%>/expedientes/verExpediente.jsp"> 
            Detalles</a>
    </li>

    <%if (permisoControlAccesoExp.permisoRolVentana(rolUsuarioConectadoExp, 9)) {%>
    <li class="nav-item">
        <a class="nav-link" 
           href="<%=request.getContextPath()%>/documentos.jsp">
            Documentos</a>
    </li>
    <%}%>
    <%if (permisoControlAccesoExp.permisoRolVentana(rolUsuarioConectadoExp, 14)) {%>
    <li class="nav-item">
        <a class="nav-link" href="<%=request.getContextPath()%>/eventos.jsp">
            Eventos</a>
    </li>
    <%}%>
</ul> 
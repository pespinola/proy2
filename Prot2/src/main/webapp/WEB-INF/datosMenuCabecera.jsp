<%@page import="modeloMng.PermisoJpaController"%>
<%@page import="modelo.Rol"%>
<%@page import="modelo.Usuario"%>
<link href="<%=request.getContextPath()%>/css/menu.css" rel="stylesheet">
<% Usuario usuario = (Usuario) request.getSession().getAttribute("usuario");
   Integer rolUsuarioConectado = usuario.getIdRol().getIdRol();
   PermisoJpaController permisoControlAcceso = new PermisoJpaController();
%>

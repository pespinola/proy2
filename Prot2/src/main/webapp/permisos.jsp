
<%@page import="modelo.Rol"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="modeloMng.RolJpaController"%>  
<%response.setHeader("Cache-Control", "no-cache");
%>

<!DOCTYPE html>
<html>
    <head>
        <title>Permiso - Ta'angapp</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="//WEB-INF/paginaCabecera.jsp" %>
        <link rel="stylesheet" type="text/css" href="//cdn.datatables.net/1.10.16/css/jquery.dataTables.css">
        <script type="text/javascript" charset="utf-8" src="//cdn.datatables.net/1.10.16/js/jquery.dataTables.js"></script>
    </head>
    <body>
        <%
           
            List<Rol> lista = new RolJpaController().findRolEntities(); 

        %> 

        <%@include file="//WEB-INF/menuCabecera.jsp" %>
        <br>
        
        <div class="container form-control">
            <%@include file="//WEB-INF/mensajeErrorABM.jsp" %>
            <h2 class="text-justify">Permiso</h2>
            <br>
            
            <table id="mytable" class="table table-striped table-bordered dt-responsive nowrap">
                <thead style="background-color:whitesmoke">
                    <tr>
                        
                        <th>Rol</th>
                        <th></th>
                    </tr>
                </thead>

                <tbody id='cuerpoTabla'>
                    <%for (int i = 0; i < lista.size(); i++) {%>

                    <tr>
                        <input id="idRol-<%=i%>" type="hidden"  value="<%=lista.get(i).getIdRol()%>"/>   
                        <td id="descripcion-<%=i%>"><%=lista.get(i).getDescripcion()%></td>
                        <td>
                            <%if(permisoControlAcceso.permisoRolVentana(rolUsuarioConectado,42)){%>
                                <i class="fa fa-search" 
                                   style="font-size:24px"  
                                   onmouseover="this.style.cursor = 'pointer'" 
                                   onclick='window.location.href = "<%=request.getContextPath()%>/permisos/verPermiso.jsp?idRol=<%=lista.get(i).getIdRol()%>"'>  
                                </i>
                            <%}%>
                            <%if(permisoControlAcceso.permisoRolVentana(rolUsuarioConectado,41)){%>
                                <i class="fa fa-edit" 
                                   style="font-size:24px"  
                                   onmouseover="this.style.cursor = 'pointer'" 
                                   onclick='window.location.href = "<%=request.getContextPath()%>/permisos/editarPermiso.jsp?idRol=<%=lista.get(i).getIdRol()%>"'>  
                                </i>
                            <%}%>
                        </td>
                    </tr>
                    <%}%>
                </tbody>
            </table> 
        </div>
        <br>
        <script>
            $(document).ready(function () {
                $('#mytable').DataTable({
                    "language": {
                        "url": "//cdn.datatables.net/plug-ins/1.10.16/i18n/Spanish.json"
                    }
                });
            });
        </script>
    </body>
</html>
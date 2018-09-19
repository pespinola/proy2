<%-- 
    Document   : usuarios
    Created on : 13-sep-2018, 11:53:38
    Author     : Acer
--%>

<%@page import="modelo.Rol"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="modeloMng.RolJpaController"%>  
<%response.setHeader("Cache-Control", "no-cache");
%>

<!DOCTYPE html>
<html>
    <head>
        <title>Usuario - Ta'angapp</title>
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
            <h2 class="text-justify">Roles</h2>
            <br>
            
            <table id="mytable" class="table table-striped table-bordered dt-responsive nowrap">
                <thead style="background-color:whitesmoke">
                    <tr>
                        
                        <th>Rol</th>
                        <th>Estado</th>
                        <th>
                            <%if(permisoControlAcceso.permisoRolVentana(rolUsuarioConectado,37)){%> 
                                <i class="fa fa-plus-circle" 
                                    style="font-size:24px"  
                                    onmouseover="this.style.cursor = 'pointer'" 
                                    onclick='window.location.href = "<%=request.getContextPath()%>/roles/agregarRol.jsp"'> 
                                </i>
                            <%}%>
                        </th>
                    </tr>
                </thead>

                <tbody id='cuerpoTabla'>
                    <%for (int i = 0; i < lista.size(); i++) {%>

                    <tr>
                        <input id="idRol-<%=i%>" type="hidden"  value="<%=lista.get(i).getIdRol()%>"/>     
                        <td id="descripcion-<%=i%>"><%=lista.get(i).getRol()%></td>
                        <td id="estado-<%=i%>"><%=lista.get(i).getEstado()%></td>
                        <td>
                            <%if(permisoControlAcceso.permisoRolVentana(rolUsuarioConectado,38)){%> 
                                <i class="fa fa-edit" 
                                   style="font-size:24px"  
                                   onmouseover="this.style.cursor = 'pointer'" 
                                   onclick='window.location.href = "<%=request.getContextPath()%>/roles/editarRol.jsp?idRol=<%=lista.get(i).getIdRol()%>"'>  
                                </i>
                            <%}%>
                            <%if(permisoControlAcceso.permisoRolVentana(rolUsuarioConectado,39 )){%> 
                                <i class="fa fa-remove" 
                                   style="font-size:24px"  
                                   onmouseover="this.style.cursor = 'pointer'" 
                                   onclick="modalEliminar('<%=i%>')"> 
                                </i>
                            <%}%>
                        </td>
                    </tr>
                    <%}%>
                </tbody>
            </table> 

        </div>
        <%-- Modal Eliminar --%>
        <div class="modal fade" id="modal-eliminar" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">

                    <div class="modal-header">
                        <h4 class="modal-title">Eliminar</h4>
                        <button type="button" class="close" data-dismiss="modal">&times;</button>

                    </div>
                    <div class="modal-body">
                        <form id="form-eliminar" action="<%=request.getContextPath()%>/RolServlet" method="post">
                            <input name= "idRol" id="eliminar-rol" type="hidden"/>   
                            <p id="eliminar-mensaje"></p>

                        </form>
                    </div>
                    <div class="modal-footer">
                        <button form="form-eliminar" id="btn-eliminar"  type="submit" name="eliminar" class="btn btn-default" >Eliminar</button>
                    </div>
                </div>
            </div>
        </div>
        <br>
        <script>
            function modalEliminar(fila) {
                $(document).ready(function () {

                    $("#modal-eliminar").modal();
                    var descripcion = document.getElementById("descripcion-"+fila).textContent;
                    var idRol = document.getElementById("idRol-"+fila).value; 
                    
                    document.getElementById("eliminar-rol").value = idRol; 
                    document.getElementById("eliminar-mensaje").textContent =
                            "¿Desea eliminar el rol " + descripcion + "?";
                    
                    
                });
            }
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
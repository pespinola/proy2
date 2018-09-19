

<%@page import="modelo.Usuario"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="modeloMng.UsuarioJpaController"%>  
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
           
            List<Usuario> lista = new UsuarioJpaController().findUsuarioEntities(); 

        %> 

        <%@include file="//WEB-INF/menuCabecera.jsp" %>
        <br>
        
        <div class="container form-control">
            <%@include file="//WEB-INF/mensajeErrorABM.jsp" %>
            <h2 class="text-justify">Usuarios</h2>
            <br>
            
            <table id="mytable" class="table table-striped table-bordered dt-responsive nowrap">
                <thead style="background-color:whitesmoke">
                    <tr>
                        <th>Código Usuario</th>
                        <th>Cuenta</th>
                        <th>Rol</th>
                        <th>
                            <%if(permisoControlAcceso.permisoRolVentana(rolUsuarioConectado,32 )){%>
                                <i class="fa fa-plus-circle" 
                                    style="font-size:24px"  
                                    onmouseover="this.style.cursor = 'pointer'" 
                                    onclick='window.location.href = "<%=request.getContextPath()%>/usuarios/agregarUsuario.jsp"'> 
                                </i>
                            <%}%>
                        </th>
                    </tr>
                </thead>

                <tbody id='cuerpoTabla'>
                    <%for (int i = 0; i < lista.size(); i++) {%>

                    <tr>
                        <input id="idUsuario-<%=i%>" type="hidden"  value="<%=lista.get(i).getIdUsuario()%>"/>   
                        <td><%=lista.get(i).getIdUsuario()%></td>
                        <td id="cuenta-<%=i%>"><%=lista.get(i).getCuenta()%></td> 
                        <td><%=lista.get(i).getIdRol().getDescripcion()%></td>
                        <td>
                            <%if(permisoControlAcceso.permisoRolVentana(rolUsuarioConectado, 33)){%>
                                <i class="fa fa-search" 
                                   style="font-size:24px"  
                                   onmouseover="this.style.cursor = 'pointer'" 
                                   onclick='window.location.href = "<%=request.getContextPath()%>/usuarios/verUsuario.jsp?idUsuario=<%=lista.get(i).getIdUsuario()%>"'>  
                                </i>
                            <%}%>
                            <%if(permisoControlAcceso.permisoRolVentana(rolUsuarioConectado,34 )){%>
                                <i class="fa fa-edit" 
                                   style="font-size:24px"  

                                   onmouseover="this.style.cursor = 'pointer'" 
                                   onclick='window.location.href = "<%=request.getContextPath()%>/usuarios/editarUsuario.jsp?idUsuario=<%=lista.get(i).getIdUsuario()%>"'>  
                                </i>
                            <%}%>
                            <%if(permisoControlAcceso.permisoRolVentana(rolUsuarioConectado,35)){%>
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
                        <form id="form-eliminar" action="<%=request.getContextPath()%>/UsuarioServlet" method="post">
                            <input name= "idUsuario" id="eliminar-usuario" type="hidden"/>   
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
                    var cuenta = document.getElementById("cuenta-"+fila).textContent;
                    var idUsuario = document.getElementById("idUsuario-"+fila).value; 
                    
                    document.getElementById("eliminar-usuario").value = idUsuario; 
                    document.getElementById("eliminar-mensaje").textContent =
                            "¿Desea eliminar la cuenta " + cuenta + "?";
                    
                    
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
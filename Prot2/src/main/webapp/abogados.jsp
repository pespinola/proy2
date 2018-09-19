
<%@page import="modelo.Abogado"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="modeloMng.AbogadoJpaController"%>  
<%response.setHeader("Cache-Control", "no-cache");
%>

<!DOCTYPE html>
<html>
    <head>
        <title>Agente - Ta'angapp</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="//WEB-INF/paginaCabecera.jsp" %>
        <link rel="stylesheet" type="text/css" href="//cdn.datatables.net/1.10.16/css/jquery.dataTables.css">
        <script type="text/javascript" charset="utf-8" src="//cdn.datatables.net/1.10.16/js/jquery.dataTables.js"></script>
    </head>
    <body>
        <%
           
            List<Abogado> lista = new AbogadoJpaController().findAbogadoEntities(); 

        %> 

        <%@include file="//WEB-INF/menuCabecera.jsp" %>
        <br>
        
        <div class="container form-control">
            <%@include file="//WEB-INF/mensajeErrorABM.jsp" %>
            <h2 class="text-justify">Agentes</h2>
            <br>
            
            <table id="mytable" class="table table-striped table-bordered dt-responsive nowrap">
                <thead style="background-color:whitesmoke">
                    <tr>
                        <th>C.I.Nº</th>
                        <th>Agente</th>
                        <th>Dirección</th>
                        <th>Teléfono</th>
                        <th>Registro Profesional</th>
                        <th>
                            <%if(permisoControlAcceso.permisoRolVentana(rolUsuarioConectado, 22)){%>
                                <i class="fa fa-plus-circle" 
                                    style="font-size:24px"  
                                    onmouseover="this.style.cursor = 'pointer'" 
                                    onclick='window.location.href = "<%=request.getContextPath()%>/abogados/agregarAbogado.jsp"'> 
                                </i>
                            <%}%>
                        </th>
                    </tr>
                </thead>

                <tbody id='cuerpoTabla'>
                    <%for (int i = 0; i < lista.size(); i++) {%>

                    <tr>
                        <input id="idAbogado-<%=i%>" type="hidden"  value="<%=lista.get(i).getIdAbogado()%>"/>   
                        <td><%=lista.get(i).getCi()%></td>
                        <td id="abogado-<%=i%>"><%=lista.get(i).getNombreApellido()%></td> 
                        <td><%=lista.get(i).getDireccion()%></td>  
                        <td><%=lista.get(i).getTelefono()%></td> 
                        <td><%=lista.get(i).getRegistroProfesional()%></td> 
                        <td>
                            <%if(permisoControlAcceso.permisoRolVentana(rolUsuarioConectado,23 )){%>
                                <i class="fa fa-search" 
                                   style="font-size:24px"  
                                   onmouseover="this.style.cursor = 'pointer'" 
                                   onclick='window.location.href = "<%=request.getContextPath()%>/abogados/verAbogado.jsp?idAbogado=<%=lista.get(i).getIdAbogado()%>"'>  
                                </i>
                            <%}%>
                            <%if(permisoControlAcceso.permisoRolVentana(rolUsuarioConectado,24 )){%>
                                <i class="fa fa-edit" 
                                   style="font-size:24px"  
                                   onmouseover="this.style.cursor = 'pointer'" 
                                   onclick='window.location.href = "<%=request.getContextPath()%>/abogados/editarAbogado.jsp?idAbogado=<%=lista.get(i).getIdAbogado()%>"'> 
                                </i>
                            <%}%>
                            <%if(permisoControlAcceso.permisoRolVentana(rolUsuarioConectado,25)){%>
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
                        <form id="form-eliminar" action="<%=request.getContextPath()%>/AbogadoServlet" method="post">
                            <input name= "idAbogado" id="eliminar-abogado" type="hidden"/>   
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
                    var abogado = document.getElementById("abogado-"+fila).textContent;
                    var idAbogado = document.getElementById("idAbogado-"+fila).value; 
                    
                    document.getElementById("eliminar-abogado").value = idAbogado; 
                    document.getElementById("eliminar-mensaje").textContent =
                            "¿Desea eliminar al agente " + abogado + "?";
                    
                    
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

<%@page import="java.util.Base64"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="modelo.Marca"%> 
<%@page import="modelo.Pais"%> 
<%@page import="modelo.TipoMarca"%>  
<%@page import="modeloMng.MarcaJpaController"%> 
<%response.setHeader("Cache-Control", "no-cache");
%>
<!DOCTYPE html>
<html>
    <head>

        <title>Marcas - Ta'angapp</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="//WEB-INF/paginaCabecera.jsp" %>
        <link rel="stylesheet" type="text/css" href="//cdn.datatables.net/1.10.16/css/jquery.dataTables.css">
        <script type="text/javascript" charset="utf-8" src="//cdn.datatables.net/1.10.16/js/jquery.dataTables.js"></script>

    </head>
    <body onload="init()">
        
        <%
            List<Marca> listaMarca;
            MarcaJpaController marcaControl = new MarcaJpaController();
            listaMarca = marcaControl.findMarcaEntities();
            /*try{
                lista = clasecontrol.findClaseEntities();
            }catch(Exception e){ 
            
            }*/
        %>
        <%@include file="//WEB-INF/menuCabecera.jsp" %>
        <br>
        <div class="container form-control">
            <%@include file="//WEB-INF/mensajeErrorABM.jsp" %>
            <h2 class="text-justify">Marcas</h2>
            <br>

            <table id="mytable" class="table table-striped table-bordered dt-responsive nowrap">
                <thead style="background-color:whitesmoke">
                    <tr>
                        <th>Nombre de la Marca</th>
                        <th>Signo</th>
                        <th>País</th>
                        <th>
                            <%if(permisoControlAcceso.permisoRolVentana(rolUsuarioConectado, 2)){%>
                                <i class="fa fa-plus-circle" 
                                   style="font-size:24px"  
                                   onmouseover="this.style.cursor = 'pointer'" 
                                   onclick='window.location.href = "<%=request.getContextPath()%>/marcas/agregarMarca.jsp"'> 
                                </i>
                            <%}%> 
                        </th>
                    </tr>
                </thead>

                <tbody id='cuerpoTabla'>
                    <%for (int i = 0; i < listaMarca.size(); i++) {%>

                    <tr>
                        <input id="marca-<%=i%>" type="hidden"  value="<%=listaMarca.get(i).getIdMarca()%>"/> 
                        <td id="denominacion-<%=i%>"><%=listaMarca.get(i).getDenominacion()%></td>
                        <td id="signo-<%=i%>"><%=listaMarca.get(i).getIdTipoMarca().getDescripcion()%></td> 
                        <td id="pais-<%=i%>" ><%=listaMarca.get(i).getIdPais().getPais()%></td>
                        <td>
                            <%if(permisoControlAcceso.permisoRolVentana(rolUsuarioConectado, 3)){%>
                                <i class="fa fa-search" 
                                   style="font-size:24px"  
                                   onmouseover="this.style.cursor = 'pointer'" 
                                   onclick='window.location.href = "<%=request.getContextPath()%>/marcas/verMarca.jsp?idMarca=<%=listaMarca.get(i).getIdMarca()%>"'> 
                                </i>
                            <%}%>
                            <%if(permisoControlAcceso.permisoRolVentana(rolUsuarioConectado,4 )){%> 
                                <i class="fa fa-edit" 
                                   style="font-size:24px"  
                                   onmouseover="this.style.cursor = 'pointer'" 
                                   onclick='window.location.href = "<%=request.getContextPath()%>/marcas/editarMarca.jsp?idMarca=<%=listaMarca.get(i).getIdMarca()%>"'> 
                                </i>
                            <%}%>
                            <%if(permisoControlAcceso.permisoRolVentana(rolUsuarioConectado,5)){%>
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
                        <form id="form-eliminar" action="<%=request.getContextPath()%>/MarcaServlet" method="post">
                            <input name= "idMarca" id="eliminar-marca" type="hidden"/>   
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
                    var denominacion = document.getElementById("denominacion-" + fila).textContent;
                    var idMarca = document.getElementById("marca-" + fila).value;

                    document.getElementById("eliminar-marca").value = idMarca;
                    document.getElementById("eliminar-mensaje").textContent =
                            "¿Desea eliminar la marca " + denominacion + "?";


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

<%-- 
    Document   : agregarUsuario
    Created on : 13-sep-2018, 12:47:26
    Author     : Acer
--%>

<%@page import="modeloMng.RolJpaController"%>
<%@page import="java.util.List"%>
<%@page import="modelo.Rol"%> 
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%response.setHeader("Cache-Control", "no-cache");
%>
<!DOCTYPE html>
<html>
    <head>
        <title>Rol - Ta'angapp</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="//WEB-INF/paginaCabecera.jsp" %>
    </head>
    <body>
        <%
            Integer idRol = Integer.parseInt(request.getParameter("idRol"));
            Rol rol = new RolJpaController().findRol(idRol);

        %>
        <%@include file="//WEB-INF/menuCabecera.jsp" %>
        <br>

        <div class ="container form-control">

            <h2 class="text-justify">Editar Rol</h2>
            <br> 

            <form id="editarRol" 
                  action="<%=request.getContextPath()%>/RolServlet?editar=true" 
                  method="post"
                  novalidate
                  onsubmit="return false"
                  >
                <input type="hidden" name="idRol" value="<%=idRol%>">
            </form>

            <div class="row form-group">
                <div class="col-3">
                    <label for="rol">Rol:</label> 
                </div>
                <div class="col-6">
                    <input value="<%=rol.getRol()%>"
                           disabled
                           class="form-control"
                           >
                    
                </div>
            </div>
            
            <div class="row form-group">
                <div class="col-3">
                    <label for="rol">Descripción:</label> 
                </div>
                <div class="col-6">
                    <textarea   form="editarRol"
                                name="descripcion"
                                id="descripcion"
                                class="form-control"
                                rows="6"
                                maxlength="250"
                                placeholder="Escriba una breve descripción"
                                required
                                
                                ><%=rol.getDescripcion()%></textarea>
                    <div id="descripcion-retro"></div>
                </div> 
            </div>


            <div class="row form-group">
                <div class="col-5">
                </div>
                <div class="col-2">
                    <input id="agregar"
                           type="button"
                           value="Editar"
                           onclick="validarFormulario()"
                           >
                </div>    
            </div>
  
        </div>
            <br>
            <script>
                function validarFormulario() {
                    var validoDescripcion = validarDescripcion();

                    if (validoDescripcion) {

                        document.getElementById("editarRol").submit();
                    }
                }

                function validarDescripcion(){
                    var descripcionInput = document.getElementById("descripcion");
                    var retroDescripcion = document.getElementById("descripcion-retro");
                    var strDescripcion = descripcionInput.value;

                    if(strDescripcion.length == 0){ 
                        descripcionInput.setAttribute("class","form-control is-invalid");
                        retroDescripcion.setAttribute("class","invalid-feedback");
                        retroDescripcion.textContent = 'El campo esta vacío';

                        return false;
                    }
                
                        descripcionInput.setAttribute("class","form-control is-valid");
                        retroDescripcion.setAttribute("class","valid-feedback");
                        retroDescripcion.textContent = '';

                        return true;
                }

            </script>
    </body>
</html>

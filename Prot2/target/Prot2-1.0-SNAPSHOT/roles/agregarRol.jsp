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
            List<Rol> listaRol = new RolJpaController().findRolEntities();
            
        %>
        <%@include file="//WEB-INF/menuCabecera.jsp" %>
        <br>
         
        <div class ="container form-control">
        
            <h2 class="text-justify"> Agregar Rol</h2>
            <br> 
        
            <form id="agregarRol" 
                  action="<%=request.getContextPath()%>/RolServlet?agregar=true" 
                  method="post" 
                  novalidate
                  onsubmit="return false">
            </form>
          
            <div class="row form-group">
                <div class="col-3">
                    <label for="rol">Rol:</label> 
                </div>
                <div class="col-6">
                    <input form="agregarRol"
                           name="rol"
                           id="rol"
                           class="form-control"
                           type="text" 
                           placeholder="Rol"
                           required 
                           minlength="8"
                           onkeypress="return isNotSpaceKey(event)"
                           >
                    <div id="rol-retro"></div>
                </div> 
                
            </div>
             <div class="row form-group">
                <div class="col-3">
                    <label for="rol">Descripción:</label> 
                </div>
                <div class="col-6">
                    <textarea   form="agregarRol"
                                name="descripcion"
                                id="descripcion"
                                class="form-control"
                                rows="6"
                                maxlength="250"
                                placeholder="Escriba una breve descripción"
                                required
                                ></textarea>
                    <div id="descripcion-retro"></div>
                </div> 
                
            </div>
  
            
            <div class="row form-group">
                <div class="col-5">
                </div>
                <div class="col-2">
                    <input id="agregar"
                           type="button"
                           value="Guardar"
                           onclick="validarFormulario()"
                          >
                </div>    
            </div>
       
        </div>
        <br>
        <script>
            function validarFormulario(){
                var validoRol = validarRol();
                var validoDescripcion = validarDescripcion();
                
                if(validoRol && validoDescripcion){
                    
                    document.getElementById("agregarRol").submit();
                }   
            }
            
            function validarRol(){
                var rolInput = document.getElementById("rol");
                var retroRol = document.getElementById("rol-retro");
                var strRol = rolInput.value.trim();
                
                if(strRol.length == 0){ 
                    rolInput.setAttribute("class","form-control is-invalid");
                    retroRol.setAttribute("class","invalid-feedback");
                    retroRol.textContent = 'El campo esta vacío';
                    
                    return false;
                }
                
                rolInput.setAttribute("class","form-control is-valid");
                retroRol.setAttribute("class","valid-feedback");
                retroRol.textContent = '';
                    
                return true;
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
            
            function isNotSpaceKey(evt){
                var charCode = (evt.which) ? evt.which : event.keyCode;
                if (charCode > 31 && (charCode == 32 ))
                    return false;
                return true;
            }
            
            
           
        </script>
    </body>
</html>
    
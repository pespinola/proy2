<%-- 
    Document   : editarPermiso
    Created on : 14-sep-2018, 0:29:19
    Author     : Acer
--%>
<%@page import="modeloMng.PermisoJpaController"%>
<%@page import="modeloMng.VentanaJpaController"%> 
<%@page import="java.util.List"%>
<%@page import="modelo.Permiso"%> 
<%@page import="modelo.Ventana"%>  
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%response.setHeader("Cache-Control", "no-cache");
%>
<!DOCTYPE html>
<html>
    <head>
        <title>Permiso - Ta'angapp</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="//WEB-INF/paginaCabecera.jsp" %>
    </head>
    <body onload="inicial()">
        <%
            Integer idRol = Integer.parseInt(request.getParameter("idRol"));
            PermisoJpaController permisoControl = new PermisoJpaController();
        %>
        <%@include file="//WEB-INF/menuCabecera.jsp"%>
        <br>
         
        <div class ="container form-control">
        
            <h2 class="text-justify">Editar Permiso</h2>
            <br> 
        
            <form id="editarPermiso" 
                  action="<%=request.getContextPath()%>/PermisoServlet?editar=true" 
                  method="post">
                <input type="hidden" name="idRol" value="<%=idRol%>">
            </form>
          
            <div class="row form-group">
                <div class="col-3">
                    <input form="editarPermiso"
                               name="permiso"
                               id="menuMarca"
                               type="checkbox"
                               value="1"
                               <%if(permisoControl.permisoRolVentana(idRol, 1)){%> 
                                  checked
                               <%}%>
                               onclick="ocultarSubmenuMarcas()"
                               >Menú Marca
                </div>
                <div class="col-8 form-control">
                    <div class="col">
                        <input form="editarPermiso"
                               name="permiso"
                               id="agregarMarca"
                               type="checkbox"
                               value="2"
                               <%if(permisoControl.permisoRolVentana(idRol, 2)){%> 
                                  checked
                               <%}%>
                               >Agregar
                    </div>
                    <div class="col">
                        <input form="editarPermiso"
                               name="permiso"
                               id="verMarca"
                               type="checkbox"
                               value="3"
                               <%if(permisoControl.permisoRolVentana(idRol, 3)){%> 
                                  checked
                               <%}%>
                               >Ver
                    </div>
                    <div class="col">
                        <input form="editarPermiso"
                               name="permiso"
                               id="editarMarca"
                               type="checkbox"
                               value="4"
                               <%if(permisoControl.permisoRolVentana(idRol, 4)){%> 
                                  checked
                               <%}%>
                               >Editar
                    </div>
                    <div class="col">
                        <input form="editarPermiso"
                               name="permiso"
                               id="eliminarMarca"
                               type="checkbox"
                               value="5"
                               <%if(permisoControl.permisoRolVentana(idRol, 5)){%> 
                                  checked
                               <%}%>
                               >Eliminar
                    </div>
                </div>
            </div>
                  
            <div class="row form-group">
                <div class="col-3">
                    <input form="editarPermiso"
                               name="permiso"
                               id="menuExpediente"
                               type="checkbox"
                               value="6"
                               <%if(permisoControl.permisoRolVentana(idRol, 6)){%> 
                                  checked
                               <%}%>
                               onclick="ocultarSubmenuExpediente()"
                               >Menú Expediente
                </div>
                <div class="col-8 form-control">
                    <div class="col">
                        <input form="editarPermiso"
                               name="permiso"
                               id="agregarExp"
                               type="checkbox"
                               value="7"
                               <%if(permisoControl.permisoRolVentana(idRol, 7)){%> 
                                  checked
                               <%}%>
                               >Agregar
                    </div>
                    <div class="col">
                        <input form="editarPermiso"
                               name="permiso"
                               id="verExp"
                               type="checkbox"
                               value="8"
                               <%if(permisoControl.permisoRolVentana(idRol, 8)){%> 
                                  checked
                               <%}%>
                               onclick="ocultarSubmenuVerExp()"
                               >Ver
                    </div>
                    <div class="col">
                        <input form="editarPermiso"
                               name="permiso"
                               id="editarExp"
                               type="checkbox"
                               value="19"
                               <%if(permisoControl.permisoRolVentana(idRol, 19)){%> 
                                  checked
                               <%}%>
                               >Editar
                    </div>
                    <div class="col">
                        <input form="editarPermiso"
                               name="permiso"
                               id="eliminarExp"
                               type="checkbox"
                               value="20"
                               <%if(permisoControl.permisoRolVentana(idRol, 20)){%> 
                                  checked
                               <%}%>
                               >Eliminar
                    </div>
                </div>
            </div>
                  
            <div class="row form-group">
                <div class="col-3">
                    <input form="editarPermiso"
                               name="permiso"
                               id="menuDocumento"
                               type="checkbox"
                               value="9"
                               <%if(permisoControl.permisoRolVentana(idRol, 9)){%> 
                                  checked
                               <%}%>
                               onclick="ocultarSubmenuDocumento()"
                               >Menú Documento
                </div>
                <div class="col-8 form-control">
                    <div class="col">
                        <input form="editarPermiso"
                               name="permiso"
                               id="agregarDoc"
                               type="checkbox"
                               value="10"
                               <%if(permisoControl.permisoRolVentana(idRol, 10)){%> 
                                  checked
                               <%}%>
                               >Agregar
                    </div>
                    <div class="col">
                        <input form="editarPermiso"
                               name="permiso"
                               id="verDoc"
                               type="checkbox"
                               value="11"
                               <%if(permisoControl.permisoRolVentana(idRol, 11)){%> 
                                  checked
                               <%}%>
                               >Ver
                    </div>
                    <div class="col">
                        <input form="editarPermiso"
                               name="permiso"
                               id="editarDoc"
                               type="checkbox"
                               value="12"
                               <%if(permisoControl.permisoRolVentana(idRol, 12)){%> 
                                  checked
                               <%}%>
                               >Editar
                    </div>
                    <div class="col">
                        <input form="editarPermiso"
                               name="permiso"
                               id="eliminarDoc"
                               type="checkbox"
                               value="13"
                               <%if(permisoControl.permisoRolVentana(idRol, 13)){%> 
                                  checked
                               <%}%>
                               >Eliminar
                    </div>
                </div>
            </div>
                  
            <div class="row form-group">
                <div class="col-3">
                    <input form="editarPermiso"
                               name="permiso"
                               id="menuEvento"
                               type="checkbox"
                               value="14"
                               <%if(permisoControl.permisoRolVentana(idRol, 14)){%> 
                                  checked
                               <%}%>
                               onclick="ocultarSubmenuEvento()"
                               >Menú Evento
                </div>
                <div class="col-8 form-control">
                    <div class="col">
                        <input form="editarPermiso"
                               name="permiso"
                               id="agregarEven"
                               type="checkbox"
                               value="15"
                               <%if(permisoControl.permisoRolVentana(idRol, 15)){%> 
                                  checked
                               <%}%>
                               >Agregar
                    </div>
                    <div class="col">
                        <input form="editarPermiso"
                               name="permiso"
                               id="verEven"
                               type="checkbox"
                               value="16"
                               <%if(permisoControl.permisoRolVentana(idRol, 16)){%> 
                                  checked
                               <%}%>
                               >Ver
                    </div>
                    <div class="col">
                        <input form="editarPermiso"
                               name="permiso"
                               id="editarEven"
                               type="checkbox"
                               value="17"
                               <%if(permisoControl.permisoRolVentana(idRol, 17)){%> 
                                  checked
                               <%}%>
                               >Editar
                    </div>
                    <div class="col">
                        <input form="editarPermiso"
                               name="permiso"
                               id="eliminarEven"
                               type="checkbox"
                               value="18"
                               <%if(permisoControl.permisoRolVentana(idRol, 18)){%> 
                                  checked
                               <%}%>
                               >Eliminar
                    </div>
                </div>
            </div>
                  
            <div class="row form-group">
                <div class="col-3">
                    <input form="editarPermiso"
                               name="permiso"
                               id="menuAgente"
                               type="checkbox"
                               value="21"
                               <%if(permisoControl.permisoRolVentana(idRol, 21)){%> 
                                  checked
                               <%}%>
                               onclick="ocultarSubmenuAgente()"
                               >Menú Agente
                </div>
                <div class="col-8 form-control">
                    <div class="col">
                        <input form="editarPermiso"
                               name="permiso"
                               id="agregarAgente"
                               type="checkbox"
                               value="22"
                               <%if(permisoControl.permisoRolVentana(idRol, 22)){%> 
                                  checked
                               <%}%>
                               >Agregar
                    </div>
                    <div class="col">
                        <input form="editarPermiso"
                               name="permiso"
                               id="verAgente"
                               type="checkbox"
                               value="23"
                               <%if(permisoControl.permisoRolVentana(idRol, 23)){%> 
                                  checked
                               <%}%>
                               >Ver
                    </div>
                    <div class="col">
                        <input form="editarPermiso"
                               name="permiso"
                               id="editarAgente"
                               type="checkbox"
                               value="24"
                               <%if(permisoControl.permisoRolVentana(idRol, 24)){%> 
                                  checked
                               <%}%>
                               >Editar
                    </div>
                    <div class="col">
                        <input form="editarPermiso"
                               name="permiso"
                               id="eliminarAgente"
                               type="checkbox"
                               value="25"
                               <%if(permisoControl.permisoRolVentana(idRol, 25)){%> 
                                  checked
                               <%}%>
                               >Eliminar
                    </div>
                </div>
            </div>
                  
            <div class="row form-group">
                <div class="col-3">
                    <input form="editarPermiso"
                               name="permiso"
                               id="menuTitular"
                               type="checkbox"
                               value="26"
                               <%if(permisoControl.permisoRolVentana(idRol, 26)){%> 
                                  checked
                               <%}%>
                               onclick="ocultarSubmenuTitular()"
                               >Menú Titular
                </div>
                <div class="col-8 form-control">
                    <div class="col">
                        <input form="editarPermiso"
                               name="permiso"
                               id="agregarTitular"
                               type="checkbox"
                               value="27"
                               <%if(permisoControl.permisoRolVentana(idRol, 27)){%> 
                                  checked
                               <%}%>
                               >Agregar
                    </div>
                    <div class="col">
                        <input form="editarPermiso"
                               name="permiso"
                               id="verTitular"
                               type="checkbox"
                               value="28"
                               <%if(permisoControl.permisoRolVentana(idRol, 28)){%> 
                                  checked
                               <%}%>
                               >Ver
                    </div>
                    <div class="col">
                        <input form="editarPermiso"
                               name="permiso"
                               id="editarTitular"
                               type="checkbox"
                               value="29"
                               <%if(permisoControl.permisoRolVentana(idRol, 29)){%> 
                                  checked
                               <%}%>
                               >Editar
                    </div>
                    <div class="col">
                        <input form="editarPermiso"
                               name="permiso"
                               id="eliminarTitular"
                               type="checkbox"
                               value="30"
                               <%if(permisoControl.permisoRolVentana(idRol, 30)){%> 
                                  checked
                               <%}%>
                               >Eliminar
                    </div>
                </div>
            </div>
                  
            <div class="row form-group">
                <div class="col-3">
                    <input form="editarPermiso"
                               name="permiso"
                               id="menuUsuario"
                               type="checkbox"
                               value="31"
                               <%if(permisoControl.permisoRolVentana(idRol, 31)){%> 
                                  checked
                               <%}%>
                               onclick="ocultarSubmenuUsuario()"
                               >Menú Usuario
                </div>
                <div class="col-8 form-control">
                    <div class="col">
                        <input form="editarPermiso"
                               name="permiso"
                               id="agregarUsuario"
                               type="checkbox"
                               value="32"
                               <%if(permisoControl.permisoRolVentana(idRol, 32)){%> 
                                  checked
                               <%}%>
                               >Agregar
                    </div>
                    <div class="col">
                        <input form="editarPermiso"
                               name="permiso"
                               id="verUsuario"
                               type="checkbox"
                               value="33"
                               <%if(permisoControl.permisoRolVentana(idRol, 33)){%> 
                                  checked
                               <%}%>
                               >Ver
                    </div>
                    <div class="col">
                        <input form="editarPermiso"
                               name="permiso"
                               id="editarUsuario"
                               type="checkbox"
                               value="34"
                               <%if(permisoControl.permisoRolVentana(idRol, 34)){%> 
                                  checked
                               <%}%>
                               >Editar
                    </div>
                    <div class="col">
                        <input form="editarPermiso"
                               name="permiso"
                               id="eliminarUsuario"
                               type="checkbox"
                               value="35"
                               <%if(permisoControl.permisoRolVentana(idRol, 35)){%> 
                                  checked
                               <%}%>
                               >Eliminar
                    </div>
                </div>
            </div>
                  
            <div class="row form-group">
                <div class="col-3">
                    <input form="editarPermiso"
                               name="permiso"
                               id="menuRol"
                               type="checkbox"
                               value="36"
                               <%if(permisoControl.permisoRolVentana(idRol, 36)){%> 
                                  checked
                               <%}%>
                               onclick="ocultarSubmenuRol()"
                               >Menú Rol
                </div>
                <div class="col-8 form-control">
                    <div class="col">
                        <input form="editarPermiso"
                               name="permiso"
                               id="agregarRol"
                               type="checkbox"
                               value="37"
                               <%if(permisoControl.permisoRolVentana(idRol, 37)){%> 
                                  checked
                               <%}%>
                               >Agregar
                    </div>
                    
                    <div class="col">
                        <input form="editarPermiso"
                               name="permiso"
                               id="editarRol"
                               type="checkbox"
                               value="38"
                               <%if(permisoControl.permisoRolVentana(idRol, 38)){%> 
                                  checked
                               <%}%>
                               >Editar
                    </div>
                    <div class="col">
                        <input form="editarPermiso"
                               name="permiso"
                               id="eliminarRol"
                               type="checkbox"
                               value="39"
                               <%if(permisoControl.permisoRolVentana(idRol, 39)){%> 
                                  checked
                               <%}%>
                               >Eliminar
                    </div>
                </div>
            </div>
                  
            <div class="row form-group">
                <div class="col-3">
                    <input form="editarPermiso"
                               name="permiso"
                               id="menuPermiso"
                               type="checkbox"
                               value="40"
                               <%if(permisoControl.permisoRolVentana(idRol, 40)){%> 
                                  checked
                               <%}%>
                               onclick="ocultarSubmenuPermiso()"
                               >Menú Permiso
                </div>
                <div class="col-8 form-control">
                    <div class="col">
                        <input form="editarPermiso"
                               name="permiso"
                               id="agregarPermiso"
                               type="checkbox"
                               value="41"
                               <%if(permisoControl.permisoRolVentana(idRol, 41)){%> 
                                  checked
                               <%}%>
                               >Editar
                    </div>
                    
                    <div class="col">
                        <input form="editarPermiso"
                               name="permiso"
                               id="verPermiso"
                               type="checkbox"
                               value="42"
                               <%if(permisoControl.permisoRolVentana(idRol, 42)){%> 
                                  checked
                               <%}%>
                               >Ver
                    </div>
                    
                </div>
            </div>
  
            
            <div class="row form-group">
                <div class="col-5">
                </div>
                <div class="col-2">
                    <input form="editarPermiso"
                           type="submit"
                           value="Guardar"
                          >
                </div>    
            </div>
       
        </div>
        <br>
        <script>
            function inicial(){
                
                ocultarSubmenuMarcas();
                ocultarSubmenuExpediente();
                ocultarSubmenuDocumento();
                ocultarSubmenuEvento();
                ocultarSubmenuAgente();
                ocultarSubmenuTitular();
                ocultarSubmenuUsuario();
                ocultarSubmenuRol();
                ocultarSubmenuPermiso();
                
                
                
                ocultarSubmenuVerExp();
                
            }
            
            function ocultarSubmenuPermiso(){
                var checkInput = document.getElementById("menuPermiso");
                    
                if(checkInput.checked){
                    document.getElementById("agregarPermiso").removeAttribute("disabled","");
                    document.getElementById("verPermiso").removeAttribute("disabled","");
                    
                }else{
                    document.getElementById("agregarPermiso").setAttribute("disabled","");
                    document.getElementById("verPermiso").setAttribute("disabled","");
                    
                }
            }
            
            function ocultarSubmenuRol(){
                var checkInput = document.getElementById("menuRol");
                    
                if(checkInput.checked){
                    document.getElementById("agregarRol").removeAttribute("disabled","");
                    document.getElementById("eliminarRol").removeAttribute("disabled","");
                    document.getElementById("editarRol").removeAttribute("disabled","");
                    
                }else{
                    document.getElementById("agregarRol").setAttribute("disabled","");
                    document.getElementById("eliminarRol").setAttribute("disabled","");
                    document.getElementById("editarRol").setAttribute("disabled","");
                }
            }
            
            function ocultarSubmenuUsuario(){
                var checkInput = document.getElementById("menuUsuario");
                    
                if(checkInput.checked){
                    document.getElementById("agregarUsuario").removeAttribute("disabled","");
                    document.getElementById("verUsuario").removeAttribute("disabled","");
                    document.getElementById("eliminarUsuario").removeAttribute("disabled","");
                    document.getElementById("editarUsuario").removeAttribute("disabled","");
                    
                }else{
                    document.getElementById("agregarUsuario").setAttribute("disabled","");
                    document.getElementById("verUsuario").setAttribute("disabled","");
                    document.getElementById("eliminarUsuario").setAttribute("disabled","");
                    document.getElementById("editarUsuario").setAttribute("disabled","");
                }
            }
            
            
            function ocultarSubmenuTitular(){
                var checkInput = document.getElementById("menuTitular");
                    
                if(checkInput.checked){
                    document.getElementById("agregarTitular").removeAttribute("disabled","");
                    document.getElementById("verTitular").removeAttribute("disabled","");
                    document.getElementById("eliminarTitular").removeAttribute("disabled","");
                    document.getElementById("editarTitular").removeAttribute("disabled","");
                    
                }else{
                    document.getElementById("agregarTitular").setAttribute("disabled","");
                    document.getElementById("verTitular").setAttribute("disabled","");
                    document.getElementById("eliminarTitular").setAttribute("disabled","");
                    document.getElementById("editarTitular").setAttribute("disabled","");
                }
            }
            
            function ocultarSubmenuAgente(){
                var checkInput = document.getElementById("menuAgente");
                    
                if(checkInput.checked){
                    document.getElementById("agregarAgente").removeAttribute("disabled","");
                    document.getElementById("verAgente").removeAttribute("disabled","");
                    document.getElementById("eliminarAgente").removeAttribute("disabled","");
                    document.getElementById("editarAgente").removeAttribute("disabled","");
                    
                }else{
                    document.getElementById("agregarAgente").setAttribute("disabled","");
                    document.getElementById("verAgente").setAttribute("disabled","");
                    document.getElementById("eliminarAgente").setAttribute("disabled","");
                    document.getElementById("editarAgente").setAttribute("disabled","");
                }
            }
            
            function ocultarSubmenuMarcas(){
                var checkMarca = document.getElementById("menuMarca");
                    
                if(checkMarca.checked){
                    document.getElementById("agregarMarca").removeAttribute("disabled","");
                    document.getElementById("verMarca").removeAttribute("disabled","");
                    document.getElementById("eliminarMarca").removeAttribute("disabled","");
                    document.getElementById("editarMarca").removeAttribute("disabled","");
                    
                }else{
                    document.getElementById("agregarMarca").setAttribute("disabled","");
                    document.getElementById("verMarca").setAttribute("disabled","");
                    document.getElementById("eliminarMarca").setAttribute("disabled","");
                    document.getElementById("editarMarca").setAttribute("disabled","");
                }
            }
            
            function ocultarSubmenuExpediente(){
                var checkInput= document.getElementById("menuExpediente");
                    
                if(checkInput.checked){
                    document.getElementById("agregarExp").removeAttribute("disabled","");
                    document.getElementById("verExp").removeAttribute("disabled","");
                    document.getElementById("eliminarExp").removeAttribute("disabled","");
                    document.getElementById("editarExp").removeAttribute("disabled","");
                    
                    ocultarSubmenuVerExp();
                    
                }else{
                    document.getElementById("agregarExp").setAttribute("disabled","");
                    document.getElementById("verExp").setAttribute("disabled","");
                    document.getElementById("eliminarExp").setAttribute("disabled","");
                    document.getElementById("editarExp").setAttribute("disabled","");
                    
                    document.getElementById("menuDocumento").setAttribute("disabled","");
                    document.getElementById("agregarDoc").setAttribute("disabled","");
                    document.getElementById("verDoc").setAttribute("disabled","");
                    document.getElementById("eliminarDoc").setAttribute("disabled","");
                    document.getElementById("editarDoc").setAttribute("disabled","");
                    
                    document.getElementById("menuEvento").setAttribute("disabled","");
                    document.getElementById("agregarEven").setAttribute("disabled","");
                    document.getElementById("verEven").setAttribute("disabled","");
                    document.getElementById("eliminarEven").setAttribute("disabled","");
                    document.getElementById("editarEven").setAttribute("disabled","");
                }
            }
            
            function ocultarSubmenuDocumento(){
                var checkInput= document.getElementById("menuDocumento");
                    
                if(checkInput.checked){
                    document.getElementById("agregarDoc").removeAttribute("disabled","");
                    document.getElementById("verDoc").removeAttribute("disabled","");
                    document.getElementById("eliminarDoc").removeAttribute("disabled","");
                    document.getElementById("editarDoc").removeAttribute("disabled","");
                    
                }else{
                    document.getElementById("agregarDoc").setAttribute("disabled","");
                    document.getElementById("verDoc").setAttribute("disabled","");
                    document.getElementById("eliminarDoc").setAttribute("disabled","");
                    document.getElementById("editarDoc").setAttribute("disabled","");
                }
            }
            
            function ocultarSubmenuEvento(){
                var checkInput= document.getElementById("menuEvento");
                    
                if(checkInput.checked){
                    document.getElementById("agregarEven").removeAttribute("disabled","");
                    document.getElementById("verEven").removeAttribute("disabled","");
                    document.getElementById("eliminarEven").removeAttribute("disabled","");
                    document.getElementById("editarEven").removeAttribute("disabled","");
                    
                }else{
                    document.getElementById("agregarEven").setAttribute("disabled","");
                    document.getElementById("verEven").setAttribute("disabled","");
                    document.getElementById("eliminarEven").setAttribute("disabled","");
                    document.getElementById("editarEven").setAttribute("disabled","");
                }
            }
            
            function ocultarSubmenuVerExp(){
                var checkInput= document.getElementById("verExp");
                
                if(checkInput.checked){
                    document.getElementById("menuDocumento").removeAttribute("disabled","");
                    document.getElementById("menuEvento").removeAttribute("disabled","");
                    
                    ocultarSubmenuDocumento();
                    ocultarSubmenuEvento();
                    
                }else{
                    document.getElementById("menuDocumento").setAttribute("disabled","");
                    document.getElementById("agregarDoc").setAttribute("disabled","");
                    document.getElementById("verDoc").setAttribute("disabled","");
                    document.getElementById("eliminarDoc").setAttribute("disabled","");
                    document.getElementById("editarDoc").setAttribute("disabled","");
                    
                    document.getElementById("menuEvento").setAttribute("disabled","");
                    document.getElementById("agregarEven").setAttribute("disabled","");
                    document.getElementById("verEven").setAttribute("disabled","");
                    document.getElementById("eliminarEven").setAttribute("disabled","");
                    document.getElementById("editarEven").setAttribute("disabled","");
                }
                
            }
            
            
        </script>
    </body>
</html>
    
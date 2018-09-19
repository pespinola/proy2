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
        <title>Usuario - Ta'angapp</title>
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
        
            <h2 class="text-justify"> Agregar Usuario</h2>
            <br> 
        
            <form id="agregarUsuario" 
                  action="<%=request.getContextPath()%>/UsuarioServlet?agregar=true" 
                  method="post" 
                  novalidate>
            </form>
            
            <div class="row form-group">
                <div class="col-3">
                    <label for="idRol">Rol:</label>
                </div>  
                <div class="col-6">
                    <select form="agregarUsuario" 
                            name="idRol" 
                            id="idRol" 
                            class="form-control">
                            <%for (int j = 0; j < listaRol.size(); j++) {%>   
                                <option value="<%=listaRol.get(j).getIdRol()%>">   
                                    <%=listaRol.get(j).getDescripcion()%>  
                                </option>
                            <%}%>
                    </select>             
                </div>
            </div>
            
            <div class="row form-group">
                <div class="col-3">
                    <label id="label"for="cuenta">Cuenta Usuario:</label> 
                </div>
                <div class="col-6">
                    <input form="agregarUsuario"
                           name="cuenta"
                           id="cuenta"
                           class="form-control"
                           type="text" 
                           placeholder="Escriba la cuenta del usuario"
                           required 
                           minlength="8"
                           onkeypress="return isLetterNumberKey(event)">
                    <div id="cuenta-retro"></div>
                </div> 
            </div>
  
            <div class="row form-group">
                <div class="col-3">
                    <label for="contrasena">Contraseña:</label> 
                </div>
                <div class="col-6">
                    <input form="agregarUsuario"
                           name="contrasena"
                           id="contrasena"
                           class="form-control"
                           type="password" 
                           placeholder="Escriba la contraseña"
                           minlength="8"
                           onkeypress="return isNotSpaceKey(event)"
                           required >
                    <div id="contrasena-retro"></div>
                </div> 
            </div>
            
            <div class="row form-group">
                <div class="col-3">
                    <label for="confirmar">Confirmar Contraseña:</label> 
                </div>
                <div class="col-6">
                    <input form="agregarUsuario"
                           name="confirmar"
                           id="confirmar"
                           class="form-control"
                           type="password" 
                           placeholder="Escriba de nuevo la contraseña para confrimar"
                           minlength="8"
                           required >
                    <div id="contrasena-retro"></div>
                </div> 
            </div>
                       
            <div class="row form-group">
                <div class="col-5">
                </div>
                <div class="col-2">
                    <input id="agregar"
                           type="button"
                           value="Guardar"
                           onclick="validarFormulario()">
                </div>    
            </div>
       
        </div>
        <br>
        <script>
            
            
            function validarFormulario(){
               
                var cuentaValida = validarCuenta();
                var contraseñaValido = validarContraseña();
                
                if(cuentaValida && contraseñaValido){
                    validarUnicidadCuenta();

                }
            }
            
            //Llamada al ajax para validar que la cuenta del usuario 
            //sea unico
            //Si no es unico, informa del error
            //Caso contrario, envia el formulario
            function validarUnicidadCuenta(){

                var cuentaInput = document.getElementById("cuenta");
                var retroCuenta = document.getElementById("cuenta-retro");
                var strCuenta = cuentaInput.value; 

                var xmlHttp = new XMLHttpRequest();
                xmlHttp.open("GET",
                "<%=request.getContextPath()%>/UsuarioServlet?cuentaDuplicado="+strCuenta, 
                true);

                xmlHttp.onreadystatechange=function(){

                   if (xmlHttp.readyState == 4 && xmlHttp.status == 200) {

                        clearTimeout(xmlHttpTimeout); 

                        var objectoJSON = JSON.parse(this.responseText);
                        var cuentaDuplicado = objectoJSON.cuentaDuplicado;

                        if(cuentaDuplicado == null){

                            cuentaInput.setAttribute("class","form-control is-invalid");
                            retroCuenta.setAttribute("class","invalid-feedback");
                            retroCuenta.textContent = '¡Ocurrió un fallo! No se pudo comprobar la unicidad de la cuenta';

                            //se desbloquea boton agregar
                            document.getElementById("agregar").removeAttribute("disabled");

                        } else if(cuentaDuplicado){

                            cuentaInput.setAttribute("class","form-control is-invalid");
                            retroCuenta.setAttribute("class","invalid-feedback");
                            retroCuenta.textContent = 'Ya existe un usuario con el mismo nombre de cuenta';

                            //se desbloquea boton agregar
                            document.getElementById("agregar").removeAttribute("disabled");

                        }else{
                            //se envia formulario
                            document.getElementById("agregarUsuario").submit();

                        }

                    }
                };

                //bloquear boton agregar
                document.getElementById("agregar").setAttribute("disabled","");
                xmlHttp.send();

                // Timeout para abortar despues 5 segundos
                var xmlHttpTimeout=setTimeout(ajaxTimeout,5000);
                function ajaxTimeout(){
                    xmlHttp.abort();

                    cuentaInput.setAttribute("class","form-control is-invalid");
                    retroCuenta.setAttribute("class","invalid-feedback");
                    retroCuenta.textContent = 'No se pudo validar que la cuenta sea única. \n Intente más tarde';

                    // Se desbloque boton agregar
                    document.getElementById("agregar").removeAttribute("disabled");
                }

            }
               
               
            function validarCuenta(){
                var cuentaInput = document.getElementById("cuenta");
                var retroCuenta = document.getElementById("cuenta-retro");
                var strCuenta = cuentaInput.value; 
                
                if(strCuenta.length < 8 ){ 
                    cuentaInput.setAttribute("class","form-control is-invalid");
                    retroCuenta.setAttribute("class","invalid-feedback");
                    retroCuenta.textContent = 'El nombre de la cuenta debe contener mínimo 8 caracteres';
                    
                    return false;
                }
                
                cuentaInput.setAttribute("class","form-control is-valid");
                retroCuenta.setAttribute("class","valid-feedback");
                retroCuenta.textContent = '';
                    
                return true;
            }
            
            function validarContraseña(){
                var contrasenaInput = document.getElementById("contrasena");
                var retroContrasena = document.getElementById("contrasena-retro");
                var strContrasena = contrasenaInput.value;
                
                if(strContrasena.length < 8){ 
                    contrasenaInput.setAttribute("class","form-control is-invalid");
                    retroContrasena.setAttribute("class","invalid-feedback");
                    retroContrasena.textContent = 'La contraseña debe contener mínimo 8 caracteres';
                    
                    return false;
                }
                
                if(!(new RegExp('[abcdefghijklmnñopqrstuvwxyzáéíóú]').test(strContrasena))){
                    contrasenaInput.setAttribute("class","form-control is-invalid");
                    retroContrasena.setAttribute("class","invalid-feedback");
                    retroContrasena.textContent = 'La contraseña debe tener al menos una letra minúscula';
                    
                    return false;
                }
                
                /*if(!(new RegExp('[ABCDEFGHIJKLMNÑOPQRSTUVWXYZÁÉÍÓÚ]').test(strContrasena))){
                    contrasenaInput.setAttribute("class","form-control is-invalid");
                    retroContrasena.setAttribute("class","invalid-feedback");
                    retroContrasena.textContent = 'La contraseña debe tener al menos una letra mayúscula';
                
                    return false;
                }*/
                if(!(new RegExp('[0123456789]').test(strContrasena))){
                    contrasenaInput.setAttribute("class","form-control is-invalid");
                    retroContrasena.setAttribute("class","invalid-feedback");
                    retroContrasena.textContent = 'La contraseña debe tener al menos un número';
                    
                    return false;
                }
                
                contrasenaInput.setAttribute("class","form-control is-valid");
                retroContrasena.setAttribute("class","valid-feedback");
                retroContrasena.textContent = '';
                    
                return true;
            }
            
            
            //Permite unicamente la insercion de numeros y letras
            function isLetterNumberKey(evt){
                var charCode = (evt.which) ? evt.which : event.keyCode;
                if (charCode > 31 
                        && (charCode < 48 || charCode > 57) 
                        && (charCode < 65 || charCode > 90) 
                        && (charCode < 97 || charCode > 122))
                    return false;
                return true;
            }
            
            //No se inserta espacios
            function isNotSpaceKey(evt){
                var charCode = (evt.which) ? evt.which : event.keyCode;
                if (charCode > 31 && (charCode == 32 ))
                    return false;
                return true;
            }
            
            
            
           
        </script>
    </body>
</html>
    
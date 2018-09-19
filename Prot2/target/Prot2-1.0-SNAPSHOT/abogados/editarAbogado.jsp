<%-- 
    Document   : editarAbogado
    Created on : 11-sep-2018, 16:20:52
    Author     : Acer
--%>

<%@page import="modeloMng.AbogadoJpaController"%>
<%@page import="java.util.List"%>
<%@page import="modelo.Abogado"%> 
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%response.setHeader("Cache-Control", "no-cache");
%>
<!DOCTYPE html>
<html>
    <head>
        <title>Agente - Ta'angapp</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="//WEB-INF/paginaCabecera.jsp" %>
    </head>
    <body>
        <%
            Integer idAbogado = Integer.parseInt(request.getParameter("idAbogado")); 
            Abogado abogado = new AbogadoJpaController().findAbogado(idAbogado); 
            
        %>
        <%@include file="//WEB-INF/menuCabecera.jsp" %>
        <br>
         
        <div class ="container form-control">
        
            <h2 class="text-justify"> Editar Agente</h2>
            <br> 
        
            <form id="editarAbogado" 
                  action="<%=request.getContextPath()%>/AbogadoServlet?editar=true" 
                  method="post" 
                  novalidate>
                <input type="hidden" name="idAbogado" value="<%=idAbogado%>"> 
            </form>
            
            <div class="row form-group">
                <div class="col-3">
                    <label for="idUsuario">Cuenta de Usuario:</label>
                </div>  
                <div class="col-6">
                    <input form="editarAbogado" 
                            readonly
                            class="form-control"
                            value="<%=abogado.getIdUsuario().getCuenta()%>"> 
                </div>
            </div>
                    
            <div class="row form-group">
                <div class="col-3">
                    <label for="ci">C.I.Nº:</label> 
                </div>
                <div class="col-6">
                    <input form="editarAbogado"
                           name="ci"
                           id="ci"
                           class="form-control"
                           type="number" 
                           placeholder="Escriba el número de cédula del agente"
                           required 
                           value="<%=abogado.getCi()%>"
                           onkeypress="return isNumberKey(event)">
                    <div id="ci-retro"></div>
                </div> 
            </div>
                  
            <div class="row form-group">
                <div class="col-3">
                    <label for="nombre">Nombre:</label> 
                </div>
                <div class="col-6">
                    <input form="editarAbogado"
                           name="nombre"
                           id="nombre"
                           class="form-control"
                           type="text" 
                           placeholder="Escriba el nombre del agente"
                           maxlength=""
                           value="<%=abogado.getNombre()%>" 
                           required >
                    <div id="nombre-retro"></div>
                </div> 
            </div>
                  
            <div class="row form-group">
                <div class="col-3">
                    <label for="apellido">Apellido:</label> 
                </div>
                <div class="col-6">
                    <input form="editarAbogado"
                           name="apellido"
                           id="apellido"
                           class="form-control"
                           type="text" 
                           placeholder="Escriba el apellido del agente"
                           maxlength=""
                           value="<%=abogado.getApellido()%>" 
                           required >
                    <div id="apellido-retro"></div>
                </div> 
            </div>
                  
            <div class="row form-group">
                <div class="col-3">
                    <label for="direccion">Dirección:</label> 
                </div>
                <div class="col-6">
                    <input form="editarAbogado"
                           name="direccion"
                           id="direccion"
                           class="form-control"
                           type="text" 
                           placeholder="Escriba la dirección del agente"
                           maxlength=""
                           value="<%=abogado.getDireccion()%>" 
                           required >
                    <div id="direccion-retro"></div>
                </div> 
            </div>
               
            <div class="row form-group">
                <div class="col-3">
                    <label for="telefono">Teléfono:</label> 
                </div>
                <div class="col-6">
                    <input form="editarAbogado"
                           name="telefono"
                           id="telefono"
                           class="form-control"
                           type="text" 
                           placeholder="Escriba el teléfono del agente"
                           maxlength=""
                           value="<%=abogado.getTelefono()%>"
                           required >
                    <div id="telefono-retro"></div>
                </div> 
            </div>
                  
            <div class="row form-group">
                <div class="col-3">
                    <label for="regProf">Registro Profesional:</label> 
                </div>
                <div class="col-6">
                    <input form="editarAbogado"
                           name="regProf"
                           id="regProf"
                           class="form-control"
                           type="text" 
                           placeholder="Escriba el registro profesional agente"
                           maxlength=""
                           value="<%=abogado.getRegistroProfesional()%>" 
                           required >
                    <div id="regProf-retro"></div>
                </div> 
            </div>
            <div class="row form-group">
                <div class="col-5">
                </div>
                <div class="col-2">
                    <input id="editar" 
                           type="button"
                           value="Editar"
                           onclick="validarFormulario()">
                </div>    
            </div> 
        </div>
        <br>
        <script>
            function validarFormulario(){
                var ciValido = validarCi();
                var nombreValido = validarNombre();
                var apellidoValido = validarApellido();
                var direccionValido = validarDireccion();
                var telefonoValido = validarTelefono();
                
                if(ciValido && nombreValido && apellidoValido && direccionValido && telefonoValido){
                    validarUnicidadCi();
                    
                }
            }
            
            //Llamada al ajax para validar que el numero de cedula del abogado
            //sea unico
            //Si no es unico, informa al cliente
            //Caso contrario, envia el formulario
            function validarUnicidadCi(){

                var ciInput = document.getElementById("ci");
                var retroCi = document.getElementById("ci-retro");
                var strCi = ciInput.value;

                var xmlHttp = new XMLHttpRequest();
                xmlHttp.open("GET",
                "<%=request.getContextPath()%>/AbogadoServlet?ciDuplicado="+strCi+"&idAbogado="+<%=idAbogado%>, 
                true);

                xmlHttp.onreadystatechange=function(){

                   if (xmlHttp.readyState == 4 && xmlHttp.status == 200) {

                        clearTimeout(xmlHttpTimeout); 

                        var objectoJSON = JSON.parse(this.responseText);
                        var ciDuplicado = objectoJSON.ciDuplicado;

                        if(ciDuplicado == null){

                            ciInput.setAttribute("class","form-control is-invalid");
                            retroCi.setAttribute("class","invalid-feedback");
                            retroCi.textContent = '¡Ocurrió un fallo! No se pudo comprobar la unicidad de la cédula';

                            //se desbloquea boton editar
                            document.getElementById("editar").removeAttribute("disabled");

                        } else if(ciDuplicado){

                            ciInput.setAttribute("class","form-control is-invalid");
                            retroCi.setAttribute("class","invalid-feedback");
                            retroCi.textContent = 'Ya existe un agente con la misma cédula';

                            //se desbloquea boton editar
                            document.getElementById("editar").removeAttribute("disabled");

                        }else{
                            //se envia formulario
                            document.getElementById("editarAbogado").submit();

                        }

                    }
                };

                //bloquear boton editar
                document.getElementById("editar").setAttribute("disabled","");
                xmlHttp.send();

                // Timeout para abortar despues 5 segundos
                var xmlHttpTimeout=setTimeout(ajaxTimeout,5000);
                function ajaxTimeout(){
                    xmlHttp.abort();

                    ciInput.setAttribute("class","form-control is-invalid");
                    retroCi.setAttribute("class","invalid-feedback");
                    retroCi.textContent = 'No se pudo validar que la cédula sea única. \n Intente más tarde';

                    // Se desbloque boton editar
                    document.getElementById("editar").removeAttribute("disabled");
                }

            }
               
               
            function validarCi(){
                var ciInput = document.getElementById("ci");
                var retroCi = document.getElementById("ci-retro");
                var strCi = ciInput.value;
                
                if(strCi.length == 0){ 
                    ciInput.setAttribute("class","form-control is-invalid");
                    retroCi.setAttribute("class","invalid-feedback");
                    retroCi.textContent = 'El campo esta vacío';
                    
                    return false;
                }
                
                ciInput.setAttribute("class","form-control is-valid");
                retroCi.setAttribute("class","valid-feedback");
                retroCi.textContent = '';
                    
                return true;
            }
            
            function validarNombre(){
                var nombreInput = document.getElementById("nombre");
                var retroNombre = document.getElementById("nombre-retro");
                var strNombre = nombreInput.value.trim();
                
                if(strNombre.length == 0){ 
                    nombreInput.setAttribute("class","form-control is-invalid");
                    retroNombre.setAttribute("class","invalid-feedback");
                    retroNombre.textContent = 'El campo esta vacío';
                    
                    return false;
                }
                
                nombreInput.setAttribute("class","form-control is-valid");
                retroNombre.setAttribute("class","valid-feedback");
                retroNombre.textContent = '';
                    
                return true;
            }
            
            function validarApellido(){
                var apellidoInput = document.getElementById("apellido");
                var retroApellido = document.getElementById("apellido-retro");
                var strApellido = apellidoInput.value.trim();
                
                if(strApellido.length == 0){ 
                    apellidoInput.setAttribute("class","form-control is-invalid");
                    retroApellido.setAttribute("class","invalid-feedback");
                    retroApellido.textContent = 'El campo esta vacío';
                    
                    return false;
                }
                
                apellidoInput.setAttribute("class","form-control is-valid");
                retroApellido.setAttribute("class","valid-feedback");
                retroApellido.textContent = '';
                    
                return true;
            }
            
            function validarDireccion(){
                var direccionInput = document.getElementById("direccion");
                var retroDireccion = document.getElementById("direccion-retro");
                var strDireccion = direccionInput.value.trim();
                
                if(strDireccion.length == 0){ 
                    direccionInput.setAttribute("class","form-control is-invalid");
                    retroDireccion.setAttribute("class","invalid-feedback");
                    retroDireccion.textContent = 'El campo esta vacío';
                    
                    return false;
                }
                
                direccionInput.setAttribute("class","form-control is-valid");
                retroDireccion.setAttribute("class","valid-feedback");
                retroDireccion.textContent = '';
                    
                return true;
            }
            
            function validarDireccion(){
                var direccionInput = document.getElementById("direccion");
                var retroDireccion = document.getElementById("direccion-retro");
                var strDireccion = direccionInput.value.trim();
                
                if(strDireccion.length == 0){ 
                    direccionInput.setAttribute("class","form-control is-invalid");
                    retroDireccion.setAttribute("class","invalid-feedback");
                    retroDireccion.textContent = 'El campo esta vacío';
                    
                    return false;
                }
                
                direccionInput.setAttribute("class","form-control is-valid");
                retroDireccion.setAttribute("class","valid-feedback");
                retroDireccion.textContent = '';
                    
                return true;
            }
            
            function validarTelefono(){
                var telefonoInput = document.getElementById("telefono");
                var retroTelefono = document.getElementById("telefono-retro");
                var strTelefono = telefonoInput.value.trim();
                
                if(strTelefono.length == 0){ 
                    telefonoInput.setAttribute("class","form-control is-invalid");
                    retroTelefono.setAttribute("class","invalid-feedback");
                    retroTelefono.textContent = 'El campo esta vacío';
                    
                    return false;
                }
                
                telefonoInput.setAttribute("class","form-control is-valid");
                retroTelefono.setAttribute("class","valid-feedback");
                retroTelefono.textContent = '';
                    
                return true;
            }
            
            //Permite unicamente la insercion de numeros
            function isNumberKey(evt){
                var charCode = (evt.which) ? evt.which : event.keyCode;
                if (charCode > 31 && (charCode < 48 || charCode > 57))
                    return false;
                return true;
            }
        </script>
    </body>
</html>
    

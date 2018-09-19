<%-- 
    Document   : agregarExpediente
    Created on : 22-ago-2018, 13:27:25
    Author     : Acer
--%>


<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="modeloMng.ClienteJpaController"%>
<%@page import="modeloMng.AbogadoJpaController"%>
<%@page import="modeloMng.EstadoMarcaJpaController"%>
<%@page import="modeloMng.ClaseJpaController"%>
<%@page import="modeloMng.MarcaJpaController"%>
<%@page import="modeloMng.TipoExpedienteJpaController"%> 

<%@page import="java.util.List"%>
<%@page import="modelo.Cliente"%>
<%@page import="modelo.Abogado"%>
<%@page import="modelo.EstadoMarca"%> 
<%@page import="modelo.Clase"%>
<%@page import="modelo.Marca"%>
<%@page import="modelo.TipoExpediente"%> 
<%response.setHeader("Cache-Control", "no-cache");
%>
<!DOCTYPE html>
<html>
    <head>
        <title>Expediente - Ta'angapp</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="//WEB-INF/paginaCabecera.jsp" %>
    </head>
    <body onload="verificarSelectNoVacios()">
        <%
            
            List<Cliente> listaCliente;
            ClienteJpaController clienteControl = new ClienteJpaController();
            listaCliente = clienteControl.findClienteEntities();
            
            List<Abogado> listaAbogado;
            AbogadoJpaController abogadoControl = new AbogadoJpaController();
            listaAbogado= abogadoControl.findAbogadoEntities(); 

            List<EstadoMarca> listaEstadoMarca;
            EstadoMarcaJpaController estadoMarcaControl = new EstadoMarcaJpaController();
            listaEstadoMarca = estadoMarcaControl.findEstadoMarcaEntities(); 

            List<Marca> listaMarca;
            MarcaJpaController marcaControl = new MarcaJpaController();
            listaMarca = marcaControl.findMarcaEntities(); 

            List<Clase> listaClase;
            ClaseJpaController claseControl = new ClaseJpaController();
            listaClase = claseControl.findClaseEntities();  

            List<TipoExpediente> listaTipoExpediente;
            TipoExpedienteJpaController tipoExpedienteControl = new TipoExpedienteJpaController();
            listaTipoExpediente = tipoExpedienteControl.findTipoExpedienteEntities();  

            
        %>
        <%@include file="//WEB-INF/menuCabecera.jsp" %>
        <br>

        <div class ="container form-control">
            <h2 class="text-justify">Agregar Expediente</h2> 
            <br>
          
            <form id="agregarExpediente" 
                  action="<%=request.getContextPath()%>/ExpedienteServlet?agregar=true" 
                  method="post" 
                  novalidate>
            </form>
               
            <div class = "row form-group">
                <div class="col-3">
                    <label for="nroExpediente">Número del Expediente:</label>
                </div>
                <div class="col-6">
                    <input form="agregarExpediente"
                           name="nroExpediente"
                           id="nroExpediente"
                           class="form-control"
                           type="text"
                           placeholder="Escriba el número de expediente"
                           required
                           onkeypress="return isNumberKey(event)">
                    <div id="nroExpediente-retro"></div> 
                </div>
            </div>
            <div class="row form-group">
                <div class="col-3">
                    <label for="nroClase">Clase:</label>
                </div>
                <div class="col-6">
                    <input form="agregarExpediente"
                           name="nroClase"
                           id="nroClase"
                           type="text" 
                           class="form-control"
                           placeholder="Escriba el número de clase"
                           required
                           onkeypress="return isNumberKey(event)"
                           maxlength="2"
                           >
                    <div id="nroClase-retro"></div>
                </div>
            </div>
            
            <div class="row form-group">
                <div class="col-3">
                    <label for="fechaSolicitud">Fecha de Solicitud:</label>
                </div>
                <div class="col-6">
                    <input form="agregarExpediente"
                           name="fechaSolicitud"
                           id="fechaSolicitud"
                           type="date" 
                           class="form-control"
                           value="<%=new SimpleDateFormat("yyyy-MM-dd").format(new Date())%>"
                           required>
                    <div id="fechaSolicitud-retro"></div>
                </div>               
            </div>
               
            <div class="row form-group">
                <div class="col-3">
                    <label for="idEstadoMarca">Estado:</label>
                </div>  
                <div class="col-6">
                    <select form="agregarExpediente" 
                            name="idEstadoMarca" 
                            id="idEstadoMarca" 
                            class="form-control">
                            <%for (int j = 0; j < listaEstadoMarca.size(); j++) {%> 
                                <option value="<%=listaEstadoMarca.get(j).getIdEstado()%>"> 
                                    <%=listaEstadoMarca.get(j).getDescripcion()%>  
                                </option>
                            <%}%>
                    </select>
                </div>
            </div>
            
            <div class="row form-group">
                <div class="col-3">
                    <label for="fechaEstado">Fecha de Status:</label>
                </div>
                <div class="col-6">
                    <input form="agregarExpediente"
                           name="fechaEstado"
                           id="fechaEstado"
                           type="date" 
                           class="form-control"
                           value="<%=new SimpleDateFormat("yyyy-MM-dd").format(new Date())%>"
                           required>
                    <div id="fechaEstado-retro"></div>
                </div>
            </div>
                    
            <div class="row form-group">
                <div class="col-3">
                    <label for="idAbogado">Agente:</label>
                </div>
                <div class="col-6">
                    <select form="agregarExpediente"
                            name="idAbogado" 
                            id="idAbogado"
                            class="form-control">
                            <%for (int j = 0; j < listaAbogado.size(); j++) {%> 
                                <option value="<%=listaAbogado.get(j).getIdAbogado()%>">  
                                    <%=listaAbogado.get(j).getNombreApellido()%>  
                                </option>
                            <%}%>
                    </select>
                    <div id="idAbogado-retro"></div>
                </div>
            </div>
                  
            <div class="row form-group">
                <div class="col-3">
                    <label for="idCliente">Titular:</label>
                </div>
                <div class="col-6">                                                
                    <select form="agregarExpediente"
                            name="idCliente" 
                            id="idCliente"
                            class="form-control">
                            <%for (int j = 0; j < listaCliente.size(); j++) {%> 
                                <option value="<%=listaCliente.get(j).getIdCliente()%>"> 
                                    <%=listaCliente.get(j).getNombreCliente()%> 
                                </option>
                            <%}%>
                    </select>
                    <div id="idCliente-retro"></div>
                </div>
            </div> 
                    
            <div class="row form-group">
                <div class="col-3">
                    <label for="idMarca">Denominación de la marca:</label>
                </div>
                <div class="col-6">
                    <select form="agregarExpediente"
                            name="idMarca" 
                            id="idMarca" 
                            class="form-control">
                                <%for (int j = 0; j < listaMarca.size(); j++) {%> 
                                    <option value="<%=listaMarca.get(j).getIdMarca()%>"> 
                                        <%=listaMarca.get(j).getDenominacion()%>  
                                    </option>
                                <%}%>
                    </select>
                    <div id="idMarca-retro"></div>
                </div>
            </div>
                    
            <div class="row form-group">
                <div class="col-3">
                    <label for="idTipoExpediente">Tipo de trámite:</label>
                </div>
                <div class="col-6">  
                    <select form="agregarExpediente"
                            name="idTipoExpediente" 
                            id="idTipoExpediente"
                            class="form-control">
                            <%for (int j = 0; j < listaTipoExpediente.size(); j++) {%> 
                                <option value="<%=listaTipoExpediente.get(j).getIdTipoExpediente()%>"> 
                                    <%=listaTipoExpediente.get(j).getDescripcion()%>  
                                </option>
                            <%}%>
                    </select>
                </div>
            </div>
                    
            <div class="row form-group">
                <div class="col-3">
                    <label for="producto">Producto:</label>
                </div>
                <div class="col-6">
                    <textarea   form="agregarExpediente"
                                name="producto"
                                id="producto"
                                class="form-control"
                                rows="6"
                                maxlength="250"
                                placeholder="Escriba una breve descripción del producto"
                                required
                                ></textarea>
                    <div id="producto-retro"></div>
                </div>
            </div>
                    
            <div class="row form-group">
                <div class="col-3">
                    <label for="obs">Observación:</label>
                </div>
                <div class="col-6">
                    <textarea   form="agregarExpediente"
                                name="obs"
                                id="obs"
                                class="form-control"
                                rows="6"
                                maxlength="250"
                                placeholder="Escriba una breve observacion"
                                ></textarea>
                    <div id="obs-retro"></div>
                </div>
            </div>
                        
            <div class="row form-group">
                <div class="col-5">
                </div>
                <div class="col-2">
                    <input id="agregar"
                           type="button"
                           value="Agregar"
                           onclick="validarFormulario()">
                </div>    
            </div>  
         
        </div>
        <br>
        <script>
            function validarFormulario(){
                var nroExpedienteValido = validarNroExpediente();
                var nroClase = validarNroClase();
                var productoValido = validarProducto();
                var fechaSolicitudValido = validarFechaSolicitud();
                var fechaEstadoValido = validarFechaEstado(fechaSolicitudValido);
                
                if(nroExpedienteValido && 
                    nroClase && 
                    productoValido && 
                    fechaEstadoValido && 
                    fechaSolicitudValido){
                    
                    validarUnicidadNroExpediente();
                    
                }
            }
                
            //Llamada al ajax para validar que el numero de expediente
            //sea unico
            //Si no es unico, informa al cliente
            //Caso contrario, envia el formulario
            function validarUnicidadNroExpediente(){

                var nroExpedienteInput = document.getElementById("nroExpediente");
                var retroNroExpediente = document.getElementById("nroExpediente-retro");
                var strNroExpediente = nroExpedienteInput.value;

                var xmlHttp = new XMLHttpRequest();
                xmlHttp.open("GET",
                "<%=request.getContextPath()%>/ExpedienteServlet?nroExpedienteDuplicado="+strNroExpediente, 
                true);

                xmlHttp.onreadystatechange=function(){

                   if (xmlHttp.readyState == 4 && xmlHttp.status == 200) {

                        clearTimeout(xmlHttpTimeout); 

                        var objectoJSON = JSON.parse(this.responseText);
                        var nroExpedienteDuplicado = objectoJSON.nroExpedienteDuplicado;

                        if(nroExpedienteDuplicado == null){

                            nroExpedienteInput.setAttribute("class","form-control is-invalid");
                            retroNroExpediente.setAttribute("class","invalid-feedback");
                            retroNroExpediente.textContent = '¡Ocurrió un fallo! No se pudo comprobar la unicidad del expediente';

                            //se desbloquea boton agregar
                            document.getElementById("agregar").removeAttribute("disabled");

                        } else if(nroExpedienteDuplicado){

                            nroExpedienteInput.setAttribute("class","form-control is-invalid");
                            retroNroExpediente.setAttribute("class","invalid-feedback");
                            retroNroExpediente.textContent = 'Ya existe un expediente con el mismo número';

                            //se desbloquea boton agregar
                            document.getElementById("agregar").removeAttribute("disabled");

                        }else{
                            //se envia formulario
                            document.getElementById("agregarExpediente").submit();

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

                    nroExpedienteInput.setAttribute("class","form-control is-invalid");
                    retroNroExpediente.setAttribute("class","invalid-feedback");
                    retroNroExpediente.textContent = 'No se pudo validar que el número deexpediente sea único. \n Intente más tarde';

                    // Se desbloque boton agregar
                    document.getElementById("agregar").removeAttribute("disabled");
                }

            }
               
            
            
            function validarNroExpediente(){
                var nroExpedienteInput = document.getElementById("nroExpediente");
                var retroNroExpediente = document.getElementById("nroExpediente-retro");
                var strNroExpediente = nroExpedienteInput.value;
                
                if(strNroExpediente.length == 0){ 
                    nroExpedienteInput.setAttribute("class","form-control is-invalid");
                    retroNroExpediente.setAttribute("class","invalid-feedback");
                    retroNroExpediente.textContent = 'El campo esta vacío';
                    
                    return false;
                }
                
                nroExpedienteInput.setAttribute("class","form-control is-valid");
                retroNroExpediente.setAttribute("class","valid-feedback");
                retroNroExpediente.textContent = '';
                    
                return true;
                
            }
            
            function validarNroClase(){
                var nroClaseInput = document.getElementById("nroClase");
                var retroNroClase = document.getElementById("nroClase-retro");
                var strNroClase = nroClaseInput.value;
                
                if(strNroClase.length == 0){ 
                    nroClaseInput.setAttribute("class","form-control is-invalid");
                    retroNroClase.setAttribute("class","invalid-feedback");
                    retroNroClase.textContent = 'El campo esta vacío';
                    
                    return false;
                }
                
                if(Number(strNroClase) <= 0  || Number(strNroClase) > 45){ 
                    nroClaseInput.setAttribute("class","form-control is-invalid");
                    retroNroClase.setAttribute("class","invalid-feedback");
                    retroNroClase.textContent = 'La clase debe ser un número entre 1 y 45';
                    
                    return false;
                }
                
                nroClaseInput.setAttribute("class","form-control is-valid");
                retroNroClase.setAttribute("class","valid-feedback");
                retroNroClase.textContent = '';
                    
                return true;
                
            }
            
            function validarProducto(){
                var productoInput = document.getElementById("producto");
                var retroProducto = document.getElementById("producto-retro");
                var strProducto = productoInput.value.trim();
                
                if(strProducto.length == 0){ 
                    productoInput.setAttribute("class","form-control is-invalid");
                    retroProducto.setAttribute("class","invalid-feedback");
                    retroProducto.textContent = 'El campo esta vacío';
                    
                    return false;
                }
                
                productoInput.setAttribute("class","form-control is-valid");
                retroProducto.setAttribute("class","valid-feedback");
                retroProducto.textContent = '';
                    
                return true;
                
            }
            
            function validarFechaEstado(fechaSolicitudValido){
                var fechaEstadoInput = document.getElementById("fechaEstado");
                var retroFechaEstado = document.getElementById("fechaEstado-retro");
                var strFechaEstado = fechaEstadoInput.value.trim(); 
                
                if(strFechaEstado.length == 0){ 
                    fechaEstadoInput.setAttribute("class","form-control is-invalid");
                    retroFechaEstado.setAttribute("class","invalid-feedback");
                    retroFechaEstado.textContent = 'El campo esta vacío';
                    
                    return false;
                }
                
                if(fechaSolicitudValido){
                    fechaEstadoInput.setAttribute("min",document.getElementById("fechaSolicitud").value);
                
                    if(fechaEstadoInput.validity.rangeUnderflow){
                        fechaEstadoInput.setAttribute("class","form-control is-invalid");
                        retroFechaEstado.setAttribute("class","invalid-feedback");
                        retroFechaEstado.textContent = 'La fecha del estado debe ser mayor o igual que la fecha de solicitud';

                        return false;
                    }
                }
                
                fechaEstadoInput.setAttribute("class","form-control is-valid");
                retroFechaEstado.setAttribute("class","valid-feedback");
                retroFechaEstado.textContent = '';
                    
                return true;
                
            }
            
            function validarFechaSolicitud(){
                var fechaSolicitudInput = document.getElementById("fechaSolicitud");
                var retroFechaSolicitud = document.getElementById("fechaSolicitud-retro");
                var strFechaSolicitud = fechaSolicitudInput.value.trim(); 
                
                if(strFechaSolicitud.length == 0){ 
                    fechaSolicitudInput.setAttribute("class","form-control is-invalid");
                    retroFechaSolicitud.setAttribute("class","invalid-feedback");
                    retroFechaSolicitud.textContent = 'El campo esta vacío';
                    
                    return false;
                }
   
                fechaSolicitudInput.setAttribute("class","form-control is-valid");
                retroFechaSolicitud.setAttribute("class","valid-feedback");
                retroFechaSolicitud.textContent = '';
                    
                return true;
                
            }
            
            
            //Permite unicamente la insercion de numeros
            function isNumberKey(evt){
                var charCode = (evt.which) ? evt.which : event.keyCode;
                if (charCode > 31 && (charCode < 48 || charCode > 57))
                    return false;
                return true;
            }
            
            //Verificar que los select no esten vacíos
            function verificarSelectNoVacios(){
                var idAbogadoInput = document.getElementById("idAbogado");
                var retroIdAbogado = document.getElementById("idAbogado-retro");
                var strIdAbogado = idAbogadoInput.value.trim();
                
                if(strIdAbogado.length == 0){ 
                    idAbogadoInput.setAttribute("class","form-control is-invalid");
                    retroIdAbogado.setAttribute("class","invalid-feedback");
                    retroIdAbogado.textContent = 'Debe cargar los datos del abogado';
                    
                    document.getElementById("agregar").setAttribute("disabled","");
                }
                
                var idClienteInput = document.getElementById("idCliente");
                var retroIdCliente = document.getElementById("idCliente-retro");
                var strIdCliente = idClienteInput.value.trim();
                
                if(strIdCliente.length == 0){ 
                    idClienteInput.setAttribute("class","form-control is-invalid");
                    retroIdCliente.setAttribute("class","invalid-feedback");
                    retroIdCliente.textContent = 'Debe cargar los datos del titular';
                    
                    document.getElementById("agregar").setAttribute("disabled","");
                }
                
                var idMarcaInput = document.getElementById("idMarca");
                var retroIdMarca = document.getElementById("idMarca-retro");
                var strIdMarca = idMarcaInput.value.trim();
                
                if(strIdMarca.length == 0){ 
                    idMarcaInput.setAttribute("class","form-control is-invalid");
                    retroIdMarca.setAttribute("class","invalid-feedback");
                    retroIdMarca.textContent = 'Debe cargar los datos de la marca';
                    
                    document.getElementById("agregar").setAttribute("disabled","");
                }
                
            }
        </script>
    </body>
</html>

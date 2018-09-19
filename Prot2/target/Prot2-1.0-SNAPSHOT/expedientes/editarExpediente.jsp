<%-- 
    Document   : editarExpediente
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
<%@page import="modeloMng.ExpedienteJpaController"%> 

<%@page import="java.util.List"%>
<%@page import="modelo.Cliente"%>
<%@page import="modelo.Abogado"%>
<%@page import="modelo.EstadoMarca"%> 
<%@page import="modelo.Clase"%>
<%@page import="modelo.Marca"%>
<%@page import="modelo.TipoExpediente"%> 
<%@page import="modelo.Expediente"%> 
<%response.setHeader("Cache-Control", "no-cache");
%>
<!DOCTYPE html>
<html>
    <head>
        <title>Expediente - Ta'angapp</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="//WEB-INF/paginaCabecera.jsp" %>
    </head>
    <body>
        <%
            Integer idExp = Integer.parseInt(request.getParameter("idExpediente"));
            Expediente  expediente = new ExpedienteJpaController().findExpediente(idExp);
            
            List<Cliente> listaCliente;
            listaCliente = new ClienteJpaController().findClienteEntities(); 
            
            List<Abogado> listaAbogado;
            listaAbogado= new AbogadoJpaController().findAbogadoEntities(); 

            List<EstadoMarca> listaEstadoMarca;
            listaEstadoMarca = new EstadoMarcaJpaController().findEstadoMarcaEntities(); 

            List<Marca> listaMarca;
            listaMarca = new MarcaJpaController().findMarcaEntities(); 

            List<Clase> listaClase;
            listaClase = new ClaseJpaController().findClaseEntities();   

            List<TipoExpediente> listaTipoExpediente;
            listaTipoExpediente = new TipoExpedienteJpaController().findTipoExpedienteEntities();  

        %>
        <%@include file="//WEB-INF/menuCabecera.jsp" %>
        <br>

        <div class ="container form-control">
            <h2 class="text-justify">Editar Expediente</h2> 
            <br>
            
            <form id="editarExpediente" 
                  action="<%=request.getContextPath()%>/ExpedienteServlet?editar=true" 
                  method="post" 
                  novalidate>
                <input type="hidden" name="idExpediente" value="<%=idExp%>">
            </form>
               
            <div class = "row form-group">
                <div class="col-3">
                    <label for="nroExpediente">Número del Expediente:</label>
                </div>
                <div class="col-6">
                    <input form="editarExpediente"
                           name="nroExpediente"
                           id="nroExpediente"
                           class="form-control"
                           type="text"
                           placeholder="Escriba el número de expediente"
                           required
                           value="<%=expediente.getNroExpediente()%>" 
                           onkeypress="return isNumberKey(event)">
                    <div id="nroExpediente-retro"></div> 
                </div>
            </div>
            <div class="row form-group">
                <div class="col-3">
                    <label for="nroClase">Clase:</label>
                </div>
                <div class="col-6">
                    <input form="editarExpediente"
                           name="nroClase"
                           id="nroClase"
                           type="text" 
                           class="form-control"
                           placeholder="Escriba el número de clase"
                           required
                           onkeypress="return isNumberKey(event)"
                           maxlength="2"
                           value="<%=expediente.getNroClase().getNroClase()%>" 
                           >
                    <div id="nroClase-retro"></div>
                </div>
            </div>
            
            <div class="row form-group">
                <div class="col-3">
                    <label for="fechaSolicitud">Fecha de Solicitud:</label>
                </div>
                <div class="col-6">
                    <input form="editarExpediente"
                           name="fechaSolicitud"
                           id="fechaSolicitud"
                           type="date" 
                           class="form-control"
                           value="<%=new SimpleDateFormat("yyyy-MM-dd").format(expediente.getFechaSolicitud())%>"
                           required>
                    <div id="fechaSolicitud-retro"></div>
                </div>               
            </div>
               
            <div class="row form-group">
                <div class="col-3">
                    <label for="idEstadoMarca">Estado:</label>
                </div>  
                <div class="col-6">
                    <select form="editarExpediente" 
                            name="idEstadoMarca" 
                            id="idEstadoMarca" 
                            class="form-control">
                            <%for (int j = 0; j < listaEstadoMarca.size(); j++) {
                                if(listaEstadoMarca.get(j).getIdEstado() == expediente.getIdEstado().getIdEstado()){%> 
                                    <option selected value="<%=listaEstadoMarca.get(j).getIdEstado()%>"> 
                                        <%=listaEstadoMarca.get(j).getDescripcion()%>  
                                    </option>
                                <%}else{%>
                                    <option value="<%=listaEstadoMarca.get(j).getIdEstado()%>"> 
                                        <%=listaEstadoMarca.get(j).getDescripcion()%>  
                                    </option>
                                <%}%>
                            <%}%>
                    </select>
                </div>
            </div>
            
            <div class="row form-group">
                <div class="col-3">
                    <label for="fechaEstado">Fecha de Status:</label>
                </div>
                <div class="col-6">
                    <input form="editarExpediente"
                           name="fechaEstado"
                           id="fechaEstado"
                           type="date" 
                           class="form-control"
                           value="<%=new SimpleDateFormat("yyyy-MM-dd").format(expediente.getFechaEstado())%>"
                           required>
                    <div id="fechaEstado-retro"></div>
                </div>
            </div>
                    
            <div class="row form-group">
                <div class="col-3">
                    <label for="idAbogado">Agente:</label>
                </div>
                <div class="col-6">
                    <select form="editarExpediente"
                            name="idAbogado" 
                            id="idAbogado"
                            class="form-control">
                            <%for (int j = 0; j < listaAbogado.size(); j++) { 
                                if(listaAbogado.get(j).getIdAbogado() == expediente.getIdAbogado().getIdAbogado()){
                            %> 
                                    <option selected value="<%=listaAbogado.get(j).getIdAbogado()%>">  
                                        <%=listaAbogado.get(j).getNombreApellido()%>  
                                    </option>
                                <%}else{%>
                                    <option value="<%=listaAbogado.get(j).getIdAbogado()%>">  
                                        <%=listaAbogado.get(j).getNombreApellido()%>  
                                    </option>
                                <%}%>
                            <%}%>
                    </select>
                </div>
            </div>
                  
            <div class="row form-group">
                <div class="col-3">
                    <label for="idCliente">Titular:</label>
                </div>
                <div class="col-6">                                                
                    <select form="editarExpediente"
                            name="idCliente" 
                            id="idCliente"
                            class="form-control">
                            <%for (int j = 0; j < listaCliente.size(); j++) {
                                if(listaCliente.get(j).getIdCliente() == expediente.getIdCliente().getIdCliente()){
                            %> 
                                    <option selected value="<%=listaCliente.get(j).getIdCliente()%>"> 
                                        <%=listaCliente.get(j).getNombreCliente()%> 
                                    </option>
                                <%}else{%>
                                    <option value="<%=listaCliente.get(j).getIdCliente()%>"> 
                                        <%=listaCliente.get(j).getNombreCliente()%> 
                                    </option>
                                <%}%>
                            <%}%>
                    </select>
                </div>
            </div> 
                    
            <div class="row form-group">
                <div class="col-3">
                    <label for="idMarca">Denominación de la marca:</label>
                </div>
                <div class="col-6">
                    <select form="editarExpediente"
                            name="idMarca" 
                            id="idMarca" 
                            class="form-control">
                                <%for (int j = 0; j < listaMarca.size(); j++) {
                                    if(listaMarca.get(j).getIdMarca() == expediente.getIdMarca().getIdMarca()){
                                %> 
                                        <option selected value="<%=listaMarca.get(j).getIdMarca()%>"> 
                                            <%=listaMarca.get(j).getDenominacion()%>  
                                        </option>
                                    <%}else{%>
                                        <option value="<%=listaMarca.get(j).getIdMarca()%>"> 
                                            <%=listaMarca.get(j).getDenominacion()%>  
                                        </option>
                                    <%}%>
                                <%}%>
                    </select>
                </div>
            </div>
                    
            <div class="row form-group">
                <div class="col-3">
                    <label for="idTipoExpediente">Tipo de trámite:</label>
                </div>
                <div class="col-6">  
                    <select form="editarExpediente"
                            name="idTipoExpediente" 
                            id="idTipoExpediente"
                            class="form-control">
                            <%for (int j = 0; j < listaTipoExpediente.size(); j++) {
                                if(listaTipoExpediente.get(j).getIdTipoExpediente() == expediente.getTipoExpediente().getIdTipoExpediente()){
                            %> 
                                <option selected value="<%=listaTipoExpediente.get(j).getIdTipoExpediente()%>"> 
                                        <%=listaTipoExpediente.get(j).getDescripcion()%>  
                                    </option>
                                <%}else{%>
                                    <option value="<%=listaTipoExpediente.get(j).getIdTipoExpediente()%>"> 
                                        <%=listaTipoExpediente.get(j).getDescripcion()%>  
                                    </option>
                                <%}%>
                            <%}%>
                    </select>
                </div>
            </div>
                    
            <div class="row form-group">
                <div class="col-3">
                    <label for="producto">Producto:</label>
                </div>
                <div class="col-6">
                    <textarea   form="editarExpediente"
                                name="producto"
                                id="producto"
                                class="form-control"
                                rows="6"
                                maxlength="250"
                                placeholder="Escriba una breve descripción del producto"
                                required
                                ><%=expediente.getProducto()%></textarea> 
                    <div id="producto-retro"></div>
                </div>
            </div>
                    
            <div class="row form-group">
                <div class="col-3">
                    <label for="obs">Observación:</label>
                </div>
                <div class="col-6">
                    <textarea   form="editarExpediente"
                                name="obs"
                                id="obs"
                                class="form-control"
                                rows="6"
                                maxlength="250"
                                placeholder="Escriba una breve observacion"
                                ><%=expediente.getObservacion()%></textarea> 
                    <div id="obs-retro"></div>
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
                "<%=request.getContextPath()%>/ExpedienteServlet?nroExpedienteDuplicado="+strNroExpediente+"&idExp="+<%=idExp%>, 
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

                            //se desbloquea boton editar
                            document.getElementById("editar").removeAttribute("disabled");

                        } else if(nroExpedienteDuplicado){

                            nroExpedienteInput.setAttribute("class","form-control is-invalid");
                            retroNroExpediente.setAttribute("class","invalid-feedback");
                            retroNroExpediente.textContent = 'Ya existe un expediente con el mismo número';

                            //se desbloquea boton editar
                            document.getElementById("editar").removeAttribute("disabled");

                        }else{
                            //se envia formulario
                            document.getElementById("editarExpediente").submit();

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

                    nroExpedienteInput.setAttribute("class","form-control is-invalid");
                    retroNroExpediente.setAttribute("class","invalid-feedback");
                    retroNroExpediente.textContent = 'No se pudo validar que el número de expediente sea único. \n Intente más tarde';

                    // Se desbloque boton editar
                    document.getElementById("editar").removeAttribute("disabled");
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
        </script>
    </body>
</html>

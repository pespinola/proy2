<%-- 
    Document   : agregarDocumento
    Created on : 27-ago-2018, 16:19:36
    Author     : Acer
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="modelo.TipoDocumento"%>
<%@page import="java.util.List"%>
<%@page import="modeloMng.TipoDocumentoJpaController"%>

<%@page import="modelo.Expediente"%>
<%@page import="modeloMng.ExpedienteJpaController"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Documento - Ta'angapp</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="//WEB-INF/paginaCabecera.jsp" %>
    </head>
    <body onload="cambiarIdTipo()">
        <%
            Integer idExp = (Integer) (request.getSession().getAttribute("idExpediente"));

            ExpedienteJpaController expControl = new ExpedienteJpaController();
            Expediente expediente = expControl.findExpediente(idExp);

            TipoDocumentoJpaController tipoDocControl = new TipoDocumentoJpaController();
            List<TipoDocumento> listaTipoDoc = tipoDocControl.findTipoDocumentoEntities();

        %>

        <%@include file="//WEB-INF/menuCabecera.jsp" %>
        <br>
        <div class="container">
           <%@include file="//WEB-INF/menuExpediente.jsp" %>     
        </div>
        <div class="container form-control">
            <h2 class="text-justify">Agregar Documento</h2> 
            <br>
            
            <form id="agregarDocumento" 
                  action="<%=request.getContextPath()%>/DocumentoServlet?agregar=true"
                  method="post"
                  enctype="multipart/form-data"
                  novalidate>
            </form>

            <div class="row form-group">
                <div class="col-3">
                    <label for="">Número de Expediente:</label>
                </div>
                <div class="col-6">
                    <input form="agregarDocumento"
                           name=""
                           class="form-control"
                           type="text"
                           readonly
                           value="<%=expediente.getNroExpediente()%>">
                </div>
            </div>
                
            <div class="row form-group">
                <div class="col-3">
                    <label for="fechaDoc">Fecha actual: </label>
                </div>
                <div class="col-6">
                    <input form="agregarDocumento"
                           name="fechaDoc"
                           id=""
                           class="form-control"
                           type="date"
                           value="<%=new SimpleDateFormat("yyyy-MM-dd").format(new Date())%>"
                           required
                           readonly> 
                    <div id=""></div>
                </div>
            </div>

            <div class="row form-group">    
                <div class="col-3">
                    <label for="nombreDoc">Nombre del documento:</label></div>
                <div class="col-6">
                    <input form="agregarDocumento"
                           name="nombreDoc"
                           id="nombreDoc"
                           class="form-control"
                           type="text"
                           placeholder="Escriba el nombre para el documento"
                           required
                           maxlength=""
                           pattern='^[^<>\/:?*"|]+$'>
                    <div id="nombreDoc-retro"></div>
                </div>
            </div>

            

            <div class="row form-group">
                <div class="col-3">
                    <label for="idTipoDoc">Tipo de Documento:</label>
                </div>
                <div class="col-6">
                    <div class="row">
                        <div class="col-3">
                            <input id="idDoc" class="form-control" disabled >
                        </div>
                        <div class="col">
                            <select form="agregarDocumento"
                                    name="idTipoDoc" 
                                    class="form-control"
                                    id="idTipoDoc"
                                    onchange="cambiarIdTipo()">

                                <%for (int j = 0; j < listaTipoDoc.size(); j++) {%>

                                <option value="<%=listaTipoDoc.get(j).getIdTipoDocumento()%>" >
                                    <%=listaTipoDoc.get(j).getDescripcion()%>
                                </option>

                                <%}%>
                            </select>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row form-group">
                <div class="col-3">
                    <label for="descripcion">Descripción: </label>
                </div>
                <div class="col-6">
                    <textarea   form="agregarDocumento"
                                name="descripcionDoc"
                                id="descripcionDoc"
                                class="form-control"
                                rows="6"
                                maxlength="250"
                                placeholder="Escriba una breve descripción"
                                required
                                ></textarea>
                    <div id="descripcionDoc-retro"></div>
                </div>
            </div>

            <div class="row form-group">
                <div class="col-3">
                    <label for="archivoDoc">Documento: </label>
                </div>
                <div class="col-6">
                    <input form="agregarDocumento"
                           name="archivoDoc"
                           id="archivoDoc"
                           class="form-control"
                           type="file"
                           required
                           accept=".pdf">
                    <div id="archivoDoc-retro"></div>
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
            function cambiarIdTipo() {
                document.getElementById("idDoc").value = document.getElementById("idTipoDoc").value;
            }
            
            function validarFormulario(){
                
                var nombreValido= validarNombre();
                var descripcionValido = validarDescripcion();
                var archivoValido = validarArchivo();
                
                
                if(nombreValido && descripcionValido && archivoValido){
                    
                    validarNombreNoDuplicado();
                }
                
                
            }
 
            //Llamada al ajax para validar que nombre
            //del documento no este duplicado por expediente
            //Si esta duplicado informa al cliente
            //Caso contrario, envia el formulario
            function validarNombreNoDuplicado(){
                
                var nombreDocInput = document.getElementById("nombreDoc");
                var retroNombreDoc = document.getElementById("nombreDoc-retro");
                var strNombre = nombreDocInput.value.trim();
                
                var xmlHttp = new XMLHttpRequest();
                xmlHttp.open("GET",
                "<%=request.getContextPath()%>/DocumentoServlet?existeNombre="+strNombre, 
                true);

                xmlHttp.onreadystatechange=function(){
                    
                   if (xmlHttp.readyState == 4 && xmlHttp.status == 200) {
                       
                        clearTimeout(xmlHttpTimeout); 
                        
                        var objectoJSON = JSON.parse(this.responseText);
                        var existeNombre = objectoJSON.existeNombre;
                        
                        if(existeNombre == null){
                            
                            nombreDocInput.setAttribute("class","form-control is-invalid");
                            retroNombreDoc.setAttribute("class","invalid-feedback");
                            retroNombreDoc.textContent = '¡Ocurrió un fallo! No se pudo comprobar la unicidad del nombre';
                            
                            //se desbloquea boton agregar
                            document.getElementById("agregar").removeAttribute("disabled");
                            
                        } else if(existeNombre){
                            
                            nombreDocInput.setAttribute("class","form-control is-invalid");
                            retroNombreDoc.setAttribute("class","invalid-feedback");
                            retroNombreDoc.textContent = 'Ya existe un documento con el mismo nombre';
                            
                            //se desbloquea boton agregar
                            document.getElementById("agregar").removeAttribute("disabled");
                            
                        }else{
                            //se envia formulario
                            document.getElementById("agregarDocumento").submit();
                            
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
                 
                    nombreDocInput.setAttribute("class","form-control is-invalid");
                    retroNombreDoc.setAttribute("class","invalid-feedback");
                    retroNombreDoc.textContent = 'No se pudo validar que el nombre no sea duplicado. \n Intente más tarde';
                    
                    // Se desbloque boton agregar
                    document.getElementById("agregar").removeAttribute("disabled");
                }
                
            }
            //Se valida que:
            //El nombre no este vacio
            //Que no sea una secuencia de espacios en blanco
            //Que no tenga caracteres especiales
            function validarNombre(){
                
                var nombreDocInput = document.getElementById("nombreDoc");
                var retroNombreDoc = document.getElementById("nombreDoc-retro");
                var strNombre = nombreDocInput.value;
                var patt = new RegExp('[<>\/:?*"|]');
                
                //Si contiene caracteres invalidos, lo informa
                
                if(strNombre.trim().length == 0){ 
                    nombreDocInput.setAttribute("class","form-control is-invalid");
                    retroNombreDoc.setAttribute("class","invalid-feedback");
                    retroNombreDoc.textContent = 'El campo esta vacío';
                    
                    return false;
                }
                
                if(patt.test(strNombre)){

                    nombreDocInput.setAttribute("class","form-control is-invalid");
                    retroNombreDoc.setAttribute("class","invalid-feedback");
                    retroNombreDoc.textContent = 'No debe contener los caracteres <>\/:?*"|';
                    return false;
                }
                
                nombreDocInput.setAttribute("class","form-control is-valid");
                retroNombreDoc.setAttribute("class","valid-feedback");
                retroNombreDoc.textContent = '';
                
                return true;
            }
            
            
            //Se valida que la descripcion no este vacía
            function validarDescripcion(){
                
                var descripcionInput = document.getElementById("descripcionDoc");
                var retroDescripcion = document.getElementById("descripcionDoc-retro");
                var strDescripcion = descripcionInput.value;
                
                
                if(strDescripcion.trim().length == 0){

                    descripcionInput.setAttribute("class","form-control is-invalid");
                    retroDescripcion.setAttribute("class","invalid-feedback");
                    retroDescripcion.textContent = 'Escriba la descripción';
                    
                    return false;
                }
                
                descripcionInput.setAttribute("class","form-control is-valid");
                retroDescripcion.setAttribute("class","valid-feedback");
                retroDescripcion.textContent = '';
                    
                 
                return true;
            }
            
            function validarArchivo(){
                
                var archivoInput = document.getElementById("archivoDoc");
                var retroArchivo = document.getElementById("archivoDoc-retro");
                var strArchivo = archivoInput.value;
                var formato = (strArchivo.substring(strArchivo.lastIndexOf("."))).toLowerCase();
                
                if(strArchivo.length == 0){
                    archivoInput.setAttribute("class","form-control is-invalid");
                    retroArchivo.setAttribute("class","invalid-feedback");
                    retroArchivo.textContent = 'Seleccione un archivo pdf'; 
                    return false; 
                }
                
                if(formato != ".pdf"){
                    archivoInput.setAttribute("class","form-control is-invalid");
                    retroArchivo.setAttribute("class","invalid-feedback");
                    retroArchivo.textContent = 'El formato debe ser pdf'; 
                    
                    return false;
                    
                }
                
                archivoInput.setAttribute("class","form-control is-valid");
                retroArchivo.setAttribute("class","valid-feedback");
                retroArchivo.textContent = ''; 
                    
                
                return true;
            }   
        </script>     
    </body>
</html>



<%--
      <div class="row">
          <div class="col-6">
              <label for="idExpDoc">Número de Expediente:</label>
              <input form="agregarDocumento"
                     name="idExpDoc"
                     class="form-control"
                     type="text"
                     readonly
                     value="<%=expediente.getNroExpediente()%>">

                    <label for="nombreDoc">Nombre del documento:</label>
                    <input form="agregarDocumento"
                           name="nombreDoc"
                           class="form-control"
                           type="text">

                    <label for="fechaDoc">Fecha: </label>
                    <input form="agregarDocumento"
                           name="fechaDoc"
                           class="form-control"
                           type="date"
                           value="<%=new SimpleDateFormat("yyyy-MM-dd").format(new Date())%>"> 


                    <label for="idTipoDoc">Tipo de Documento:</label>
                    <input id="idDoc" class="form-control" disabled >
                    <select form="agregarDocumento"
                            name="idTipoDoc" 
                            class="form-control"
                            id="idTipoDoc"
                            onchange="cambiarIdTipo()">

                        <%for (int j = 0; j < listaTipoDoc.size(); j++) {%>

                        <option value="<%=listaTipoDoc.get(j).getIdTipoDocumento()%>" >
                            <%=listaTipoDoc.get(j).getDescripcion()%>
                        </option>

                        <%}%>
                    </select>

                    <label for="descripcion">Descripción: </label>
                    <input form="agregarDocumento"
                           name="descripcionDoc"
                           class="form-control"
                           type="text">

                </div>
            </div>
            <div class="row">
                <div class="col-5">
                </div>
                <div class="col-2">
                    

                        <input form="agregarDocumento"
                               name="agregar"
                               type="submit"
                               value="Agregar">
                    
                </div>
            </div>
--%>
<%-- 
    Document   : verMarca
    Created on : 20-ago-2018, 22:23:44
    Author     : Acer
--%>


<%@page import="java.lang.String"%>
<%@page import="modeloMng.PaisJpaController"%>
<%@page import="modeloMng.TipoMarcaJpaController"%>
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
        <title>Marca - Ta'angapp</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="//WEB-INF/paginaCabecera.jsp" %>
    </head>

    <body onload="actualizarSigno(); actualizarPais();">
        <%
            
    
            List<TipoMarca> listaTipoMarca;
            TipoMarcaJpaController tipoMarcaControl = new TipoMarcaJpaController();
            listaTipoMarca = tipoMarcaControl.findTipoMarcaEntities();

            List<Pais> listaPais;
            PaisJpaController paisControl = new PaisJpaController();
            listaPais = paisControl.findPaisEntities();

        %>
        <%@include file="//WEB-INF/menuCabecera.jsp" %>
        <br>
         
        <div class ="container form-control">
        
            <h2 class="text-justify"> Agregar Marca</h2>
            <br>
            
            <form id="agregarMarca" 
                  action="<%=request.getContextPath()%>/MarcaServlet?agregar=true" 
                  method="post" 
                  enctype="multipart/form-data" 
                  novalidate
                  onsubmit="return false" 
                  >
            </form>
            
            <div class="row form-group">
                <div class="col-3">
                    <label for="denominacion">Denominación:</label>
                </div>
                <div class="col-6">
                    <input form="agregarMarca"
                           name="denominacion"
                           id="denominacion"
                           class="form-control"
                           type="text" 
                           placeholder="Escriba la denominación para la marca"
                           maxlength=""
                           required >
                    <div id="denominacion-retro"></div>
                </div> 
            </div>
            
            <div class = "row form-group">   
                <div class="col-3">
                    <label for="idTipoMarca">Signo:</label>
                </div>
                <div class="col-6">    
                    <div class="row">
                        <div class="col-3">
                            <input id="codigoTipoMarca" class="form-control" disabled>
                        </div>
                        <div class="col">
                            <select form="agregarMarca"
                                    name="idTipoMarca"
                                    id="idTipoMarca"
                                    class="form-control"
                                    onchange="actualizarSigno()">
                                    <%for (int j = 0; j < listaTipoMarca.size(); j++) {%>
                                        <option value="<%=listaTipoMarca.get(j).getIdTipoMarca()%>">
                                            <%=listaTipoMarca.get(j).getDescripcion()%>
                                        </option>
                                    <%}%>
                            </select>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row form-group">
                <div class="col-3">
                    <label for="idPais">País de origen:</label>
                </div>
                <div class="col-6">
                    <div class="row">
                        <div class="col-3">
                            <input id="codigoPais" class="form-control" disabled>
                        </div>
                        <div class="col">
                            <select form="agregarMarca"
                                    name="idPais" 
                                    id="idPais"
                                    class="form-control"
                                    onchange="actualizarPais()">
                                    <%for (int j = 0; j < listaPais.size(); j++) {%>
                                        <option value="<%=listaPais.get(j).getIdPais()%>">
                                            <%=listaPais.get(j).getPais()%>
                                        </option>
                                    <%}%>
                            </select>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="row form-group">
                <div class="col-3">
                    <label for="imagenMarca"> Imagen:</label>
                </div>
                <div class="col-6">
                    <input form="agregarMarca" 
                           name="imagenMarca"
                           id="imagenMarca"
                           class="form-control"
                           type="file"    
                           accept="image/png, image/jpeg">
                    <div id="imagenMarca-retro"></div>
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
            
            function actualizarSigno(){
                
                var codigoSigno = document.getElementById("codigoTipoMarca")
                        
                codigoSigno.value = document.getElementById("idTipoMarca").value;  
                
                //Si el signo de marca es denominativo entonces no se acepta imagen
                if(codigoSigno.value == <%= new TipoMarca().getNroIdDenominativo()%> ){
                    
                    document.getElementById("imagenMarca").disabled = true;
                    document.getElementById("imagenMarca").value = "";
                }else{
                    
                    document.getElementById("imagenMarca").disabled = false;
                }
                
            }
            
            function actualizarPais(){
                
                document.getElementById("codigoPais").value = document.getElementById("idPais").value;          
            }
            
            function validarFormulario(){
                var denominacionValido = validarDenominacion();
                var imagenValido = validarImagen();
                
                if(denominacionValido && imagenValido){
                    
                    validarDenominacionNoDuplicado();
                }
            }
            
            //Llamada al ajax para validar que denominacion
            //de la marca no este duplicado
            //Si esta duplicado informa al cliente
            //Caso contrario, envia el formulario
            function validarDenominacionNoDuplicado(){
                
                var denominacionInput = document.getElementById("denominacion");
                var retroDenominacion = document.getElementById("denominacion-retro");
                var strDenominacion = denominacionInput.value.trim(); 
                
                var xmlHttp = new XMLHttpRequest();
                xmlHttp.open("GET",
                "<%=request.getContextPath()%>/MarcaServlet?existeDenominacion="+strDenominacion, 
                true);

                xmlHttp.onreadystatechange=function(){
                    
                   if (xmlHttp.readyState == 4 && xmlHttp.status == 200) {
                       
                        clearTimeout(xmlHttpTimeout); 
                        
                        var objectoJSON = JSON.parse(this.responseText);
                        var existeDenominacion = objectoJSON.existeDenominacion;
                        
                        if(existeDenominacion ==  null){
                            
                            denominacionInput.setAttribute("class","form-control is-invalid");
                            retroDenominacion.setAttribute("class","invalid-feedback");
                            retroDenominacion.textContent = '¡Ocurrió un fallo! No se pudo comprobar la unicidad de la denominación';
                                                           
                            //se desbloquea boton agregar
                            document.getElementById("agregar").removeAttribute("disabled");
                            
                        }else if(existeDenominacion){
                            
                            denominacionInput.setAttribute("class","form-control is-invalid");
                            retroDenominacion.setAttribute("class","invalid-feedback");
                            retroDenominacion.textContent = 'Ya existe una marca con la misma denominación';
                            
                            //se desbloquea boton agregar
                            document.getElementById("agregar").removeAttribute("disabled");
                            
                        }else{
                            //se envia formulario
                            document.getElementById("agregarMarca").submit();
                            
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
                 
                    denominacionInput.setAttribute("class","form-control is-invalid");
                    retroDenominacion.setAttribute("class","invalid-feedback");
                    retroDenominacion.textContent = 'No se pudo conectar con el servidor. Intente más tarde';
                    
                    // Se desbloque boton agregar
                    document.getElementById("agregar").removeAttribute("disabled");
                }
                
            }
            
            //Se asegura que la denominacion no este vacia
            function validarDenominacion(){
                
                var denominacionInput = document.getElementById("denominacion");
                var retroDenominacion = document.getElementById("denominacion-retro");
                var strDenominacion = denominacionInput.value;
               
                
                //Si contiene caracteres invalidos, lo informa
                
                if(strDenominacion.trim().length == 0){ 
                    denominacionInput.setAttribute("class","form-control is-invalid");
                    retroDenominacion.setAttribute("class","invalid-feedback");
                    retroDenominacion.textContent = 'El campo esta vacío';
                    
                    return false;
                }
                
                denominacionInput.setAttribute("class","form-control is-valid");
                retroDenominacion.setAttribute("class","valid-feedback");
                retroDenominacion.textContent = '';
                
                return true;
            }
            
            function validarImagen(){
                
                var imagenInput = document.getElementById("imagenMarca");
                var retroImagen = document.getElementById("imagenMarca-retro");
                var strImagen = imagenInput.value;
                var formato = (strImagen.substring(strImagen.lastIndexOf("."))).toLowerCase();
                
                var estaDeshabilitado = document.getElementById("imagenMarca").disabled;
                
                if(!estaDeshabilitado){
                    if(strImagen.length == 0 ){
                        imagenInput.setAttribute("class","form-control is-invalid");
                        retroImagen.setAttribute("class","invalid-feedback");
                        retroImagen.textContent = 'Seleccione una imagen con algunos de los siguientes formatos: jpg,jpeg,png'; 
                        return false; 
                    }

                    if(formato != ".jpg" && formato != ".jpeg" && formato != ".png"){
                        imagenInput.setAttribute("class","form-control is-invalid");
                        retroImagen.setAttribute("class","invalid-feedback");
                        retroImagen.textContent = 'El formato de la imagen debe ser alguno de los siguientes: jpg,jpeg,png'; 

                        return false;

                    }
                }
                
                imagenInput.setAttribute("class","form-control is-valid");
                retroImagen.setAttribute("class","valid-feedback");
                retroImagen.textContent = ''; 
                
                return true;
            }
            
        </script>
    </body>
</html>

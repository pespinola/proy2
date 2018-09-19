<%-- 
    Document   : agregarExpediente
    Created on : 05-sep-2018, 19:37:40
    Author     : Acer
--%>

<%@page import="java.util.Calendar"%>
<%@page import="modelo.Evento"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.List"%>
<%@page import="modeloMng.EventoJpaController"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Evento - Ta'angapp</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="//WEB-INF/paginaCabecera.jsp" %>
    </head>
    <body>
        <%

            Integer idEvento = Integer.parseInt(request.getParameter("idEvento"));
            Evento evento = new EventoJpaController().findEvento(idEvento);
            
            Calendar c = Calendar.getInstance();
            c.setTime(new Date());
            c.add(Calendar.DATE, 1);
            Date fechaMinima = c.getTime();
            
            
        %>
        <%@include file="//WEB-INF/menuCabecera.jsp" %>
        <br>
        
        <div class="container">
           <%@include file="//WEB-INF/menuExpediente.jsp" %>     
        </div>
        
        <div class="container form-control">
            <h2 class="text-justify">Editar Evento</h2> 
            <br>
            
            <form id="editarEvento" 
                  action="<%=request.getContextPath()%>/EventoServlet?editar=true"
                  method="post"
                  novalidate>
                <input type="hidden" name="idEvento" value="<%=idEvento%>"> 
            </form>
                  
            <div class="row form-group">
                <div class="col-3">
                    <label for="">Número de Expediente:</label>
                </div>
                <div class="col-6">
                    <input form="editarEvento"
                           name=""
                           class="form-control"
                           type="text"
                           readonly
                           value="<%=evento.getIdExpediente().getNroExpediente()%>"> 
                </div>
            </div>
            
            <div class="row form-group">    
                <div class="col-3">
                    <label for="nombre">Nombre del evento:</label>
                </div>
                <div class="col-6">
                    <input form="editarEvento"
                           name="nombre"
                           id="nombre"
                           class="form-control"
                           type="text"
                           maxlength=""
                           placeholder="Escriba el nombre para el evento"
                           required
                           value="<%=evento.getNombre()%>" 
                           >
                    <div id="nombre-retro"></div>
                </div>
            </div>
                
            <div class="row form-group">    
                <div class="col-3">
                    <label for="fecha">Programar para:</label>
                </div>
                <div class="col-6">
                    <input form="editarEvento"
                           name="fecha"
                           id="fecha"
                           class="form-control"
                           type="date"
                           min="<%=new SimpleDateFormat("yyyy-MM-dd").format(fechaMinima)%>"  
                           required
                           >
                    <div id="fecha-retro"></div>
                </div>
            </div>
            
            <div class="row form-group">    
                <div class="col-3">
                    <label for="descripcion">Detalles del evento:</label>
                </div>
                <div class="col-6">
                    <textarea form="editarEvento"
                            name="descripcion"
                            id="descripcion"
                            class="form-control"
                            rows="6"
                            maxlength="250"
                            placeholder="Escriba una breve descripción"
                            required><%=evento.getDescripcion()%></textarea>
                            
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
                           onclick="validarFormulario()">
                </div>    
            </div>  
        </div>
        <br>
        <script>
            function validarFormulario(){
                var validoNombre = validarNombre();
                var validoDescripcion = validarDescripcion();
                var validoFecha = validarFecha();
                
                //Si todo es correcto, se envía el formulario
                if(validoNombre && validoDescripcion && validoFecha){
                    
                    document.getElementById("editarEvento").submit();
                }
            }
            
            
            function validarNombre(){
                
                var nombreInput = document.getElementById("nombre");
                var retroNombre = document.getElementById("nombre-retro");
                var strNombre = nombreInput.value.trim();
                
                if(strNombre.length === 0){ 
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
            
            function validarDescripcion(){
                
                var descripcionInput = document.getElementById("descripcion");
                var retroDescripcion = document.getElementById("descripcion-retro");
                var strDescripcion = descripcionInput.value.trim();
                
                if(strDescripcion.length === 0){ 
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
            
            function validarFecha(){
                
                var fechaInput = document.getElementById("fecha");
                var retroFecha = document.getElementById("fecha-retro");
                var strFecha = fechaInput.value.trim(); 
                
                if(strFecha.length === 0){ 
                    fechaInput.setAttribute("class","form-control is-invalid");
                    retroFecha.setAttribute("class","invalid-feedback");
                    retroFecha.textContent = 'El campo esta vacío';
                    
                    return false;
                } 
                
                if(fechaInput.validity.rangeUnderflow){ 
                    fechaInput.setAttribute("class","form-control is-invalid");
                    retroFecha.setAttribute("class","invalid-feedback");
                    retroFecha.textContent = 'La fecha debe ser después de hoy (<%=new SimpleDateFormat("dd/MM/yyyy").format(new Date())%>)';
                    
                    return false;
                }
                
                fechaInput.setAttribute("class","form-control is-valid");
                retroFecha.setAttribute("class","valid-feedback");
                retroFecha.textContent = ''; 
                
                return true;
            }
        </script>
    </body>
</html>

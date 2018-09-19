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

<%@page import="modelo.Documento"%>
<%@page import="modeloMng.DocumentoJpaController"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Documento - Ta'angapp</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="//WEB-INF/paginaCabecera.jsp" %>
    </head>
    <body>
        <%
            //Integer idExp = (Integer) (request.getSession().getAttribute("idExpediente"));

            Integer idDoc = Integer.parseInt(request.getParameter("idDocumento"));
            Documento documento = new DocumentoJpaController().findDocumento(idDoc);

            TipoDocumentoJpaController tipoDocControl = new TipoDocumentoJpaController();
            List<TipoDocumento> listaTipoDoc = tipoDocControl.findTipoDocumentoEntities();
            
            String direccionDoc = request.getContextPath(); 
            direccionDoc+= "/obtenerDocumento/"+
                            documento.getNombreDocumento()+
                            ".pdf?idDocumento="+idDoc;

        %>

        <%@include file="//WEB-INF/menuCabecera.jsp" %>
        <br>
        
        <div class="container">
            <%@include file="//WEB-INF/menuExpediente.jsp" %>       
        </div>
        
        <div class="container form-control">
            <h2 class="text-justify">Documento</h2> 
            <br>
            
            <div class="row form-group">
                <div class="col-3">
                    <label>Número de Expediente:</label>
                </div>
                <div class="col-6 form-control">
                    <%=documento.getIdExpediente().getNroExpediente()%>
                </div>
            </div>

            <div class="row form-group">    
                <div class="col-3">
                    <label>Nombre del documento:</label></div>
                <div class="col-6 form-control">
                    <%=documento.getNombreDocumento()%> 
                </div>
            </div>

            <div class="row form-group">
                <div class="col-3">
                    <label>Fecha: </label>
                </div>
                <div class="col-6 form-control">
                    <%=documento.getStringFecha()%>  
                </div>
            </div>

            <div class="row form-group">
                <div class="col-3">
                    <label>Tipo de Documento:</label>
                </div>
                <div class="col-6">
                    <div class=" row">
                        <div class="col-2 form-control">
                            <%=documento.getIdTipoDocumento().getIdTipoDocumento()%>
                        </div>
                        
                        <div class="col-1"></div>
                        
                        <div class="col form-control">
                            <%=documento.getIdTipoDocumento().getDescripcion()%> 
                        </div>
                    </div>
                </div>
            </div>

            <div class="row form-group">
                <div class="col-3">
                    <label>Descripción: </label>
                </div>
                <div class="col-6 form-control">
                    <%=documento.getDescripcion()%>
                </div>
            </div>

            <div class="row form-group">
                <div class="col-3">
                    <label>Documento: </label>
                </div>
                <div class="col-6">
                    <button class="btn btn-primary"
                            onclick="window.open('<%=direccionDoc%>')"> 
                            Leer
                    </button>
                </div>
            </div>
        </div>
        <br>
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
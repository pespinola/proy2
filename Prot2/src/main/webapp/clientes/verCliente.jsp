<%-- 
    Document   : verCliente
    Created on : 13-sep-2018, 1:43:06
    Author     : Acer
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="modelo.Cliente"%>   
<%@page import="modeloMng.ClienteJpaController"%> 
<%response.setHeader("Cache-Control", "no-cache");
%>
<!DOCTYPE html>
<html>
    <head>
        <title>Titular - Ta'angapp</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="//WEB-INF/paginaCabecera.jsp" %>
    </head>

    <body>
        <%
            
            Integer idCliente = Integer.parseInt(request.getParameter("idCliente"));
            Cliente cliente = new ClienteJpaController().findCliente(idCliente);
     
        %>
        <%@include file="//WEB-INF/menuCabecera.jsp" %>
        <br>
        
        <div class ="container form-control">
            
            <h2 class="text-justify">Titular</h2>
            <br>
            <%if(cliente.getTipoCliente().equals("F")){%>
                <div class="row form-group">
                    <div class="col-3">
                        <label>C.I.Nº:</label>
                    </div>
                    <div class="col-6 form-control">
                        <%=cliente.getCi()%>  
                    </div> 
                </div>
                
                <div class="row form-group">
                    <div class="col-3">
                        <label>Nombre:</label>
                    </div>
                    <div class="col-6 form-control">
                        <%=cliente.getNombre()%> 
                    </div> 
                </div>
                
                <div class="row form-group">
                    <div class="col-3">
                        <label>Apellido:</label>
                    </div>
                    <div class="col-6 form-control">
                        <%=cliente.getApellido()%> 
                    </div> 
                </div>
            <%}else{%>
                <div class="row form-group">
                    <div class="col-3">
                        <label>Razón Social:</label>
                    </div>
                    <div class="col-6 form-control">
                        <%=cliente.getRazonSocial()%>   
                    </div> 
                </div>
            <%}%> 
            
            <%if(cliente.getRuc() != null){%>
                <div class="row form-group">
                        <div class="col-3">
                            <label>R.U.C.</label>
                        </div>
                        <div class="col-6 form-control">
                            <%=cliente.getRuc()%> 
                        </div> 
                </div>
            <%}%>      
            <div class="row form-group">
                <div class="col-3">
                    <label>Dirección:</label>
                </div>
                <div class="col-6 form-control">
                    <%=cliente.getDireccion()%>
                </div> 
            </div>
                
            <div class="row form-group">
                <div class="col-3">
                    <label>Teléfono:</label>
                </div>
                <div class="col-6 form-control">
                    <%=cliente.getTelefono()%>
                </div> 
            </div>
                
            <div class="row form-group">
                <div class="col-3">
                    <label>Cuenta de Usuario:</label>
                </div>
                <div class="col-6 form-control">
                    <%=cliente.getIdUsuario().getCuenta()%> 
                </div> 
            </div>
        </div>
        <br>
    </body>
</html>
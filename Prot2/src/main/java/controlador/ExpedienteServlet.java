/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controlador;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelo.*;
import modeloMng.*;


/**
 *
 * @author Acer
 */
@WebServlet(name = "ExpedienteServlet", urlPatterns = {"/ExpedienteServlet"})
public class ExpedienteServlet extends HttpServlet {


   
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        /*Retorna un json a la consulta del ajax
          Si el número de expediente esta duplicado, retorna true
          caso contrario, false
        */
        request.setCharacterEncoding("UTF-8");
        
        ExpedienteJpaController expControl = new ExpedienteJpaController();
        Boolean numeroExpedienteDuplicado = null;
        Integer idExpediente= null;
        
        BigDecimal nroExpediente = new BigDecimal(request.getParameter("nroExpedienteDuplicado"));
        
        
        //Cuando la operacion es editar 
        
        if(request.getParameter("idExp") != null){
            idExpediente = Integer.parseInt(request.getParameter("idExp"));
        }
        
        //La operacion es agregar
        if(nroExpediente != null){
           
            numeroExpedienteDuplicado = expControl.existeNumeroExpDuplicado(nroExpediente,idExpediente); 
            
            try (PrintWriter out = response.getWriter()) {
                out.println("{\"nroExpedienteDuplicado\":"+numeroExpedienteDuplicado+"}");
            }
        }
        /**/
    }

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        ExpedienteJpaController expControl = new ExpedienteJpaController();
        TipoExpedienteJpaController tipoExpControl = new TipoExpedienteJpaController();
        ClienteJpaController clienteControl = new ClienteJpaController();
        AbogadoJpaController abogadoControl = new AbogadoJpaController();
        EstadoMarcaJpaController estadoMarcaControl = new EstadoMarcaJpaController();
        MarcaJpaController marcaControl = new MarcaJpaController();
        ClaseJpaController claseControl = new ClaseJpaController();
        
        SimpleDateFormat formatoFecha = new SimpleDateFormat("yyyy-MM-dd");
        
        //agregar
        if(request.getParameter("agregar") != null){
            try{
                Integer nroExp = Integer.parseInt(request.getParameter("nroExpediente"));
                Integer idCliente = Integer.parseInt(request.getParameter("idCliente"));
                Integer idAbogado = Integer.parseInt(request.getParameter("idAbogado"));
                Integer idEstadoMarca = Integer.parseInt(request.getParameter("idEstadoMarca"));
                Integer idMarca = Integer.parseInt(request.getParameter("idMarca"));
                Integer nroClase = Integer.parseInt(request.getParameter("nroClase"));
                Integer idTipoExpediente = Integer.parseInt(request.getParameter("idTipoExpediente"));
                String producto = request.getParameter("producto");
                String observacion = request.getParameter("obs");
                Date fechaEstado = formatoFecha.parse(request.getParameter("fechaEstado")); 
                Date fechaSolicitud = formatoFecha.parse(request.getParameter("fechaSolicitud"));
    
            
            
                Cliente cliente = clienteControl.findCliente(idCliente);
                Abogado abogado = abogadoControl.findAbogado(idAbogado);
                EstadoMarca estadoMarca = estadoMarcaControl.findEstadoMarca(idEstadoMarca);
                Marca marca = marcaControl.findMarca(idMarca);
                Clase clase = claseControl.findClase(new BigDecimal(nroClase));
                TipoExpediente tipoExpediente = tipoExpControl.findTipoExpediente(idTipoExpediente);
            
                
                Expediente exp = new Expediente();
                exp.setNroExpediente(BigInteger.valueOf(nroExp));
                exp.setIdCliente(cliente);
                exp.setIdAbogado(abogado);
                exp.setIdEstado(estadoMarca);
                exp.setIdMarca(marca);
                exp.setNroClase(clase);
                exp.setTipoExpediente(tipoExpediente);
                exp.setProducto(producto);
                exp.setObservacion(observacion);
                exp.setFechaEstado(fechaEstado);
                exp.setFechaSolicitud(fechaSolicitud);
            
                expControl.create(exp);
            }catch(Exception e){
                
                request.getSession().setAttribute("mensajeErrorABM", "No se pudo agregar el expediente");
            
            }finally{
                response.sendRedirect("expedientes.jsp");
            }
        }
        
         //Eliminar
        if(request.getParameter("eliminar") != null){
            try {
                Integer idExp = Integer.parseInt(request.getParameter("idExpediente"));
                expControl.destroy(idExp);
                
            } catch (Exception e) {
                System.out.println(e);
                request.getSession().setAttribute("mensajeErrorABM", "No se pudo eliminar el expediente");
            }finally{
           
                response.sendRedirect("expedientes.jsp");
            }
        }
        
        //Editar
        if(request.getParameter("editar") != null){
            try{
                Integer idExpediente = Integer.parseInt(request.getParameter("idExpediente"));
                Expediente exp = expControl.findExpediente(idExpediente);
                        
                Integer nroExp = Integer.parseInt(request.getParameter("nroExpediente"));
                Integer idCliente = Integer.parseInt(request.getParameter("idCliente"));
                Integer idAbogado = Integer.parseInt(request.getParameter("idAbogado"));
                Integer idEstadoMarca = Integer.parseInt(request.getParameter("idEstadoMarca"));
                Integer idMarca = Integer.parseInt(request.getParameter("idMarca"));
                Integer nroClase = Integer.parseInt(request.getParameter("nroClase"));
                Integer idTipoExpediente = Integer.parseInt(request.getParameter("idTipoExpediente"));
                String producto = request.getParameter("producto");
                String observacion = request.getParameter("obs");
                Date fechaEstado = formatoFecha.parse(request.getParameter("fechaEstado")); 
                Date fechaSolicitud = formatoFecha.parse(request.getParameter("fechaSolicitud"));
    
            
            
                Cliente cliente = clienteControl.findCliente(idCliente);
                Abogado abogado = abogadoControl.findAbogado(idAbogado);
                EstadoMarca estadoMarca = estadoMarcaControl.findEstadoMarca(idEstadoMarca);
                Marca marca = marcaControl.findMarca(idMarca);
                Clase clase = claseControl.findClase(new BigDecimal(nroClase));
                TipoExpediente tipoExpediente = tipoExpControl.findTipoExpediente(idTipoExpediente);
                
                
                exp.setNroExpediente(BigInteger.valueOf(nroExp));
                exp.setIdCliente(cliente);
                exp.setIdAbogado(abogado);
                exp.setIdEstado(estadoMarca);
                exp.setIdMarca(marca);
                exp.setNroClase(clase);
                exp.setTipoExpediente(tipoExpediente);
                exp.setProducto(producto);
                exp.setObservacion(observacion);
                exp.setFechaEstado(fechaEstado);
                exp.setFechaSolicitud(fechaSolicitud);
            
                expControl.edit(exp);
            }catch(Exception e){
                
                request.getSession().setAttribute("mensajeErrorABM", "No se pudo editar el expediente");
            
            }finally{
                response.sendRedirect("expedientes.jsp");
            }
        }
        
    }

    
    @Override
    public String getServletInfo() {
        return "ABM Expediente";
    }

}

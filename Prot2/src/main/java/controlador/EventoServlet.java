/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controlador;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
//import java.io.PrintWriter;
//import java.util.logging.Level;
//import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelo.Evento;
import modeloMng.EventoJpaController;
import modeloMng.ExpedienteJpaController;
//import modeloMng.exceptions.NonexistentEntityException;

/**
 *
 * @author Acer
 */
@WebServlet(name = "EventoServlet", urlPatterns = {"/EventoServlet"})
public class EventoServlet extends HttpServlet {
   
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       
    }

   
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        EventoJpaController eventoControl = new EventoJpaController();
        ExpedienteJpaController expControl= new ExpedienteJpaController();
        
        SimpleDateFormat formatoFecha = new SimpleDateFormat("yyyy-MM-dd");
        
        //Eliminar
        if(request.getParameter("eliminar")!= null){
            
            Integer idEvento = Integer.parseInt(request.getParameter("idEvento")); 
            
            try {
                eventoControl.destroy(idEvento);
            } catch (Exception e) {
                request.getSession().setAttribute("mensajeErrorABM", "No se pudo eliminar el evento");
            }finally{
                response.sendRedirect("eventos.jsp");
            }
             
        }
        //Agregar
        if(request.getParameter("agregar") != null){
            
            try{
                
                Integer idExp = (Integer)(request.getSession().getAttribute("idExpediente"));
                String nombre = request.getParameter("nombre");
                String descripcion = request.getParameter("descripcion");
                Date fecha = formatoFecha.parse(request.getParameter("fecha"));
                
                Evento evento = new Evento();
                
                evento.setIdExpediente(expControl.findExpediente(idExp));
                evento.setNombre(nombre);
                evento.setDescripcion(descripcion);
                evento.setFecha(fecha);
                
                eventoControl.create(evento);
                
            } 
            catch (Exception e) {
                
                request.getSession().setAttribute("mensajeErrorABM", "No se pudo agregar el evento");
            
            }finally{
                
                response.sendRedirect("eventos.jsp");
            }
        }
        
        if(request.getParameter("editar") != null){
            
            try{
                Integer idEvento = Integer.parseInt(request.getParameter("idEvento")); 
                
                String nombre = request.getParameter("nombre");
                String descripcion = request.getParameter("descripcion");
                Date fecha = formatoFecha.parse(request.getParameter("fecha"));
                
                Evento evento = eventoControl.findEvento(idEvento);
                
                evento.setNombre(nombre);
                evento.setDescripcion(descripcion);
                evento.setFecha(fecha);
                
                eventoControl.edit(evento); 
                
            } 
            catch (Exception e) {
                
                request.getSession().setAttribute("mensajeErrorABM", "No se pudo editar el evento");
            
            }finally{
                
                response.sendRedirect("eventos.jsp");
            }
        }
    }
    
   

    
    @Override
    public String getServletInfo() {
        return "ABM Evento";
    }

}

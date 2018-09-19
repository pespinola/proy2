/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controlador;

import java.io.IOException;
//import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelo.Rol;
import modeloMng.RolJpaController;

/**
 *
 * @author Acer
 */
@WebServlet(name = "RolServlet", urlPatterns = {"/RolServlet"})
public class RolServlet extends HttpServlet {

    

    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        
        
        
    }

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        
        
        RolJpaController rolControl = new RolJpaController();
        
        //Eliminar
        if(request.getParameter("eliminar")!= null){
            
            Integer idRol = Integer.parseInt(request.getParameter("idRol")); 
            
            try {
                rolControl.destroy(idRol);
                
            } catch (Exception e) {
                
                request.getSession().setAttribute("mensajeErrorABM", "No se pudo eliminar el rol");
            
            }finally{
                
                response.sendRedirect("roles.jsp");
            }
             
        }
        
        //Guardar
        if(request.getParameter("agregar")!= null){
            try{
                
                String rol = request.getParameter("rol");
                String descripcion = request.getParameter("descripcion");
                
                
                Rol roles = new Rol();
                roles.setRol(rol);
                roles.setDescripcion(descripcion);
                roles.setEstado("NO ASOCIADO");
                rolControl.create(roles);
                
            }catch (Exception e) {
                
                request.getSession().setAttribute("mensajeErrorABM", "No se pudo agregar el rol");
            
            }finally{
                
                response.sendRedirect("roles.jsp");
            }
        }
        
        //Editar
        if(request.getParameter("editar")!= null){
            try{
                Integer idRol = Integer.parseInt(request.getParameter("idRol"));
                
                Rol rol = rolControl.findRol(idRol);
                
                String descripcion = request.getParameter("descripcion");
                
                rol.setDescripcion(descripcion);
                
                
                rolControl.edit(rol);
                
            }catch (Exception e) {
                
                request.getSession().setAttribute("mensajeErrorABM", "No se pudo editar el rol");
            
            }finally{
                
                response.sendRedirect("roles.jsp");
            }
        }
        
        
    }

    
    @Override
    public String getServletInfo() {
        return "ABM Rol";
    }

}

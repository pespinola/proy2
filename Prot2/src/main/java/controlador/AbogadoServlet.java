/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controlador;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelo.Abogado;
import modelo.Usuario;
import modeloMng.AbogadoJpaController;
import modeloMng.UsuarioJpaController;

/**
 *
 * @author Acer
 */
@WebServlet(name = "AbogadoServlet", urlPatterns = {"/AbogadoServlet"})
public class AbogadoServlet extends HttpServlet {

    
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        AbogadoJpaController abogadoControl = new AbogadoJpaController();
        Boolean ciDuplicado = null;
        Integer idAbogado = null;
        
        String ci = request.getParameter("ciDuplicado");
         
        
        //Cuando la operacion es editar 
        
        if(request.getParameter("idAbogado") != null){
            idAbogado = Integer.parseInt(request.getParameter("idAbogado"));
        }
        
        //La operacion es agregar
        if(ci != null){
            Long nroCi = Long.parseLong(ci);
            
            ciDuplicado = abogadoControl.existeCiDuplicado(nroCi,idAbogado); 
            
            try (PrintWriter out = response.getWriter()) {
                out.println("{\"ciDuplicado\":"+ciDuplicado+"}");
            }
        }
    }

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        AbogadoJpaController abogadoControl = new AbogadoJpaController();
        UsuarioJpaController usuarioControl = new UsuarioJpaController();
        
        if(request.getParameter("agregar") != null){
            try{
                Integer idUsuario = Integer.parseInt(request.getParameter("idUsuario"));
                Long ci = Long.parseLong(request.getParameter("ci"));
                String nombre = request.getParameter("nombre");
                String apellido = request.getParameter("apellido");
                String direccion = request.getParameter("direccion");
                String telefono = request.getParameter("telefono");
                String regProf = request.getParameter("regProf");
                
                Abogado abogado = new Abogado();
                Usuario usuario = usuarioControl.findUsuario(idUsuario);
                
                abogado.setIdUsuario(usuario);
                abogado.setCi(ci);
                abogado.setNombre(nombre);
                abogado.setApellido(apellido);
                abogado.setDireccion(direccion);
                abogado.setTelefono(telefono);
                abogado.setRegistroProfesional(regProf);
                
                abogadoControl.create(abogado);
                
            }catch(Exception e){
                request.getSession().setAttribute("mensajeErrorABM", "No se pudo agregar el agente");
            }finally{
                response.sendRedirect("abogados.jsp");
            }
        }
        
        if(request.getParameter("editar") != null){
            try{
                Integer idAbogado = Integer.parseInt(request.getParameter("idAbogado"));
                Long ci = Long.parseLong(request.getParameter("ci"));
                String nombre = request.getParameter("nombre");
                String apellido = request.getParameter("apellido");
                String direccion = request.getParameter("direccion");
                String telefono = request.getParameter("telefono");
                String regProf = request.getParameter("regProf");
                
                Abogado abogado = abogadoControl.findAbogado(idAbogado);
                
                abogado.setCi(ci);
                abogado.setNombre(nombre);
                abogado.setApellido(apellido);
                abogado.setDireccion(direccion);
                abogado.setTelefono(telefono);
                abogado.setRegistroProfesional(regProf);
                
                abogadoControl.edit(abogado);
                
            }catch(Exception e){
                request.getSession().setAttribute("mensajeErrorABM", "No se pudo editar el agente");
            }finally{
                response.sendRedirect("abogados.jsp");
            }
        }
        
        if(request.getParameter("eliminar") != null){
            try {
                Integer idAbogado = Integer.parseInt(request.getParameter("idAbogado"));
                abogadoControl.destroy(idAbogado);
                
            } catch (Exception e) {
                
                request.getSession().setAttribute("mensajeErrorABM", "No se pudo eliminar el agente");
            }finally{
           
                response.sendRedirect("abogados.jsp");
            }
        }
    }

    
    @Override
    public String getServletInfo() {
        return "ABM Abogado";
    }

}

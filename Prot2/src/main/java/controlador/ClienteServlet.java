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
import modelo.Cliente;
import modelo.Usuario;
import modeloMng.ClienteJpaController;
import modeloMng.UsuarioJpaController;

/**
 *
 * @author Acer
 */
@WebServlet(name = "ClienteServlet", urlPatterns = {"/ClienteServlet"})
public class ClienteServlet extends HttpServlet {

    
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        ClienteJpaController clienteControl = new ClienteJpaController();
        Integer idCliente = null;
        String ci = request.getParameter("ciDuplicado");
        String ruc = request.getParameter("rucDuplicado");
        
        
        //Cuando la operacion es editar 
        
        if(request.getParameter("idCliente") != null){
            idCliente = Integer.parseInt(request.getParameter("idCliente"));
        }
        
        //Operacion agregar
        if(ci != null){
            Integer ciNumero = Integer.parseInt(ci);
            Boolean ciDuplicado = clienteControl.existeCiDuplicado(ciNumero,idCliente); 
            
            try (PrintWriter out = response.getWriter()) {
                out.println("{\"ciDuplicado\":"+ciDuplicado+"}");
            }
        }
        if(ruc != null){
            Boolean rucDuplicado = clienteControl.existeRucDuplicado(ruc,idCliente); 
            
            try (PrintWriter out = response.getWriter()) {
                out.println("{\"rucDuplicado\":"+rucDuplicado+"}");
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        ClienteJpaController clienteControl = new ClienteJpaController();
        UsuarioJpaController usuarioControl = new UsuarioJpaController();
        if(request.getParameter("agregar") != null){
            try{
                String idUsuario = request.getParameter("idUsuario");
                String idTipoCliente = request.getParameter("tipoCliente");
                String ci = request.getParameter("ci");
                String nombre = request.getParameter("nombre");
                String apellido = request.getParameter("apellido");
                String ruc = request.getParameter("ruc");
                String razonSocial = request.getParameter("razonSocial");
                String direccion = request.getParameter("direccion");
                String telefono = request.getParameter("telefono");

                 
                Usuario usuario = usuarioControl.findUsuario(Integer.parseInt(idUsuario));

                Cliente cliente = new Cliente();
                
                cliente.setIdUsuario(usuario);
                cliente.setTipoCliente(idTipoCliente); 
                cliente.setNombre(nombre);
                cliente.setApellido(apellido);
                
                cliente.setRazonSocial(razonSocial);
                cliente.setDireccion(direccion);
                cliente.setTelefono(telefono);
                cliente.setEstado("ACTIVO");
                if(ci != null){
                    cliente.setCi(Integer.parseInt(ci));
                    
                }
                if(ruc.length() > 0){
                    cliente.setRuc(ruc);
                }
                clienteControl.create(cliente);
           
            
            }catch(Exception e){ 
                System.out.println(e);
                request.getSession().setAttribute("mensajeErrorABM", "No se pudo agregar el titular");
            }finally{
                response.sendRedirect("clientes.jsp");
            }
        
        }
        
        //Eliminar
        if(request.getParameter("eliminar") != null){
            try {
                Integer idCliente = Integer.parseInt(request.getParameter("idCliente"));
                clienteControl.destroy(idCliente);
                
            } catch (Exception e) {
                
                request.getSession().setAttribute("mensajeErrorABM", "No se pudo eliminar el titular");
            }finally{
           
                response.sendRedirect("clientes.jsp");
            }
        }
        
        //Editar
        if(request.getParameter("editar") != null){
            try{
                Integer idCliente = Integer.parseInt(request.getParameter("idCliente"));
                Cliente cliente = clienteControl.findCliente(idCliente);
                        
                
                String idTipoCliente = request.getParameter("tipoCliente");
                String ci = request.getParameter("ci");
                String nombre = request.getParameter("nombre");
                String apellido = request.getParameter("apellido");
                String ruc = request.getParameter("ruc");
                String razonSocial = request.getParameter("razonSocial");
                String direccion = request.getParameter("direccion");
                String telefono = request.getParameter("telefono");

                 
                
                cliente.setTipoCliente(idTipoCliente); 
                cliente.setNombre(nombre);
                cliente.setApellido(apellido);
                cliente.setRazonSocial(razonSocial);
                cliente.setDireccion(direccion);
                cliente.setTelefono(telefono);
                cliente.setEstado("ACTIVO");
                if(ci != null){
                    cliente.setCi(Integer.parseInt(ci));
                    
                }
                if(ruc.length() > 0){
                    cliente.setRuc(ruc);
                }
                clienteControl.edit(cliente);
           
            
            }catch(Exception e){ 
                System.out.println(e);
                request.getSession().setAttribute("mensajeErrorABM", "No se pudo editar el titular");
            }finally{
                response.sendRedirect("clientes.jsp");
            }
        
        }
    }

    
    @Override
    public String getServletInfo() {
        return "ABM Cliente";
    }

}

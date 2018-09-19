/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controlador;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelo.Permiso;
import modelo.Rol;
import modelo.Ventana;
import modeloMng.PermisoJpaController;
import modeloMng.RolJpaController;
import modeloMng.VentanaJpaController;

/**
 *
 * @author Acer
 */
@WebServlet(name = "PermisoServlet", urlPatterns = {"/PermisoServlet"})
public class PermisoServlet extends HttpServlet {

    

    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
    }

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PermisoJpaController permisoControl = new PermisoJpaController();
        try{
            if(request.getParameter("editar") != null){
                String[] nuevoPermiso = request.getParameterValues("permiso");


                Integer idRol = Integer.parseInt(request.getParameter("idRol"));
                
                //Eliminamos los roles
                List<Permiso> listPermiso = permisoControl.getPermisoRol(idRol);

                for(int j=0;j<listPermiso.size();j++){
                    permisoControl.destroy(listPermiso.get(j).getIdPermiso()); 
                }

                //Ahora creamos los permisos
                Rol rol = new RolJpaController().findRol(idRol);
                if(nuevoPermiso != null){
                    for(int i=0;i<nuevoPermiso.length;i++){
                        
                        
                        Integer idVentana = Integer.parseInt(nuevoPermiso[i]);
                        Ventana ventana = new VentanaJpaController().findVentana(idVentana);
                       
                        Permiso permiso = new Permiso();
                        
                        permiso.setIdRol(rol);
                        permiso.setIdVentana(ventana);
                        
                        permisoControl.create(permiso);
                        
                    }
                }
            }
        }catch(Exception e){
            System.out.println(e);
        }finally{
            response.sendRedirect("menu.jsp");
        }
        
        
    }

    
    @Override
    public String getServletInfo() {
        return "Editar permiso";
    }

}

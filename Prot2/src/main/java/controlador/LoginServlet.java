/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controlador;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigInteger;
import java.security.MessageDigest;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import modelo.Usuario;
import modeloMng.UsuarioJpaController;

/**
 *
 * @author Acer
 */
@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession sesion = request.getSession();
        Usuario usuario = (Usuario) sesion.getAttribute("usuario");
        if (request.getParameter("desconectar") != null) {
            if (usuario != null) {
                sesion.removeAttribute("usuario");
                response.sendRedirect("login.jsp");
            }
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * Inicia la sesion del usuario
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession sesion = request.getSession();
        Usuario usuario = null;

        if (request.getParameter("conectar") != null) {

            //String contexto = request.getContextPath();
            //Parametros cuenta y contraseña
            String cuenta = request.getParameter("usuario");
            String contraseña = request.getParameter("contrasena");
            try{
                MessageDigest md = MessageDigest.getInstance("MD5");
                byte[] messageDigest = md.digest(contraseña.getBytes()); //EN VEZ DE INPUT PASARLE CONTRASEÑA
                BigInteger number = new BigInteger(1, messageDigest);
                String hashtext = number.toString(16);

                while (hashtext.length() < 32) {
                    hashtext = "0" + hashtext;
                }
                
                // Valida Parametros no vacios
                //if (cuenta != null && contraseña != null) {
                UsuarioJpaController usuMng = new UsuarioJpaController();
                usuario = usuMng.getUsuario(cuenta, hashtext);
                if (usuario == null) {

                    response.sendRedirect("errorLogin.jsp");
                } else {
                    sesion.setAttribute("usuario", usuario);
                    //request.getRequestDispatcher("clienteVista.jsp").forward(request, response);
                    response.sendRedirect("menu.jsp");
                }
            }catch(Exception e ){
            
            }
                
            
            //}else {
            //response.sendRedirect("errorLogin.jsp");
            //}
        }

    }

    @Override
    public String getServletInfo() {
        return "Servlet encargado del inicio de sesion";
    }// </editor-fold>

}

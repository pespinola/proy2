/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controlador;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
//import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
//import java.util.logging.Level;
//import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import modelo.Documento;
import modeloMng.DocumentoJpaController;
import modeloMng.ExpedienteJpaController;
import modeloMng.TipoDocumentoJpaController;
//import modeloMng.exceptions.NonexistentEntityException;

/**
 *
 * @author Acer
 */

@MultipartConfig
@WebServlet(name = "DocumentoServlet", urlPatterns = {"/DocumentoServlet"})
public class DocumentoServlet extends HttpServlet {

    

    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        /*Retorna un json a la consulta del ajax
          Si ya existe un nombre porexpediente, retorna true
          caso contrario, false
        */
        DocumentoJpaController documentoControl = new DocumentoJpaController();
        Boolean existeNombre = null;
        Integer idDoc = null;
        
        String nombre = request.getParameter("existeNombre");
        Object idExp = request.getSession().getAttribute("idExpediente"); 
        
        //Cuando la operacion es editar 
        
        if(request.getParameter("idDocumento") != null){
            idDoc = Integer.parseInt(request.getParameter("idDocumento"));
        }
        
        //La operacion es agregar
        if(nombre != null && idExp != null){
            Integer idExpediente = (Integer)idExp;
            
            existeNombre = documentoControl.existeNombreDocumentoExpediente(idExpediente,nombre,idDoc); 
            
            try (PrintWriter out = response.getWriter()) {
                out.println("{\"existeNombre\":"+existeNombre+"}");
            }
        }
        /**/
    }

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        
        DocumentoJpaController documentoControl = new DocumentoJpaController();
        ExpedienteJpaController expControl= new ExpedienteJpaController(); 
        TipoDocumentoJpaController tipoDocControl = new TipoDocumentoJpaController();
        
        SimpleDateFormat formatoFecha = new SimpleDateFormat("yyyy-MM-dd");
        

        //Agregar
        if (request.getParameter("agregar") != null) {
            
            try{
                
                Integer idExp = (Integer)(request.getSession().getAttribute("idExpediente"));
                String nombre = request.getParameter("nombreDoc");
                Integer idTipoDoc = Integer.parseInt(request.getParameter("idTipoDoc"));
                String descripcion = request.getParameter("descripcionDoc");
                
                
                //Convierte string a fecha
                Date fecha = formatoFecha.parse(request.getParameter("fechaDoc"));
                
                Part filePart = request.getPart("archivoDoc");
                byte[] bFile = null;
                //convierte archivo a binario
                if (filePart.getSize() > 0) {
                    bFile = new byte[((int) filePart.getSize())];
                    FileInputStream fileInputStream = (FileInputStream) filePart.getInputStream();
                    fileInputStream.read(bFile);
                    fileInputStream.close();

                }      
                
                
                Documento documento = new Documento();
                documento.setIdExpediente(expControl.findExpediente(idExp)); 
                documento.setNombreDocumento(nombre);
                documento.setIdTipoDocumento(tipoDocControl.findTipoDocumento(idTipoDoc));
                documento.setDescripcion(descripcion);
                documento.setDocumento(bFile);
                documento.setFecha(fecha);

                
                documentoControl.create(documento);
            }catch (Exception e) {
                
                request.getSession().setAttribute("mensajeErrorABM", "No se pudo agregar el documento");
            
            }finally{
                
                response.sendRedirect("documentos.jsp");
            }    
        }
        
        //Eliminar
        if(request.getParameter("eliminar") != null){
            try {
                Integer idDoc = Integer.parseInt(request.getParameter("idDocumento"));
                documentoControl.destroy(idDoc);
                
            } catch (Exception e) {
                
                request.getSession().setAttribute("mensajeErrorABM", "No se pudo eliminar el documento");
            }finally{
           
                response.sendRedirect("documentos.jsp");
            }
        }
        
        //Editar
        if(request.getParameter("editar") != null){
            try{
                Integer idDoc = Integer.parseInt(request.getParameter("idDocumento")); 

                Documento documento = documentoControl.findDocumento(idDoc);
                String nombre = request.getParameter("nombreDoc");
                Integer idTipoDoc = Integer.parseInt(request.getParameter("idTipoDoc"));
                String descripcion = request.getParameter("descripcionDoc");
                
                Date fecha = formatoFecha.parse(request.getParameter("fechaDoc"));
                
                Part filePart = request.getPart("archivoDoc");
                byte[] bFile = null;
                
                //convierte archivo a binario
                if (filePart.getSize() > 0) {
                    bFile = new byte[((int) filePart.getSize())];
                    FileInputStream fileInputStream = (FileInputStream) filePart.getInputStream();
                    fileInputStream.read(bFile);
                    fileInputStream.close();

                }
                
                documento.setNombreDocumento(nombre);
                documento.setIdTipoDocumento(tipoDocControl.findTipoDocumento(idTipoDoc));
                documento.setDescripcion(descripcion);
                //Si  hay archivo a guardar, cambia fecha
                if(bFile != null){
                    documento.setFecha(fecha);
                    documento.setDocumento(bFile);
                }    
                
                documentoControl.edit(documento); 
            } 
            catch (Exception e) {
                
                request.getSession().setAttribute("mensajeErrorABM", "No se pudo editar el documento");
            
            }finally{
                
                response.sendRedirect("documentos.jsp");
            
            }       
        }
       
    }

 
    @Override
    public String getServletInfo() {
        return "ABM Documento";
    }

}

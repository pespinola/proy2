/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controlador;

//import java.io.ByteArrayOutputStream;
import java.io.FileInputStream;
import java.io.IOException;
//import java.io.InputStream;
import java.io.PrintWriter;
import java.math.BigDecimal;
//import java.nio.file.Paths;
//import java.util.logging.Level;
//import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import modelo.Marca;
import modeloMng.MarcaJpaController;
import modeloMng.PaisJpaController;
import modeloMng.TipoMarcaJpaController;
//import modeloMng.exceptions.IllegalOrphanException;
//import modeloMng.exceptions.NonexistentEntityException;

/**
 *
 * @author Acer
 */
@MultipartConfig//(maxFileSize = 1024*500) // 500 kb permitido
@WebServlet(name = "MarcaServlet", urlPatterns = {"/MarcaServlet"})
public class MarcaServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        /*Retorna un json a la consulta del ajax
          Si ya existe una denominacion de la marca, retorna true
          caso contrario, false
        */
        MarcaJpaController marcaControl = new MarcaJpaController();
        
        Boolean existeDenominacion = null;
        Integer idMarca = null;
        
        String denominacion = request.getParameter("existeDenominacion");
        
        
        //Cuando la operacion es editar 
        
        if(request.getParameter("idMarca") != null){
            idMarca = Integer.parseInt(request.getParameter("idMarca"));
        }
        
        //La operacion es agregar
        if(denominacion != null){
            
            existeDenominacion = marcaControl.existeDenominacion(denominacion,idMarca); 
            
            try (PrintWriter out = response.getWriter()) {
                out.println("{\"existeDenominacion\":"+existeDenominacion+"}");
            }
        }
        
    }

   
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        TipoMarcaJpaController tipoMarcaControl = new TipoMarcaJpaController();
        PaisJpaController paisControl = new PaisJpaController();
        MarcaJpaController marcaControl = new MarcaJpaController();

        //agregar
        if (request.getParameter("agregar") != null) {
            try{
                
                Integer idTipoMarca = Integer.parseInt(request.getParameter("idTipoMarca"));
                BigDecimal idPais = new BigDecimal(Integer.parseInt(request.getParameter("idPais")));
                String denominacion = request.getParameter("denominacion");
                Part filePart = request.getPart("imagenMarca");
                byte[] bFile = null;
                
                if(filePart != null){
                    //String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                    bFile = new byte[((int) filePart.getSize())];
                    FileInputStream fileInputStream = (FileInputStream) filePart.getInputStream();
                    fileInputStream.read(bFile);
                    fileInputStream.close();
                }

                Marca marca = new Marca();
                marca.setIdTipoMarca(tipoMarcaControl.findTipoMarca(idTipoMarca));
                marca.setIdPais(paisControl.findPais(idPais));
                marca.setDenominacion(denominacion);
                marca.setImagenMarca(bFile);

                marcaControl.create(marca);
                
            }catch(Exception e){
                
                request.getSession().setAttribute("mensajeErrorABM", "No se pudo agregar la marca");
           
            }finally{
            
                response.sendRedirect("marcas.jsp");
            }

        }

        //Editar
        if (request.getParameter("editar") != null) {
            try {
                Integer idMarca = Integer.parseInt(request.getParameter("idMarca"));
                Integer idTipoMarca = Integer.parseInt(request.getParameter("idTipoMarca"));
                BigDecimal idPais = new BigDecimal(Integer.parseInt(request.getParameter("idPais")));
                String denominacion = request.getParameter("denominacion");

                Part filePart = request.getPart("imagenMarca");
                byte[] bFile = null;


                Marca marca = marcaControl.findMarca(idMarca);

                marca.setIdTipoMarca(tipoMarcaControl.findTipoMarca(idTipoMarca));
                marca.setIdPais(paisControl.findPais(idPais));
                marca.setDenominacion(denominacion);

                //Si el signo es denominativo, no se enviará
                //el parametro imagenMarca
                if(filePart == null){

                    marca.setImagenMarca(null);

                //Si el signo son figurativo o mixto, entonces se enviará
                //o no el parametro imagenMarca
                //Sí se ha enviado la imagen, entonces se actualizará
                }else if (filePart.getSize() > 0) {

                    bFile = new byte[((int) filePart.getSize())];
                    FileInputStream fileInputStream = (FileInputStream) filePart.getInputStream();
                    fileInputStream.read(bFile);
                    fileInputStream.close();

                    marca.setImagenMarca(bFile);
                }
           
                marcaControl.edit(marca);
                
            }catch(Exception e) {
                
               request.getSession().setAttribute("mensajeErrorABM", "No se pudo editar la marca");
            
            }finally{
                
                response.sendRedirect("marcas.jsp");
            }
           
            
        }
        
        //Eliminar
        if (request.getParameter("eliminar") != null) {
            try {
                Integer idMarca = Integer.parseInt(request.getParameter("idMarca"));
                marcaControl.destroy(idMarca);
                
            }catch(Exception e) {
                
                request.getSession().setAttribute("mensajeErrorABM", "No se pudo eliminar la marca");
            
            }finally{
                
                response.sendRedirect("marcas.jsp");
                
            }
        }

        
    }
    

    @Override
    public String getServletInfo() {
        return "ABM Marca";
    }

}

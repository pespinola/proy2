/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modeloMng;

import java.io.Serializable;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Query;
import javax.persistence.EntityNotFoundException;
import javax.persistence.Persistence;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import modelo.Documento;
import modelo.Expediente;
import modelo.TipoDocumento;
import modeloMng.exceptions.NonexistentEntityException;

/**
 *
 * @author Acer
 */
public class DocumentoJpaController implements Serializable {

    public DocumentoJpaController() {
        this.emf = Persistence.createEntityManagerFactory("com.mycompany_Prot2_war_1.0-SNAPSHOTPU");
    }
    private EntityManagerFactory emf = null;

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public void create(Documento documento) {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Expediente idExpediente = documento.getIdExpediente();
            if (idExpediente != null) {
                idExpediente = em.getReference(idExpediente.getClass(), idExpediente.getIdExpediente());
                documento.setIdExpediente(idExpediente);
            }
            TipoDocumento idTipoDocumento = documento.getIdTipoDocumento();
            if (idTipoDocumento != null) {
                idTipoDocumento = em.getReference(idTipoDocumento.getClass(), idTipoDocumento.getIdTipoDocumento());
                documento.setIdTipoDocumento(idTipoDocumento);
            }
            em.persist(documento);
            if (idExpediente != null) {
                idExpediente.getDocumentoList().add(documento);
                idExpediente = em.merge(idExpediente);
            }
            if (idTipoDocumento != null) {
                idTipoDocumento.getDocumentoList().add(documento);
                idTipoDocumento = em.merge(idTipoDocumento);
            }
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void edit(Documento documento) throws NonexistentEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Documento persistentDocumento = em.find(Documento.class, documento.getIdDocumento());
            Expediente idExpedienteOld = persistentDocumento.getIdExpediente();
            Expediente idExpedienteNew = documento.getIdExpediente();
            TipoDocumento idTipoDocumentoOld = persistentDocumento.getIdTipoDocumento();
            TipoDocumento idTipoDocumentoNew = documento.getIdTipoDocumento();
            if (idExpedienteNew != null) {
                idExpedienteNew = em.getReference(idExpedienteNew.getClass(), idExpedienteNew.getIdExpediente());
                documento.setIdExpediente(idExpedienteNew);
            }
            if (idTipoDocumentoNew != null) {
                idTipoDocumentoNew = em.getReference(idTipoDocumentoNew.getClass(), idTipoDocumentoNew.getIdTipoDocumento());
                documento.setIdTipoDocumento(idTipoDocumentoNew);
            }
            documento = em.merge(documento);
            if (idExpedienteOld != null && !idExpedienteOld.equals(idExpedienteNew)) {
                idExpedienteOld.getDocumentoList().remove(documento);
                idExpedienteOld = em.merge(idExpedienteOld);
            }
            if (idExpedienteNew != null && !idExpedienteNew.equals(idExpedienteOld)) {
                idExpedienteNew.getDocumentoList().add(documento);
                idExpedienteNew = em.merge(idExpedienteNew);
            }
            if (idTipoDocumentoOld != null && !idTipoDocumentoOld.equals(idTipoDocumentoNew)) {
                idTipoDocumentoOld.getDocumentoList().remove(documento);
                idTipoDocumentoOld = em.merge(idTipoDocumentoOld);
            }
            if (idTipoDocumentoNew != null && !idTipoDocumentoNew.equals(idTipoDocumentoOld)) {
                idTipoDocumentoNew.getDocumentoList().add(documento);
                idTipoDocumentoNew = em.merge(idTipoDocumentoNew);
            }
            em.getTransaction().commit();
        } catch (Exception ex) {
            String msg = ex.getLocalizedMessage();
            if (msg == null || msg.length() == 0) {
                Integer id = documento.getIdDocumento();
                if (findDocumento(id) == null) {
                    throw new NonexistentEntityException("The documento with id " + id + " no longer exists.");
                }
            }
            throw ex;
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void destroy(Integer id) throws NonexistentEntityException {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Documento documento;
            try {
                documento = em.getReference(Documento.class, id);
                documento.getIdDocumento();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The documento with id " + id + " no longer exists.", enfe);
            }
            Expediente idExpediente = documento.getIdExpediente();
            if (idExpediente != null) {
                idExpediente.getDocumentoList().remove(documento);
                idExpediente = em.merge(idExpediente);
            }
            TipoDocumento idTipoDocumento = documento.getIdTipoDocumento();
            if (idTipoDocumento != null) {
                idTipoDocumento.getDocumentoList().remove(documento);
                idTipoDocumento = em.merge(idTipoDocumento);
            }
            em.remove(documento);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public List<Documento> findDocumentoEntities() {
        return findDocumentoEntities(true, -1, -1);
    }

    public List<Documento> findDocumentoEntities(int maxResults, int firstResult) {
        return findDocumentoEntities(false, maxResults, firstResult);
    }

    private List<Documento> findDocumentoEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            cq.select(cq.from(Documento.class));
            Query q = em.createQuery(cq);
            if (!all) {
                q.setMaxResults(maxResults);
                q.setFirstResult(firstResult);
            }
            return q.getResultList();
        } finally {
            em.close();
        }
    }

    public Documento findDocumento(Integer id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(Documento.class, id);
        } finally {
            em.close();
        }
    }

    public int getDocumentoCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<Documento> rt = cq.from(Documento.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }

    /*Responde si existe una duplicacion de nombres de documento por expediente  
    
      Si idDocumento es nulo:(GUARDAR)
        Considera si el nombre esta o no duplicado por expediente
    
      Si idDocumento no es nulo:(EDITAR)
        Considera si el nombre esta o no duplicado por expediente
        pero sin considerar el nombre del documento identificado por idDocumento
    */
    public Boolean existeNombreDocumentoExpediente(Integer idExpediente, String nombre, Integer idDocumento) {
       
       EntityManager em = getEntityManager();
       
        try {
            String consulta =   "select count(d) from Documento d "+
                                "where d.idExpediente.idExpediente = :idExp"+
                                " and trim(upper(d.nombreDocumento)) = trim(upper(:nombre))";
                    
            if(idDocumento != null){
                consulta+= " and d.idDocumento != :idDoc"; 
            }
            Query q = em.createQuery(consulta);
            
            q.setParameter("idExp", idExpediente);
            q.setParameter("nombre", nombre);
            
            if(idDocumento != null){
                q.setParameter("idDoc", idDocumento);
            }
             
            Integer cant = ((Long) q.getSingleResult()).intValue();
            System.out.println(cant+ " cantidad");
            
            if(cant>0){
                return  true;
            }else{
                return false;
            }
            
        } catch(Exception e){
            System.out.println(e);
            return null;
            
        }finally {
            em.close();
        }
    }
    
}

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modeloMng;

import java.io.Serializable;
import javax.persistence.Query;
import javax.persistence.EntityNotFoundException;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import modelo.Pais;
import modelo.TipoMarca;
import modelo.Expediente;
import java.util.ArrayList;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import modelo.Marca;
import modeloMng.exceptions.IllegalOrphanException;
import modeloMng.exceptions.NonexistentEntityException;

/**
 *
 * @author Acer
 */
public class MarcaJpaController implements Serializable {

    public MarcaJpaController() {
        this.emf = Persistence.createEntityManagerFactory("com.mycompany_Prot2_war_1.0-SNAPSHOTPU");
    }
    private EntityManagerFactory emf = null;

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public void create(Marca marca) {
        if (marca.getExpedienteList() == null) {
            marca.setExpedienteList(new ArrayList<Expediente>());
        }
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Pais idPais = marca.getIdPais();
            if (idPais != null) {
                idPais = em.getReference(idPais.getClass(), idPais.getIdPais());
                marca.setIdPais(idPais);
            }
            TipoMarca idTipoMarca = marca.getIdTipoMarca();
            if (idTipoMarca != null) {
                idTipoMarca = em.getReference(idTipoMarca.getClass(), idTipoMarca.getIdTipoMarca());
                marca.setIdTipoMarca(idTipoMarca);
            }
            List<Expediente> attachedExpedienteList = new ArrayList<Expediente>();
            for (Expediente expedienteListExpedienteToAttach : marca.getExpedienteList()) {
                expedienteListExpedienteToAttach = em.getReference(expedienteListExpedienteToAttach.getClass(), expedienteListExpedienteToAttach.getIdExpediente());
                attachedExpedienteList.add(expedienteListExpedienteToAttach);
            }
            marca.setExpedienteList(attachedExpedienteList);
            em.persist(marca);
            if (idPais != null) {
                idPais.getMarcaList().add(marca);
                idPais = em.merge(idPais);
            }
            if (idTipoMarca != null) {
                idTipoMarca.getMarcaList().add(marca);
                idTipoMarca = em.merge(idTipoMarca);
            }
            for (Expediente expedienteListExpediente : marca.getExpedienteList()) {
                Marca oldIdMarcaOfExpedienteListExpediente = expedienteListExpediente.getIdMarca();
                expedienteListExpediente.setIdMarca(marca);
                expedienteListExpediente = em.merge(expedienteListExpediente);
                if (oldIdMarcaOfExpedienteListExpediente != null) {
                    oldIdMarcaOfExpedienteListExpediente.getExpedienteList().remove(expedienteListExpediente);
                    oldIdMarcaOfExpedienteListExpediente = em.merge(oldIdMarcaOfExpedienteListExpediente);
                }
            }
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void edit(Marca marca) throws IllegalOrphanException, NonexistentEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Marca persistentMarca = em.find(Marca.class, marca.getIdMarca());
            Pais idPaisOld = persistentMarca.getIdPais();
            Pais idPaisNew = marca.getIdPais();
            TipoMarca idTipoMarcaOld = persistentMarca.getIdTipoMarca();
            TipoMarca idTipoMarcaNew = marca.getIdTipoMarca();
            List<Expediente> expedienteListOld = persistentMarca.getExpedienteList();
            List<Expediente> expedienteListNew = marca.getExpedienteList();
            List<String> illegalOrphanMessages = null;
            for (Expediente expedienteListOldExpediente : expedienteListOld) {
                if (!expedienteListNew.contains(expedienteListOldExpediente)) {
                    if (illegalOrphanMessages == null) {
                        illegalOrphanMessages = new ArrayList<String>();
                    }
                    illegalOrphanMessages.add("You must retain Expediente " + expedienteListOldExpediente + " since its idMarca field is not nullable.");
                }
            }
            if (illegalOrphanMessages != null) {
                throw new IllegalOrphanException(illegalOrphanMessages);
            }
            if (idPaisNew != null) {
                idPaisNew = em.getReference(idPaisNew.getClass(), idPaisNew.getIdPais());
                marca.setIdPais(idPaisNew);
            }
            if (idTipoMarcaNew != null) {
                idTipoMarcaNew = em.getReference(idTipoMarcaNew.getClass(), idTipoMarcaNew.getIdTipoMarca());
                marca.setIdTipoMarca(idTipoMarcaNew);
            }
            List<Expediente> attachedExpedienteListNew = new ArrayList<Expediente>();
            for (Expediente expedienteListNewExpedienteToAttach : expedienteListNew) {
                expedienteListNewExpedienteToAttach = em.getReference(expedienteListNewExpedienteToAttach.getClass(), expedienteListNewExpedienteToAttach.getIdExpediente());
                attachedExpedienteListNew.add(expedienteListNewExpedienteToAttach);
            }
            expedienteListNew = attachedExpedienteListNew;
            marca.setExpedienteList(expedienteListNew);
            marca = em.merge(marca);
            if (idPaisOld != null && !idPaisOld.equals(idPaisNew)) {
                idPaisOld.getMarcaList().remove(marca);
                idPaisOld = em.merge(idPaisOld);
            }
            if (idPaisNew != null && !idPaisNew.equals(idPaisOld)) {
                idPaisNew.getMarcaList().add(marca);
                idPaisNew = em.merge(idPaisNew);
            }
            if (idTipoMarcaOld != null && !idTipoMarcaOld.equals(idTipoMarcaNew)) {
                idTipoMarcaOld.getMarcaList().remove(marca);
                idTipoMarcaOld = em.merge(idTipoMarcaOld);
            }
            if (idTipoMarcaNew != null && !idTipoMarcaNew.equals(idTipoMarcaOld)) {
                idTipoMarcaNew.getMarcaList().add(marca);
                idTipoMarcaNew = em.merge(idTipoMarcaNew);
            }
            for (Expediente expedienteListNewExpediente : expedienteListNew) {
                if (!expedienteListOld.contains(expedienteListNewExpediente)) {
                    Marca oldIdMarcaOfExpedienteListNewExpediente = expedienteListNewExpediente.getIdMarca();
                    expedienteListNewExpediente.setIdMarca(marca);
                    expedienteListNewExpediente = em.merge(expedienteListNewExpediente);
                    if (oldIdMarcaOfExpedienteListNewExpediente != null && !oldIdMarcaOfExpedienteListNewExpediente.equals(marca)) {
                        oldIdMarcaOfExpedienteListNewExpediente.getExpedienteList().remove(expedienteListNewExpediente);
                        oldIdMarcaOfExpedienteListNewExpediente = em.merge(oldIdMarcaOfExpedienteListNewExpediente);
                    }
                }
            }
            em.getTransaction().commit();
        } catch (Exception ex) {
            String msg = ex.getLocalizedMessage();
            if (msg == null || msg.length() == 0) {
                Integer id = marca.getIdMarca();
                if (findMarca(id) == null) {
                    throw new NonexistentEntityException("The marca with id " + id + " no longer exists.");
                }
            }
            throw ex;
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void destroy(Integer id) throws IllegalOrphanException, NonexistentEntityException {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Marca marca;
            try {
                marca = em.getReference(Marca.class, id);
                marca.getIdMarca();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The marca with id " + id + " no longer exists.", enfe);
            }
            List<String> illegalOrphanMessages = null;
            List<Expediente> expedienteListOrphanCheck = marca.getExpedienteList();
            for (Expediente expedienteListOrphanCheckExpediente : expedienteListOrphanCheck) {
                if (illegalOrphanMessages == null) {
                    illegalOrphanMessages = new ArrayList<String>();
                }
                illegalOrphanMessages.add("This Marca (" + marca + ") cannot be destroyed since the Expediente " + expedienteListOrphanCheckExpediente + " in its expedienteList field has a non-nullable idMarca field.");
            }
            if (illegalOrphanMessages != null) {
                throw new IllegalOrphanException(illegalOrphanMessages);
            }
            Pais idPais = marca.getIdPais();
            if (idPais != null) {
                idPais.getMarcaList().remove(marca);
                idPais = em.merge(idPais);
            }
            TipoMarca idTipoMarca = marca.getIdTipoMarca();
            if (idTipoMarca != null) {
                idTipoMarca.getMarcaList().remove(marca);
                idTipoMarca = em.merge(idTipoMarca);
            }
            em.remove(marca);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public List<Marca> findMarcaEntities() {
        return findMarcaEntities(true, -1, -1);
    }

    public List<Marca> findMarcaEntities(int maxResults, int firstResult) {
        return findMarcaEntities(false, maxResults, firstResult);
    }

    private List<Marca> findMarcaEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            cq.select(cq.from(Marca.class));
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

    public Marca findMarca(Integer id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(Marca.class, id);
        } finally {
            em.close();
        }
    }

    public int getMarcaCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<Marca> rt = cq.from(Marca.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }
    
    /*Responde si existe una duplicacion de la denominacion de marca  
    
      Si idMarca es nulo:(GUARDAR)
        Considera si la denominacion esta o no duplicada
    
      Si idMarca no es nulo:(EDITAR)
        Considera si la denominacion esta o no duplicada 
        pero sin considerar la denominacion de la marca identificado por idMarca
    */
    public Boolean existeDenominacion(String denominacion, Integer idMarca) {
       
       EntityManager em = getEntityManager();
       
        try {
            String consulta =   "select count(m) from Marca m "+
                                "where trim(upper(m.denominacion)) = trim(upper(:denominacion))";
                    
            if(idMarca != null){
                consulta+= " and m.idMarca != :idMarca"; 
            }
            Query q = em.createQuery(consulta);
            
            q.setParameter("denominacion", denominacion);
            
            if(idMarca != null){
                q.setParameter("idMarca", idMarca);
            }
             
            Integer cant = ((Long) q.getSingleResult()).intValue();
            //System.out.println(cant+ " cantidad");
            
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

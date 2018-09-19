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
import modelo.Usuario;
import modelo.Expediente;
import java.util.ArrayList;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import modelo.Abogado;
import modelo.Historial;
import modeloMng.exceptions.IllegalOrphanException;
import modeloMng.exceptions.NonexistentEntityException;

/**
 *
 * @author Acer
 */
public class AbogadoJpaController implements Serializable {

    public AbogadoJpaController() {
        this.emf = Persistence.createEntityManagerFactory("com.mycompany_Prot2_war_1.0-SNAPSHOTPU");
    }
    private EntityManagerFactory emf = null;

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public void create(Abogado abogado) {
        if (abogado.getExpedienteList() == null) {
            abogado.setExpedienteList(new ArrayList<Expediente>());
        }
        if (abogado.getHistorialList() == null) {
            abogado.setHistorialList(new ArrayList<Historial>());
        }
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Usuario idUsuario = abogado.getIdUsuario();
            if (idUsuario != null) {
                idUsuario = em.getReference(idUsuario.getClass(), idUsuario.getIdUsuario());
                abogado.setIdUsuario(idUsuario);
            }
            List<Expediente> attachedExpedienteList = new ArrayList<Expediente>();
            for (Expediente expedienteListExpedienteToAttach : abogado.getExpedienteList()) {
                expedienteListExpedienteToAttach = em.getReference(expedienteListExpedienteToAttach.getClass(), expedienteListExpedienteToAttach.getIdExpediente());
                attachedExpedienteList.add(expedienteListExpedienteToAttach);
            }
            abogado.setExpedienteList(attachedExpedienteList);
            List<Historial> attachedHistorialList = new ArrayList<Historial>();
            for (Historial historialListHistorialToAttach : abogado.getHistorialList()) {
                historialListHistorialToAttach = em.getReference(historialListHistorialToAttach.getClass(), historialListHistorialToAttach.getIdHistorial());
                attachedHistorialList.add(historialListHistorialToAttach);
            }
            abogado.setHistorialList(attachedHistorialList);
            em.persist(abogado);
            if (idUsuario != null) {
                idUsuario.getAbogadoList().add(abogado);
                idUsuario = em.merge(idUsuario);
            }
            for (Expediente expedienteListExpediente : abogado.getExpedienteList()) {
                Abogado oldIdAbogadoOfExpedienteListExpediente = expedienteListExpediente.getIdAbogado();
                expedienteListExpediente.setIdAbogado(abogado);
                expedienteListExpediente = em.merge(expedienteListExpediente);
                if (oldIdAbogadoOfExpedienteListExpediente != null) {
                    oldIdAbogadoOfExpedienteListExpediente.getExpedienteList().remove(expedienteListExpediente);
                    oldIdAbogadoOfExpedienteListExpediente = em.merge(oldIdAbogadoOfExpedienteListExpediente);
                }
            }
            for (Historial historialListHistorial : abogado.getHistorialList()) {
                Abogado oldIdAbogadoOfHistorialListHistorial = historialListHistorial.getIdAbogado();
                historialListHistorial.setIdAbogado(abogado);
                historialListHistorial = em.merge(historialListHistorial);
                if (oldIdAbogadoOfHistorialListHistorial != null) {
                    oldIdAbogadoOfHistorialListHistorial.getHistorialList().remove(historialListHistorial);
                    oldIdAbogadoOfHistorialListHistorial = em.merge(oldIdAbogadoOfHistorialListHistorial);
                }
            }
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void edit(Abogado abogado) throws IllegalOrphanException, NonexistentEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Abogado persistentAbogado = em.find(Abogado.class, abogado.getIdAbogado());
            Usuario idUsuarioOld = persistentAbogado.getIdUsuario();
            Usuario idUsuarioNew = abogado.getIdUsuario();
            List<Expediente> expedienteListOld = persistentAbogado.getExpedienteList();
            List<Expediente> expedienteListNew = abogado.getExpedienteList();
            List<Historial> historialListOld = persistentAbogado.getHistorialList();
            List<Historial> historialListNew = abogado.getHistorialList();
            List<String> illegalOrphanMessages = null;
            for (Expediente expedienteListOldExpediente : expedienteListOld) {
                if (!expedienteListNew.contains(expedienteListOldExpediente)) {
                    if (illegalOrphanMessages == null) {
                        illegalOrphanMessages = new ArrayList<String>();
                    }
                    illegalOrphanMessages.add("You must retain Expediente " + expedienteListOldExpediente + " since its idAbogado field is not nullable.");
                }
            }
            for (Historial historialListOldHistorial : historialListOld) {
                if (!historialListNew.contains(historialListOldHistorial)) {
                    if (illegalOrphanMessages == null) {
                        illegalOrphanMessages = new ArrayList<String>();
                    }
                    illegalOrphanMessages.add("You must retain Historial " + historialListOldHistorial + " since its idAbogado field is not nullable.");
                }
            }
            if (illegalOrphanMessages != null) {
                throw new IllegalOrphanException(illegalOrphanMessages);
            }
            if (idUsuarioNew != null) {
                idUsuarioNew = em.getReference(idUsuarioNew.getClass(), idUsuarioNew.getIdUsuario());
                abogado.setIdUsuario(idUsuarioNew);
            }
            List<Expediente> attachedExpedienteListNew = new ArrayList<Expediente>();
            for (Expediente expedienteListNewExpedienteToAttach : expedienteListNew) {
                expedienteListNewExpedienteToAttach = em.getReference(expedienteListNewExpedienteToAttach.getClass(), expedienteListNewExpedienteToAttach.getIdExpediente());
                attachedExpedienteListNew.add(expedienteListNewExpedienteToAttach);
            }
            expedienteListNew = attachedExpedienteListNew;
            abogado.setExpedienteList(expedienteListNew);
            List<Historial> attachedHistorialListNew = new ArrayList<Historial>();
            for (Historial historialListNewHistorialToAttach : historialListNew) {
                historialListNewHistorialToAttach = em.getReference(historialListNewHistorialToAttach.getClass(), historialListNewHistorialToAttach.getIdHistorial());
                attachedHistorialListNew.add(historialListNewHistorialToAttach);
            }
            historialListNew = attachedHistorialListNew;
            abogado.setHistorialList(historialListNew);
            abogado = em.merge(abogado);
            if (idUsuarioOld != null && !idUsuarioOld.equals(idUsuarioNew)) {
                idUsuarioOld.getAbogadoList().remove(abogado);
                idUsuarioOld = em.merge(idUsuarioOld);
            }
            if (idUsuarioNew != null && !idUsuarioNew.equals(idUsuarioOld)) {
                idUsuarioNew.getAbogadoList().add(abogado);
                idUsuarioNew = em.merge(idUsuarioNew);
            }
            for (Expediente expedienteListNewExpediente : expedienteListNew) {
                if (!expedienteListOld.contains(expedienteListNewExpediente)) {
                    Abogado oldIdAbogadoOfExpedienteListNewExpediente = expedienteListNewExpediente.getIdAbogado();
                    expedienteListNewExpediente.setIdAbogado(abogado);
                    expedienteListNewExpediente = em.merge(expedienteListNewExpediente);
                    if (oldIdAbogadoOfExpedienteListNewExpediente != null && !oldIdAbogadoOfExpedienteListNewExpediente.equals(abogado)) {
                        oldIdAbogadoOfExpedienteListNewExpediente.getExpedienteList().remove(expedienteListNewExpediente);
                        oldIdAbogadoOfExpedienteListNewExpediente = em.merge(oldIdAbogadoOfExpedienteListNewExpediente);
                    }
                }
            }
            for (Historial historialListNewHistorial : historialListNew) {
                if (!historialListOld.contains(historialListNewHistorial)) {
                    Abogado oldIdAbogadoOfHistorialListNewHistorial = historialListNewHistorial.getIdAbogado();
                    historialListNewHistorial.setIdAbogado(abogado);
                    historialListNewHistorial = em.merge(historialListNewHistorial);
                    if (oldIdAbogadoOfHistorialListNewHistorial != null && !oldIdAbogadoOfHistorialListNewHistorial.equals(abogado)) {
                        oldIdAbogadoOfHistorialListNewHistorial.getHistorialList().remove(historialListNewHistorial);
                        oldIdAbogadoOfHistorialListNewHistorial = em.merge(oldIdAbogadoOfHistorialListNewHistorial);
                    }
                }
            }
            em.getTransaction().commit();
        } catch (Exception ex) {
            String msg = ex.getLocalizedMessage();
            if (msg == null || msg.length() == 0) {
                Integer id = abogado.getIdAbogado();
                if (findAbogado(id) == null) {
                    throw new NonexistentEntityException("The abogado with id " + id + " no longer exists.");
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
            Abogado abogado;
            try {
                abogado = em.getReference(Abogado.class, id);
                abogado.getIdAbogado();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The abogado with id " + id + " no longer exists.", enfe);
            }
            List<String> illegalOrphanMessages = null;
            List<Expediente> expedienteListOrphanCheck = abogado.getExpedienteList();
            for (Expediente expedienteListOrphanCheckExpediente : expedienteListOrphanCheck) {
                if (illegalOrphanMessages == null) {
                    illegalOrphanMessages = new ArrayList<String>();
                }
                illegalOrphanMessages.add("This Abogado (" + abogado + ") cannot be destroyed since the Expediente " + expedienteListOrphanCheckExpediente + " in its expedienteList field has a non-nullable idAbogado field.");
            }
            List<Historial> historialListOrphanCheck = abogado.getHistorialList();
            for (Historial historialListOrphanCheckHistorial : historialListOrphanCheck) {
                if (illegalOrphanMessages == null) {
                    illegalOrphanMessages = new ArrayList<String>();
                }
                illegalOrphanMessages.add("This Abogado (" + abogado + ") cannot be destroyed since the Historial " + historialListOrphanCheckHistorial + " in its historialList field has a non-nullable idAbogado field.");
            }
            if (illegalOrphanMessages != null) {
                throw new IllegalOrphanException(illegalOrphanMessages);
            }
            Usuario idUsuario = abogado.getIdUsuario();
            if (idUsuario != null) {
                idUsuario.getAbogadoList().remove(abogado);
                idUsuario = em.merge(idUsuario);
            }
            em.remove(abogado);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public List<Abogado> findAbogadoEntities() {
        return findAbogadoEntities(true, -1, -1);
    }

    public List<Abogado> findAbogadoEntities(int maxResults, int firstResult) {
        return findAbogadoEntities(false, maxResults, firstResult);
    }

    private List<Abogado> findAbogadoEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            cq.select(cq.from(Abogado.class));
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

    public Abogado findAbogado(Integer id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(Abogado.class, id);
        } finally {
            em.close();
        }
    }

    public int getAbogadoCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<Abogado> rt = cq.from(Abogado.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }

   
    /*Responde si existe una duplicacion del numero de cedula  
    
      Si idAbogado es nulo:(GUARDAR)
        Considera si el numero de cedula esta o no duplicado
    
      Si idAbogado no es nulo:(EDITAR)
        Considera si el ci esta o no duplicado 
        pero sin considerar el ci del abogado identificado por idAbogado
    */
    public Boolean existeCiDuplicado(Long nroCi, Integer idAbogado) {
       
       EntityManager em = getEntityManager();
       
        try {
            String consulta =   "select count(a) from Abogado a "+
                                "where a.ci = :nroCi";
                    
            if(idAbogado != null){
                consulta+= " and a.idAbogado != :idAbogado"; 
            }
            Query q = em.createQuery(consulta);
            
            q.setParameter("nroCi", nroCi);
           
            
            if(idAbogado != null){
                 q.setParameter("idAbogado", idAbogado);
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

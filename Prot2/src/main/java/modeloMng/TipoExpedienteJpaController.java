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
import modelo.Expediente;
import java.util.ArrayList;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import modelo.TipoExpediente;
import modeloMng.exceptions.IllegalOrphanException;
import modeloMng.exceptions.NonexistentEntityException;

/**
 *
 * @author Acer
 */
public class TipoExpedienteJpaController implements Serializable {

    public TipoExpedienteJpaController() {
        this.emf = Persistence.createEntityManagerFactory("com.mycompany_Prot2_war_1.0-SNAPSHOTPU");
    }
    private EntityManagerFactory emf = null;

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public void create(TipoExpediente tipoExpediente) {
        if (tipoExpediente.getExpedienteList() == null) {
            tipoExpediente.setExpedienteList(new ArrayList<Expediente>());
        }
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            List<Expediente> attachedExpedienteList = new ArrayList<Expediente>();
            for (Expediente expedienteListExpedienteToAttach : tipoExpediente.getExpedienteList()) {
                expedienteListExpedienteToAttach = em.getReference(expedienteListExpedienteToAttach.getClass(), expedienteListExpedienteToAttach.getIdExpediente());
                attachedExpedienteList.add(expedienteListExpedienteToAttach);
            }
            tipoExpediente.setExpedienteList(attachedExpedienteList);
            em.persist(tipoExpediente);
            for (Expediente expedienteListExpediente : tipoExpediente.getExpedienteList()) {
                TipoExpediente oldTipoExpedienteOfExpedienteListExpediente = expedienteListExpediente.getTipoExpediente();
                expedienteListExpediente.setTipoExpediente(tipoExpediente);
                expedienteListExpediente = em.merge(expedienteListExpediente);
                if (oldTipoExpedienteOfExpedienteListExpediente != null) {
                    oldTipoExpedienteOfExpedienteListExpediente.getExpedienteList().remove(expedienteListExpediente);
                    oldTipoExpedienteOfExpedienteListExpediente = em.merge(oldTipoExpedienteOfExpedienteListExpediente);
                }
            }
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void edit(TipoExpediente tipoExpediente) throws IllegalOrphanException, NonexistentEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            TipoExpediente persistentTipoExpediente = em.find(TipoExpediente.class, tipoExpediente.getIdTipoExpediente());
            List<Expediente> expedienteListOld = persistentTipoExpediente.getExpedienteList();
            List<Expediente> expedienteListNew = tipoExpediente.getExpedienteList();
            List<String> illegalOrphanMessages = null;
            for (Expediente expedienteListOldExpediente : expedienteListOld) {
                if (!expedienteListNew.contains(expedienteListOldExpediente)) {
                    if (illegalOrphanMessages == null) {
                        illegalOrphanMessages = new ArrayList<String>();
                    }
                    illegalOrphanMessages.add("You must retain Expediente " + expedienteListOldExpediente + " since its tipoExpediente field is not nullable.");
                }
            }
            if (illegalOrphanMessages != null) {
                throw new IllegalOrphanException(illegalOrphanMessages);
            }
            List<Expediente> attachedExpedienteListNew = new ArrayList<Expediente>();
            for (Expediente expedienteListNewExpedienteToAttach : expedienteListNew) {
                expedienteListNewExpedienteToAttach = em.getReference(expedienteListNewExpedienteToAttach.getClass(), expedienteListNewExpedienteToAttach.getIdExpediente());
                attachedExpedienteListNew.add(expedienteListNewExpedienteToAttach);
            }
            expedienteListNew = attachedExpedienteListNew;
            tipoExpediente.setExpedienteList(expedienteListNew);
            tipoExpediente = em.merge(tipoExpediente);
            for (Expediente expedienteListNewExpediente : expedienteListNew) {
                if (!expedienteListOld.contains(expedienteListNewExpediente)) {
                    TipoExpediente oldTipoExpedienteOfExpedienteListNewExpediente = expedienteListNewExpediente.getTipoExpediente();
                    expedienteListNewExpediente.setTipoExpediente(tipoExpediente);
                    expedienteListNewExpediente = em.merge(expedienteListNewExpediente);
                    if (oldTipoExpedienteOfExpedienteListNewExpediente != null && !oldTipoExpedienteOfExpedienteListNewExpediente.equals(tipoExpediente)) {
                        oldTipoExpedienteOfExpedienteListNewExpediente.getExpedienteList().remove(expedienteListNewExpediente);
                        oldTipoExpedienteOfExpedienteListNewExpediente = em.merge(oldTipoExpedienteOfExpedienteListNewExpediente);
                    }
                }
            }
            em.getTransaction().commit();
        } catch (Exception ex) {
            String msg = ex.getLocalizedMessage();
            if (msg == null || msg.length() == 0) {
                Integer id = tipoExpediente.getIdTipoExpediente();
                if (findTipoExpediente(id) == null) {
                    throw new NonexistentEntityException("The tipoExpediente with id " + id + " no longer exists.");
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
            TipoExpediente tipoExpediente;
            try {
                tipoExpediente = em.getReference(TipoExpediente.class, id);
                tipoExpediente.getIdTipoExpediente();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The tipoExpediente with id " + id + " no longer exists.", enfe);
            }
            List<String> illegalOrphanMessages = null;
            List<Expediente> expedienteListOrphanCheck = tipoExpediente.getExpedienteList();
            for (Expediente expedienteListOrphanCheckExpediente : expedienteListOrphanCheck) {
                if (illegalOrphanMessages == null) {
                    illegalOrphanMessages = new ArrayList<String>();
                }
                illegalOrphanMessages.add("This TipoExpediente (" + tipoExpediente + ") cannot be destroyed since the Expediente " + expedienteListOrphanCheckExpediente + " in its expedienteList field has a non-nullable tipoExpediente field.");
            }
            if (illegalOrphanMessages != null) {
                throw new IllegalOrphanException(illegalOrphanMessages);
            }
            em.remove(tipoExpediente);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public List<TipoExpediente> findTipoExpedienteEntities() {
        return findTipoExpedienteEntities(true, -1, -1);
    }

    public List<TipoExpediente> findTipoExpedienteEntities(int maxResults, int firstResult) {
        return findTipoExpedienteEntities(false, maxResults, firstResult);
    }

    private List<TipoExpediente> findTipoExpedienteEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            cq.select(cq.from(TipoExpediente.class));
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

    public TipoExpediente findTipoExpediente(Integer id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(TipoExpediente.class, id);
        } finally {
            em.close();
        }
    }

    public int getTipoExpedienteCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<TipoExpediente> rt = cq.from(TipoExpediente.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }
    
}

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
import modelo.Permiso;
import java.util.ArrayList;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import modelo.Ventana;
import modeloMng.exceptions.IllegalOrphanException;
import modeloMng.exceptions.NonexistentEntityException;

/**
 *
 * @author Acer
 */
public class VentanaJpaController implements Serializable {

    public VentanaJpaController() {
        this.emf = Persistence.createEntityManagerFactory("com.mycompany_Prot2_war_1.0-SNAPSHOTPU");
    }
    private EntityManagerFactory emf = null;

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public void create(Ventana ventana) {
        if (ventana.getPermisoList() == null) {
            ventana.setPermisoList(new ArrayList<Permiso>());
        }
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            List<Permiso> attachedPermisoList = new ArrayList<Permiso>();
            for (Permiso permisoListPermisoToAttach : ventana.getPermisoList()) {
                permisoListPermisoToAttach = em.getReference(permisoListPermisoToAttach.getClass(), permisoListPermisoToAttach.getIdPermiso());
                attachedPermisoList.add(permisoListPermisoToAttach);
            }
            ventana.setPermisoList(attachedPermisoList);
            em.persist(ventana);
            for (Permiso permisoListPermiso : ventana.getPermisoList()) {
                Ventana oldIdVentanaOfPermisoListPermiso = permisoListPermiso.getIdVentana();
                permisoListPermiso.setIdVentana(ventana);
                permisoListPermiso = em.merge(permisoListPermiso);
                if (oldIdVentanaOfPermisoListPermiso != null) {
                    oldIdVentanaOfPermisoListPermiso.getPermisoList().remove(permisoListPermiso);
                    oldIdVentanaOfPermisoListPermiso = em.merge(oldIdVentanaOfPermisoListPermiso);
                }
            }
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void edit(Ventana ventana) throws IllegalOrphanException, NonexistentEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Ventana persistentVentana = em.find(Ventana.class, ventana.getIdVentana());
            List<Permiso> permisoListOld = persistentVentana.getPermisoList();
            List<Permiso> permisoListNew = ventana.getPermisoList();
            List<String> illegalOrphanMessages = null;
            for (Permiso permisoListOldPermiso : permisoListOld) {
                if (!permisoListNew.contains(permisoListOldPermiso)) {
                    if (illegalOrphanMessages == null) {
                        illegalOrphanMessages = new ArrayList<String>();
                    }
                    illegalOrphanMessages.add("You must retain Permiso " + permisoListOldPermiso + " since its idVentana field is not nullable.");
                }
            }
            if (illegalOrphanMessages != null) {
                throw new IllegalOrphanException(illegalOrphanMessages);
            }
            List<Permiso> attachedPermisoListNew = new ArrayList<Permiso>();
            for (Permiso permisoListNewPermisoToAttach : permisoListNew) {
                permisoListNewPermisoToAttach = em.getReference(permisoListNewPermisoToAttach.getClass(), permisoListNewPermisoToAttach.getIdPermiso());
                attachedPermisoListNew.add(permisoListNewPermisoToAttach);
            }
            permisoListNew = attachedPermisoListNew;
            ventana.setPermisoList(permisoListNew);
            ventana = em.merge(ventana);
            for (Permiso permisoListNewPermiso : permisoListNew) {
                if (!permisoListOld.contains(permisoListNewPermiso)) {
                    Ventana oldIdVentanaOfPermisoListNewPermiso = permisoListNewPermiso.getIdVentana();
                    permisoListNewPermiso.setIdVentana(ventana);
                    permisoListNewPermiso = em.merge(permisoListNewPermiso);
                    if (oldIdVentanaOfPermisoListNewPermiso != null && !oldIdVentanaOfPermisoListNewPermiso.equals(ventana)) {
                        oldIdVentanaOfPermisoListNewPermiso.getPermisoList().remove(permisoListNewPermiso);
                        oldIdVentanaOfPermisoListNewPermiso = em.merge(oldIdVentanaOfPermisoListNewPermiso);
                    }
                }
            }
            em.getTransaction().commit();
        } catch (Exception ex) {
            String msg = ex.getLocalizedMessage();
            if (msg == null || msg.length() == 0) {
                Integer id = ventana.getIdVentana();
                if (findVentana(id) == null) {
                    throw new NonexistentEntityException("The ventana with id " + id + " no longer exists.");
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
            Ventana ventana;
            try {
                ventana = em.getReference(Ventana.class, id);
                ventana.getIdVentana();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The ventana with id " + id + " no longer exists.", enfe);
            }
            List<String> illegalOrphanMessages = null;
            List<Permiso> permisoListOrphanCheck = ventana.getPermisoList();
            for (Permiso permisoListOrphanCheckPermiso : permisoListOrphanCheck) {
                if (illegalOrphanMessages == null) {
                    illegalOrphanMessages = new ArrayList<String>();
                }
                illegalOrphanMessages.add("This Ventana (" + ventana + ") cannot be destroyed since the Permiso " + permisoListOrphanCheckPermiso + " in its permisoList field has a non-nullable idVentana field.");
            }
            if (illegalOrphanMessages != null) {
                throw new IllegalOrphanException(illegalOrphanMessages);
            }
            em.remove(ventana);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public List<Ventana> findVentanaEntities() {
        return findVentanaEntities(true, -1, -1);
    }

    public List<Ventana> findVentanaEntities(int maxResults, int firstResult) {
        return findVentanaEntities(false, maxResults, firstResult);
    }

    private List<Ventana> findVentanaEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            cq.select(cq.from(Ventana.class));
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

    public Ventana findVentana(Integer id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(Ventana.class, id);
        } finally {
            em.close();
        }
    }

    public int getVentanaCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<Ventana> rt = cq.from(Ventana.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }
    
}

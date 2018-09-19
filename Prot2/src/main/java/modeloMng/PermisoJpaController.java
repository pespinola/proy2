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
import modelo.Permiso;
import modelo.Ventana;
import modeloMng.exceptions.NonexistentEntityException;

/**
 *
 * @author Acer
 */
public class PermisoJpaController implements Serializable {

    public PermisoJpaController() {
        this.emf = Persistence.createEntityManagerFactory("com.mycompany_Prot2_war_1.0-SNAPSHOTPU");
    }
    private EntityManagerFactory emf = null;

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public void create(Permiso permiso) {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Ventana idVentana = permiso.getIdVentana();
            if (idVentana != null) {
                idVentana = em.getReference(idVentana.getClass(), idVentana.getIdVentana());
                permiso.setIdVentana(idVentana);
            }
            em.persist(permiso);
            if (idVentana != null) {
                idVentana.getPermisoList().add(permiso);
                idVentana = em.merge(idVentana);
            }
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void edit(Permiso permiso) throws NonexistentEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Permiso persistentPermiso = em.find(Permiso.class, permiso.getIdPermiso());
            Ventana idVentanaOld = persistentPermiso.getIdVentana();
            Ventana idVentanaNew = permiso.getIdVentana();
            if (idVentanaNew != null) {
                idVentanaNew = em.getReference(idVentanaNew.getClass(), idVentanaNew.getIdVentana());
                permiso.setIdVentana(idVentanaNew);
            }
            permiso = em.merge(permiso);
            if (idVentanaOld != null && !idVentanaOld.equals(idVentanaNew)) {
                idVentanaOld.getPermisoList().remove(permiso);
                idVentanaOld = em.merge(idVentanaOld);
            }
            if (idVentanaNew != null && !idVentanaNew.equals(idVentanaOld)) {
                idVentanaNew.getPermisoList().add(permiso);
                idVentanaNew = em.merge(idVentanaNew);
            }
            em.getTransaction().commit();
        } catch (Exception ex) {
            String msg = ex.getLocalizedMessage();
            if (msg == null || msg.length() == 0) {
                Integer id = permiso.getIdPermiso();
                if (findPermiso(id) == null) {
                    throw new NonexistentEntityException("The permiso with id " + id + " no longer exists.");
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
            Permiso permiso;
            try {
                permiso = em.getReference(Permiso.class, id);
                permiso.getIdPermiso();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The permiso with id " + id + " no longer exists.", enfe);
            }
            Ventana idVentana = permiso.getIdVentana();
            if (idVentana != null) {
                idVentana.getPermisoList().remove(permiso);
                idVentana = em.merge(idVentana);
            }
            em.remove(permiso);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public List<Permiso> findPermisoEntities() {
        return findPermisoEntities(true, -1, -1);
    }

    public List<Permiso> findPermisoEntities(int maxResults, int firstResult) {
        return findPermisoEntities(false, maxResults, firstResult);
    }

    private List<Permiso> findPermisoEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            cq.select(cq.from(Permiso.class));
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

    public Permiso findPermiso(Integer id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(Permiso.class, id);
        } finally {
            em.close();
        }
    }

    public int getPermisoCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<Permiso> rt = cq.from(Permiso.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }
    
    public List<Permiso> getPermisoRol(Integer idRol) {
        EntityManager em = getEntityManager();
        
        try {
           
            String consulta = "select p from Permiso p where p.idRol.idRol = :idRol";
            
            Query q = em.createQuery(consulta);
            q.setParameter("idRol",idRol);
            return q.getResultList();
            
        }finally {
            em.close();
        }
    }
    
    public Boolean permisoRolVentana(Integer idRol, Integer idVentana) {
        EntityManager em = getEntityManager();
        
        try {
           
            String consulta = "select count(p) from Permiso p where p.idRol.idRol = :idRol "+
                              "and p.idVentana.idVentana =:idVentana";
            
            Query q = em.createQuery(consulta);
            q.setParameter("idRol",idRol);
            q.setParameter("idVentana",idVentana);
            Integer cant = ((Long) q.getSingleResult()).intValue();
            
            if(cant>0){
                return  true;
            }else{
                return false;
            }
            
        }finally {
            em.close();
        }
    }
    
}

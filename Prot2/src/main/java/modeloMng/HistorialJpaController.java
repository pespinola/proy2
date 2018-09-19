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
import modelo.Abogado;
import modelo.Expediente;
import modelo.Historial;
import modeloMng.exceptions.NonexistentEntityException;

/**
 *
 * @author Acer
 */
public class HistorialJpaController implements Serializable {

    public HistorialJpaController() {
        this.emf = Persistence.createEntityManagerFactory("com.mycompany_Prot2_war_1.0-SNAPSHOTPU");
    }
    private EntityManagerFactory emf = null;

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public void create(Historial historial) {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Abogado idAbogado = historial.getIdAbogado();
            if (idAbogado != null) {
                idAbogado = em.getReference(idAbogado.getClass(), idAbogado.getIdAbogado());
                historial.setIdAbogado(idAbogado);
            }
            Expediente idExpediente = historial.getIdExpediente();
            if (idExpediente != null) {
                idExpediente = em.getReference(idExpediente.getClass(), idExpediente.getIdExpediente());
                historial.setIdExpediente(idExpediente);
            }
            em.persist(historial);
            if (idAbogado != null) {
                idAbogado.getHistorialList().add(historial);
                idAbogado = em.merge(idAbogado);
            }
            if (idExpediente != null) {
                idExpediente.getHistorialList().add(historial);
                idExpediente = em.merge(idExpediente);
            }
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void edit(Historial historial) throws NonexistentEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Historial persistentHistorial = em.find(Historial.class, historial.getIdHistorial());
            Abogado idAbogadoOld = persistentHistorial.getIdAbogado();
            Abogado idAbogadoNew = historial.getIdAbogado();
            Expediente idExpedienteOld = persistentHistorial.getIdExpediente();
            Expediente idExpedienteNew = historial.getIdExpediente();
            if (idAbogadoNew != null) {
                idAbogadoNew = em.getReference(idAbogadoNew.getClass(), idAbogadoNew.getIdAbogado());
                historial.setIdAbogado(idAbogadoNew);
            }
            if (idExpedienteNew != null) {
                idExpedienteNew = em.getReference(idExpedienteNew.getClass(), idExpedienteNew.getIdExpediente());
                historial.setIdExpediente(idExpedienteNew);
            }
            historial = em.merge(historial);
            if (idAbogadoOld != null && !idAbogadoOld.equals(idAbogadoNew)) {
                idAbogadoOld.getHistorialList().remove(historial);
                idAbogadoOld = em.merge(idAbogadoOld);
            }
            if (idAbogadoNew != null && !idAbogadoNew.equals(idAbogadoOld)) {
                idAbogadoNew.getHistorialList().add(historial);
                idAbogadoNew = em.merge(idAbogadoNew);
            }
            if (idExpedienteOld != null && !idExpedienteOld.equals(idExpedienteNew)) {
                idExpedienteOld.getHistorialList().remove(historial);
                idExpedienteOld = em.merge(idExpedienteOld);
            }
            if (idExpedienteNew != null && !idExpedienteNew.equals(idExpedienteOld)) {
                idExpedienteNew.getHistorialList().add(historial);
                idExpedienteNew = em.merge(idExpedienteNew);
            }
            em.getTransaction().commit();
        } catch (Exception ex) {
            String msg = ex.getLocalizedMessage();
            if (msg == null || msg.length() == 0) {
                Integer id = historial.getIdHistorial();
                if (findHistorial(id) == null) {
                    throw new NonexistentEntityException("The historial with id " + id + " no longer exists.");
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
            Historial historial;
            try {
                historial = em.getReference(Historial.class, id);
                historial.getIdHistorial();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The historial with id " + id + " no longer exists.", enfe);
            }
            Abogado idAbogado = historial.getIdAbogado();
            if (idAbogado != null) {
                idAbogado.getHistorialList().remove(historial);
                idAbogado = em.merge(idAbogado);
            }
            Expediente idExpediente = historial.getIdExpediente();
            if (idExpediente != null) {
                idExpediente.getHistorialList().remove(historial);
                idExpediente = em.merge(idExpediente);
            }
            em.remove(historial);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public List<Historial> findHistorialEntities() {
        return findHistorialEntities(true, -1, -1);
    }

    public List<Historial> findHistorialEntities(int maxResults, int firstResult) {
        return findHistorialEntities(false, maxResults, firstResult);
    }

    private List<Historial> findHistorialEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            cq.select(cq.from(Historial.class));
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

    public Historial findHistorial(Integer id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(Historial.class, id);
        } finally {
            em.close();
        }
    }

    public int getHistorialCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<Historial> rt = cq.from(Historial.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }
    
}

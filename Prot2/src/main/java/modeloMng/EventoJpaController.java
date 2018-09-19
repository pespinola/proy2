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
import modelo.Evento;
import modelo.Expediente;
import modeloMng.exceptions.NonexistentEntityException;

/**
 *
 * @author Acer
 */
public class EventoJpaController implements Serializable {

    public EventoJpaController() {
       this.emf = Persistence.createEntityManagerFactory("com.mycompany_Prot2_war_1.0-SNAPSHOTPU");
    }
    private EntityManagerFactory emf = null;

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public void create(Evento evento) {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Expediente idExpediente = evento.getIdExpediente();
            if (idExpediente != null) {
                idExpediente = em.getReference(idExpediente.getClass(), idExpediente.getIdExpediente());
                evento.setIdExpediente(idExpediente);
            }
            em.persist(evento);
            if (idExpediente != null) {
                idExpediente.getEventoList().add(evento);
                idExpediente = em.merge(idExpediente);
            }
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void edit(Evento evento) throws NonexistentEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Evento persistentEvento = em.find(Evento.class, evento.getIdEvento());
            Expediente idExpedienteOld = persistentEvento.getIdExpediente();
            Expediente idExpedienteNew = evento.getIdExpediente();
            if (idExpedienteNew != null) {
                idExpedienteNew = em.getReference(idExpedienteNew.getClass(), idExpedienteNew.getIdExpediente());
                evento.setIdExpediente(idExpedienteNew);
            }
            evento = em.merge(evento);
            if (idExpedienteOld != null && !idExpedienteOld.equals(idExpedienteNew)) {
                idExpedienteOld.getEventoList().remove(evento);
                idExpedienteOld = em.merge(idExpedienteOld);
            }
            if (idExpedienteNew != null && !idExpedienteNew.equals(idExpedienteOld)) {
                idExpedienteNew.getEventoList().add(evento);
                idExpedienteNew = em.merge(idExpedienteNew);
            }
            em.getTransaction().commit();
        } catch (Exception ex) {
            String msg = ex.getLocalizedMessage();
            if (msg == null || msg.length() == 0) {
                Integer id = evento.getIdEvento();
                if (findEvento(id) == null) {
                    throw new NonexistentEntityException("The evento with id " + id + " no longer exists.");
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
            Evento evento;
            try {
                evento = em.getReference(Evento.class, id);
                evento.getIdEvento();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The evento with id " + id + " no longer exists.", enfe);
            }
            Expediente idExpediente = evento.getIdExpediente();
            if (idExpediente != null) {
                idExpediente.getEventoList().remove(evento);
                idExpediente = em.merge(idExpediente);
            }
            em.remove(evento);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public List<Evento> findEventoEntities() {
        return findEventoEntities(true, -1, -1);
    }

    public List<Evento> findEventoEntities(int maxResults, int firstResult) {
        return findEventoEntities(false, maxResults, firstResult);
    }

    private List<Evento> findEventoEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            cq.select(cq.from(Evento.class));
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

    public Evento findEvento(Integer id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(Evento.class, id);
        } finally {
            em.close();
        }
    }

    public int getEventoCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<Evento> rt = cq.from(Evento.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }
    
}

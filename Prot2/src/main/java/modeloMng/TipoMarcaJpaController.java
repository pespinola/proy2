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
import modelo.Marca;
import java.util.ArrayList;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import modelo.TipoMarca;
import modeloMng.exceptions.IllegalOrphanException;
import modeloMng.exceptions.NonexistentEntityException;

/**
 *
 * @author Acer
 */
public class TipoMarcaJpaController implements Serializable {

    public TipoMarcaJpaController() {
        this.emf = Persistence.createEntityManagerFactory("com.mycompany_Prot2_war_1.0-SNAPSHOTPU");
    }
    private EntityManagerFactory emf = null;

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public void create(TipoMarca tipoMarca) {
        if (tipoMarca.getMarcaList() == null) {
            tipoMarca.setMarcaList(new ArrayList<Marca>());
        }
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            List<Marca> attachedMarcaList = new ArrayList<Marca>();
            for (Marca marcaListMarcaToAttach : tipoMarca.getMarcaList()) {
                marcaListMarcaToAttach = em.getReference(marcaListMarcaToAttach.getClass(), marcaListMarcaToAttach.getIdMarca());
                attachedMarcaList.add(marcaListMarcaToAttach);
            }
            tipoMarca.setMarcaList(attachedMarcaList);
            em.persist(tipoMarca);
            for (Marca marcaListMarca : tipoMarca.getMarcaList()) {
                TipoMarca oldIdTipoMarcaOfMarcaListMarca = marcaListMarca.getIdTipoMarca();
                marcaListMarca.setIdTipoMarca(tipoMarca);
                marcaListMarca = em.merge(marcaListMarca);
                if (oldIdTipoMarcaOfMarcaListMarca != null) {
                    oldIdTipoMarcaOfMarcaListMarca.getMarcaList().remove(marcaListMarca);
                    oldIdTipoMarcaOfMarcaListMarca = em.merge(oldIdTipoMarcaOfMarcaListMarca);
                }
            }
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void edit(TipoMarca tipoMarca) throws IllegalOrphanException, NonexistentEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            TipoMarca persistentTipoMarca = em.find(TipoMarca.class, tipoMarca.getIdTipoMarca());
            List<Marca> marcaListOld = persistentTipoMarca.getMarcaList();
            List<Marca> marcaListNew = tipoMarca.getMarcaList();
            List<String> illegalOrphanMessages = null;
            for (Marca marcaListOldMarca : marcaListOld) {
                if (!marcaListNew.contains(marcaListOldMarca)) {
                    if (illegalOrphanMessages == null) {
                        illegalOrphanMessages = new ArrayList<String>();
                    }
                    illegalOrphanMessages.add("You must retain Marca " + marcaListOldMarca + " since its idTipoMarca field is not nullable.");
                }
            }
            if (illegalOrphanMessages != null) {
                throw new IllegalOrphanException(illegalOrphanMessages);
            }
            List<Marca> attachedMarcaListNew = new ArrayList<Marca>();
            for (Marca marcaListNewMarcaToAttach : marcaListNew) {
                marcaListNewMarcaToAttach = em.getReference(marcaListNewMarcaToAttach.getClass(), marcaListNewMarcaToAttach.getIdMarca());
                attachedMarcaListNew.add(marcaListNewMarcaToAttach);
            }
            marcaListNew = attachedMarcaListNew;
            tipoMarca.setMarcaList(marcaListNew);
            tipoMarca = em.merge(tipoMarca);
            for (Marca marcaListNewMarca : marcaListNew) {
                if (!marcaListOld.contains(marcaListNewMarca)) {
                    TipoMarca oldIdTipoMarcaOfMarcaListNewMarca = marcaListNewMarca.getIdTipoMarca();
                    marcaListNewMarca.setIdTipoMarca(tipoMarca);
                    marcaListNewMarca = em.merge(marcaListNewMarca);
                    if (oldIdTipoMarcaOfMarcaListNewMarca != null && !oldIdTipoMarcaOfMarcaListNewMarca.equals(tipoMarca)) {
                        oldIdTipoMarcaOfMarcaListNewMarca.getMarcaList().remove(marcaListNewMarca);
                        oldIdTipoMarcaOfMarcaListNewMarca = em.merge(oldIdTipoMarcaOfMarcaListNewMarca);
                    }
                }
            }
            em.getTransaction().commit();
        } catch (Exception ex) {
            String msg = ex.getLocalizedMessage();
            if (msg == null || msg.length() == 0) {
                Integer id = tipoMarca.getIdTipoMarca();
                if (findTipoMarca(id) == null) {
                    throw new NonexistentEntityException("The tipoMarca with id " + id + " no longer exists.");
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
            TipoMarca tipoMarca;
            try {
                tipoMarca = em.getReference(TipoMarca.class, id);
                tipoMarca.getIdTipoMarca();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The tipoMarca with id " + id + " no longer exists.", enfe);
            }
            List<String> illegalOrphanMessages = null;
            List<Marca> marcaListOrphanCheck = tipoMarca.getMarcaList();
            for (Marca marcaListOrphanCheckMarca : marcaListOrphanCheck) {
                if (illegalOrphanMessages == null) {
                    illegalOrphanMessages = new ArrayList<String>();
                }
                illegalOrphanMessages.add("This TipoMarca (" + tipoMarca + ") cannot be destroyed since the Marca " + marcaListOrphanCheckMarca + " in its marcaList field has a non-nullable idTipoMarca field.");
            }
            if (illegalOrphanMessages != null) {
                throw new IllegalOrphanException(illegalOrphanMessages);
            }
            em.remove(tipoMarca);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public List<TipoMarca> findTipoMarcaEntities() {
        return findTipoMarcaEntities(true, -1, -1);
    }

    public List<TipoMarca> findTipoMarcaEntities(int maxResults, int firstResult) {
        return findTipoMarcaEntities(false, maxResults, firstResult);
    }

    private List<TipoMarca> findTipoMarcaEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            cq.select(cq.from(TipoMarca.class));
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

    public TipoMarca findTipoMarca(Integer id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(TipoMarca.class, id);
        } finally {
            em.close();
        }
    }

    public int getTipoMarcaCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<TipoMarca> rt = cq.from(TipoMarca.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }
    
}

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
import modelo.Rol;
import modelo.Abogado;
import java.util.ArrayList;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import modelo.Cliente;
import modelo.Usuario;
import modeloMng.exceptions.IllegalOrphanException;
import modeloMng.exceptions.NonexistentEntityException;

/**
 *
 * @author Acer
 */
public class UsuarioJpaController implements Serializable {
    
    
    
    public UsuarioJpaController() {
        this.emf = Persistence.createEntityManagerFactory("com.mycompany_Prot2_war_1.0-SNAPSHOTPU");
    }
    private EntityManagerFactory emf = null;

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public void create(Usuario usuario) {
        if (usuario.getAbogadoList() == null) {
            usuario.setAbogadoList(new ArrayList<Abogado>());
        }
        if (usuario.getClienteList() == null) {
            usuario.setClienteList(new ArrayList<Cliente>());
        }
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Rol idRol = usuario.getIdRol();
            if (idRol != null) {
                idRol = em.getReference(idRol.getClass(), idRol.getIdRol());
                usuario.setIdRol(idRol);
            }
            List<Abogado> attachedAbogadoList = new ArrayList<Abogado>();
            for (Abogado abogadoListAbogadoToAttach : usuario.getAbogadoList()) {
                abogadoListAbogadoToAttach = em.getReference(abogadoListAbogadoToAttach.getClass(), abogadoListAbogadoToAttach.getIdAbogado());
                attachedAbogadoList.add(abogadoListAbogadoToAttach);
            }
            usuario.setAbogadoList(attachedAbogadoList);
            List<Cliente> attachedClienteList = new ArrayList<Cliente>();
            for (Cliente clienteListClienteToAttach : usuario.getClienteList()) {
                clienteListClienteToAttach = em.getReference(clienteListClienteToAttach.getClass(), clienteListClienteToAttach.getIdCliente());
                attachedClienteList.add(clienteListClienteToAttach);
            }
            usuario.setClienteList(attachedClienteList);
            em.persist(usuario);
            if (idRol != null) {
                idRol.getUsuarioList().add(usuario);
                idRol = em.merge(idRol);
            }
            for (Abogado abogadoListAbogado : usuario.getAbogadoList()) {
                Usuario oldIdUsuarioOfAbogadoListAbogado = abogadoListAbogado.getIdUsuario();
                abogadoListAbogado.setIdUsuario(usuario);
                abogadoListAbogado = em.merge(abogadoListAbogado);
                if (oldIdUsuarioOfAbogadoListAbogado != null) {
                    oldIdUsuarioOfAbogadoListAbogado.getAbogadoList().remove(abogadoListAbogado);
                    oldIdUsuarioOfAbogadoListAbogado = em.merge(oldIdUsuarioOfAbogadoListAbogado);
                }
            }
            for (Cliente clienteListCliente : usuario.getClienteList()) {
                Usuario oldIdUsuarioOfClienteListCliente = clienteListCliente.getIdUsuario();
                clienteListCliente.setIdUsuario(usuario);
                clienteListCliente = em.merge(clienteListCliente);
                if (oldIdUsuarioOfClienteListCliente != null) {
                    oldIdUsuarioOfClienteListCliente.getClienteList().remove(clienteListCliente);
                    oldIdUsuarioOfClienteListCliente = em.merge(oldIdUsuarioOfClienteListCliente);
                }
            }
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void edit(Usuario usuario) throws IllegalOrphanException, NonexistentEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Usuario persistentUsuario = em.find(Usuario.class, usuario.getIdUsuario());
            Rol idRolOld = persistentUsuario.getIdRol();
            Rol idRolNew = usuario.getIdRol();
            List<Abogado> abogadoListOld = persistentUsuario.getAbogadoList();
            List<Abogado> abogadoListNew = usuario.getAbogadoList();
            List<Cliente> clienteListOld = persistentUsuario.getClienteList();
            List<Cliente> clienteListNew = usuario.getClienteList();
            List<String> illegalOrphanMessages = null;
            for (Abogado abogadoListOldAbogado : abogadoListOld) {
                if (!abogadoListNew.contains(abogadoListOldAbogado)) {
                    if (illegalOrphanMessages == null) {
                        illegalOrphanMessages = new ArrayList<String>();
                    }
                    illegalOrphanMessages.add("You must retain Abogado " + abogadoListOldAbogado + " since its idUsuario field is not nullable.");
                }
            }
            for (Cliente clienteListOldCliente : clienteListOld) {
                if (!clienteListNew.contains(clienteListOldCliente)) {
                    if (illegalOrphanMessages == null) {
                        illegalOrphanMessages = new ArrayList<String>();
                    }
                    illegalOrphanMessages.add("You must retain Cliente " + clienteListOldCliente + " since its idUsuario field is not nullable.");
                }
            }
            if (illegalOrphanMessages != null) {
                throw new IllegalOrphanException(illegalOrphanMessages);
            }
            if (idRolNew != null) {
                idRolNew = em.getReference(idRolNew.getClass(), idRolNew.getIdRol());
                usuario.setIdRol(idRolNew);
            }
            List<Abogado> attachedAbogadoListNew = new ArrayList<Abogado>();
            for (Abogado abogadoListNewAbogadoToAttach : abogadoListNew) {
                abogadoListNewAbogadoToAttach = em.getReference(abogadoListNewAbogadoToAttach.getClass(), abogadoListNewAbogadoToAttach.getIdAbogado());
                attachedAbogadoListNew.add(abogadoListNewAbogadoToAttach);
            }
            abogadoListNew = attachedAbogadoListNew;
            usuario.setAbogadoList(abogadoListNew);
            List<Cliente> attachedClienteListNew = new ArrayList<Cliente>();
            for (Cliente clienteListNewClienteToAttach : clienteListNew) {
                clienteListNewClienteToAttach = em.getReference(clienteListNewClienteToAttach.getClass(), clienteListNewClienteToAttach.getIdCliente());
                attachedClienteListNew.add(clienteListNewClienteToAttach);
            }
            clienteListNew = attachedClienteListNew;
            usuario.setClienteList(clienteListNew);
            usuario = em.merge(usuario);
            if (idRolOld != null && !idRolOld.equals(idRolNew)) {
                idRolOld.getUsuarioList().remove(usuario);
                idRolOld = em.merge(idRolOld);
            }
            if (idRolNew != null && !idRolNew.equals(idRolOld)) {
                idRolNew.getUsuarioList().add(usuario);
                idRolNew = em.merge(idRolNew);
            }
            for (Abogado abogadoListNewAbogado : abogadoListNew) {
                if (!abogadoListOld.contains(abogadoListNewAbogado)) {
                    Usuario oldIdUsuarioOfAbogadoListNewAbogado = abogadoListNewAbogado.getIdUsuario();
                    abogadoListNewAbogado.setIdUsuario(usuario);
                    abogadoListNewAbogado = em.merge(abogadoListNewAbogado);
                    if (oldIdUsuarioOfAbogadoListNewAbogado != null && !oldIdUsuarioOfAbogadoListNewAbogado.equals(usuario)) {
                        oldIdUsuarioOfAbogadoListNewAbogado.getAbogadoList().remove(abogadoListNewAbogado);
                        oldIdUsuarioOfAbogadoListNewAbogado = em.merge(oldIdUsuarioOfAbogadoListNewAbogado);
                    }
                }
            }
            for (Cliente clienteListNewCliente : clienteListNew) {
                if (!clienteListOld.contains(clienteListNewCliente)) {
                    Usuario oldIdUsuarioOfClienteListNewCliente = clienteListNewCliente.getIdUsuario();
                    clienteListNewCliente.setIdUsuario(usuario);
                    clienteListNewCliente = em.merge(clienteListNewCliente);
                    if (oldIdUsuarioOfClienteListNewCliente != null && !oldIdUsuarioOfClienteListNewCliente.equals(usuario)) {
                        oldIdUsuarioOfClienteListNewCliente.getClienteList().remove(clienteListNewCliente);
                        oldIdUsuarioOfClienteListNewCliente = em.merge(oldIdUsuarioOfClienteListNewCliente);
                    }
                }
            }
            em.getTransaction().commit();
        } catch (Exception ex) {
            String msg = ex.getLocalizedMessage();
            if (msg == null || msg.length() == 0) {
                Integer id = usuario.getIdUsuario();
                if (findUsuario(id) == null) {
                    throw new NonexistentEntityException("The usuario with id " + id + " no longer exists.");
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
            Usuario usuario;
            try {
                usuario = em.getReference(Usuario.class, id);
                usuario.getIdUsuario();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The usuario with id " + id + " no longer exists.", enfe);
            }
            List<String> illegalOrphanMessages = null;
            List<Abogado> abogadoListOrphanCheck = usuario.getAbogadoList();
            for (Abogado abogadoListOrphanCheckAbogado : abogadoListOrphanCheck) {
                if (illegalOrphanMessages == null) {
                    illegalOrphanMessages = new ArrayList<String>();
                }
                illegalOrphanMessages.add("This Usuario (" + usuario + ") cannot be destroyed since the Abogado " + abogadoListOrphanCheckAbogado + " in its abogadoList field has a non-nullable idUsuario field.");
            }
            List<Cliente> clienteListOrphanCheck = usuario.getClienteList();
            for (Cliente clienteListOrphanCheckCliente : clienteListOrphanCheck) {
                if (illegalOrphanMessages == null) {
                    illegalOrphanMessages = new ArrayList<String>();
                }
                illegalOrphanMessages.add("This Usuario (" + usuario + ") cannot be destroyed since the Cliente " + clienteListOrphanCheckCliente + " in its clienteList field has a non-nullable idUsuario field.");
            }
            if (illegalOrphanMessages != null) {
                throw new IllegalOrphanException(illegalOrphanMessages);
            }
            Rol idRol = usuario.getIdRol();
            if (idRol != null) {
                idRol.getUsuarioList().remove(usuario);
                idRol = em.merge(idRol);
            }
            em.remove(usuario);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public List<Usuario> findUsuarioEntities() {
        return findUsuarioEntities(true, -1, -1);
    }

    public List<Usuario> findUsuarioEntities(int maxResults, int firstResult) {
        return findUsuarioEntities(false, maxResults, firstResult);
    }

    private List<Usuario> findUsuarioEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            cq.select(cq.from(Usuario.class));
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

    public Usuario findUsuario(Integer id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(Usuario.class, id);
        } finally {
            em.close();
        }
    }

    public int getUsuarioCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<Usuario> rt = cq.from(Usuario.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }
    
    public Usuario getUsuario(String cuenta, String contraseña) {
        EntityManager em = getEntityManager();
        try {
            String consulta = "select u from Usuario u where u.cuenta = :cuenta"
                                + " and u.password = :password";
            Query q = em.createQuery(consulta);
            
            q.setParameter("cuenta", cuenta);
            q.setParameter("password", contraseña);
            
            Usuario usuario = (Usuario) q.getSingleResult();
            
            return usuario;
            
        } catch(Exception e){
            
            return null;
        
        }finally {
            em.close();
        }
    }
    
    public List<Usuario> getUsuariosNiClientesNiAbogados() {
        EntityManager em = getEntityManager();
        
        try {
           
            String consulta = "select u from Usuario u where u "+
                              "not in (select a.idUsuario from Abogado a) "+
                              "and u not in (select c.idUsuario from Cliente c)";
            Query q = em.createQuery(consulta);
            
            return q.getResultList();
            
        }finally {
            em.close();
        }
    }
    
    /** Obtiene una lista de usuarios cuyo rol es de abogado
    * y que no esten en la tabla abogado
    */
    public List<Usuario> getNuevosUsuariosRolAbogado() {
        EntityManager em = getEntityManager();
        
        try {
           
            String consulta = "select u from Usuario u where u "+
                              "not in (select a.idUsuario from Abogado a) "+
                              "and u.idRol = (select r from Rol r where upper(r.descripcion) = :rol)";
            Query q = em.createQuery(consulta);
            q.setParameter("rol", "ABOGADO");
            return q.getResultList();
            
        }finally {
            em.close();
        }
    }
    
    /** Obtiene una lista de usuarios cuyo rol es de cliente
    * y que no esten en la tabla cliente
    */
    public List<Usuario> getNuevosUsuariosRolCliente() {
        EntityManager em = getEntityManager();
        
        try {
           
            String consulta = "select u from Usuario u where u "+
                              "not in (select c.idUsuario from Cliente c) "+
                              "and u.idRol = (select r from Rol r where upper(r.descripcion) = :rol)";
            Query q = em.createQuery(consulta);
            q.setParameter("rol","CLIENTE"); 
            return q.getResultList();
            
        }finally {
            em.close();
        }
    }

    /*Responde si existe una duplicacion de la cuenta de usuario 
    
      Si idUsuario es nulo:(GUARDAR)
        Considera si el nombre de cuenta esta o no duplicado
    
      Si idUsuario no es nulo:(EDITAR)
        Considera si la cuenta esta o no duplicado 
        pero sin considerar la cuenta del usuario identificado por idUsuario
    */
    public Boolean existeCuentaDuplicado(String cuenta, Integer idUsuario) {
        EntityManager em = getEntityManager();
       
        try {
            String consulta =   "select count(u) from Usuario u "+
                                "where u.cuenta = :cuenta";
                    
            if(idUsuario != null){
                consulta+= " and u.idUsuario != :idUsuario"; 
            }
            Query q = em.createQuery(consulta);
            
            q.setParameter("cuenta", cuenta);
           
            
            if(idUsuario != null){
                 q.setParameter("idUsuario", idUsuario);
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

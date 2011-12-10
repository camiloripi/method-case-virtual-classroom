/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package mcvc.util;

import java.util.Date;
import java.util.List;
import mcvc.hibernate.clases.HibernateUtil;
import mcvc.hibernate.clases.TblEstudiantesxclase;
import mcvc.hibernate.clases.TblEstudiantesxclaseId;
import mcvc.hibernate.clases.TblLog;
import mcvc.hibernate.clases.TblSession;
import mcvc.hibernate.clases.TblUsuarios;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;

/**
 *
 * @author camilo
 */
public class Sqlquery {

    private Session session = null;
    private List<TblUsuarios> tblusuarios;
    private List<TblSession> tblsession;
    private List<TblLog> tbllog;
    private List<TblEstudiantesxclase> tblestudiantesxclase;
    private List<TblEstudiantesxclaseId> tblestudiantesxclaseid;

    public Sqlquery() {
        this.session = HibernateUtil.getSessionFactory().getCurrentSession();
    }

    public TblUsuarios getUserinfo(String email) {
        this.session = HibernateUtil.getSessionFactory().getCurrentSession();
        TblUsuarios user = null;
        tblusuarios = null;
        try {
            org.hibernate.Transaction tx = session.beginTransaction();
            Query q = session.createQuery("from TblUsuarios where USR_Email='"+email+"'");
            tblusuarios = (List<TblUsuarios>) q.list();
        } catch (Exception e) {
        }
        if(tblusuarios.size()>0){
            user = tblusuarios.get(0);
        }

        return user;

    }
    
    public void setMaestroClases(String email){
        this.session = HibernateUtil.getSessionFactory().getCurrentSession();
        tblsession = null;
        try {
            org.hibernate.Transaction tx = session.beginTransaction();
            Query q = session.createQuery("from TblSession where clsMaestro='"+email+"'");
            tblsession = (List<TblSession>) q.list();
        } catch (Exception e) {
        }
    }

    public String insertUser(String usrEmail, String usrNombre, String usrPrimerApellido, String usrSegundoApellido, String usrCelular, String usrTelefono, String usrPassword) {
        this.session = HibernateUtil.getSessionFactory().getCurrentSession();
        String  ok = "";
        org.hibernate.Transaction tx = null;
        try {
            tx = session.beginTransaction();
            TblUsuarios tr = new TblUsuarios();
            tr.setUsrEmail(usrEmail);
            tr.setUsrNombres(usrNombre);
            tr.setUsrPrimerApellido(usrPrimerApellido);
            tr.setUsrSegundoApellido(usrSegundoApellido);
            tr.setUsrCelular(usrCelular);
            tr.setUsrTelefono(usrTelefono);
            tr.setUsrPassword(usrPassword);
            tr.setUsrStatus(true);
            session.save(tr);
            tx.commit();
        } catch (HibernateException e) {
            if (tx != null) {
                tx.rollback();
            }
            ok = e.getMessage();
        }

        return ok;
    }
    
    public String insertSession(String clsNombre,Date clsFechaCreacion,Date clsFechaSession,short clsCupo,String clsToken,String clsMaestro,short clsStatus,String clsSessionId){
        this.session = HibernateUtil.getSessionFactory().getCurrentSession();
        String ok="";
        org.hibernate.Transaction tx = null;
        try {
            tx = session.beginTransaction();
            TblSession tr = new TblSession();
            tr.setClsNombre(clsNombre);
            tr.setClsFechaCreacion(clsFechaCreacion);
            tr.setClsFechaSession(clsFechaSession);
            tr.setClsCupo(clsCupo);
            tr.setClsToken(clsToken);
            tr.setClsMaestro(clsMaestro);
            tr.setClsStatus(clsStatus);
            tr.setClsSessionId(clsSessionId);
            
            session.save(tr);
            tx.commit();
        } catch (HibernateException e) {
            if (tx != null) {
                tx.rollback();
            }
            ok = e.getMessage();
        }
        
        return ok;
    }

    /**
     * @return the session
     */
    public Session getSession() {
        return session;
    }

    /**
     * @param session the session to set
     */
    public void setSession(Session session) {
        this.session = session;
    }

    /**
     * @return the tblusuarios
     */
    public List<TblUsuarios> getTblusuarios() {
        return tblusuarios;
    }

    /**
     * @param tblusuarios the tblusuarios to set
     */
    public void setTblusuarios(List<TblUsuarios> tblusuarios) {
        this.tblusuarios = tblusuarios;
    }

    /**
     * @return the tblsession
     */
    public List<TblSession> getTblsession() {
        return tblsession;
    }

    /**
     * @param tblsession the tblsession to set
     */
    public void setTblsession(List<TblSession> tblsession) {
        this.tblsession = tblsession;
    }

    /**
     * @return the tbllog
     */
    public List<TblLog> getTbllog() {
        return tbllog;
    }

    /**
     * @param tbllog the tbllog to set
     */
    public void setTbllog(List<TblLog> tbllog) {
        this.tbllog = tbllog;
    }

    /**
     * @return the tblestudiantesxclase
     */
    public List<TblEstudiantesxclase> getTblestudiantesxclase() {
        return tblestudiantesxclase;
    }

    /**
     * @param tblestudiantesxclase the tblestudiantesxclase to set
     */
    public void setTblestudiantesxclase(List<TblEstudiantesxclase> tblestudiantesxclase) {
        this.tblestudiantesxclase = tblestudiantesxclase;
    }

    /**
     * @return the tblestudiantesxclaseid
     */
    public List<TblEstudiantesxclaseId> getTblestudiantesxclaseid() {
        return tblestudiantesxclaseid;
    }

    /**
     * @param tblestudiantesxclaseid the tblestudiantesxclaseid to set
     */
    public void setTblestudiantesxclaseid(List<TblEstudiantesxclaseId> tblestudiantesxclaseid) {
        this.tblestudiantesxclaseid = tblestudiantesxclaseid;
    }
}

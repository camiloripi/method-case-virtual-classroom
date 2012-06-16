/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package mcvc.util;

import java.util.Date;
import java.util.List;
import mcvc.hibernate.clases.*;
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
    private List<TblBoard> tblboard;

    public Sqlquery() {
    }
    public void setcurrentSession(){
      this.session = HibernateUtil.getSessionFactory().openSession(); 
      
    }
    
    public void closeSession(){
        session.close();
    }
    
    public List<TblEstudiantesxclase> getTablaNotas(Integer id)
    {
        try
        {
             tblestudiantesxclase = null; 
             session.beginTransaction();
             Query q = session.createQuery("from TblEstudiantesxclase where EXC_Clase = " + id);
             tblestudiantesxclase = ( List<TblEstudiantesxclase>) q.list();
        }
        catch(Exception ex){}
        
        return tblestudiantesxclase;
    }
    
    public TblUsuarios getUserinfo(String email) {
        TblUsuarios user = null;
        
        try {
            tblusuarios = null;
            session.beginTransaction();
            Query q = session.createQuery("from TblUsuarios where USR_Email='"+email+"'");
            tblusuarios = (List<TblUsuarios>) q.list();
            if(tblusuarios.size()>0){
            user = tblusuarios.get(0);
            }
        } catch (Exception e) {
        }
        

        return user;

    }
    
    public boolean  isMaestro(String email,String token){
        boolean ismaestro = false;
        
        try {
            tblsession = null;
           session.beginTransaction();
            Query q = session.createQuery("from TblSession where clsMaestro='"+email+"' and clsToken='"+token+"'");
            tblsession = (List<TblSession>) q.list();
             if(tblsession.size() > 0){
            ismaestro=true;
        }
        } catch (Exception e) {
        }
       
        
        return ismaestro;
       
    }
    
    public String getSessionId(String Token){
        String sessionid="";
        
        try {
            tblsession = null;
           session.beginTransaction();
            Query q = session.createQuery("from TblSession where clsToken='"+Token+"'");
            tblsession = (List<TblSession>) q.list();
            if(tblsession.size()>0){
            sessionid = tblsession.get(0).getClsSessionId();
        }
        } catch (Exception e) {
        }
        
        
        return sessionid;
    }
    
    public String changeClassStatus(String Token,String Status){
        tblsession = null;
        String ok="";
        try {
            org.hibernate.Transaction tx = session.beginTransaction();
            Query q = session.createQuery("from TblSession where  clsToken='"+Token+"'");
            tblsession = (List<TblSession>) q.list();
            if(tblsession.size()>0){
                TblSession tblupdate;
                tblupdate = tblsession.get(0);
                int status = Integer.valueOf(Status);
                short status_short = (short)status;
                tblupdate.setClsStatus(status_short);
                session.saveOrUpdate(tblupdate);
                tx.commit();
            }
            
        } catch (Exception e) {
            ok = "No se Pudo Cambiar de Estatus";
        }
        
        return ok;
    }
    
    public void setMaestroClases(String email){
        tblsession = null;
        try {
            org.hibernate.Transaction tx = session.beginTransaction();
            Query q = session.createQuery("from TblSession where clsMaestro='"+email+"'");
            tblsession = (List<TblSession>) q.list();
        } catch (Exception e) {
        }
    }
    public Integer getiD(String token){
        List<TblSession> mitemp;
        //tblsession = null;
        try {
            org.hibernate.Transaction tx = session.beginTransaction();
            Query q = session.createQuery("from TblSession where CLS_Token='"+token+"'");
            mitemp = (List<TblSession>) q.list();
            if (mitemp.size()==1){
            return mitemp.get(0).getClsId();
            }else{
                return null;}
        } catch (Exception e) {
            
            return null;
        }
    }
    public String registrarToken(Integer id, String email) {
        String  ok = "";
        org.hibernate.Transaction tx = null;
        try {
            tx = session.beginTransaction();
            TblEstudiantesxclase tr = new TblEstudiantesxclase();
            TblEstudiantesxclaseId temporal=new TblEstudiantesxclaseId();
            temporal.setExcClase(id);
            temporal.setExcEstudiante(email);
            tr.setId(temporal);
            
            tr.setExcCantParticipaciones(0);
            tr.setExcNota('D');          
            
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
    
    public void setEstudianteClases(String email){
        this.tblestudiantesxclase=null;
        try {
            org.hibernate.Transaction tx = session.beginTransaction();
            Query q = session.createQuery("from TblEstudiantesxclase where EXC_Estudiante='"+email+"'");
            tblestudiantesxclase = (List<TblEstudiantesxclase>) q.list();
        } catch (Exception e) {
        }
    }

    public String insertUser(String usrEmail, String usrNombre, String usrPrimerApellido, String usrSegundoApellido, String usrCelular, String usrTelefono, String usrPassword) {
  
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
            ok = "No se Pudo Insertar el Usuario Intentelo de Nuevo";
        }

        return ok;
    }
    
    public String insertSession(String clsNombre,Date clsFechaCreacion,Date clsFechaSession,short clsCupo,String clsToken,String clsMaestro,short clsStatus,String clsSessionId){
      
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
    
     public String UpdateGrade(String CLS_ID,String Alumno,String Grade,String Participacion){
        tblestudiantesxclase = null;
        String ok="";
        try {
            org.hibernate.Transaction tx = session.beginTransaction();
            Query q = session.createQuery("from TblEstudiantesxclase where  EXC_Estudiante='"+Alumno+"' and EXC_Clase='"+CLS_ID+"'");
            tblestudiantesxclase  = (List<TblEstudiantesxclase>) q.list();
            if(tblestudiantesxclase.size()>0){
                TblEstudiantesxclase tblupdate;
                tblupdate = tblestudiantesxclase.get(0);
                int participacion = Integer.valueOf(Participacion);
                tblupdate.setExcCantParticipaciones(participacion);
                tblupdate.setExcNota(Grade.charAt(0));
                session.saveOrUpdate(tblupdate);
                tx.commit();
            }
            
        } catch (Exception e) {
            ok = "No se Guardar La Nota";
        }
        
        return ok;
    }
     
     public String insertBoard(String Name,String CLS_ID,String tabid) {
  
        String  ok = "";
        org.hibernate.Transaction tx = null;
        try {
            tx = session.beginTransaction();
            tblsession = null;
            Query q = session.createQuery("from TblBoard where CLS_ID='"+CLS_ID+"' and BRD_TabID='"+tabid+"'");
            
            tblboard = (List<TblBoard>) q.list();
            if(tblboard.isEmpty()){
            q = session.createQuery("from TblSession where clsId='"+CLS_ID+"'");
            tblsession = (List<TblSession>) q.list();
            TblSession sessioncls = null;
            if(tblsession.size()>0){
            sessioncls = tblsession.get(0);
            }
            TblBoardId tblboardid = new TblBoardId(tabid,Integer.parseInt(CLS_ID));
            TblBoard tr = new TblBoard(tblboardid,sessioncls, Name);
            session.save(tr);
            tx.commit();
            }else{
               TblBoard tblupdate;
                tblupdate = tblboard.get(0);
                tblupdate.setBrdText("");
                
                session.saveOrUpdate(tblupdate);
                tx.commit();        
            }
        } catch (HibernateException e) {
            if (tx != null) {
                tx.rollback();
            }
            ok = "No se Pudo Insertar el Usuario Intentelo de Nuevo";
        }

        return ok;
    }
     
     public void SelectBoards(String CLS_ID){
         tblboard = null;
        String ok="";
        try {
            org.hibernate.Transaction tx = session.beginTransaction();
            Query q = session.createQuery("from TblBoard where  CLS_ID='"+CLS_ID+"'");
            tblboard  = (List<TblBoard>) q.list();
            
        } catch (Exception e) {
            ok = "No se Guardar La tab";
        }
         
     }
     
     public String UpdatBoard(String CLS_ID,String Tab,String Text,String Name){
        tblboard = null;
        String ok="";
        try {
            org.hibernate.Transaction tx = session.beginTransaction();
            Query q = session.createQuery("from TblBoard where  CLS_ID='"+CLS_ID+"' and BRD_TabID='"+Tab+"'");
            tblboard  = (List<TblBoard>) q.list();
            if(tblboard.size()>0){
                TblBoard tblupdate;
                tblupdate = tblboard.get(0);
                tblupdate.setBrdName(Name);
                tblupdate.setBrdText(Text);
                session.saveOrUpdate(tblupdate);
                tx.commit();
            }
            
        } catch (Exception e) {
            ok = "No se Guardar La tab";
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

    /**
     * @return the tblboard
     */
    public List<TblBoard> getTblboard() {
        return tblboard;
    }

    /**
     * @param tblboard the tblboard to set
     */
    public void setTblboard(List<TblBoard> tblboard) {
        this.tblboard = tblboard;
    }
}

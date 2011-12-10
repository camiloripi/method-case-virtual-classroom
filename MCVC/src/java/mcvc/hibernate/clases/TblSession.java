package mcvc.hibernate.clases;
// Generated Dec 9, 2011 4:38:12 PM by Hibernate Tools 3.2.1.GA


import java.util.Date;
import java.util.HashSet;
import java.util.Set;

/**
 * TblSession generated by hbm2java
 */
public class TblSession  implements java.io.Serializable {


     private Integer clsId;
     private String clsNombre;
     private Date clsFechaCreacion;
     private Date clsFechaSession;
     private short clsCupo;
     private String clsToken;
     private String clsMaestro;
     private short clsStatus;
     private String clsTokenMaestro;
     private String clsSessionId;
     private String clsTime;
     private Set<TblEstudiantesxclase> tblEstudiantesxclases = new HashSet<TblEstudiantesxclase>(0);

    public TblSession() {
    }

	
    public TblSession(String clsNombre, Date clsFechaCreacion, Date clsFechaSession, short clsCupo, String clsToken, String clsMaestro, short clsStatus, String clsTokenMaestro, String clsSessionId, String clsTime) {
        this.clsNombre = clsNombre;
        this.clsFechaCreacion = clsFechaCreacion;
        this.clsFechaSession = clsFechaSession;
        this.clsCupo = clsCupo;
        this.clsToken = clsToken;
        this.clsMaestro = clsMaestro;
        this.clsStatus = clsStatus;
        this.clsTokenMaestro = clsTokenMaestro;
        this.clsSessionId = clsSessionId;
        this.clsTime = clsTime;
    }
    public TblSession(String clsNombre, Date clsFechaCreacion, Date clsFechaSession, short clsCupo, String clsToken, String clsMaestro, short clsStatus, String clsTokenMaestro, String clsSessionId, String clsTime, Set<TblEstudiantesxclase> tblEstudiantesxclases) {
       this.clsNombre = clsNombre;
       this.clsFechaCreacion = clsFechaCreacion;
       this.clsFechaSession = clsFechaSession;
       this.clsCupo = clsCupo;
       this.clsToken = clsToken;
       this.clsMaestro = clsMaestro;
       this.clsStatus = clsStatus;
       this.clsTokenMaestro = clsTokenMaestro;
       this.clsSessionId = clsSessionId;
       this.clsTime = clsTime;
       this.tblEstudiantesxclases = tblEstudiantesxclases;
    }
   
    public Integer getClsId() {
        return this.clsId;
    }
    
    public void setClsId(Integer clsId) {
        this.clsId = clsId;
    }
    public String getClsNombre() {
        return this.clsNombre;
    }
    
    public void setClsNombre(String clsNombre) {
        this.clsNombre = clsNombre;
    }
    public Date getClsFechaCreacion() {
        return this.clsFechaCreacion;
    }
    
    public void setClsFechaCreacion(Date clsFechaCreacion) {
        this.clsFechaCreacion = clsFechaCreacion;
    }
    public Date getClsFechaSession() {
        return this.clsFechaSession;
    }
    
    public void setClsFechaSession(Date clsFechaSession) {
        this.clsFechaSession = clsFechaSession;
    }
    public short getClsCupo() {
        return this.clsCupo;
    }
    
    public void setClsCupo(short clsCupo) {
        this.clsCupo = clsCupo;
    }
    public String getClsToken() {
        return this.clsToken;
    }
    
    public void setClsToken(String clsToken) {
        this.clsToken = clsToken;
    }
    public String getClsMaestro() {
        return this.clsMaestro;
    }
    
    public void setClsMaestro(String clsMaestro) {
        this.clsMaestro = clsMaestro;
    }
    public short getClsStatus() {
        return this.clsStatus;
    }
    
    public void setClsStatus(short clsStatus) {
        this.clsStatus = clsStatus;
    }
    public String getClsTokenMaestro() {
        return this.clsTokenMaestro;
    }
    
    public void setClsTokenMaestro(String clsTokenMaestro) {
        this.clsTokenMaestro = clsTokenMaestro;
    }
    public String getClsSessionId() {
        return this.clsSessionId;
    }
    
    public void setClsSessionId(String clsSessionId) {
        this.clsSessionId = clsSessionId;
    }
    public String getClsTime() {
        return this.clsTime;
    }
    
    public void setClsTime(String clsTime) {
        this.clsTime = clsTime;
    }
    public Set<TblEstudiantesxclase> getTblEstudiantesxclases() {
        return this.tblEstudiantesxclases;
    }
    
    public void setTblEstudiantesxclases(Set<TblEstudiantesxclase> tblEstudiantesxclases) {
        this.tblEstudiantesxclases = tblEstudiantesxclases;
    }




}



/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package mcvc.face.select;

import org.hibernate.Session;
import mcvc.hibernate.clases.HibernateUtil;

/**
 *
 * @author Camilo
 */
public class face_select {
    Session session = null;
    
    public face_select(){
        this.session = HibernateUtil.getSessionFactory().getCurrentSession();
    }
    

     
      
     
 
    
}

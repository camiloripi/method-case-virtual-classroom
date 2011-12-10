/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package mcvc.servlets;

import com.opentok.api.API_Config;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.text.ParseException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.opentok.api.API_Config;
import com.opentok.api.OpenTokSDK;
import com.opentok.api.constants.RoleConstants;
import com.opentok.exception.OpenTokException;
import java.util.Date;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import mcvc.hibernate.clases.HibernateUtil;
import mcvc.hibernate.clases.TblSession;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import java.security.*;

/**
 *
 * @author Manuel
 */
@WebServlet(name = "Servlet_Home_1", urlPatterns = {"/Servlet_Home_1"})
public class Servlet_Home_1 extends HttpServlet {

    OpenTokSDK sdk = new OpenTokSDK(API_Config.API_KEY, API_Config.API_SECRET); 
    
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            /* TODO output your page here
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet Servlet_Home_1</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Servlet_Home_1 at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
             */
            
            String usuario=(String)request.getSession().getAttribute("usuario");
            
            out.println("<html>"+request.getParameter("txt_sesion"));
            //Imprimiendo
            String nombre=request.getParameter("txt_sesion");
            String fecha=request.getParameter("txt_fecha");
            String hora=request.getParameter("txt_hora");
            out.println(fecha);
            out.println(hora);
            short cupo = Short.valueOf(request.getParameter("txt_cupo"));
            out.println(request.getParameter("txt_cupo"));
            //Imprimiendo
            
            String sessionid,tokenmaestro;
            
            DateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            
            Date dateNow = new java.util.Date(); 
            out.println("NOW: "+dateFormat.format(dateNow));
                      
            Date dateSession = dateFormat.parse(fecha+" "+hora+":00");            
            out.println(dateFormat.format(dateSession));
            
            sessionid=generateSessionID();            
            tokenmaestro=generateToKenMaestro(sessionid);
            out.println(sessionid);
            out.println(tokenmaestro);
            
            //out.println(dateFormat.format(date));
            out.println(this.agregarbd(usuario, nombre, dateNow, dateSession, cupo, tokenmaestro, sessionid));
            
            
            out.println("</html>");
    
            
            
        } catch (ParseException ex) {
            Logger.getLogger(Servlet_Home_1.class.getName()).log(Level.SEVERE, null, ex);
        } catch (OpenTokException ex) {
            Logger.getLogger(Servlet_Home_1.class.getName()).log(Level.SEVERE, null, ex);
        } finally {            
            out.close();
        }
    }
    
       public String generateSessionID() throws OpenTokException{
        String ID="";

        //Generate a basic session
       ID = sdk.create_session().session_id;
        System.out.println(ID);      
        return ID;
        
    }
       public String agregarbd(String usuario, String nombre,  Date fechacreacion, Date fechasession, short cupo, String tokenMaestro, String sessionid)
       {
           String error = "";
     
     Session session = HibernateUtil.getSessionFactory().getCurrentSession();
   
  
            org.hibernate.Transaction tx = null;
            
            
          String token = nombre+usuario+fechacreacion+fechasession;
         
         String tokenClase = StringMD.getStringMessageDigest(token, "MD5");
         
         

      try {
          
          
       tx = session.beginTransaction();
        TblSession tr = new  TblSession();
        tr.setClsNombre(nombre);
        tr.setClsCupo(cupo);
        tr.setClsMaestro(usuario);
        tr.setClsSessionId(sessionid);        
        tr.setClsStatus((short)1);
        tr.setClsFechaCreacion(fechacreacion);
        tr.setClsFechaSession(fechasession);
        tr.setClsToken(tokenClase);
        tr.setClsTokenMaestro(tokenMaestro);
       
      session.save(tr);
      tx.commit();
      }catch ( HibernateException e ) {
             if ( tx != null ){ tx.rollback(); error = e.getMessage();}
         }  
     
     return error;
       }
    
    public String generateToKenMaestro(String sessionID) throws OpenTokException{
        String token="";
         token =  sdk.generate_token(sessionID,RoleConstants.MODERATOR);
        return token;
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}

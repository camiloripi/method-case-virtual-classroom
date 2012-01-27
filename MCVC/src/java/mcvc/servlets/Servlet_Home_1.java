/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package mcvc.servlets;

import com.opentok.exception.OpenTokException;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import mcvc.face.select.face_tokbox;
import mcvc.util.Sqlquery;

/**
 *
 * @author Manuel
 */
@WebServlet(name = "Servlet_Home_1", urlPatterns = {"/Servlet_Home_1"})
public class Servlet_Home_1 extends HttpServlet {

    
    
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
        Sqlquery sql = new Sqlquery();
        sql.setcurrentSession();
        try {
            
            String usuario=(String)request.getSession().getAttribute("usuario");
            
            String nombre=request.getParameter("txt_sesion");
            String fecha=request.getParameter("txt_fecha");
            String hora=request.getParameter("txt_hora");
            out.println(fecha);
            out.println(hora);
            short cupo = Short.valueOf(request.getParameter("txt_cupo"));
            
            String sessionid;
            
            DateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            
            Date dateNow = new java.util.Date(); 
                      
            Date dateSession = dateFormat.parse(fecha+" "+hora+":00");   
            
            face_tokbox toxbox = new face_tokbox();
            sessionid=toxbox.generateSessionID();           
                        
            String token = nombre + usuario + dateNow.toString() + dateSession.toString();
            String tokenClase = StringMD.getStringMessageDigest(token, "MD5");
            
            
            String mes=sql.insertSession(nombre, dateNow, dateSession, cupo, tokenClase, usuario, (short)1, sessionid); 
            
            if(!mes.equals("")){
                
                response.sendRedirect("MsjError.jsp?msj=No Se Pudo crear la clase&topage=Home&text=Home");
            }else{
                 
            response.sendRedirect("TokenPage.jsp?token="+tokenClase+"&nombre="+nombre);            
            }
            
    
        } catch (OpenTokException ex) {
            Logger.getLogger(Servlet_Home_1.class.getName()).log(Level.SEVERE, null, ex);
            
            response.sendRedirect("MsjError.jsp?msj=No Se Pudo crear la clase&topage=Home&text=Home");
        } catch (ParseException ex) {
            Logger.getLogger(Servlet_Home_1.class.getName()).log(Level.SEVERE, null, ex);
            response.sendRedirect("MsjError.jsp?msj=No Se Pudo crear la clase&topage=Home&text=Home");
        } finally { 
            sql.closeSession();
            out.close();
        }
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

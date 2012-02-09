/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package mcvc.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.text.StyledEditorKit;
import mcvc.util.publisherProperties;

/**
 *
 * @author Camilo-Rivera
 */
public class PublisherProperties extends HttpServlet {

    /**
     * Processes requests for both HTTP
     * <code>GET</code> and
     * <code>POST</code> methods.
     *
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
            String todo = request.getParameter("todo");
            if(todo.equals("set")){
                publisherProperties pp = new publisherProperties();
                boolean video = true;
                boolean audio = true;
                String videostr = request.getParameter("video");
                String audiostr = request.getParameter("audio");
                if(videostr.equals("false")){
                    video = false;
                }
                if(audiostr.equals("false")){
                    audio = false;
                }
                String sessionid = request.getParameter("sessionId");
                pp.setAudio(audio);
                pp.setVideo(video);
                pp.setSessionid(sessionid);
                ArrayList<publisherProperties> publisher = (ArrayList<publisherProperties>)request.getServletContext().getAttribute("publisher");
                publisher.add(pp); 
                request.getServletContext().setAttribute("publisher", publisher);
                
            }
        } finally {            
            out.close();
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP
     * <code>GET</code> method.
     *
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
     * Handles the HTTP
     * <code>POST</code> method.
     *
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
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}

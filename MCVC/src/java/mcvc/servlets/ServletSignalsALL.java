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
import mcvc.util.SIGNALS;

/**
 *
 * @author Camilo-Rivera
 */
public class ServletSignalsALL extends HttpServlet {

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
            String sessionId = request.getParameter("sessionId");
            String sender = request.getParameter("sender");
            String reciver = request.getParameter("reciver");
            int type = Integer.valueOf(request.getParameter("type"));
            String tab = request.getParameter("tab");
            String text = request.getParameter("text");
            String reciver_arr[] = reciver.split(";");
            ArrayList<SIGNALS>signals_arr = (ArrayList<SIGNALS>)request.getServletContext().getAttribute(sessionId);
            for(int i=0;i<reciver_arr.length;i++){
            SIGNALS signal = new SIGNALS();
            signal.setEstatus(true);
            signal.setReciber(reciver_arr[i]);
            signal.setSender(sender);
            signal.setType(type);
            signal.setText(text);
            signal.setTab(tab);           
            signals_arr.add(signal);
            }
            request.getServletContext().setAttribute(sessionId,signals_arr);
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

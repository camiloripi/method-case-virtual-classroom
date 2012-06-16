/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package mcvc.servlets;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.Type;
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
public class ServletSiganlR extends HttpServlet {

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
            String reciver = request.getParameter("reciver");
            ArrayList<SIGNALS> signals_arr = (ArrayList<SIGNALS>) request.getServletContext().getAttribute(sessionId);
            ArrayList<SIGNALS> toreturn = new ArrayList<SIGNALS>();
            for (int i = 0; i < signals_arr.size(); i++) {
                if(signals_arr.get(i).getType()==101){
                    SIGNALS sig = signals_arr.get(i);
                    toreturn.add(sig);  
                }else{
                if (signals_arr.get(i).isEstatus() && signals_arr.get(i).getReciber().equals(reciver)) {
                    SIGNALS sig = signals_arr.get(i);
                    sig.setEstatus(false);
                    toreturn.add(sig);
                    signals_arr.set(i, sig);

                }
                }
            }
            request.getServletContext().setAttribute(sessionId, signals_arr);
            Gson gson = new Gson();
            Type listType = new TypeToken<ArrayList<SIGNALS>>() {
            }.getType();
            out.print(gson.toJson(toreturn, listType));
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

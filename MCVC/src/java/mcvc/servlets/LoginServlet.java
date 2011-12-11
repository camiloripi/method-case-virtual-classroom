/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package mcvc.servlets;

import java.io.IOException; //Esta
import java.io.PrintWriter;

import javax.servlet.ServletException; //Esta
import javax.servlet.http.HttpServlet; //Esta
import javax.servlet.http.HttpServletRequest; //Esta
import javax.servlet.http.HttpServletResponse; //Esta

import mcvc.hibernate.clases.TblUsuarios;
import mcvc.util.Sqlquery;

/**
 *
 * @author Eliazar Melendez
 */
public class LoginServlet extends HttpServlet {

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

            String usr = request.getParameter("user");
            String pass = request.getParameter("password");
            Sqlquery sqlquery = new Sqlquery();
            sqlquery.setcurrentSession();
            TblUsuarios user = sqlquery.getUserinfo(usr);
            if (user != null) {
                if (user.getUsrPassword().equals(pass)) {
                    request.getSession().setAttribute("usuario", usr);
                    sqlquery.closeSession();
                    response.sendRedirect("Home.jsp");
                } else {
                    sqlquery.closeSession();
                    response.sendRedirect("LoginFail.jsp");
                }
            } else {
                sqlquery.closeSession();
                response.sendRedirect("LoginFail.jsp");
            }




        } finally {
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

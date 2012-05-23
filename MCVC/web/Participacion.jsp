<%-- 
    Document   : Participacion
    Created on : 05-20-2012, 02:42:23 PM
    Author     : Camilo-Rivera
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="mcvc.hibernate.clases.TblEstudiantesxclase"%>
<%@page import="mcvc.util.Sqlquery"%>
<%@page import="java.util.List" %>
<%Sqlquery face = new Sqlquery();%>
<%face.setcurrentSession();%>
<%Integer cls_id = face.getiD(request.getParameter("token"));    %>
<%List<TblEstudiantesxclase> lista = face.getTablaNotas(cls_id); %>

<% %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="shortcut icon" href="http://www.unitec.edu/wp-content/themes/unitec/unitec.ico" type="image/x-icon">
        <%if (session.getAttribute("usuario") == null) {
                response.sendRedirect("index.jsp");
            }%>
        <link rel="stylesheet" type="text/css" href="CSS/home.css">
        <title>MCVC</title>
    </head>
    <body>        
        <div class="box home">
            <fieldset class="boxBody">
                
                <table border="15">
                    <tr>
                        <th> Nombre </th>
                        <th> Nota </th>
                        <th> Participaciones </th>
                    </tr>                       
                <% for(int i=0; i<lista.size(); i++)
                    {  %>    
                    <tr>
                        <td> 
                            <%=lista.get(i).getTblUsuarios().getUsrNombres()%>
                        </td>
                        
                        <td>
                            <%=lista.get(i).getExcNota()%>
                        </td>
                        
                        <td>
                            <%=lista.get(i).getExcCantParticipaciones()%>
                        </td>
                    </tr>
                <%  }%>    
                </table>
            </fieldset> 
            <footer>
                <a href="Home.jsp" class="btnLogin" style="color: #000">Ir a Home</a>
            </footer>
</html>

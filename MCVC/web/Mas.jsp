<%-- 
    Document   : Mas
    Created on : 05-20-2012, 02:30:37 PM
    Author     : Camilo-Rivera
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
     <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%if (session.getAttribute("usuario") == null) {
                        response.sendRedirect("index.jsp");
                    }%>
        <%@include file="WEB-INF/jspf/CS_CSS_JS.jspf" %>
    </head>
    <body>
        <div class="box login">
            <fieldset class="boxBody">
                <label><a style="color: #000"href="TokenPage.jsp?token=<%=request.getParameter("token")%>&nombre=<%=request.getParameter("nombre")%>">Ver Token</a></label>
                <label><a style="color: #000"href="Participacion.jsp?token=<%=request.getParameter("token")%>">Ver Participacion</a></label><br/><br/><br/><br/><br/><br/><br/>
        
            </fieldset>
            <footer>
                <a href="Home.jsp" class="btnLogin" style="color: #000">Ir a Home</a>
            </footer>
            
        </div>
    </body>
</html>

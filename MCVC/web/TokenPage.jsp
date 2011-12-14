<%-- 
    Document   : TokenPage
    Created on : Dec 11, 2011, 12:24:16 PM
    Author     : camilo
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
                <label>Token Generado para la Clase: <%=request.getParameter("nombre")%></label>
                <label><%=request.getParameter("token")%></label><br/><br/><br/><br/><br/>
            </fieldset>
            <footer>
                <a href="Home.jsp" class="btnLogin" style="color: #000">Ir a Home</a>
            </footer>
            
        </div>
    </body>
</html>

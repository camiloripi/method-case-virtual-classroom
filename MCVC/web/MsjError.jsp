<%-- 
    Document   : MsjError
    Created on : Dec 14, 2011, 10:48:33 AM
    Author     : camilo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="WEB-INF/jspf/CS_CSS_JS.jspf" %>
    </head>
    <body>
        <form class="box login" action="LoginServlet" method="post">
            <fieldset class="boxBody" style="height: 155px;">
                <label>Ha Ocurrido Un Error:</label>
                <label><%=request.getParameter("msj")%></label>
                
                <%String topage= request.getParameter("topage");%>
                <%String text= request.getParameter("text");%>
            </fieldset>
            <footer>
                <label><a href="<%=topage%>.jsp" class="btnLogin" style="text-decoration: none;color: #000;">Go to <%=text%></a></label>
                              
            </footer>
        </form>
        
    </body>
</html>

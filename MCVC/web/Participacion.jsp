<%-- 
    Document   : Participacion
    Created on : 05-20-2012, 02:42:23 PM
    Author     : Camilo-Rivera
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
            </fieldset> 
            <footer>
                <a href="Home.jsp" class="btnLogin" style="color: #000">Ir a Home</a>
            </footer>
</html>

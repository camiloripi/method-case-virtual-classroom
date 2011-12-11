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
        
        <link rel="shortcut icon" href="http://www.unitec.edu/wp-content/themes/unitec/unitec.ico" type="image/x-icon">
        <link rel="stylesheet" type="text/css" href="CSS/reset.css">
        <link rel="stylesheet" type="text/css" href="CSS/structure.css"></link>
        <title>MCVC</title>
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

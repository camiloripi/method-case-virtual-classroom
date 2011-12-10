<%-- 
    Document   : Login
    Created on : 11-29-2011, 01:04:49 PM
    Author     : Eliazar Melendez
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="shortcut icon" href="http://www.unitec.edu/wp-content/themes/unitec/unitec.ico" type="image/x-icon">
        <link rel="stylesheet" type="text/css" href="CSS/reset.css">
        <link rel="stylesheet" type="text/css" href="CSS/structure.css">
        <title>MCVC</title>
    </head>
    <body>
        <form class="box login" action="LoginServlet" method="post">
	<fieldset class="boxBody">
	  <label>Email</label>
	  <input type="text" tabindex="1" placeholder="ejemplo@gmail.com" required name="user" id="user"/>
	  <label>Contraseña</label>
	  <input type="password" tabindex="2" required name="password" id="password"/>
	</fieldset>
	<footer>
	  <label><a href="Registrar.jsp">Registrar</a></label>
	  <input type="submit" class="btnLogin" value="Login" tabindex="4">
	</footer>
</form>
        
       

    </body>
</html>

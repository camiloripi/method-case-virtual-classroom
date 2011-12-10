<%-- 
    Document   : Registrar
    Created on : Dec 9, 2011, 12:02:24 PM
    Author     : camilo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>MCVC</title>
    </head>
    <body>
        <form action="RegistrarServlets" method="post">
            <label>Email</label>
            <input type="email" name="email" id="email"/><br/>
            <label>Nombre</label>
            <input type="text" name="nombre" id="nombre"/><br/>
            <label>Primer Apellido</label>
            <input type="text" name="1apellido" id="1apellido"/><br/>
            <label>Segundo Apellido</label>
            <input type="text" name="2apellido" id="2apellido"/><br/>
            <label>Celular</label>
            <input type="text" name="celular" id="celular"/><br/>
            <label>Telefono</label>
            <input type="text" name="telefono" id="telefono"/><br/>
            <label>Contraseña</label>
            <input type="password" name="pass" id="pass"/><br/>
            <input type="submit" name="submit" id="submit"></input>
            
        </form>
    </body>
</html>

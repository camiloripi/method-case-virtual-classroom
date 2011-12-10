<%-- 
    Document   : CrearClase
    Created on : 19-nov-2011, 15:26:49
    Author     : Camilo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Crear Clase</h1>
<FORM action="Servlet_Home_1" method="post">
<table>
        <tr>
	<td>Nombre de la Sesión:</td>
	<td><input type="text" value="" name="txt_sesion" /><td>
        </tr>
        <tr>
	<td>Fecha Sesión:</td>
	<td><input type="date" value="" name="txt_fecha"/><td>
        </tr>
        <tr>
	<td>Hora Sesión:</td>
	<td><input type="time" value="" name="txt_hora"/><td>
        </tr>
        <tr>
	<td>Cupo:</td>
	<td><input type="text" value="" name="txt_cupo"/><td>
      </tr>
</table>
  <input type="submit" name="btn_crear" value="Crear" /><br />
    </FORM>

    </body>
</html>

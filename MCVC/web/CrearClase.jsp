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
        <%if (session.getAttribute("usuario") == null) {
                response.sendRedirect("index.jsp");
            }%>
        <%@include file="WEB-INF/jspf/CS_CSS_JS.jspf" %>
    </head>
    <body>

        <FORM action="Servlet_Home_1" method="POST" class="box crearclase">

            <fieldset class="boxBody">

                <table>
                    <tr>

                        <td>
                            <label>Nombre de la Sesión:</label>
                            <input type="text"  name="txt_sesion" required />
                        <td>
                    </tr>
                    <tr>

                        <td>
                            <label>Fecha Sesión:</label>
                            <input type="date"  name="txt_fecha" id="txt_fecha" required/>
                        <td>
                    </tr>
                    <tr>
                        <td>
                            <label>Hora Sesión:</label>
                            <input type="time"  name="txt_hora" id="txt_hora" required/>
                        <td>
                    </tr>
                    <tr>
                        <td>
                            <label>Cupo:</label>
                            <input type="number"  name="txt_cupo" required/>
                        <td>
                    </tr>
                </table>  
            </fieldset>
            <footer>
                <input type="submit" name="btn_crear" value="Crear" class="btnnormal" />  
            </footer>

        </FORM>

    </body>
</html>

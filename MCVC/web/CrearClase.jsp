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
        <link rel="shortcut icon" href="http://www.unitec.edu/wp-content/themes/unitec/unitec.ico" type="image/x-icon">
        <link rel="stylesheet" type="text/css" href="CSS/reset.css">
        <link rel="stylesheet" type="text/css" href="CSS/structure.css"></link>

        <title>MCVC</title>
    </head>
    <body>
        
        <FORM action="Servlet_Home_1" method="POST" class="box crearclase">
          
            <fieldset class="boxBody">
                
              <table>
                <tr>
                 
                    <td>
                    <label>Nombre de la Sesión:</label>
                    <input type="text" value="" name="txt_sesion" required />
                    <td>
                </tr>
                <tr>
                    
                    <td>
                    <label>Fecha Sesión:</label>
                    <input type="date" value="" name="txt_fecha" requiredS/>
                    <td>
                </tr>
                <tr>
                    <td>
                    <label>Hora Sesión:</label>
                    <input type="time" value="" name="txt_hora" required/>
                    <td>
                </tr>
                <tr>
                    <td>
                    <label>Cupo:</label>
                    <input type="text" value="" name="txt_cupo" required/>
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

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
        <link rel="shortcut icon" href="http://www.unitec.edu/wp-content/themes/unitec/unitec.ico" type="image/x-icon">
        <link rel="stylesheet" type="text/css" href="CSS/reset.css">
        <link rel="stylesheet" type="text/css" href="CSS/structure.css">
        <title>MCVC</title>
    </head>
    <body>
        <form class="box registrar" action="RegistrarServlet" method="POST">
            <fieldset class="boxBody">
                <table>
                    <tr>
                        <td>
                            <label>Email</label>
                            <input type="text" tabindex="1" placeholder="ejemplo@gmail.com" required name="email" id="email"/> 
                        </td>
                        <td style="padding-left: 10px;">
                            <label>Celular</label>
                            <input type="text" name="celular" id="celular" required/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label>Nombre</label>
                            <input type="text" name="nombre" id="nombre" required/>
                        </td> 
                        <td style="padding-left: 10px;">
                            <label>Telefono</label>
                            <input type="text" name="telefono" id="telefono" required/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label>Primer Apellido</label>
                            <input type="text" name="1apellido" id="1apellido" required/> 
                        </td>
                        <td style="padding-left: 10px;">
                            <label>Contraseña</label>
                            <input type="password" tabindex="2" required name="password" id="password" required/>

                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label>Segundo Apellido</label>
                            <input type="text" name="2apellido" id="2apellido" required/>
                        </td>
                    </tr>

                </table>

            </fieldset>
            <footer>
                <input type="submit" class="btnLogin" value="Guardar" tabindex="4">
            </footer>
        </form>


    </body>
</html>

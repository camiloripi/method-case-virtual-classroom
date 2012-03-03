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
        <%@include file="WEB-INF/jspf/CS_CSS_JS.jspf" %>
    </head>
    <body>
        <form class="box registrar" action="RegistrarServlets" method="POST">
            <fieldset class="boxBody">
                <table>
                    <tr>
                        <td>
                            <label>Email</label>
                            <input type="email" tabindex="1" placeholder="ejemplo@gmail.com" required name="email" id="email"/> 
                        </td>
                        <td style="padding-left: 10px;">
                            <label>Celular</label>
                            <input type="number" name="celular" tabindex="2" id="celular" required/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label>Nombre</label>
                            <input type="text" name="nombre" tabindex="3" id="nombre" required/>
                        </td> 
                        <td style="padding-left: 10px;">
                            <label>Telefono</label>
                            <input type="number" name="telefono" tabindex="4" id="telefono" required/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label>Primer Apellido</label>
                            <input type="text" name="1apellido" tabindex="5" id="1apellido" required/> 
                        </td>
                        <td style="padding-left: 10px;">
                            <label>Contraseña</label>
                            <input type="password" tabindex="6" required name="pass" id="pass" required/>

                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label>Segundo Apellido</label>
                            <input type="text" name="2apellido" tabindex="7" id="2apellido" required/>
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

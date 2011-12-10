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
        <title>Login</title>
    </head>
    <body>
        <form action="LoginServlet" method="post">
            <div style="padding-left: 35%; padding-right: 35%; padding-top: 75px">
                <table style="border: ridge">
                    <tr>
                        <td colspan="2" style="text-align: center; background-color: coral; color: white">
                            Login
                        </td> 
                    </tr>
                    <tr>
                        <td>
                            Usuario:
                        </td>
                        <td>
                            <input type="text" name="user" id="user" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Contraseña:
                        </td>
                        <td>
                            <input type="password" name="password" id="password"/>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right" colspan="2">
                            <input type="submit" value="Login" id="btEnviar"/>
                        </td>
                    </tr>
                </table>
            </div>
        </form>
        
        <a href="Registrar.jsp">Registrar</a>
            
    </body>
</html>

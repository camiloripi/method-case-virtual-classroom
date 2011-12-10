<%-- 
    Document   : Home
    Created on : 19-nov-2011, 15:16:37
    Author     : Camilo & Jaime
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="face" scope="application" class="mcvc.util.Sqlquery"/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        Bienvenido <% out.print(request.getSession().getAttribute("usuario"));%>
        <table border="1">
            <tr>
                <td><a href="CrearClase.jsp">CREAR CLASE</a></td>
                <td>OPCION PARA REGISTRAR TOKEN</td>
            </tr>
            <tr>
                <td>Mis Sessiones como Maestro</td>
                <td>Mis Sessiones como Alumno</td>
            </tr>
            <tr><td>

                    <%face.setMaestroClases((String) request.getSession().getAttribute("usuario"));%>
                    <%if (face.getSession()!=null){for (int i = 0; i < face.getTblsession().size(); i++) {%>
                    <a href="Clase.jsp?token=<%=face.getTblsession().get(i).getClsToken()%>">
                        <label><%=face.getTblsession().get(i).getClsNombre()%> - <%=face.getTblsession().get(i).getClsId()%></label></a><br></br>
                        <%}}%>
                </td>



                <td>
                    <%face.setEstudianteClases((String) request.getSession().getAttribute("usuario"));%>

                    <% if (face.getTblestudiantesxclase() == null) {
                            out.print("ES NULL");
                        } else {
                            out.print("El size es: " + face.getTblestudiantesxclase().size());
                        }%>
                </td>
            </tr>
        </table>

    </body>
</html>

<%-- 
    Document   : Home
    Created on : 19-nov-2011, 15:16:37
    Author     : Camilo & Jaime
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="face" scope="page" class="mcvc.util.Sqlquery"/>
  <%face.setcurrentSession();%>
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
                <td>XXX


                    <FORM action="RegistrarToken_Servlet" method="post">
                        <table>
                            <tr>
                                <td>Token:</td>
                                <td><input type="text" value="" name="txt_token" /><td>
                                <td> <input type="submit" name="btn_registrar" value="Registrar Token" /></td>    
                            </tr>
                        </table>
                        <br />
                    </FORM>


                    OPCION PARA REGISTRAR TOKEN


                    XXX

                </td>
            </tr>
            <tr>
                <td>Mis Sessiones como Maestro</td>
                <td>Mis Sessiones como Alumno</td>
            </tr>
            <tr><td>
                    <table border="1" >
                        <tr>
                            <td>Nombre de la Sesion</td>
                            <td>Fecha</td>
                            <td>Status</td>
                        </tr>
                        <tr>
                            <%face.setMaestroClases((String) request.getSession().getAttribute("usuario"));%>
                            <%if (face.getSession() != null) {
                                    for (int i = 0; i < face.getTblsession().size(); i++) {
                            %><td><a href="Clase.jsp?token=<%=face.getTblsession().get(i).getClsToken()%>">
                                    <%=face.getTblsession().get(i).getClsNombre()%></a></td>
                            <td><% out.print(face.getTblsession().get(i).getClsFechaSession());%></td>
                            <td>
                                <%if (face.getTblsession().get(i).getClsStatus() == 1) {%>
                                Inactiva       
                                <%}%>
                                <%if (face.getTblsession().get(i).getClsStatus() == 2) {%>
                                Activa      
                                <%}%>
                                <%if (face.getTblsession().get(i).getClsStatus() == 3) {%>
                                En Proceso       
                                <%}%>
                                <%if (face.getTblsession().get(i).getClsStatus() == 4) {%>
                                Terminada       
                                <%}%>
                            </td>
                        </tr>
                        <%
                                }
                            }%>


                    </table>






                <td>

                    <table border="1" >
                        <tr>
                            <td>Nombre de la Sesion</td>
                            <td>Fecha</td>
                            <td>Status</td>
                        </tr>



                        <%face.setEstudianteClases((String) request.getSession().getAttribute("usuario"));%>
                        <% if (face.getTblestudiantesxclase() == null) {
                                out.print("ES NULL");
                            } else {
                        %>
                        <tr>
                            <%for (int i = 0; i < face.getTblestudiantesxclase().size(); i++) {%>
                            <td>
                                <%if (face.getTblestudiantesxclase().get(i).getTblSession().getClsStatus() == 1 || face.getTblestudiantesxclase().get(i).getTblSession().getClsStatus() == 4) {%>
                                <label><% out.print(face.getTblestudiantesxclase().get(i).getTblSession().getClsNombre());%></label>
                                <%}else{%>
                                <a href="Clase.jsp?token=<% out.print(face.getTblestudiantesxclase().get(i).getTblSession().getClsToken());%>"> <% out.print(face.getTblestudiantesxclase().get(i).getTblSession().getClsNombre());%></a>
                                <%}%>
                            </td>
                            <td>
                                <%out.print(face.getTblestudiantesxclase().get(i).getTblSession().getClsFechaSession());%>
                            </td>
                            <td>
                                <%if (face.getTblestudiantesxclase().get(i).getTblSession().getClsStatus() == 1) {%>
                                Inactiva       
                                <%}%>
                                <%if (face.getTblestudiantesxclase().get(i).getTblSession().getClsStatus() == 2) {%>
                                Activa      
                                <%}%>
                                <%if (face.getTblestudiantesxclase().get(i).getTblSession().getClsStatus() == 3) {%>
                                En Proceso       
                                <%}%>
                                <%if (face.getTblestudiantesxclase().get(i).getTblSession().getClsStatus() == 4) {%>
                                Terminada       
                                <%}%>

                            </td>
                        </tr><%}}%>

                    </table>


                </td>
            </tr>
        </table>

    </body>
</html>

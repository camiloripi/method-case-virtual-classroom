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
        <link rel="shortcut icon" href="http://www.unitec.edu/wp-content/themes/unitec/unitec.ico" type="image/x-icon">
        <link rel="stylesheet" type="text/css" href="CSS/reset.css">
        <link rel="stylesheet" type="text/css" href="CSS/structure.css"></link>
        <title>MCVC</title>
    </head>
    <body>
        <div class="box home">

            <fieldset class="boxBody">
                <table style="width: 100%">
                    <thead>
                    <th>
                        <label>Mis Sessiones como Maestro</lable>
                    </th>
                    <th>
                        <label>Mis Sessiones como Alumno</lable>
                    </th>
                    </thead>
                    <tbody>
                    <td>
                        <div style="width: 100%; height: 300px; overflow: auto;">
                            <table style="width: 100%;">
                                <tr>
                                    <td>
                                        <label>Nombre de la Sesion</label> 
                                    </td>
                                    <td>
                                        <label>Fecha</label>
                                    </td>
                                    <td>
                                        <label>Estatus</label>
                                    </td>
                                </tr>
                                <%face.setMaestroClases((String) request.getSession().getAttribute("usuario"));%>
                                <%if (face.getSession() != null) {
                                        for (int i = 0; i < face.getTblsession().size(); i++) {
                                %><tr class="trh"><td><label><a style="color: #000;"href="Clase.jsp?token=<%=face.getTblsession().get(i).getClsToken()%>"><%=face.getTblsession().get(i).getClsNombre()%></a></td></label>

                                    <td><label><% out.print(face.getTblsession().get(i).getClsFechaSession());%></label></td>
                                    <td>
                                        <%if (face.getTblsession().get(i).getClsStatus() == 1) {%>
                                        <label>Inactiva</label>       
                                        <%}%>
                                        <%if (face.getTblsession().get(i).getClsStatus() == 2) {%>
                                        <label>Activa </label>     
                                        <%}%>
                                        <%if (face.getTblsession().get(i).getClsStatus() == 3) {%>
                                        <label>En Proceso</label>       
                                        <%}%>
                                        <%if (face.getTblsession().get(i).getClsStatus() == 4) {%>
                                        <label>Terminada</label>     
                                        <%}%>
                                    </td>
                                </tr>
                                <%
                                        }
                                    }%>


                            </table>   
                        </div>

                    </td>
                    <td style="padding-left: 10px;">
                        <form action="RegistrarToken_Servlet" method="POST">
                          <label>Token:</label>
                        <table >
                            <tr>
                                <td>
                                  <input type="text" value="" name="txt_token" />  
                                </td>
                                <td><input style="margin-top: 5px;" type="submit" name="btn_registrar" value="Registrar Token" class="btnnormal" /></td>
                            </tr>
                        </table>  
                        </form>
                        
                        <div style="width: 100%; height: 220px; overflow: auto;">
                            <table style="width: 100%" >
                                <tr>
                                    <td><label>Nombre de la Sesion</label></td>
                                    <td><label>Fecha</label></td>
                                    <td><label>Estatus</label></td>
                                </tr>



                                <%face.setEstudianteClases((String) request.getSession().getAttribute("usuario"));%>
                                <% if (face.getTblestudiantesxclase() == null) {
                                        out.print("ES NULL");
                                    } else {
                                %>

                                <%for (int i = 0; i < face.getTblestudiantesxclase().size(); i++) {%>
                                <tr class="trh"><td >
                                        <%if (face.getTblestudiantesxclase().get(i).getTblSession().getClsStatus() == 1 || face.getTblestudiantesxclase().get(i).getTblSession().getClsStatus() == 4) {%>
                                        <label><% out.print(face.getTblestudiantesxclase().get(i).getTblSession().getClsNombre());%></label>
                                        <%} else {%>
                                        <label><a style="color: #000;" href="Clase.jsp?token=<% out.print(face.getTblestudiantesxclase().get(i).getTblSession().getClsToken());%>"> <% out.print(face.getTblestudiantesxclase().get(i).getTblSession().getClsNombre());%></a></label>
                                        <%}%>
                                    </td>
                                    <td>
                                        <label><%out.print(face.getTblestudiantesxclase().get(i).getTblSession().getClsFechaSession());%></label> 
                                    </td>
                                    <td>
                                        <%if (face.getTblestudiantesxclase().get(i).getTblSession().getClsStatus() == 1) {%>
                                        <label>Inactiva</label>      
                                        <%}%>
                                        <%if (face.getTblestudiantesxclase().get(i).getTblSession().getClsStatus() == 2) {%>
                                        <label>Activa</label>    
                                        <%}%>
                                        <%if (face.getTblestudiantesxclase().get(i).getTblSession().getClsStatus() == 3) {%>
                                        <label>En Proceso</label>       
                                        <%}%>
                                        <%if (face.getTblestudiantesxclase().get(i).getTblSession().getClsStatus() == 4) {%>
                                        <label>Terminada</label>       
                                        <%}%>

                                    </td>
                                </tr><%}
                                    }%>

                            </table>
                                    
                        </div>
                           
                        
                    </td>

                    </tbody>
                </table>

            </fieldset> 
                                    <footer style="padding-top: 12px !important;">
                <table>
                    <tr>
                        <td style="padding-top: 10px;">
                          <a href="CrearClase.jsp" class="btnnormal" style="color: #000;text-decoration: none">CREAR CLASE</a>  
                        </td>
                        <td>
                            <label style="color: #fff; margin-left: 20px;font-size: 30px;">Bienvenido <% out.print(request.getSession().getAttribute("usuario"));%></label>
                        </td>
                    </tr>
                </table>
              
            </footer>

        </table>


    </div>

    <%face.closeSession();%>
</body>
</html>

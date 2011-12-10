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
        
        <table border="1">
            <tr>
                <td><a href="CrearClase.jsp">CREAR CLASE</a></td>
                <td>Mis Sessiones como Alumno</td>
            </tr>
            <tr>
                <td>Mis Sessiones como Maestro</td>
                <td>Mis Sessiones como Alumno</td>
            </tr>
            <tr><td>
                
                <%face.setMaestroClases((String) request.getSession().getAttribute("usuario"));%>
        <%for (int i = 0; i < face.getTblsession().size(); i++) {%>
        <a href="LinkCamilo.jsp?token=<%=face.getTblsession().get(i).getClsToken()%>&usuario=<%=request.getSession().getAttribute("usuario")%>">
        <label><%=face.getTblsession().get(i).getClsNombre()%> - <%=face.getTblsession().get(i).getClsId()%></label></a><br></br>        <%}%>
                row 2, cell 1</td>
                <td>row 2, cell 2</td>
            </tr>
        </table>
        
    </body>
</html>

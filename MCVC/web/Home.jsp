<%-- 
    Document   : Home
    Created on : 19-nov-2011, 15:16:37
    Author     : Camilo
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
        <%face.setMaestroClases((String)request.getSession().getAttribute("usuario"));%>
        <%for(int i=0; i< face.getTblsession().size();i++){%>
        <label><%=face.getTblsession().get(i).getClsNombre()%></label><br/>
        <label><%=face.getTblsession().get(i).getClsId()%></label><br/><br/>
        <%}%>
    </body>
</html>

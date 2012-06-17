<%-- 
    Document   : excel
    Created on : Jun 17, 2012, 4:49:16 PM
    Author     : siwady
--%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"

    pageEncoding="ISO-8859-1"%>
<%@page import="mcvc.hibernate.clases.TblEstudiantesxclase"%>
<%@page import="mcvc.util.Sqlquery"%>
<%@page import="java.util.List" %>
<%Sqlquery face = new Sqlquery();%>
<%face.setcurrentSession();%>
<%Integer cls_id = face.getiD(request.getParameter("token"));    %>
<%List<TblEstudiantesxclase> lista = face.getTablaNotas(cls_id); %>

<%
    response.setContentType ("application/xls"); 
    response.setHeader ("Content-Disposition", "attachment;filename=\"participaciones.xls\"");
%>



        <table style="margin: 0 auto" width="100%">
                    <tr>
                        <th style="border:#000 solid 1px; margin: 0 auto "> Nombre              </th>
                        <th style="border:#000 solid 1px; margin: 0 auto"> Nota                </th>
                        <th style="border:#000 solid 1px; margin: 0 auto"> Participaciones     </th>
                    </tr>                       
                <% for(int i=0; i<lista.size(); i++)
                    {  %>    
                    <tr>
                        <td style="border:#000 solid 1px; margin: 0 auto"> 
                            <%=lista.get(i).getTblUsuarios().getUsrNombres() + " " + lista.get(i).getTblUsuarios().getUsrPrimerApellido() %>
                            </td>
                        
                        <td style="border:#000 solid 1px; margin: 0 auto">
                            <%=lista.get(i).getExcNota()%> 
                        </td>
                        
                        <td style="border:#000 solid 1px; margin: 0 auto">
                            <%=lista.get(i).getExcCantParticipaciones()%>
                        </td>
                    </tr>
                <%  }%>    
                </table>
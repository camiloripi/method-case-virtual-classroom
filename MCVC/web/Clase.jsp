<%-- 
    Document   : Clase
    Created on : 19-nov-2011, 15:27:21
    Author     : Camilo
--%>

<%@page import="mcvc.hibernate.clases.TblSession"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="face" scope="page" class="mcvc.util.Sqlquery"/>
<jsp:useBean id="tokbox" scope="page" class="mcvc.face.select.face_tokbox"/>
<%face.setcurrentSession();%>
<%boolean ismaestro = face.isMaestro((String) request.getSession().getAttribute("usuario"), request.getParameter("token"));%>
<%String sessionId = face.getSessionId(request.getParameter("token"));%>
<%TblSession tblsession = face.getTblsession().get(0);%>
<%int cupos = tblsession.getClsCupo();%>
<%int n = 1;%>

<%while ((n * n) < cupos) {%>
<%n++;
    }%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%if (session.getAttribute("usuario") == null) {
                response.sendRedirect("index.jsp");
            }%>
        <%@include file="WEB-INF/jspf/CS_CSS_JS.jspf" %>
        <script src="http://staging.tokbox.com/v0.91/js/TB.min.js" type="text/javascript" charset="utf-8"></script>       
        <script type="text/javascript" charset="utf-8">
            var session = TB.initSession("<%=sessionId%>"); // Sample session ID. 
            var publisher;
            session.addEventListener("sessionConnected", sessionConnectedHandler);
            session.addEventListener("streamCreated", streamCreatedHandler);
            session.addEventListener("streamDestroyed", streamDestroyedHandler);
            session.addEventListener("connectionCreated", connectionCreatedHandler);
            // OpenTok sample API key and sample token string. 
            $(document).ready(function() {
                $("#disconnectLink").hide();
                $("#pubControls").hide();
            });
            
            function connect(){
                token ="";
            <%if (ismaestro) {%>
                    token = "<%=tokbox.generateToKenMaestro(sessionId)%>";        
            <%} else {%>
                    token="<%=tokbox.generateToKenAlumno(sessionId)%>";
            <%}%>
                    session.connect(6642061, token);
                    
                }
            
                function disconnect(){
                    session.disconnect();
            <%if (ismaestro) {%>
                    changeStatus(4);
            <%}%>
                
                }
             
                function startPublishing(){
                    if (!publisher) {              
                        var containerDiv = document.createElement('div');
                        containerDiv.className = "subscriberContainer";
                        containerDiv.setAttribute('id', 'opentok_publisher');
                        var videoPanel = document.getElementById("maestro_div");
                        videoPanel.appendChild(containerDiv);
                        var publisherDiv = document.createElement('div'); // Create a div for the publisher to replace
                        publisherDiv.setAttribute('id', 'replacement_div')
                        containerDiv.appendChild(publisherDiv);
            
                        var publisherProperties = new Object();
                        if (document.getElementById("pubAudioOnly").checked) {
                            publisherProperties.publishVideo = false;
                        }
                        if (document.getElementById("pubVideoOnly").checked) {
                            publisherProperties.publishAudio = false;
                        }
                        
                        publisherProperties.width=200;
                        publisherProperties.height=200;
                        publisher= session.publish(publisherDiv.id, publisherProperties);
                        changeStatus(3);
                        $("#pubControls").hide();
                    } 
                }
                        
                function sessionConnectedHandler(event) {              
                    subscribeToStreams(event.streams);
                    $("#disconnectLink").show();
                    $("#connectLink").hide();
            <%if (ismaestro) {%>
                    $("#pubControls").show();
                    changeStatus(2);
            <%}%>
                
                
                }
			
                function streamCreatedHandler(event) {
                    subscribeToStreams(event.streams);
                }
                
                function streamDestroyedHandler(event) {
                    var publisherContainer = document.getElementById("opentok_publisher");
                    var videoPanel = document.getElementById("videoPanel");
                    for (i = 0; i < event.streams.length; i++) {
                        var stream = event.streams[i];
                        if (stream.connection.connectionId == session.connection.connectionId) {
                            videoPanel.removeChild(publisherContainer);
                        } else {
                            var streamContainerDiv = document.getElementById("streamContainer" + stream.streamId);
                            if(streamContainerDiv) {
                                videoPanel = document.getElementById("videoPanel")
                                videoPanel.removeChild(streamContainerDiv);
                            }
                        }
                    }
            <%if (!ismaestro) {%>
                    window.location.replace("Home.jsp");
            <%}%>
                    
                }
                
			
                function subscribeToStreams(streams) {
                    for (i = 0; i < streams.length; i++) {
                        var stream = streams[i];
                        if (stream.connection.connectionId != session.connection.connectionId) {
                            var containerDiv = document.createElement('div'); // Create a container for the subscriber and its controls
                            containerDiv.className = "subscriberContainer";
                            var divId = stream.streamId;    // Give the div the id of the stream as its id
                            containerDiv.setAttribute('id', 'streamContainer' + divId);
                            var videoPanel = document.getElementById("alumno_div");
                            videoPanel.appendChild(containerDiv);

                            var subscriberDiv = document.createElement('div'); // Create a replacement div for the subscriber
                            subscriberDiv.setAttribute('id', divId);
                            containerDiv.appendChild(subscriberDiv);
                            session.subscribe(stream, divId);
                        }
                    }
                }
                
                function changeStatus(status)
                {
                    var xmlhttp;
                    if (window.XMLHttpRequest)
                    {// code for IE7+, Firefox, Chrome, Opera, Safari
                        xmlhttp=new XMLHttpRequest();
                    }
                    else
                    {// code for IE6, IE5
                        xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
                    }
                    xmlhttp.onreadystatechange=function()
                    {
                        if (xmlhttp.readyState==4 && xmlhttp.status==200)
                        {
                            switch(status){
                                case 2 : alert("Se cambio el status a: Activa");
                                    break;
                                case 3 : alert("Se cambio el status a: En Proceso");
                                    break;
                                case 4 : alert("Se cambio el status a: Terminada");
                                    window.location.replace("Home.jsp");
                                    break;
                                    
                            }
                            
                            
                           
                        }
                    }
                    xmlhttp.open("POST","ChangeStatusServlet",true);
                    xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
                    xmlhttp.send("token=<%=request.getParameter("token")%>&status="+status);
                }
                
                function connectionCreatedHandler(event) {
                      <%if (ismaestro) {%> 
                         var row = $("#row").val();
                         var col = $("#col").val();
                         $("#alu_"+row+"_"+col).attr("style","background-color: #000");
                         var n = $("#n").val();
                         col++;
                         if(col >= n-1){
                             $("#col").val(0);
                             $("#row").val(row + 1);
                         }else{
                            $("#col").val(col); 
                         }
                         
                      <%}%>
                   
                   
                }
            
            
            
        </script>

    </head>
    <body>

        <div class="box clase">

            <fieldset class="boxBodyclase">
                <div id="videoPanel">
                    <table style="width: 400px;height: 200px">
                        <tr>
                            <td style="width: 50%">
                                <div id="maestro_div">

                                </div> 
                            </td>
                            <td style="width: 50%">
                                <div id="alumno_div">

                                </div>
                            </td>
                        </tr>
                        <tr>
                        <table style="width: 200px;height: 200px" >
                            <%for (int i = 0; i < n; i++) {%>
                            <tr>
                                <%for (int j = 0; j < n; j++) {%>
                                <td style="border: 1px solid #000" id="alu_<%=String.valueOf(i)+"_"+String.valueOf(j)%>"></td>
                                <%}%>

                            </tr>
                            <%}%>
                        </table>

                        </tr>
                    </table>


                </div> 
            </fieldset>
            <footer >
                <table>
                    <tr>
                        <td>
                            <div id="sessionControls">
                                <input type="button" class="btnnormal" value="Connect" id ="connectLink" onClick="connect()" />
                                <input type="button" class="btnnormal" value="Leave" id ="disconnectLink" onClick="disconnect()" />
                            </div> 
                        </td>
                        <td>
                            <div id ="pubControls">
                                <form id="publishForm"> 
                                    <input type="button" class="btnnormal" value="Start Publishing" onClick="startPublishing()" />
                                    <input type="radio" id="pubAV" name="pubRad" checked="checked" />&nbsp;Audio/Video&nbsp;&nbsp; 
                                    <input type="radio" id="pubAudioOnly" name="pubRad" />&nbsp;Audio-only&nbsp;&nbsp;
                                    <input type="radio" id="pubVideoOnly" name="pubRad" />&nbsp;Video-only
                                </form>
                            </div>
                        </td>
                    </tr>

                </table>



            </footer>



        </div>

                        <input type="hidden" id="row" value="0"/>
                        <input type="hidden" id="col" value="0"/>
                        <input type="hidden" id="n" value="<%=n%>"/>
    </body>
</html>

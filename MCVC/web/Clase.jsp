<%-- 
    Document   : Clase
    Created on : 19-nov-2011, 15:27:21
    Author     : Camilo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="face" scope="page" class="mcvc.util.Sqlquery"/>
<jsp:useBean id="tokbox" scope="page" class="mcvc.face.select.face_tokbox"/>
<%face.setcurrentSession();%>
<%boolean ismaestro = face.isMaestro((String) request.getSession().getAttribute("usuario"), request.getParameter("token"));%>
<%String sessionId = face.getSessionId(request.getParameter("token"));%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="shortcut icon" href="http://www.unitec.edu/wp-content/themes/unitec/unitec.ico" type="image/x-icon">
        <title>MCVC</title>
        <link rel="stylesheet" type="text/css" href="CSS/reset.css">
        <link rel="stylesheet" type="text/css" href="CSS/structure.css">
        <script src="http://staging.tokbox.com/v0.91/js/TB.min.js" type="text/javascript" charset="utf-8"></script>
        <script type="text/javascript" charset="utf-8">
            var session = TB.initSession("<%=sessionId%>"); // Sample session ID. 
			
            session.addEventListener("sessionConnected", sessionConnectedHandler);
            session.addEventListener("streamCreated", streamCreatedHandler);
            // OpenTok sample API key and sample token string. 
            function connect(){
                session.connect(6642061, "<%=tokbox.generateToKenMaestro(sessionId)%>");   
            }
                        
                        
            function sessionConnectedHandler(event) {
                subscribeToStreams(event.streams);
                var containerDiv = document.createElement('div');
                containerDiv.className = "subscriberContainer";
                containerDiv.setAttribute('id', 'opentok_publisher');
                containerDiv.style.float = "left";
                var videoPanel = document.getElementById("videoPanel");
                videoPanel.appendChild(containerDiv);
                var publisherDiv = document.createElement('div'); // Create a div for the publisher to replace
                        publisherDiv.setAttribute('id', 'replacement_div')
                        containerDiv.appendChild(publisherDiv);
                session.publish(publisherDiv.id);
            }
			
            function streamCreatedHandler(event) {
                subscribeToStreams(event.streams);
            }
			
            function subscribeToStreams(streams) {
                for (i = 0; i < streams.length; i++) {
                    var stream = streams[i];
                    if (stream.connection.connectionId != session.connection.connectionId) {
                        session.subscribe(stream);
                    }
                }
            }
            
            
            
        </script>

    </head>
    <body>

        <div class="box clase">

            <fieldset class="boxBodyclase">
                <div id="videoPanel" style="display:block"></div> 
            </fieldset>
            <footer style="height: 102px !important;">
                <div id="sessionControls">
                    <input type="button" class="btnnormal" value="Connect" id ="connectLink" onClick="connect()" style="display:block" />
                    <input type="button" class="btnnormal" value="Leave" id ="disconnectLink" onClick="disconnect()" style="display:none" />
                </div>

                <div id ="pubControls" style="display:none">
                    <form id="publishForm"> 
                        <input type="button" class="btnnormal" value="Start Publishing" onClick="startPublishing()" />
                        <input type="radio" id="pubAV" name="pubRad" checked="checked" />&nbsp;Audio/Video&nbsp;&nbsp; 
                        <input type="radio" id="pubAudioOnly" name="pubRad" />&nbsp;Audio-only&nbsp;&nbsp;
                        <input type="radio" id="pubVideoOnly" name="pubRad" />&nbsp;Video-only
                    </form>
                </div>
                <div id ="unpubControls" style="display:none">
                    <input type="button" class="btnnormal" value="Stop Publishing" onClick="stopPublishing()" style="display:block"/>
                </div>
            </footer>



        </div>


    </body>
</html>

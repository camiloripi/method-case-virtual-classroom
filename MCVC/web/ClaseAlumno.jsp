<%-- 
    Document   : ClaseAlumno
    Created on : 06-05-2012, 03:14:38 PM
    Author     : Camilo-Rivera
--%>
<%@page import="mcvc.face.select.face_tokbox"%>
<%@page import="mcvc.util.Sqlquery"%>
<%@page import="java.util.ArrayList"%>
<%@page import="mcvc.util.SIGNALS"%>
<%@page import="mcvc.hibernate.clases.TblUsuarios"%>
<%@page import="mcvc.hibernate.clases.TblSession"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%if (request.getParameter("token") != null && session.getAttribute("usuario") != null) {
        Sqlquery face = new Sqlquery();
        face_tokbox tokbox = new face_tokbox();
        face.setcurrentSession();
        try {
            String sessionId = face.getSessionId(request.getParameter("token"));
            TblSession tblsession = face.getTblsession().get(0);
            TblUsuarios tblUsuarios = face.getUserinfo((String) session.getAttribute("usuario"));
            String maestro = tblsession.getClsMaestro();
            int cls_ID = tblsession.getClsId();

%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%if (session.getAttribute("usuario") == null) {
                response.sendRedirect("index.jsp");
            }%>

        <title>MCVC</title>
        <link rel="shortcut icon" href="http://www.unitec.edu/wp-content/themes/unitec/unitec.ico" type="image/x-icon">
        <link rel="stylesheet" type="text/css" href="CSS/reset.css">
        <link rel="stylesheet" type="text/css" href="CSS/structure.css">
        <link type="text/css" href="CSS/jquery-ui-1.8.18.custom.css" rel="stylesheet">
        <script type="text/javascript" src="JS/jquery-1.7.1.js"></script>
        <script type="text/javascript" src="JS/jquery-ui-1.8.18.custom.min.js"></script>
        <!--<script src="http://static.opentok.com/v0.91/js/TB.min.js" type="text/javascript" charset="utf-8"></script>*/-->

        <script type="text/javascript">
            $(document).ready(function() {
                hideAllMessages();
                $("#disconnectLink").hide();
                $("#aluControls").hide();
                $("body").width($("body").width());
            });
            $(function() {
                tab_counter = 2;
                $( "#tabs").tabs({
                    add: function( event, ui ) {
                        $( ui.panel ).append(" <p class='piz'></p>");                                
                    },
                    show: function(event, ui) { 
                        var tab = $(ui.panel).attr("id");
                        var tabl = "#tab"+tab.substring(5, tab.length);
                        var class_ = $(tabl).attr("class");
                        class_=class_.replace("uptab", "");
                        $(tabl).attr("class",class_);                                
                    }
                });
                    
                    
            });
                
            function addTab() {
                if(tab_counter<20){
                    $( "#tabs").tabs( "option", "tabTemplate", "<li id='tab"+tab_counter+"'><a href='#tabs-"+tab_counter+"'><label class='tabinput'>"+tab_counter+"</label></a></li>" );
                    $( "#tabs").tabs( "add", "#tabs-" + tab_counter,tab_counter );            
                    $("#tabs-" + tab_counter).attr("style","height: 80%" );
                         
                      
                    tab_counter++;
                }
                       
            }
            function hideAllMessages()
            {
                $('.infofrommaster').css('top', -$('.infofrommaster').outerHeight()); 
                        
            }
            
            function closemessagesfrommaster(){
                $('.infofrommaster').css('top', -$('.infofrommaster').outerHeight());
            }
        </script>
    </head>
    <body>
        <div id="clasemain">
            <fieldset class="boxBodyclase">
                <table style="width: 100%;height: 100%">
                    <tr>
                        <td>
                            <table style="width: 100%;height: 100%">
                                <tr>
                                    <td style="width: 220px;" >
                                        <table style="height: 100%;width: 220px;">
                                            <tr>
                                                <td style="width: 220px;height: 280px; position: relative">
                                                    <div id="videoPanel">
                                                        <table style="width: 220px;height: 280px" >
                                                            <tr>
                                                                <td style="width: 220px;/*border: 1px solid #000*/">
                                                                    <div id="maestro_div">

                                                                    </div> 
                                                                </td>

                                                            </tr>
                                                            <tr>
                                                                <td style="width: 120px;/*border: 1px solid #000*/">
                                                                    <div id="alumno_div">

                                                                    </div>
                                                                </td>
                                                            </tr>

                                                        </table>
                                                    </div>  
                                                </td>
                                            </tr>
                                        </table>

                                    </td>
                                    <td style="height: 100%">
                                        <div style="height: 100%;margin:10px 5px 5px 5px">
                                            <div id="tabs"style="height: 95%">
                                                <ul>
                                                    <li id="tab1"><a href="#tabs-1"><label value="1" class="tabinput">1</label> </a></li>                                                
                                                </ul>
                                                <div id="tabs-1" style="height: 80%">
                                                    <p class="piz"></p>

                                                </div>

                                            </div>
                                    </td>
                                </tr>
                            </table>  
                        </td>
                    </tr>
                </table>
            </fieldset>
            <footer >
                <table style="height: 100%;">
                    <tr>
                        <td style="vertical-align:middle;">
                            <div id="sessionControls">
                                <input type="button" class="btnnormal2" value="Connect" id ="connectLink" onClick="connect()" />
                                <input type="button" class="btnnormal2" value="Leave" id ="disconnectLink" onClick="disconnect()" />
                            </div> 
                        </td>
                        <td style="vertical-align:middle;">
                            <div id="aluControls">
                                <input type="button" class="btnnormal2" value="Levantar Mano" id ="levantar_mano" onClick="LevantarMano()" />
                                <input type="button" class="btnnormal2" value="Dejar de Hablar" id ="dejar_de_hablar" onClick="BajarMano()" />
                            </div>
                        </td>
                    </tr>

                </table>
            </footer>
        </div>

        <div class="infofrommaster message">
            <h3 id="messagefrommaster">Send A Message to the Student</h3>
            <button  class="btnnormal2" onclick="closemessagesfrommaster()">OK</button>

        </div>                               
    </body>
    <script type="text/javascript" src ="http://static.opentok.com/v0.91/js/TB.min.js"></script>
    <script type="text/javascript">
        var sessionId = "<%=sessionId%>";
        var token;
        var session;
        var publisher;
        var alumno_talking = false;
        
        TB.addEventListener("exception", exceptionHandler);

        if (TB.checkSystemRequirements() != TB.HAS_REQUIREMENTS) {
            alert("You don't have the minimum requirements to run this application."
                + "Please upgrade to the latest version of Flash.");
        } else {
            session = TB.initSession(sessionId);
            session.addEventListener("sessionConnected", sessionConnectedHandler);
            session.addEventListener("streamCreated", streamCreatedHandler);
            session.addEventListener("streamDestroyed", streamDestroyedHandler);
            session.addEventListener("connectionCreated", connectionCreatedHandler);
            session.addEventListener("sessionDisconnected", sessionDisConnectedHandler);
            session.addEventListener("connectionDestroyed", connectionDestroyedHandler);
            session.addEventListener("signalReceived", signalHandler);
        }  
        function exceptionHandler(event) {
            alert("Exception: " + event.code + "::" + event.message);
        } 
        
        function connect(){
            token="<%=tokbox.generateToKenAlumno(sessionId, tblUsuarios)%>";
            session.connect(6642061, token);
        }
               
        function disconnect(){
            session.disconnect();                      
        }
        
        function startPublishing(){
            if (!publisher) {   
                $.ajax({
                    type: "POST",
                    url: "PublisherProperties",
                    data: "sessionId=<%=sessionId%>&todo=get",
                    dataType: "json",
                    success: function(data){
                        if(data!=null){
                            var containerDiv = document.createElement('div');
                            containerDiv.className = "subscriberContainer";
                            containerDiv.setAttribute('id', 'opentok_publisher');  
                            var videoPanel = document.getElementById("alumno_div");   
                            videoPanel.appendChild(containerDiv);
                            var publisherDiv = document.createElement('div');
                            publisherDiv.setAttribute('id', 'replacement_div')
                            containerDiv.appendChild(publisherDiv);
                            var publisherProperties = new Object();
                            var properties = typeof data != 'object' ? JSON.parse(data) : data;    
                            publisherProperties.publishVideo = properties.video;
                            publisherProperties.publishAudio = properties.audio;
                            publisherProperties.width=220;
                            publisherProperties.height=140;
                            alert("antes del publish");
                            $("#pubControls").hide();
                            $("#dejar_de_hablar").show();
                            $("#levantar_mano").hide();
                            publisher = session.publish(publisherDiv.id, publisherProperties);
                            alert("despues del publish");
                        }
                    }
                });
                        
                        
                        
            } 
        }
               
        function sessionConnectedHandler(event) {
            subscribeToStreams(event.streams);
            $("#disconnectLink").show();
            $("#connectLink").hide();
            $("#aluControls").show();
            $("#dejar_de_hablar").hide();
            $.ajax({
                type: "POST",
                url: "ServletBoard",
                data: "CLSID=<%=cls_ID%>",
                dataType: "json",
                success: function(data){
                    if(data!=null){
                        var señales = typeof data != 'object' ? JSON.parse(data) : data;
                        for(var i=0;i<señales.length;i++){
                            if(i!=0){
                                addTab();
                            } 
                        }
                        for(var i=0;i<señales.length;i++){
                            var texto = señales[i].text;
                            
                            var name = señales[i].name;
                            $(señales[i].Tabid).html(texto);
                            var t = señales[i].Tabid
                            var tab = "#tab"+t.substring(6, t.length-5);
                            $(tab+" .tabinput").html(name);
                        }
                    }
                }
            });
        }
        
        function streamCreatedHandler(event) {
            subscribeToStreams(event.streams);
        }
        
        function streamDestroyedHandler(event) {
                   
                    
            for (i = 0; i < event.streams.length; i++) {
                var stream = event.streams[i];
                if (stream.connection.connectionId == session.connection.connectionId) {
                    var publisherContainer = document.getElementById("opentok_publisher");
                    var videoPanel = document.getElementById("alumno_div");
                    videoPanel.removeChild(publisherContainer);
                    publisher =null;
                } else {
                            
                    var streamContainerDiv = document.getElementById("streamContainer" + stream.streamId);
                    if(streamContainerDiv) {
                        var videoPanel= document.getElementById("alumno_div");
                        var email = stream.connection.data;
                        email = email.split(",");
                        email = email[0];
                        if(email =='<%=maestro%>' ){
                            videoPanel = document.getElementById("maestro_div"); 
                        }
                        videoPanel.removeChild(streamContainerDiv);
                    }
                          
            
                }
            }
                    
        }
            
        function subscribeToStreams(streams) {
                    
            for (i = 0; i < streams.length; i++) {
                        
                var stream = streams[i];
                if (stream.connection.connectionId != session.connection.connectionId) {
                    var email = stream.connection.data;
                    email = email.split(",");
                    email = email[0];
                    var containerDiv = document.createElement('div');
                    containerDiv.className = "subscriberContainer";
                    var divId = stream.streamId;
                    containerDiv.setAttribute('id', 'streamContainer' + divId);
                    var videoPanel = "";
                    if(email=="<%=maestro%>"){
                        videoPanel = document.getElementById("maestro_div");                               
                    }else{ 
                        videoPanel = document.getElementById("alumno_div");      
                    }                        
                    videoPanel.appendChild(containerDiv);
                    var publisherProperties = new Object();
                    publisherProperties.width=220;
                    publisherProperties.height=140;
                    var subscriberDiv = document.createElement('div');
                    subscriberDiv.setAttribute('id', divId);
                    containerDiv.appendChild(subscriberDiv);
                    session.subscribe(stream, divId,publisherProperties);
                            
                }
            }
                  
        }
                
        function getConnectionData(connection) {
			
            var connectionData = connection.data.split(',')
                        
            return connectionData;
        }
                
        function sessionDisConnectedHandler(event) { 
              
            window.location.replace("Home.jsp");
        }
                
        function connectionDestroyedHandler(event) {
                 
            var arr = event.connections[0].data.split(",", 1);
            if(arr == "<%=maestro%>"){
                session.disconnect();
            }

        }
        
        function LevantarMano(){
            $.ajax({
                type: "POST",
                url: "ServletSignals",
                data: "sessionId=<%=sessionId%>&sender=<%=tblUsuarios.getUsrEmail()%>&reciver=<%=maestro%>&type=1",
                success: function(){
                    session.signal();
                    $("#levantar_mano").hide();
                }
            });
                
        }
                
        function signalHandler(event) {
            if(event.fromConnection.connectionId != session.connection.connectionId){
                $.ajax({
                    type: "POST",
                    url: "ServletSiganlR",
                    data: "sessionId=<%=sessionId%>&reciver=<%=tblUsuarios.getUsrEmail()%>",
                    dataType: "json",
                    success: function(data){
                        if(data!=null){
                            var señales = typeof data != 'object' ? JSON.parse(data) : data;
                            for(var i=0;i<señales.length;i++){
                                        
                                if(señales[i].reciber == "<%=tblUsuarios.getUsrEmail()%>"){
                                    if(señales[i].type == 2){
                                        $("#dejar_de_hablar").show();
                                        $("#levantar_mano").hide();
                                        startPublishing();
                                    }
                                    if(señales[i].type == 3){
                                        if(publisher!=null){
                                            session.unpublish(publisher); 
                                            publisher = null;
                                            $("#opentok_publisher").remove();
                                            
                                        }
                                    }
                                    if(señales[i].type == 4){
                                        var id = fintd(señales[i].sender);
                                        parar(id);
                                    }
                                    if(señales[i].type == 5){
                                        $("#dejar_de_hablar").hide();
                                        $("#levantar_mano").show();
                                                
                                    }
                                    if(señales[i].type==6){
                                        
                                        var texto = señales[i].text.split("/$/");
                                        var textopiz = "";
                                        for(var l = 1;l<texto.length;l++){
                                            textopiz += texto[l];
                                        }
                                        $(señales[i].tab).html(textopiz);
                                        var t = señales[i].tab
                                        var tab = "#tab"+t.substring(6, t.length-5);
                                        $(tab+" .tabinput").html(texto[0]);
                                        var class_ = $(tab).attr("class") + " uptab";
                                        $(tab).attr("class",class_);
                                                
                                    }
                                    if(señales[i].type==7){            
                                        addTab();
                                    }
                                    if(señales[i].type==8){
                                        $("#messagefrommaster").html(señales[i].text);
                                        $('.infofrommaster').animate({top:"0"}, 500);
                                    }
                                }
                                   
                            }
                        }  
                    }
                });
            }
        }
        
        function BajarMano(){
            $.ajax({
                type: "POST",
                url: "ServletSignals",
                data: "sessionId=<%=sessionId%>&sender=<%=tblUsuarios.getUsrEmail()%>&reciver=<%=maestro%>&type=4",
                success: function(){
                    session.signal();
                    $("#dejar_de_hablar").hide();
                    $("#levantar_mano").show();
                }
            });
                   
        }
                
        function connectionCreatedHandler(event) {

        }
    </script>
</html>
<%} finally {%>
<%face.closeSession();%>
<%}
    } else {

        response.sendRedirect("index.jsp");

    }%>
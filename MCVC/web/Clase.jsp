<%-- 
    Document   : Clase
    Created on : 19-nov-2011, 15:27:21
    Author     : Camilo
--%>

<%@page import="mcvc.face.select.face_tokbox"%>
<%@page import="mcvc.util.Sqlquery"%>
<%@page import="java.util.ArrayList"%>
<%@page import="mcvc.util.SIGNALS"%>
<%@page import="mcvc.hibernate.clases.TblUsuarios"%>
<%@page import="mcvc.hibernate.clases.TblSession"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%if (request.getParameter("token") != null) {%>
<%Sqlquery face = new Sqlquery();%>
<%face_tokbox tokbox = new face_tokbox();%>
<%face.setcurrentSession();%>
<%try {%>
<%boolean ismaestro = face.isMaestro((String) session.getAttribute("usuario"), request.getParameter("token"));%>

<%String sessionId = face.getSessionId(request.getParameter("token"));%>
<%TblSession tblsession = face.getTblsession().get(0);%>
<%TblUsuarios tblUsuarios = face.getUserinfo((String) session.getAttribute("usuario"));%>
<%String maestro = tblsession.getClsMaestro();%>
<%int cls_ID = tblsession.getClsId();%>
<%int cupos = tblsession.getClsCupo();%>


<%int n = 1;%>

<%while ((n * n) < cupos) {%>
<%n++;
    }%>

<%if (ismaestro) {%>
<%ArrayList<SIGNALS> signals_arr = new ArrayList<SIGNALS>();%>
<%getServletContext().setAttribute(sessionId, signals_arr);%>
<%}%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%if (session.getAttribute("usuario") == null) {
                response.sendRedirect("index.jsp");
            }%>
        <%@include file="WEB-INF/jspf/CS_CSS_JS.jspf" %>
        <script src="http://static.opentok.com/v0.91/js/TB.min.js" type="text/javascript" charset="utf-8"></script>       
        <style>
            .message
            {
                -webkit-background-size: 40px 40px;
                -moz-background-size: 40px 40px;
                background-size: 40px 40px;			
                background-image: -webkit-gradient(linear, left top, right bottom,
                    color-stop(.25, rgba(255, 255, 255, .05)), color-stop(.25, transparent),
                    color-stop(.5, transparent), color-stop(.5, rgba(255, 255, 255, .05)),
                    color-stop(.75, rgba(255, 255, 255, .05)), color-stop(.75, transparent),
                    to(transparent));
                background-image: -webkit-linear-gradient(135deg, rgba(255, 255, 255, .05) 25%, transparent 25%,
                    transparent 50%, rgba(255, 255, 255, .05) 50%, rgba(255, 255, 255, .05) 75%,
                    transparent 75%, transparent);
                background-image: -moz-linear-gradient(135deg, rgba(255, 255, 255, .05) 25%, transparent 25%,
                    transparent 50%, rgba(255, 255, 255, .05) 50%, rgba(255, 255, 255, .05) 75%,
                    transparent 75%, transparent);
                background-image: -ms-linear-gradient(135deg, rgba(255, 255, 255, .05) 25%, transparent 25%,
                    transparent 50%, rgba(255, 255, 255, .05) 50%, rgba(255, 255, 255, .05) 75%,
                    transparent 75%, transparent);
                background-image: -o-linear-gradient(135deg, rgba(255, 255, 255, .05) 25%, transparent 25%,
                    transparent 50%, rgba(255, 255, 255, .05) 50%, rgba(255, 255, 255, .05) 75%,
                    transparent 75%, transparent);
                background-image: linear-gradient(135deg, rgba(255, 255, 255, .05) 25%, transparent 25%,
                    transparent 50%, rgba(255, 255, 255, .05) 50%, rgba(255, 255, 255, .05) 75%,
                    transparent 75%, transparent);

                -moz-box-shadow: inset 0 -1px 0 rgba(255,255,255,.4);
                -webkit-box-shadow: inset 0 -1px 0 rgba(255,255,255,.4);		
                box-shadow: inset 0 -1px 0 rgba(255,255,255,.4);
                width: 225px;
                border: 1px solid;
                color: #fff;
                padding: 15px;
                position: fixed;
                left: 75%;
                _position: absolute;
                text-shadow: 0 1px 0 rgba(0,0,0,.5);
                -webkit-animation: animate-bg 5s linear infinite;
                -moz-animation: animate-bg 5s linear infinite;
            }

            .info
            {
                background-color: #4ea5cd;
                border-color: #3b8eb5;
            }
            .infofrommaster
            {
                background-color: #4ea5cd;
                border-color: #3b8eb5;
            }

            .error
            {
                background-color: #de4343;
                border-color: #c43d3d;
            }

            .warning
            {
                background-color: #eaaf51;
                border-color: #d99a36;
            }

            .success
            {
                background-color: #61b832;
                border-color: #55a12c;
            }

            .message h3
            {
                margin: 0 0 5px 0;													 
            }

            .message p
            {
                margin: 0;													 
            }

            .tabinput{
                border: 1px solid 
                    #000000 !important;
                -webkit-border-radius: 3px !important;
                -moz-border-radius: 3px !important;
                border-radius: 3px !important;
                -moz-box-shadow: 2px 3px 3px rgba(0, 0, 0, 0.06) inset, 0 0 1px #fff inset !important;
                -webkit-box-shadow: 2px 3px 3px 
                    rgba(0, 0, 0, 0.06) inset, 0 0 1px 
                    #fff inset !important;
                box-shadow: 2px 3px 3px 
                    rgba(0, 0, 0, 0.06) inset, 0 0 1px 
                    #fff inset !important;
                margin: 0 !important;
                padding: 0 !important;
                width: 100px !important;
                text-align: center;
            }
        </style>
        <script type="text/javascript" charset="utf-8">

            var GlobalTabs = 0;
            var session = TB.initSession("<%=sessionId%>"); // Sample session ID. 
            var publisher;
            var ocup_alumno = false;
            var ocup_maestro = false;
            var editor;
            var gopuplish = true;
            var permitir = true;
            session.addEventListener("sessionConnected", sessionConnectedHandler);
            session.addEventListener("streamCreated", streamCreatedHandler);
            session.addEventListener("streamDestroyed", streamDestroyedHandler);
            session.addEventListener("connectionCreated", connectionCreatedHandler);
            session.addEventListener("sessionDisconnected", sessionDisConnectedHandler);
            session.addEventListener("connectionDestroyed", connectionDestroyedHandler);
            session.addEventListener("signalReceived", signalHandler);
            window.onbeforeunload = function() { 
            <%if (ismaestro) {%>
                    changeStatus(4);
            <%}%>
                };
                $(document).ready(function() {
                    // Initially, hide them all
                    hideAllMessages();
		 
		 
                    // When message is clicked, hide it
                    $('.messageclose').click(function(){			  
                        // $(this).animate({top: -$(this).outerHeight()}, 500);
                    });
                
                    $(".star").hide();
                    $("#disconnectLink").hide();
                    $("#save_class").hide();
                    $("#pubControls").hide();
                    $("#aluControls").hide();
                    $(".permitir_hablar").hide();
                    $(".parar_hablar").hide();
                    $(".warm_call").hide();
                    $(".cold_call").hide();
                    $(".stu").width($(".stu").width());
                    $("body").width($("body").width());
                    $("#clasemain").width($("#clasemain").width());
            <%if (ismaestro) {%>
                    editor=$(".piz").cleditor({width:"99%", height:"100%"});
            <%}%>
                
                
                });
            
                function connect(){
              
                
                    token ="";
            <%if (ismaestro) {%>
                    token ="<%=tokbox.generateToKenMaestro(sessionId, tblUsuarios)%>";        
            <%} else {%>
                    token="<%=tokbox.generateToKenAlumno(sessionId, tblUsuarios)%>";
            <%}%>
              
                    session.connect(6642061, token);
                    //refreshtab('#tabs-1 .piz');
                }
            
                function disconnect(){
                    session.disconnect();                      
                }
             
                function startPublishing(){
                    if (!publisher) {   
                        
                       
                        var containerDiv = document.createElement('div');
                        containerDiv.className = "subscriberContainer";
                        containerDiv.setAttribute('id', 'opentok_publisher');
            <%if (ismaestro) {%>
                        var videoPanel = document.getElementById("maestro_div");       
            <%} else {%>   
                        var videoPanel = document.getElementById("alumno_div");   
            <%}%>
                          
                        
                        videoPanel.appendChild(containerDiv);
                        var publisherDiv = document.createElement('div'); // Create a div for the publisher to replace
                        publisherDiv.setAttribute('id', 'replacement_div')
                        containerDiv.appendChild(publisherDiv);
            
                        var publisherProperties = new Object();
                        
            <%if (ismaestro) {%>
                        if (document.getElementById("pubAudioOnly").checked) {
                            publisherProperties.publishVideo = false;
                        }
                        if (document.getElementById("pubVideoOnly").checked) {
                            publisherProperties.publishAudio = false;
                        }
                        $.ajax({
                            type: "POST",
                            url: "PublisherProperties",
                            data: "sessionId=<%=sessionId%>&video="+publisherProperties.publishVideo+"&audio="+publisherProperties.publishAudio+"&todo=set",
                            success: function(){
                                publisherProperties.width=220;
                                publisherProperties.height=140;
                                
                                publisher = session.publish(publisherDiv.id, publisherProperties);
                                
                            }
                        });       
            <%} else {%>
                        $.ajax({
                            type: "POST",
                            url: "PublisherProperties",
                            data: "sessionId=<%=sessionId%>&todo=get",
                            dataType: "json",
                            success: function(data){
                                if(data!=null){
                                    var properties = typeof data != 'object' ? JSON.parse(data) : data;
                                    
                                    publisherProperties.publishVideo = properties.video;
                                    publisherProperties.publishAudio = properties.audio;
                                    publisherProperties.width=220;
                                    publisherProperties.height=140;
                                  
                                    if(gopuplish){
                                        publisher = session.publish(publisherDiv.id, publisherProperties);
                                    }
                                }
                            }
                        });
            <%}%>
                        
                        
                        $("#pubControls").hide();
            <%if (!ismaestro) {%>
                        $("#dejar_de_hablar").show();
                        $("#levantar_mano").hide();
            <%} else {%>
                        changeStatus(3);
            <%}%>
                    } 
                }
                        
                function sessionConnectedHandler(event) {
                    subscribeToStreams(event.streams);
                    $("#disconnectLink").show();
                    $("#connectLink").hide();
            <%if (ismaestro) {%>
                    $("#pubControls").show();
                    changeStatus(2);
            <%} else {%>
                    $("#aluControls").show();
                    $("#dejar_de_hablar").hide();
            <%}%>
                   
                
                }
			
                function streamCreatedHandler(event) {
                    subscribeToStreams(event.streams);
                }
                
                function streamDestroyedHandler(event) {
                   
                    var publisherContainer = document.getElementById("opentok_publisher");
                    var videoPanel = document.getElementById("alumno_div");
            <%if (ismaestro) {%>
                    videoPanel = document.getElementById("maestro_div");     
            <% }%>
                    for (i = 0; i < event.streams.length; i++) {
                        var stream = event.streams[i];
                        if (stream.connection.connectionId == session.connection.connectionId) {
                            videoPanel.removeChild(publisherContainer);
                            publisher =null;ocup_maestro =false;
                        } else {
                            
                            var streamContainerDiv = document.getElementById("streamContainer" + stream.streamId);
                            if(streamContainerDiv) {
            <%if (ismaestro) {%>
                                videoPanel = document.getElementById("alumno_div");     
            <% } else {%>
                                var email = stream.connection.data;
                                email = email.split(",");
                                email = email[0];
                                if(email =='<%=maestro%>' ){
                                    videoPanel = document.getElementById("maestro_div"); 
                                }
                                     
            <%}%>
                                videoPanel.removeChild(streamContainerDiv);
                                ocup_alumno = false;
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
                            var containerDiv = document.createElement('div'); // Create a container for the subscriber and its controls
                            containerDiv.className = "subscriberContainer";
                            var divId = stream.streamId;    // Give the div the id of the stream as its id
                            containerDiv.setAttribute('id', 'streamContainer' + divId);
                            var videoPanel = null;
                            if(email=="<%=maestro%>"){
                                videoPanel = document.getElementById("maestro_div");
                                
                            }else{ 
                                videoPanel = document.getElementById("alumno_div");  
                                 
                            }
                            
                            videoPanel.appendChild(containerDiv);
                            var publisherProperties = new Object();
                            publisherProperties.width=220;
                            publisherProperties.height=140;
                            var subscriberDiv = document.createElement('div'); // Create a replacement div for the subscriber
                            subscriberDiv.setAttribute('id', divId);
                            containerDiv.appendChild(subscriberDiv);
                            session.subscribe(stream, divId,publisherProperties);
                            var id = findtd_id(stream.connection.connectionId);
                            $(id+" .parar_hablar").show();
                            
                        }
                    }
                  
                }
                
                function changeStatus(status)
                {
                    $.ajax({
                        type: "POST",
                        url: "ChangeStatusServlet",
                        data: "token=<%=request.getParameter("token")%>&status="+status,
                        success: function(){
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
                    });
                }
                
                function connectionCreatedHandler(event) {
            <%if (ismaestro) {%>
                    $("#save_class").show();
                    var foundit = false;
                    for(var j=0;j<event.connections.length;j++){
                        var connectiondata = getConnectionData(event.connections[j]);
                        for(var a=0;a < 3;a++){
                            for(var s=0;s < 7;s++){
                                if($("#alu_"+a+"_"+s+" .email").val()== connectiondata[0] && foundit == false){
                                    
                                    $("#alu_"+a+"_"+s+" .connectionid").val(event.connections[j].connectionId); 
                                    $("#alu_"+a+"_"+s+" .CONNECT").val("SI"); 
                                    $("#alu_"+a+"_"+s).attr("class","backW stu");
                                    if(permitir){
                                        $("#alu_"+a+"_"+s+" .warm_call").attr("onclick", "WarmCall('#alu_"+a+"_"+s+"')");
                                        $("#alu_"+a+"_"+s+" .warm_call").show();
                                    }
                                    $("#alu_"+a+"_"+s+" .cold_call").attr("onclick", "ColdCall('#alu_"+a+"_"+s+"')");
                                    $("#alu_"+a+"_"+s+" .cold_call").show();
                                    
                                    $("#alu_"+a+"_"+s+" .star").attr("onclick", "SetGrade('#alu_"+a+"_"+s+"')");
                                    $("#alu_"+a+"_"+s+"  .star").show();
                                   
                                    foundit = true;
                                    //refreshtab('#tabs-1 .piz');
                                    break;
                                }
                            }
                            
                        }
                        
                        if(foundit==false){
                            for(var a=0;a < 3;a++){
                                for(var s=0;s < 7;s++){
                                    if($("#alu_"+a+"_"+s+" .email").val()== "" && foundit == false){
                                        $("#alu_"+a+"_"+s+" .connectionid").val(event.connections[j].connectionId);
                                        $("#alu_"+a+"_"+s+" .email").val(connectiondata[0]);
                                        $("#alu_"+a+"_"+s+" .username").text(connectiondata[1]);
                                        $("#alu_"+a+"_"+s+" .pa").text(" "+connectiondata[2][0]+".");
                                        $("#alu_"+a+"_"+s+" .sa").val(connectiondata[3]);
                                        $("#alu_"+a+"_"+s+" .telefono").val(connectiondata[4]);
                                        $("#alu_"+a+"_"+s+" .celular").val(connectiondata[5]);
                                        $("#alu_"+a+"_"+s+" .CONNECT").val("SI"); 
                                        $("#alu_"+a+"_"+s+" .count_participacion").text("0");
                                        if(permitir){
                                            $("#alu_"+a+"_"+s+" .warm_call").attr("onclick", "WarmCall('#alu_"+a+"_"+s+"')");
                                            $("#alu_"+a+"_"+s+" .warm_call").show();
                                        }
                                        $("#alu_"+a+"_"+s+" .cold_call").attr("onclick", "ColdCall('#alu_"+a+"_"+s+"')");
                                        $("#alu_"+a+"_"+s+" .cold_call").show();
                                        $("#alu_"+a+"_"+s+" .star").attr("onclick", "SetGrade('#alu_"+a+"_"+s+"')");
                                        $("#alu_"+a+"_"+s+"  .star").show();
                                        foundit = true;
                                        //refreshtab('#tabs-1 .piz');
                                        break;
                                    }
                                }
                            
                            } 
                            
                        }
                       
                        
                        
                    }
                    addtabS();
                    for(i=1; i<GlobalTabs; i++)
                    {
                        refreshtab("#tabs-"+ i + " .piz");
                    }
            <%}%>
                   
                   
                }
                          
                function getConnectionData(connection) {
			
                    var connectionData = connection.data.split(',')
                        
                    return connectionData;
                }
            
            
                function sessionDisConnectedHandler(event) { 
                
            <%if (ismaestro) {%>
                    changeStatus(4);
            <%} else {%>
                    window.location.replace("Home.jsp");
            <%}%>
                }
                
                function connectionDestroyedHandler(event) {
                    permitir = true;
            <%if (ismaestro) {%>
                   
                
                    var foundit = false;
                    for(var j=0;j<event.connections.length;j++){
                        
                        for (var a = 0 ; a < 3 ;a++){
                            for(var s = 0; s < 7; s++){
                                if(event.connections[j].connectionId==$("#alu_"+a+"_"+s+" .connectionid").val() && foundit == false){
                            
                                    $("#alu_"+a+"_"+s).attr("class","backR stu");
                                    $("#alu_"+a+"_"+s+"  .star").hide();
                                    $("#alu_"+a+"_"+s+ ".CONNECT").val("NO");
                                    foundit = true;
                            
                                }
                                
                            }
                            
                        }
              
                    }
            <%} else {%>
                    var arr = event.connections[0].data.split(",", 1);
                    if(arr == "<%=maestro%>"){
                        session.disconnect();
                    }
            <%}%>
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
                                            if(señales[i].type== 1){
                                                var id = fintd(señales[i].sender);
                                                if(id != ""){
                                                    if(permitir){
                                                        $(id+" .permitir_participar").val("SI")
                                                        $(id+ " .permitir_hablar").attr("onclick", "permitirhablar('"+id+"')");
                                                        $(id+" .permitir_hablar").show();
                                                        $(id+" .warm_call").hide();                                                       
                                                        $(id).attr("class","backG stu");
                                                    }
                                                }
                                       
                                            }
                                            if(señales[i].type == 2){
                                                $("#dejar_de_hablar").show();
                                                $("#levantar_mano").hide();
                                                gopuplish = true;
                                                startPublishing();
                                            }
                                            if(señales[i].type == 3){
                                                gopuplish = false;
                                                if(publisher!=0){
                                                    session.unpublish(publisher); 
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
                                                $(tab+" .tabinput ").val(texto[0]);
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
                
                function fintd(email){

                    var id = ""
                    
                    for(var i =0;i<3;i++){
                        for(var j=0;j<10;j++){
                            id = "#alu_"+i+"_"+j;
                            if( $(id+" .email").val() == email){
                                return id;
                            }
                        }
                    }
                    return "";
                }
                
                function findtd_id(connectionid){
               
                    var id = ""
                    
                    for(var i =0;i<3;i++){
                        for(var j=0;j<10;j++){
                            id = "#alu_"+i+"_"+j;
                            if( $(id+" .connectionid").val() == connectionid){
                                return id;
                            }
                        }
                    }
                    return "";
                    
                }

            
                function permitirhablar(id){
                    var email = $(id+" .email").val();
                    $.ajax({
                        type: "POST",
                        url: "ServletSignals",
                        data: "sessionId=<%=sessionId%>&sender=<%=tblUsuarios.getUsrEmail()%>&reciver="+email+"&type=2",
                        success: function(){
                            permitir = false;
                            $(".permitir_hablar").hide();
                            $(id+ " .parar_hablar").attr("onclick", "parar('"+id+"')");
                            
                            $(id+" .participando").val("SI");
                            $(id+" .permitir_participar").val("NO");
                            var count = $(id+" .count_participacion").text();
                            count ++;
                            $(id+" .count_participacion").text(count);
                            $(id).attr("class","backB stu");
              
                            for(var i =0;i<3;i++){
                                for(var j=0;j<10;j++){
                                    var id_ = "#alu_"+i+"_"+j;
                                    
                                    if(id_==id){
                                        $(id_+" .BLOCK").val("NO"); 
                                    }else{
                                        $(id_+" .BLOCK").val("SI");  
                                    }
                                }
                            }
                            session.signal();
                            
                        }
                    });  
                }
                
                function parar(id){
                    var email = $(id+" .email").val();
                    var grade = $("input[name='grade']:checked").val();
                    var studentgrades = $(id+ " .GRADE").val();
                    studentgrades += grade+",";
                    $(id+ " .GRADE").val(studentgrades);
                    $.ajax({
                        type: "POST",
                        url: "ServletSignals",
                        data: "sessionId=<%=sessionId%>&sender=<%=tblUsuarios.getUsrEmail()%>&reciver="+email+"&type=3",
                        success: function(){
                            permitir = true;
                            $(".permitir_hablar").hide();
                            $(".parar_hablar").attr("onclick", "");
                            $(".parar_hablar").hide();
                            for(var i =0;i<3;i++){
                                for(var j=0;j<10;j++){
                                    var id_ = "#alu_"+i+"_"+j;
                                    $(id_+" .BLOCK").val("NO");
                                    $(id_+" .permitir_participar").val("NO");
                                    $(id_+" .participando").val("NO");
                                    if( $(id_+" .CONNECT").val()=="SI"){
                                        $(id_+" .warm_call").show();
                                        $(id_).attr("class","backW stu"); 
                                        $.ajax({
                                            type: "POST",
                                            url: "ServletSignals",
                                            data: "sessionId=<%=sessionId%>&sender=<%=tblUsuarios.getUsrEmail()%>&reciver="+$(id_+" .email").val()+"&type=5"});
                                    }
                                    
                                    
                                }
                            }
                            session.signal();
                        }
                    });
                }
                
                function WarmCall(id){
                    $("#messageid").val($(id+" .email").val());
                    $('.info').animate({top:"0"}, 500);               
                }
                function ColdCall(id){
                    $(".cold_call").hide();
                    permitirhablar(id);
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
                $(function() {
                    tab_counter = 2;
                    GlobalTabs = tab_counter;
                    $( "#tabs").tabs({
                        add: function( event, ui ) {
                         
				
            <%if (ismaestro) {%>
                            $( ui.panel ).append( "<textarea class='piz'></textarea><input type=\"button\" class=\"btnnormal2\" value=\"Refresh\" onClick=\"refreshtab('#tabs-"+tab_counter+" .piz')\" style=\"margin-top: 5px;\" id=\"btabs-"+tab_counter+"\"/>" );
                            editor = $(".piz").cleditor({width:"99%", height:"100%"});
            <%} else {%>
                            $( ui.panel ).append(" <p class='piz'></p>");   
            <%}%>
                                
                                
                        },
                        show: function(event, ui) { 
                            var tab = $(ui.panel).attr("id");
            <%if (ismaestro) {%>
                            
                            tab = tab.substr(5, tab.length);
                            tab = tab -1;
                            editor[tab].focus();
                            editor[tab].refresh();   
            <%} else {%>
                            var tabl = "#tab"+tab.substring(5, tab.length);
                            var class_ = $(tabl).attr("class");
                            class_=class_.replace("uptab", "");
                            $(tabl).attr("class",class_);
            <%}%>
                        
                        }
                    });
                    
                    
                });
                
                function addTab() {
                    if(tab_counter<20){
                        $( "#tabs").tabs( "option", "tabTemplate", "<li id='tab"+tab_counter+"'><a href='#tabs-"+tab_counter+"'><input type='text' value='"+tab_counter+"' class='tabinput'/></a></li>" );
                        $( "#tabs").tabs( "add", "#tabs-" + tab_counter,tab_counter );
            <%if (ismaestro) {%>
                        var other = $("#addtab");
                        $("#tab"+tab_counter).after(other.clone());
                        other.after($("#tab"+tab_counter)).remove();
                        addtabS();
            <%}%>
                        $("#tabs-" + tab_counter).attr("style","height: 80%" );
                         
                      
                        tab_counter++;
                        GlobalTabs = tab_counter;
                    }
                       
                }
                
                function refreshtab(id){
                   
                   var tab = "#tab"+id.substring(6, id.length-5);
                   
                   var tabname = $(tab + " .tabinput").val();
                    var liststu = "";
                    for(var i =0;i<3;i++){
                        for(var j=0;j<10;j++){
                            ids = "#alu_"+i+"_"+j;
                            if( $(ids+" .email").val() != ""){
                                liststu = liststu + $(ids+" .email").val()+";";
                            }
                        }
                    }
                    
                   
                    $.ajax({
                        type: "POST",
                        url: "ServletSignalsALL",
                        data: "sessionId=<%=sessionId%>&sender=<%=maestro%>&reciver="+liststu+"&type=6&text="+tabname+"/$/"+escape($(id).val())+"&tab="+id,
                        success: function(){
                            session.signal();
                        }
                    });
                }
                
                function addtabS(){
                    var liststu = "";
                    for(var i =0;i<3;i++){
                        for(var j=0;j<10;j++){
                            ids = "#alu_"+i+"_"+j;
                            if( $(ids+" .email").val() != ""){
                                liststu = liststu + $(ids+" .email").val()+";";
                            }
                        }
                    }
                    $.ajax({
                        type: "POST",
                        url: "ServletSignalsALL",
                        data: "sessionId=<%=sessionId%>&sender=<%=maestro%>&reciver="+liststu+"&type=7",
                        success: function(){
                            session.signal();
                        }
                    });
                }
                
               		 
                function hideAllMessages()
                {
                    $('.info').css('top', -$('.info').outerHeight()); //move element outside viewport
                    $('.infofrommaster').css('top', -$('.infofrommaster').outerHeight()); 
                        
                }
                
                function closemessages(){
                    
                    $('.info').animate({top: -$('.info').outerHeight()}, 500);
                    $.ajax({
                        type: "POST",
                        url: "ServletSignals",
                        data: "sessionId=<%=sessionId%>&sender=<%=maestro%>&reciver="+$('#messageid').val()+"&type=8&text="+$('#messagetext').val(),
                        success: function(){
                            session.signal();
                        }
                    });
                }
                function closemessagesfrommaster(){
                    $('.infofrommaster').css('top', -$('.infofrommaster').outerHeight());
                }

                function SetGrade(id){
                    
                    var actual = $(id + " .GRADE").val();
                   
                    if(actual < 3){
                        actual++;
                    
                    }else{
                    
                        actual = 0;
                    }
                   
                    $(id + " .GRADE").val(actual);
                
                    if(actual == 0){
                    
                        $(id + " .star").attr("class","star starbackgroundR");
                    }
                    if(actual == 1){
                    
                        $(id + " .star").attr("class","star starbackgroundY");
                    }
                    if(actual == 2){
                    
                        $(id + " .star").attr("class","star starbackgroundB");
                    }
                    if(actual == 3){
                    
                        $(id + " .star").attr("class","star starbackgroundG");
                    }
                
                }
                
                
                function SaveClass(){
                    var liststu = "";
                    for(var i =0;i<3;i++){
                        for(var j=0;j<10;j++){
                            ids = "#alu_"+i+"_"+j;
                            if( $(ids+" .email").val() != ""){
                                liststu = liststu + $(ids+" .email").val()+","+$(ids+" .GRADE").val()+","+$(ids+" .count_participacion").html()+";";
                            }
                        }
                    }
                    $.ajax({
                        type: "POST",
                        url: "ServletSaveClass",
                        data: "cls_ID=<%=cls_ID%>&alumnos="+liststu,
                        success: function(){
                            alert("Class Save");
                        }
                    });
                    
                }
            
              
            
        </script>

    </head>
    <body>
        <div id="clasemain">           
            <fieldset class="boxBodyclase">
                <table style="width: 100%;height: 100%">
                    <%if (ismaestro) {%>
                    <tr>

                        <td style="height: 100px">
                            <table style="width: 100%;height: 100px" id="cuadricula" >
                                <%for (int i = 0; i < 3; i++) {%>
                                <tr >
                                    <%for (int j = 0; j < 10; j++) {%> 
                                    <td style="height: 30px;padding-top: 3px;white-space: nowrap;">
                                        <div  class="backW stu" id="alu_<%=String.valueOf(i) + "_" + String.valueOf(j)%>">
                                            <input type="hidden" class="connectionid" value=""/>
                                            <input type="hidden" class="email" value=""/>
                                            <input type="hidden" class="sa" value=""/>
                                            <input type="hidden" class="telefono" value=""/>
                                            <input type="hidden" class="celular" value=""/>
                                            <input type="hidden" class="permitir_participar" value="NO" />
                                            <input type="hidden" class="participando" value="NO" />
                                            <input type="hidden" class="BLOCK" value="NO" />
                                            <input type="hidden" class="CONNECT" value="NO" />
                                            <input type="hidden" class="GRADE" value="0" />

                                            <table style="width: 100%">

                                                <tr ><td colspan="5" style="text-align: center;"><label class="username"></label><label class="pa"></label></td></tr>
                                                <tr>
                                                    <td style="text-align:left;width: 12px;"><input type="button" class ="star starbackgroundR" onClick="" /></td> 
                                                    <td style="text-align: center;"><label class="count_participacion"></label></td>
                                                    <td style="text-align: right;"><input type="button" class ="permitir_hablar" onClick="" /></td>
                                                    <td style="text-align: right;"><input type="button" class ="parar_hablar" onClick="" /></td>
                                                    <td style="text-align: right;"><input type="button" class ="warm_call" onClick="" /></td>
                                                    <td style="text-align: right;width: 12px;"><input type="button" class ="cold_call" onClick="" /></td>
                                                </tr>
                                            </table>
                                        </div>
                                    </td>
                                    <%}%>
                                </tr>
                                <%}%>

                            </table>
                        </td> 
                    </tr>
                    <%}%>
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
                                                    <li id="tab1"><a href="#tabs-1"><input type="text" value="1" class="tabinput"/> </a></li>
                                                            <%if (ismaestro) {%>
                                                    <li class=" costumTab " id="addtab"><input type="button" value="+" class="botTab" onclick="addTab()"/></li>
                                                        <%}%>
                                                </ul>
                                                <div id="tabs-1" style="height: 80%">
                                                    <%if (ismaestro) {%>
                                                    <textarea class="piz"></textarea>
                                                    <input type="button" class="btnnormal2" value="Refresh" onClick="refreshtab('#tabs-1 .piz')" style="margin-top: 5px;" id="btabs-1"/>
                                                    <%} else {%>
                                                    <p class="piz"></p>
                                                    <%}%>
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
                                <input type="button" class="btnnormal2" value="Save Class" id="save_class" onClick="SaveClass()" />
                            </div> 
                        </td>
                        <td style="vertical-align:middle;">
                            <div id ="pubControls">
                                <form id="publishForm"> 

                                    <input type="button" class="btnnormal2" value="Start Publishing" onClick="startPublishing()" />
                                    <input type="radio" id="pubAV" name="pubRad" checked="checked" />&nbsp;Audio/Video&nbsp;&nbsp; 
                                    <input type="radio" id="pubAudioOnly" name="pubRad" />&nbsp;Audio-only&nbsp;&nbsp;
                                    <input type="radio" id="pubVideoOnly" name="pubRad" />&nbsp;Video-only
                                </form>
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


        <div class="info message">
            <h3>Send A Message to the Student</h3>
            <input type="text" id="messagetext" /><button onclick="closemessages()" class="btnnormal2">Send</button>
            <input type="hidden" id="messageid"/> 
        </div>

        <div class="infofrommaster message">
            <h3 id="messagefrommaster">Send A Message to the Student</h3>
            <button  class="btnnormal2" onclick="closemessagesfrommaster()">OK</button>

        </div>                                       
    </body>
</html>
<%} finally {%>
<%face.closeSession();%>
<%}
    }%>

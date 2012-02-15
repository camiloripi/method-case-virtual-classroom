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
        <script type="text/javascript" charset="utf-8">
            var session = TB.initSession("<%=sessionId%>"); // Sample session ID. 
            var publisher;
            var ocup_alumno = false;
            var ocup_maestro = false;
            session.addEventListener("sessionConnected", sessionConnectedHandler);
            session.addEventListener("streamCreated", streamCreatedHandler);
            session.addEventListener("streamDestroyed", streamDestroyedHandler);
            session.addEventListener("connectionCreated", connectionCreatedHandler);
            session.addEventListener("sessionDisconnected", sessionDisConnectedHandler);
            session.addEventListener("connectionDestroyed", connectionDestroyedHandler);
            session.addEventListener("signalReceived", signalHandler);
            
            $(document).ready(function() {
                $("#disconnectLink").hide();
                $("#pubControls").hide();
                $("#aluControls").hide();
                $("#permitir_hablar").hide();
                $("#parar_hablar").hide();
            });
            
            function connect(){
              
                
                token ="";
            <%if (ismaestro) {%>
                    token ="<%=tokbox.generateToKenMaestro(sessionId, tblUsuarios)%>";        
            <%} else {%>
                    token="<%=tokbox.generateToKenAlumno(sessionId, tblUsuarios)%>";
            <%}%>
              
                    session.connect(6642061, token);
                    
                }
            
                function disconnect(){
                    session.disconnect();                      
                }
             
                function startPublishing(){
                    if (!publisher) {   
                        
                       
                        var containerDiv = document.createElement('div');
                        containerDiv.className = "subscriberContainer";
                        containerDiv.setAttribute('id', 'opentok_publisher');
                        if(ocup_maestro == false){
                            var videoPanel = document.getElementById("maestro_div");
                            ocup_maestro = true;
                        }else{
                            
                            if(ocup_alumno == false){
                                var videoPanel = document.getElementById("alumno_div");
                                ocup_alumno = true;
                            }
                        }
                        
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
                                publisherProperties.width=200;
                                publisherProperties.height=200;
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
                                    alert(properties.video);
                                    publisherProperties.publishVideo = properties.video;
                                    publisherProperties.publishAudio = properties.audio;
                                    publisherProperties.width=200;
                                    publisherProperties.height=200;
                                    publisher = session.publish(publisherDiv.id, publisherProperties);
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
                    var videoPanel = document.getElementById("maestro_div");
                    for (i = 0; i < event.streams.length; i++) {
                        var stream = event.streams[i];
                        if (stream.connection.connectionId == session.connection.connectionId) {
                            videoPanel.removeChild(publisherContainer);
                            publisher =null;ocup_maestro =false;
                        } else {
                            var streamContainerDiv = document.getElementById("streamContainer" + stream.streamId);
                            if(streamContainerDiv) {
                                
                                videoPanel = document.getElementById("alumno_div");
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
                            var containerDiv = document.createElement('div'); // Create a container for the subscriber and its controls
                            containerDiv.className = "subscriberContainer";
                            var divId = stream.streamId;    // Give the div the id of the stream as its id
                            containerDiv.setAttribute('id', 'streamContainer' + divId);
                            
                            if(ocup_alumno == false){
                                var videoPanel = document.getElementById("alumno_div");  
                                ocup_alumno = true;
                            }else{ 
                                if(ocup_maestro == false){
                                    var videoPanel = document.getElementById("maestro_div");  
                                    ocup_maestro  = true;
                                }
                            }
                            
                            videoPanel.appendChild(containerDiv);
                            var publisherProperties = new Object();
                            publisherProperties.width=200;
                            publisherProperties.height=200;
                            var subscriberDiv = document.createElement('div'); // Create a replacement div for the subscriber
                            subscriberDiv.setAttribute('id', divId);
                            containerDiv.appendChild(subscriberDiv);
                            session.subscribe(stream, divId,publisherProperties);
                            
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
                    
                    var n = $("#n").val();
                    var foundit = false;
                    for(var j=0;j<event.connections.length;j++){
                        var connectiondata = getConnectionData(event.connections[j]);
                        for(var a=0;a < n;a++){
                            for(var s=0;s < n;s++){
                                if($("#alu_"+a+"_"+s+" .email").val()== connectiondata[0] && foundit == false){
                                    $("#alu_"+a+"_"+s).attr("style","background-color: #e5e5e5;border: 1px solid #000; cursor: pointer");
                                    $("#alu_"+a+"_"+s).attr("onclick","showinfo('#alu_"+a+"_"+s+"')");
                                    $("#alu_"+a+"_"+s+" .connectionid").val(event.connections[j].connectionId); 
                                    foundit = true;
                                    break;
                                }
                            }
                            
                        }
                        
                        if(foundit==false){
                            for(var a=0;a < n;a++){
                                for(var s=0;s < n;s++){
                                    if($("#alu_"+a+"_"+s+" .email").val()== "" && foundit == false){
                                        $("#alu_"+a+"_"+s).attr("style","background-color: #e5e5e5;border: 1px solid #000; cursor: pointer");
                                        $("#alu_"+a+"_"+s).attr("onclick","showinfo('#alu_"+a+"_"+s+"')");
                                        $("#alu_"+a+"_"+s+" .connectionid").val(event.connections[j].connectionId);
                                        $("#alu_"+a+"_"+s+" .email").val(connectiondata[0]);
                                        $("#alu_"+a+"_"+s+" .username").val(connectiondata[1]);
                                        $("#alu_"+a+"_"+s+" .pa").val(connectiondata[2]);
                                        $("#alu_"+a+"_"+s+" .sa").val(connectiondata[3]);
                                        $("#alu_"+a+"_"+s+" .telefono").val(connectiondata[4]);
                                        $("#alu_"+a+"_"+s+" .celular").val(connectiondata[5]);
                                        foundit = true;
                                        break;
                                    }
                                }
                            
                            } 
                            
                        }
                       
                        
                        
                    }
                         
            <%}%>
                   
                   
                }
                          
                function getConnectionData(connection) {
			
                    var connectionData = connection.data.split(',')
                        
                    return connectionData;
                }
            
            
                function sessionDisConnectedHandler(event) {
                    alert("Se desconecto alguien desde csession disconecged") 
                
            <%if (ismaestro) {%>
                    changeStatus(4);
            <%} else {%>
                    window.location.replace("Home.jsp");
            <%}%>
                }
                
                function connectionDestroyedHandler(event) {
                    
            <%if (ismaestro) {%>
                   
                    var n = $("#n").val();
                    var foundit = false;
                    for(var j=0;j<event.connections.length;j++){
                        
                        for (var a = 0 ; a < n ;a++){
                            for(var s = 0; s < n; s++){
                                if(event.connections[j].connectionId==$("#alu_"+a+"_"+s+" .connectionid").val() && foundit == false){
                            
                                    $("#alu_"+a+"_"+s).attr("style","background-color: #e18787;border: 1px solid #000");
                                    $("#alu_"+a+"_"+s).attr("onclick","");
                                    foundit = true;
                            
                                }
                                
                            }
                            
                        }
              
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
                                                    $(id+" .permitir_participar").val("SI")
                                       
                                                    $(id).attr("style","background-color: #8dc700;border: 1px solid #000; cursor: pointer");
                                                }
                                       
                                            }
                                            if(señales[i].type == 2){
                                                alert("me dieron permiso")
                                                startPublishing();
                                            }
                                            if(señales[i].type == 3){
                                                session.unpublish(publisher);
                                                $("#dejar_de_hablar").hide();
                                                $("#levantar_mano").show();
                                            }
                                        }
                                   
                                    }
                                }  
                            }
                        });
                    }
                }
                
                function fintd(email){
                    var n = $("#n").val();
                    var id = ""
                    
                    for(var i =0;i<n;i++){
                        for(var j=0;j<n;j++){
                            id = "#alu_"+i+"_"+j;
                            if( $(id+" .email").val() == email){
                                return id;
                            }
                        }
                    }
                    return "";
                }
                
                function findtd_id(connectionid){
                    var n = $("#n").val();
                    var id = ""
                    
                    for(var i =0;i<n;i++){
                        for(var j=0;j<n;j++){
                            id = "#alu_"+i+"_"+j;
                            if( $(id+" .connectionid").val() == connectionid){
                                return id;
                            }
                        }
                    }
                    return "";
                    
                }
            
                function showinfo(id){
                    $("#nombre").text($(id+" .username").val()); 
                    $("#pr_ape").text($(id+" .pa").val()); 
                    $("#sg_ape").text($(id+" .sa").val()); 
                    $("#correo").text($(id+" .email").val()); 
                    $("#Telefono").text($(id+" .telefono").val()); 
                    $("#Celular").text($(id+" .celular").val());
               
                    if($(id+" .permitir_participar").val()=="SI" && $(id+" .BLOCK").val()=="NO"){
                        $("#permitir_hablar").attr("onclick", "permitirhablar('"+id+"')");
                        $("#permitir_hablar").show();
                    }else{
                        $("#permitir_hablar").hide(); 
                    }
                
                    if($(id+" .participando").val() == "SI"){
                        $("#parar_hablar").show();
                    }else{
                        $("#parar_hablar").hide();
                    }
                }
            
                function permitirhablar(id){
                    alert("Permitire hablar");
                    var email = $(id+" .email").val();
                    $.ajax({
                        type: "POST",
                        url: "ServletSignals",
                        data: "sessionId=<%=sessionId%>&sender=<%=tblUsuarios.getUsrEmail()%>&reciver="+email+"&type=2",
                        success: function(){
                            alert("Se guardo la señal");
                            $("#permitir_hablar").hide();
                            $("#parar_hablar").attr("onclick", "parar('"+id+"')");
                            $("#parar_hablar").show();
                            $(id+" .participando").val("SI");
                            $(id+" .permitir_participar").val("NO");
                            var count = $(id+" .count_participacion").text();
                            count ++;
                            $(id+" .count_participacion").text(count);
                            $(id).attr("style","background-color: #01a0c7;border: 1px solid #000; cursor: pointer");
                            var n = $("#n").val();
                            for(var i =0;i<n;i++){
                                for(var j=0;j<n;j++){
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
                    alert("detener participacion");
                    var email = $(id+" .email").val();
                    $.ajax({
                        type: "POST",
                        url: "ServletSignals",
                        data: "sessionId=<%=sessionId%>&sender=<%=tblUsuarios.getUsrEmail()%>&reciver="+email+"&type=3",
                        success: function(){
                            alert("Se guardo la señal");
                            $("#permitir_hablar").hide();
                            $("#parar_hablar").attr("onclick", "");
                            $("#parar_hablar").hide();
                            $(id+" .participando").val("NO");
                            $(id+" .permitir_participar").val("NO");
                            $(id).attr("style","background-color: #e5e5e5;border: 1px solid #000; cursor: pointer");
                            var n = $("#n").val();
                            for(var i =0;i<n;i++){
                                for(var j=0;j<n;j++){
                                    var id_ = "#alu_"+i+"_"+j;
                                    $(id_+" .BLOCK").val("NO"); 
                                }
                            }
                            session.signal();
                        }
                    });
                }
                
                function BajarMano(){
                    session.unpublish(publisher);
                    $("#dejar_de_hablar").hide();
                    $("#levantar_mano").show();
                }
            
        </script>

    </head>
    <body>

        <div class="box clase">

            <fieldset class="boxBodyclase">
                <div id="videoPanel">
                    <table style="width: 400px;height: 200px" >
                        <tr>
                            <td style="width: 200px">
                                <div id="maestro_div">

                                </div> 
                            </td>
                            <td style="width: 200px">
                                <div id="alumno_div">

                                </div>
                            </td>
                        </tr>

                    </table>
                    <%if (ismaestro) {%>
                    <table>
                        <tr>
                            <td>
                                <table style="width: 200px;height: 200px" >
                                    <%for (int i = 0; i < n; i++) {%>
                                    <tr>
                                        <%for (int j = 0; j < n; j++) {%>
                                        <td style="border: 1px solid #000;" id="alu_<%=String.valueOf(i) + "_" + String.valueOf(j)%>">
                                            <input type="hidden" class="connectionid" value=""/>
                                            <input type="hidden" class="email" value=""/>
                                            <input type="hidden" class="username" value=""/>
                                            <input type="hidden" class="pa" value=""/>
                                            <input type="hidden" class="sa" value=""/>
                                            <input type="hidden" class="telefono" value=""/>
                                            <input type="hidden" class="celular" value=""/>
                                            <input type="hidden" class="permitir_participar" value="NO" />
                                            <input type="hidden" class="participando" value="NO" />
                                            <input type="hidden" class="BLOCK" value="NO" />
                                            <label class="count_participacion">0</label>
                                        </td>
                                        <%}%>

                                    </tr>
                                    <%}%>
                                </table>

                            </td>
                            <td>
                                <table style="width: 200px;height: 200px; border: 1px solid #000">
                                    <tr>
                                        <td>Nombre</td>
                                        <td><label id="nombre"></label></td>
                                    </tr>
                                    <tr>
                                        <td>Primer Apellido</td>
                                        <td><label id="pr_ape"></label></td>
                                    </tr>
                                    <tr>
                                        <td>Segundo Apellido</td>
                                        <td><label id="sg_ape"></label></td>
                                    </tr>
                                    <tr>
                                        <td>Correro</td>
                                        <td><label id="correo"></label></td>
                                    </tr>
                                    <tr>
                                        <td>Telefono</td>
                                        <td><label id="Telefono"></label></td>
                                    </tr>
                                    <tr>
                                        <td>Celular</td>
                                        <td><label id="Celular"></label></td>
                                    </tr>
                                    <tr>
                                        <td><input type="button" class="btnnormal" value="Permitir Hablar" id ="permitir_hablar" onClick="" /></td>
                                        <td><input type="button" class="btnnormal" value="Detener Participacion" id ="parar_hablar" onClick="" /></td>
                                    </tr>

                                </table>                              
                            </td>

                        </tr>
                    </table>
                    <%}%>

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
                        <td>
                            <div id="aluControls">
                                <input type="button" class="btnnormal" value="Levantar Mano" id ="levantar_mano" onClick="LevantarMano()" />
                                <input type="button" class="btnnormal" value="Dejar de Hablar" id ="dejar_de_hablar" onClick="BajarMano()" />
                            </div>
                        </td>
                    </tr>

                </table>



            </footer>



        </div>

        <input type="hidden" id="n" value="<%=n%>"/>
    </body>
</html>
<%} finally {%>
<%face.closeSession();%>
<%}
    }%>

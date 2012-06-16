<%-- 
    Document   : ClaseMaestro
    Created on : 06-05-2012, 03:15:11 PM
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
            if (!maestro.equals((String) session.getAttribute("usuario"))) {
                response.sendRedirect("index.jsp");
            }
            face.insertBoard("1", String.valueOf(cls_ID),"#tabs-1 .piz");
            ArrayList<SIGNALS> signals_arr = new ArrayList<SIGNALS>();
            getServletContext().setAttribute(sessionId, signals_arr);
%>


<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>MCVC</title>
        <link rel="shortcut icon" href="http://www.unitec.edu/wp-content/themes/unitec/unitec.ico" type="image/x-icon">
        <link rel="stylesheet" type="text/css" href="CSS/reset.css">
        <link rel="stylesheet" type="text/css" href="CSS/structure.css">
        <link type="text/css" href="CSS/jquery-ui-1.8.18.custom.css" rel="stylesheet">
        <link type="text/css" href="CSS/jquery.cleditor.css" rel="stylesheet">
        <script type="text/javascript" src="JS/jquery-1.7.1.js"></script>
        <script type="text/javascript" src="JS/jquery-ui-1.8.18.custom.min.js"></script>
        <script type="text/javascript" src ="JS/jquery-ui-timepicker-addon.js"></script>
        <script type="text/javascript" src ="JS/jquery.cleditor.js"></script>
        <script type="text/javascript" src ="JS/jquery.cleditor.table.js"></script>
        <!--<script src="http://static.opentok.com/v0.91/js/TB.min.js" type="text/javascript" charset="utf-8"></script>*/-->
        <script type="text/javascript" charset="utf-8">
            $(document).ready(function() {
            
                hideAllMessages(); 
                $(".loading").hide();
                $(".star").hide();
                $(".refreshbutton").hide();
                $("#addtab").hide();
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
                editor=$(".piz").cleditor({width:"99%", height:"100%"});
                
                
            });
            $(function() {
                tab_counter = 2;
                $( "#tabs").tabs({
                    add: function( event, ui ) {
                        $( ui.panel ).append( "<textarea class='piz'></textarea><input type=\"button\" class=\"btnnormal2\" value=\"Refresh\" onClick=\"refreshtab('#tabs-"+tab_counter+" .piz')\" style=\"margin-top: 5px;\" id=\"btabs-"+tab_counter+"\"/>" );
                        editor = $(".piz").cleditor({width:"99%", height:"100%"});
                                
                                
                    },
                    show: function(event, ui) { 
                        var tab = $(ui.panel).attr("id");                                    
                        tab = tab.substr(5, tab.length);
                        tab = tab -1;
                        editor[tab].focus();
                        editor[tab].refresh();
                        
                    }
                });
                
               
                    
                    
            });
            
            function addTab() {
                if(tab_counter<20){
                    $( "#tabs").tabs( "option", "tabTemplate", "<li id='tab"+tab_counter+"'><a href='#tabs-"+tab_counter+"'><input type='text' value='"+tab_counter+"' class='tabinput'/></a></li>" );
                    $( "#tabs").tabs( "add", "#tabs-" + tab_counter,tab_counter );
                    var other = $("#addtab");
                    $("#tab"+tab_counter).after(other.clone());
                    other.after($("#tab"+tab_counter)).remove();
                    addtabS(tab_counter,"#tabs-"+tab_counter+" .piz");
                    $("#tabs-" + tab_counter).attr("style","height: 80%" );                                              
                    tab_counter++;
                }
                       
            }
                
            function addtabS(tab){
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
                    data: "sessionId=<%=sessionId%>&sender=<%=maestro%>&reciver="+liststu+"&type=7&clsid=<%=cls_ID%>&tabname="+tab+"&tab=#tabs-"+tab+" .piz",
                    success: function(){
                        session.signal();
                    }
                });
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
                    data: "sessionId=<%=sessionId%>&sender=<%=maestro%>&reciver="+liststu+"&type=6&clsid=<%=cls_ID%>&text="+escape($(id).val())+"&tab="+id+"&tabname="+tabname,
                    success: function(){
                        session.signal();
                    }
                });
            }
            
            function hideAllMessages()
            {
                $('.info').css('top', -$('.info').outerHeight());
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
                                                    <td style="text-align: right;">
                                                        <input type="button" class ="permitir_hablar" onClick="" />
                                                        <input type="button" class ="parar_hablar" onClick="" />
                                                        <input type="button" class ="warm_call" onClick="" />
                                                        <input type="button" class ="cold_call" onClick="" />
                                                    </td>

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
                                                    <li class=" costumTab " id="addtab"><input type="button" value="+" class="botTab" onclick="addTab()"/></li>

                                                </ul>
                                                <div id="tabs-1" style="height: 80%">

                                                    <textarea class="piz"></textarea>
                                                    <input type="button" class="btnnormal2 refreshbutton" value="Refresh" onClick="refreshtab('#tabs-1 .piz')" style="margin-top: 5px;" id="btabs-1"/>

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
                                </form>
                            </div>
                        </td>
                    </tr>

                </table>
            </footer>
            <div class="info message">
                <h3>Send A Message to the Student</h3>
                <input type="text" id="messagetext" /><button onclick="closemessages()" class="btnnormal2">Send</button>
                <input type="hidden" id="messageid"/> 
            </div> 
        </div>

        <div class="loading">

        </div>                                 
    </body>
    <script type="text/javascript" src ="http://static.opentok.com/v0.91/js/TB.min.js"></script>
    <script type="text/javascript">
        
        var sessionId = "<%=sessionId%>";
        var token;
        var session;
        var publisher;
        var alumno_talking = false;
        var cant_streams=0;

        var subscribers = {};
        
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
            $( ".loading" ).show();
            token ="<%=tokbox.generateToKenMaestro(sessionId, tblUsuarios)%>";    
            session.connect(6642061, token);
        }
        function disconnect(){
            session.disconnect();                      
        }
        function startPublishing(){
            if (!publisher) { 
                $("#pubControls").hide();
                $(".loading").show();
                var containerDiv = document.createElement('div');
                containerDiv.className = "subscriberContainer";
                containerDiv.setAttribute('id', 'opentok_publisher'); 
                var videoPanel = document.getElementById("maestro_div");
                videoPanel.appendChild(containerDiv);
                var publisherDiv = document.createElement('div');
                publisherDiv.setAttribute('id', 'replacement_div')
                containerDiv.appendChild(publisherDiv);
                var publisherProperties = new Object();
                if (document.getElementById("pubAudioOnly").checked) {
                    publisherProperties.publishVideo = false;
                }
                $.ajax({
                    type: "POST",
                    url: "PublisherProperties",
                    data: "sessionId=<%=sessionId%>&video="+publisherProperties.publishVideo+"&audio="+publisherProperties.publishAudio+"&todo=set",
                    success: function(){
                        publisherProperties.width=220;
                        publisherProperties.height=140; 
                        publisher = session.publish(publisherDiv.id, publisherProperties);
                        changeStatus(3);
                                
                    }}); 
                
            }
                        
        }         
        function sessionConnectedHandler(event) {
            subscribeToStreams(event.streams);
            $("#disconnectLink").show();
            $("#connectLink").hide();
            $("#pubControls").show();
            $(".refreshbutton").show();
            $("#addtab").show();
            changeStatus(2);       
        }
        function streamCreatedHandler(event) {
            subscribeToStreams(event.streams);
        } 
        
        function streamDestroyedHandler(event){
               
        
            for (i = 0; i < event.streams.length; i++) {
                var stream = event.streams[i];
                if (stream.connection.connectionId == session.connection.connectionId) {
                    var publisherContainer = document.getElementById("opentok_publisher");
                    var videoPanel = document.getElementById("maestro_div");  
                    videoPanel.removeChild(publisherContainer);
                    publisher =null;
                } else {
                            
                    var streamContainerDiv = document.getElementById("streamContainer" + stream.streamId);                  
                    videoPanel = document.getElementById("alumno_div");
                    videoPanel.removeChild(streamContainerDiv);
                    alumno_talking=false;
                    
                          
            
                }
            }
        } 
        
        function subscribeToStreams(streams){
            for (i = 0; i < streams.length; i++) {
                         
                    var stream = streams[i];
                    if (stream.connection.connectionId != session.connection.connectionId) {
                        var containerDiv = document.createElement('div');
                        containerDiv.className = "subscriberContainer";
                        var divId = stream.streamId;
                        containerDiv.setAttribute('id', 'streamContainer' + divId);
                        var videoPanel = null;
                        videoPanel = document.getElementById("alumno_div");
                        videoPanel.appendChild(containerDiv);
                        var publisherProperties = new Object();
                        publisherProperties.width=220;
                        publisherProperties.height=140;
                        var subscriberDiv = document.createElement('div');
                        subscriberDiv.setAttribute('id', divId);
                        containerDiv.appendChild(subscriberDiv);
                        session.subscribe(stream, divId,publisherProperties);
                        var id = findtd_id(stream.connection.connectionId);
                        //$(id+" .parar_hablar").show();
                        
                            
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
                        case 2 :  $( ".loading" ).hide();
                            break;
                        case 3 : $( ".loading" ).hide();
                            break;
                        case 4 : alert("Se cambio el status a: Terminada");
                            window.location.replace("Home.jsp");
                            break;
                                    
                    }  
                }
            });
        }     
        function connectionCreatedHandler(event){
            $("#save_class").show();
            var foundit = false;
            for(var j=0;j<event.connections.length;j++){
                var connectiondata = getConnectionData(event.connections[j]);
                for(var a=0;a < 3;a++){
                    for(var s=0;s < 10;s++){
                        if($("#alu_"+a+"_"+s+" .email").val()== connectiondata[0] && foundit == false){
                                    
                            $("#alu_"+a+"_"+s+" .connectionid").val(event.connections[j].connectionId); 
                            $("#alu_"+a+"_"+s+" .CONNECT").val("SI"); 
                            $("#alu_"+a+"_"+s).attr("class","backW stu");
                            if(alumno_talking == false){
                                $("#alu_"+a+"_"+s+" .cold_call").attr("onclick", "ColdCall('#alu_"+a+"_"+s+"')");
                                $("#alu_"+a+"_"+s+" .cold_call").show();    
                            }
                            $("#alu_"+a+"_"+s+" .warm_call").attr("onclick", "WarmCall('#alu_"+a+"_"+s+"')");
                            $("#alu_"+a+"_"+s+" .warm_call").show();
                            
                                    
                            $("#alu_"+a+"_"+s+" .star").attr("onclick", "SetGrade('#alu_"+a+"_"+s+"')");
                            $("#alu_"+a+"_"+s+"  .star").show();
                                   
                            foundit = true;
                            break;
                        }
                    }
                            
                }
                        
                if(foundit==false){
                    for(var a=0;a < 3;a++){
                        for(var s=0;s < 10;s++){
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
                                if(alumno_talking == false){
                                    $("#alu_"+a+"_"+s+" .cold_call").attr("onclick", "ColdCall('#alu_"+a+"_"+s+"')");
                                    $("#alu_"+a+"_"+s+" .cold_call").show();
                                }
                                
                                $("#alu_"+a+"_"+s+" .warm_call").attr("onclick", "WarmCall('#alu_"+a+"_"+s+"')");
                                $("#alu_"+a+"_"+s+" .warm_call").show();
                                
                                $("#alu_"+a+"_"+s+" .star").attr("onclick", "SetGrade('#alu_"+a+"_"+s+"')");
                                $("#alu_"+a+"_"+s+"  .star").show();
                                foundit = true;
                                break;
                            }
                        }
                            
                    } 
                            
                }
                       
                        
                        
            }
                         
           
        }  
        
        function sessionDisConnectedHandler(event) { 
            changeStatus(4);
        }
        
        function connectionDestroyedHandler(event){
            var foundit = false;
            for(var j=0;j<event.connections.length;j++){ 
                for (var a = 0 ; a < 3 ;a++){
                    for(var s = 0; s < 10; s++){
                        if(event.connections[j].connectionId==$("#alu_"+a+"_"+s+" .connectionid").val() && foundit == false){                          
                            $("#alu_"+a+"_"+s).attr("class","backR stu");
                            $("#alu_"+a+"_"+s+"  .star").hide();
                            $("#alu_"+a+"_"+s+" .cold_call").hide();
                            $("#alu_"+a+"_"+s+" .warm_call").hide();
                            $("#alu_"+a+"_"+s+" .permitir_hablar").hide();
                            $("#alu_"+a+"_"+s+" .parar_hablar").hide();                
                            $("#alu_"+a+"_"+s+ " .CONNECT").val("NO");
                            foundit = true;
                            
                        }
                                
                    }
                            
                }
              
            }
        }
        
        function signalHandler(event){
            
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
                                            $(id+ " .permitir_hablar").attr("onclick", "permitirhablar('"+id+"')");
                                            $(id+" .permitir_hablar").show();
                                            $(id+" .cold_call").hide();                                                       
                                            $(id).attr("class","backG stu");
                                        }
                                       
                                    }
                                    if(señales[i].type == 4){
                                        var id = fintd(señales[i].sender);
                                        parar(id);
                                    }
                                }
                                   
                            }
                        }  
                    }
                });
            }
        }
        
        function getConnectionData(connection) {
			
            var connectionData = connection.data.split(',')
                        
            return connectionData;
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
            if(alumno_talking==false){
                var email = $(id+" .email").val();
                $.ajax({
                    type: "POST",
                    url: "ServletSignals",
                    data: "sessionId=<%=sessionId%>&sender=<%=tblUsuarios.getUsrEmail()%>&reciver="+email+"&type=2",
                    success: function(){
                        $(".permitir_hablar").hide();
                        $(".cold_call").hide();
                        $(id+ " .parar_hablar").attr("onclick", "parar('"+id+"')");
                        $(id+ " .parar_hablar").show();
                        $(id+" .participando").val("SI");
                        $(id+" .permitir_participar").val("NO");
                        var count = $(id+" .count_participacion").text();
                        count ++;
                        $(id+" .count_participacion").text(count);
                        $(id).attr("class","backB stu");
                        $(".backG").attr("class","backW stu");
                        session.signal();
                        alumno_talking = true;    
                    }
                }); 
            }
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
                                $(id_+" .cold_call").show();
                                $(id_).attr("class","backW stu"); 
                                $.ajax({
                                    type: "POST",
                                    url: "ServletSignals",
                                    data: "sessionId=<%=sessionId%>&sender=<%=tblUsuarios.getUsrEmail()%>&reciver="+$(id_+" .email").val()+"&type=5"});
                            }
                                    
                                    
                        }
                    }
                    alumno_talking = false;
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
      
    </script>



</html>
<%} finally {%>
<%face.closeSession();%>
<%}
    } else {

        response.sendRedirect("index.jsp");

    }%>



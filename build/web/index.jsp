<%-- 
    Document   : index
    Created on : Jul 11, 2012, 10:22:11 AM
    Author     : hakeem
--%>

<%@page import="evo.actions.ActionsDef"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="evo.db.DBconnect"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
    
        <link rel="stylesheet" href="css/screen.css" type="text/css" title="default" />
    <link rel="stylesheet" type="text/css" href="css/ui-lightness/jquery-ui-1.8.21.custom.css">
        <title>Système de Gestion d'Equipement et d'Environnement</title>
        
        
	<script src="js/ui/jquery.ui.core.js"></script>
	<script src="js/ui/jquery.ui.widget.js"></script>
	<script src="js/ui/jquery.ui.mouse.js"></script>
	<script src="js/ui/jquery.ui.draggable.js"></script>
	<script src="js/ui/jquery.ui.position.js"></script>
	<script src="js/ui/jquery.ui.resizable.js"></script>
	<script src="js/ui/jquery.ui.dialog.js"></script>
        <script src="js/jquery-1.7.2.min.js"></script>
        <script src="js/jquery-ui-1.8.21.custom.min.js"></script>
            <style type="text/css">
      html { height: 100% }
      body { height: 100%; margin: 0; padding: 0 }
      #map_canvas { height: 50% }
      

    @media print
    {
    	#page-top-outer { display: none; }
        .nav-outer-repeat { display: none; }
        #step-holder { display: none; }
        #related-activities { display: none; }
    	#content { display: block; }
    }
    </style>
    <script type="text/javascript" src="http://maps.googleapis.com/maps/api/js?key=AIzaSyCFprLbFmAvJbDaoI2I0Q1SbC542I6G1CE&sensor=false"></script>
    
    
        <script type="text/javascript">
            var t=new Array();
            var loc=new Array();
            var nb=0;
            loc[nb]="sites.jsp";
          nb++;
          
          
            <%
            
        if(session.getAttribute("user")==null){
        
        response.sendRedirect("login.jsp");
        }else{
        DBconnect db = new DBconnect();
        db.liaison();
        db.S = db.conn.createStatement();
        Double lat=0.0,lon=0.0,maxlat=-9999.0,minlat=9999.0,maxlon=-9999.0,minlon=9999.0;
        ResultSet rs;
        rs = db.S.executeQuery("Select xsite,ysite from site");
        while(rs.next()){
        lat=rs.getDouble(1);
        lon = rs.getDouble(2);
        if(maxlat<lat)
            maxlat = lat;
        if(minlat>lat)
            minlat = lat;
        if(maxlon<lon)
            maxlon = lon;
        if(minlon>lon)
            minlon = lon;
                      }
        %>
                function initialize() {
                    showsiteinfo("homediv.jsp");
            
           var myLatlng = new google.maps.LatLng(<%=(maxlat+minlat)/2%>,<%=(maxlon+minlon)/2%>);
           var latlngbounds = new google.maps.LatLngBounds();
           latlngbounds.extend(new google.maps.LatLng(<%=maxlat%>,<%=maxlon%>));
           latlngbounds.extend(new google.maps.LatLng(<%=minlat%>,<%=minlon%>));
  var myOptions = {
    zoom: 6,
    center: myLatlng,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  }
  var map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);
  map.fitBounds (latlngbounds);
  var image = 'img/bts.png';
           <%
           rs = db.S.executeQuery("Select * from site");
        while(rs.next()){
        lat=rs.getDouble(3);
        lon = rs.getDouble(4);
           %>
      var siteMarker<%=rs.getString(1)%> = new google.maps.Marker({
      position: new google.maps.LatLng(<%=lat%>,<%=lon%>),
      map: map
  });
    //var popupContent<%=rs.getString(3)%> = '<div id="locationContent<%=rs.getString(3)%>"><a href="" onclick("loadtodiv(\"#locationContent<%=rs.getString(3)%>\",\"sites.jsp?q=\"+<%=rs.getString(3)%>)>Afficher info >></a></div>';

               
                var infoWindow<%=rs.getString(1)%> = new google.maps.InfoWindow();
  google.maps.event.addListener(siteMarker<%=rs.getString(1)%>, 'click', function () {
            //window.alert('<div id="locationContent<%=rs.getString(1)%>"><a href="" onclick("loadtodiv("#locationContent<%=rs.getString(3)%>","sites.jsp?q=<%=rs.getString(3)%>")>Afficher info >></a></div>');
            infoWindow<%=rs.getString(1)%>.setContent('<div id="locationContent<%=rs.getString(1)%>" style="height:70px">ID Site: <%=rs.getString(1)%><br/>Description: <%=rs.getString(2)%><br/>(X,Y): ( <%=rs.getString(3)%> , <%=rs.getString(4)%> )<br/><a href="#" onclick=\'loadtodiv("#right-content","sites.jsp?q=<%=rs.getString(1)%>")\'>Afficher ce site >></a></div>');
            infoWindow<%=rs.getString(1)%>.open(map, this);
        });
  
  <% } %>
  document.getElementById("map_canvas").style.visibility = "hidden";
    
  }
          

           $(function() {
		
		$( "#dialog-modal" ).dialog({
			height: 400,
                        width: 650,
                        autoOpen: false,
			modal: true
		});
                $("#step-holder").hide("medium");
                $("#related-activities").show("slow");
                //loadtodiv("#right-content","sites.jsp");
	});
      
  function showinfo(){
      //window.alert("test");
      
      $("#dialog-modal").dialog("open");
  }
  function showsiteinfo(url){
      //$("#step-holder").show("slow");
      //$("#related-activities").hide("slow");
      loadtodiv("#right-content",url);
      
      
  }
  
  function loadtodiv(val,url){
      $("#step-holder").hide("slow");
      $("#map_canvas").slideUp("slow");
      $("#divsite").slideUp("medium");
      $(val).slideUp("fast");
      $(val).load(url);
      $(val).slideDown("slow");
  }
  
  
  function loadtab(nb){
      
      switch(nb){
          case 1: 
                  $('#btsdep').hide("slide");
                  $('#btsservice').hide("slide");
                  $('#btsetude').show("slide");
              break;
          case 2: 
                    $('#btsetude').hide("slide");
                  
                  $('#btsservice').hide("slide");
                  $('#btsdep').show("slide");
              break;
          case 3: 
              
              $('#btsetude').hide("slide");
                  $('#btsdep').hide("slide");
                  $('#btsservice').show("slide");
                  
              break;
      }
      
  }
  
  function loadstep(num){
      $("#step-holder").hide("slow");
      switch(num){
          case 1:
              loadtab(1);
              document.getElementById("step-holder").innerHTML = '<div class="step-no">1</div><div class="step-done-left">En Etude</div><div class="step-done-right">&nbsp;</div><div class="step-no-off">2</div><div class="step-light-left"><a>En Déploiement</a></div><div class="step-light-right">&nbsp;</div><div class="step-no-done">3</div><div class="step-light-left">En Service</div><div class="step-light-round">&nbsp;</div><div class="clear"></div>';
              break;
          case 2:
              loadtab(2);
              document.getElementById("step-holder").innerHTML = '<div class="step-no-done">1</div><div class="step-dark-left">En Etude</div><div class="step-dark-right">&nbsp;</div><div class="step-no-done">2</div><div class="step-done-left">En Déploiement</div><div class="step-done-right">&nbsp;</div><div class="step-no-off">3</div><div class="step-light-left">En Service</div><div class="step-light-round">&nbsp;</div><div class="clear"></div>';
              break;
          case 3:
              loadtab(3);
              document.getElementById("step-holder").innerHTML = '<div class="step-no">1</div><div class="step-dark-left">En Etude</div><div class="step-dark-right">&nbsp;</div><div class="step-no">2</div><div class="step-dark-left">En Déploiement</div><div class="step-dark-right">&nbsp;</div><div class="step-no">3</div><div class="step-done-left">En Service</div><div class="step-done-round">&nbsp;</div><div class="clear"></div>';
              break;
      }
      $("#step-holder").show("slow");
  }
  
  function searchfor(){
      loadtodiv('#right-content','bts.jsp?q='+document.getElementById('txtsearch').value);
  }
  
  function initializesite(txt) {
      document.getElementById("frmsite").src = txt;
      $("#divsite").slideDown("medium");
      
      //window.alert(txt);
  }
  /*function getPos(obj,e){
var evtobj=window.event? event : e;

if (Browser == 'Explorer' || Browser == 'Opera')
{
clickX = evtobj.offsetX;
clickY = evtobj.offsetY;
}
else
{
clickX = evtobj.layerX;
clickY = evtobj.layerY;
}
alert('clickX:'+clickX+', clickY'+clickY);
}*/
  
  
      

//<div class="select">  </div>
			
//			<a href="" id="logout" class="select">Logout</a>

    </script>
    
    </head>
    
    <body onload="initialize();">
        
        
        
        
        
        <!-- Start: page-top-outer -->
<div id="page-top-outer">    

<!-- Start: page-top -->
<div id="page-top" style="vertical-align: central;height: 100%">

	<!-- start logo -->
        <div style="vertical-align: central;height: 100%"><br/>
            <p align="right" style="vertical-align: central"><span style="vertical-align: central ;text-align: right; font-size: 30px; color: white" >Système de Gestion d'Equipement et d'Environnement</span></p>
	</div>
	<!-- end logo -->
        
	
 	

</div>
<!-- End: page-top -->

</div>
<!-- End: page-top-outer -->
	
<div class="clear">&nbsp;</div>
 
<!--  start nav-outer-repeat................................................................................................. START -->
<div class="nav-outer-repeat"> 
<!--  start nav-outer -->
<div class="nav-outer"> 

		<!-- start nav-right -->
		<div id="nav-right">
		
			
			<div class="clear">&nbsp;</div>
		
			<!--  start account-content -->	
			<div class="account-content">
			<div class="account-drop-inner">
				<a href="" id="acc-settings">Settings</a>
				<div class="clear">&nbsp;</div>
				<div class="acc-line">&nbsp;</div>
				<a href="" id="acc-details">Personal details </a>
				<div class="clear">&nbsp;</div>
				<div class="acc-line">&nbsp;</div>
				<a href="" id="acc-project">Project details</a>
				<div class="clear">&nbsp;</div>
				<div class="acc-line">&nbsp;</div>
				<a href="" id="acc-inbox">Inbox</a>
				<div class="clear">&nbsp;</div>
				<div class="acc-line">&nbsp;</div>
				<a href="" id="acc-stats">Statistics</a> 
			</div>
			</div>
			<!--  end account-content -->
		
		</div>
		<!-- end nav-right -->


		<!--  start nav -->
		<div class="nav">
		<div class="table">
		
		<ul class="select"><li><a href=""><b>Accueil</b><!--[if IE 7]><!--></a><!--<![endif]-->
		<!--[if lte IE 6]><table><tr><td><![endif]-->
		
		<!--[if lte IE 6]></td></tr></table></a><![endif]-->
		</li>
		</ul>
		
		                    
                    <ul class="select" onclick=""><li><a href="#"><b>Sites</b><!--[if IE 7]><!--></a><!--<![endif]-->
		<!--[if lte IE 6]><table><tr><td><![endif]-->
                        <div class="select_sub">
			<ul class="sub">
                            <li><a href="#" onclick="loadtodiv('#right-content','sites.jsp')">Liste des sites</a></li>
				<li><a href="#" onclick='$("#map_canvas").slideUp("medium");document.getElementById("map_canvas").style.visibility = "visible";$("#map_canvas").slideDown("slow");$("#right-content").slideUp("medium");'>Sur la carte</a></li>
			</ul>
                        </div>

		<!--[if lte IE 6]></td></tr></table></a><![endif]-->
		</li>
		</ul>
		
		
		<ul class="select"><li><a href="#"  onclick="loadtodiv('#right-content','equip.jsp')"><b>Equipement</b><!--[if IE 7]><!--></a><!--<![endif]-->
		<!--[if lte IE 6]><table><tr><td><![endif]-->
                        <div class="select_sub">
			<ul class="sub">
                            <li><a href="#" onclick="loadtodiv('#right-content','msc.jsp')">MSC</a></li>
				<li><a href="#" onclick="loadtodiv('#right-content','bsc.jsp')">BSC</a></li>
				<li><a href="#" onclick="loadtodiv('#right-content','bts.jsp')">BTS</a></li>
                                <li><a href="#" onclick="loadtodiv('#right-content','antenna.jsp')">Antennes</a></li>
                                <li><a href="equipview.jsp" target='frminfo' onclick="showinfo()">Diagramme d'équipement</a></li>
			</ul>
                        </div>
		<!--[if lte IE 6]></td></tr></table></a><![endif]-->
		</li>
		</ul>
		<ul class="select"><li><a href="#nogo" onclick="loadtodiv('#right-content','rbs.jsp')"><b>RBS</b><!--[if IE 7]><!--></a><!--<![endif]-->
		<!--[if lte IE 6]><table><tr><td><![endif]-->
		
		<!--[if lte IE 6]></td></tr></table></a><![endif]-->
		</li>
		</ul>
                    <ul class="select"><li><a href="#"  onclick="loadtodiv('#right-content','env.jsp')"><b>Environnement</b><!--[if IE 7]><!--></a><!--<![endif]-->
		<!--[if lte IE 6]><table><tr><td><![endif]-->
                        <div class="select_sub">
			<ul class="sub">
                            <li><a href="#" onclick="loadtodiv('#right-content','batteries.jsp')">Batteries</a></li>
				<li><a href="#" onclick="loadtodiv('#right-content','climatisation.jsp')">Climatisation</a></li>
				<li><a href="#" onclick="loadtodiv('#right-content','compteur.jsp')">Compteurs</a></li>
                                <li><a href="#" onclick="loadtodiv('#right-content','redresseur.jsp')">Redresseurs</a></li>
			</ul>
                        </div>
		<!--[if lte IE 6]></td></tr></table></a><![endif]-->
		</li>
		</ul>
		<% ActionsDef act = new ActionsDef();%>
                
                    <ul class="select"><li><a href="<% if(act.isAdmin(session.getAttribute("user").toString())){ %>add.jsp<%}else{%>error.html<%}%>" target="frminfo" onclick="showinfo()"><b>Assistant d'Ajout</b><!--[if IE 7]><!--></a><!--<![endif]-->
		<!--[if lte IE 6]><table><tr><td><![endif]-->
		
		<!--[if lte IE 6]></td></tr></table></a><![endif]-->
		</li>
		</ul>
                    <ul class="select"><li><a href="#nogo" onclick="loadtodiv('#right-content',<%if(act.isAdmin(session.getAttribute("user").toString())){ %>'user.jsp' <%}else{%> 'getuser.jsp?idb=<%=session.getAttribute("user").toString()%>' <%}%> )"><b><%=session.getAttribute("user").toString()%></b><!--[if IE 7]><!--></a><!--<![endif]-->
		<!--[if lte IE 6]><table><tr><td><![endif]-->
		
		<!--[if lte IE 6]></td></tr></table></a><![endif]-->
		</li>
		</ul>
                    
                    <ul class="select"><li><a href="actions?action=logout"><b>Déconnexion</b><!--[if IE 7]><!--></a><!--<![endif]-->
		<!--[if lte IE 6]><table><tr><td><![endif]-->
		
		<!--[if lte IE 6]></td></tr></table></a><![endif]-->
		</li>
		</ul>
                
		<div class="clear"></div>
		</div>
		<div class="clear"></div>
		</div>
		<!--  start nav -->

</div>
<div class="clear"></div>
<!--  start nav-outer -->
</div>
<div class="clear"></div>
<!--  start step-holder -->
<div id="step-holder">
    <div id="elem1" class="step-no">1</div>
    <div id="elem2" class="step-dark-left"><a href="">Déploiement</a></div>
			<div id="elem3" class="step-dark-right">&nbsp;</div>
                        <div id="elem4" class="step-no-off">2</div>
                        <div id="elem5" class="step-light-left"><a>Etude</a></div>
			<div id="elem6" class="step-light-right">&nbsp;</div>
			<div id="elem7" class="step-no-off">3</div>
			<div id="elem8" class="step-light-left">Mise en service</div>
			<div id="elem9" class="step-light-round">&nbsp;</div>
			<div class="clear"></div>
</div>
		<!--  end step-holder -->
<!--  start nav-outer-repeat................................................... END -->


<div id="content-outer">
<!-- start content -->
<div id="content">


<!-- <div id="page-heading"><h1>Add product</h1></div> -->
<div id="content-table-inner">
		<!--  start related-activities -->
	<div id="related-activities">
		
		<!--  start related-act-top -->
                <a href="#"><div id="related-act-top" onclick="$('#related-act-bottom').slideToggle('slow');">
		<img src="img/forms/header_related_act.gif" width="271" height="43" alt="" />
		</div></a>
		<!-- end related-act-top -->
		
		<!--  start related-act-bottom -->
		<div id="related-act-bottom">
		
			<!--  start related-act-inner -->
			<div id="related-act-inner">
			
                            
				
					
					<div class="search" ><h5>Chercher un Site</h5><br/><input type="text" id="txtsearchsite" /><button onclick="loadtodiv('#right-content','sites.jsp?q='+document.getElementById('txtsearchsite').value);">Chercher</button><br/>
                                            <div class="clear"></div>
                                            Ou filtrer par:<br/><a href="#" onclick="loadtodiv('#right-content','sites.jsp?q=status1');"><span style="background-color: #aaa ">&nbsp;&nbsp;&nbsp;&nbsp;</span>&nbsp;En Etude</a>&nbsp;<a href="#" onclick="loadtodiv('#right-content','sites.jsp?q=status2');"><span style="background-color: #eb8f00 ">&nbsp;&nbsp;&nbsp;&nbsp;</span>&nbsp;En Déploiement</a>&nbsp;<a href="#" onclick="loadtodiv('#right-content','sites.jsp?q=status3');"><span style="background-color: #6da827 ">&nbsp;&nbsp;&nbsp;&nbsp;</span>&nbsp;En Service</a> </div>
					
				
				
				<div class="clear"></div>
				<div class="lines-dotted-short"></div>
				
				
				
					
					<div class="search" ><h5>Chercher un BTS</h5><br/><input type="text" id="txtsearchbts" /><button onclick="loadtodiv('#right-content','bts.jsp?q='+document.getElementById('txtsearchbts').value);">Chercher</button><br/>
                                            <div class="clear"></div>
                                            Ou filtrer par:<br/><a href="#" onclick="loadtodiv('#right-content','bts.jsp?q=status1');"><span style="background-color: #aaa ">&nbsp;&nbsp;&nbsp;&nbsp;</span>&nbsp;En Etude</a>&nbsp;<a href="#" onclick="loadtodiv('#right-content','bts.jsp?q=status2');"><span style="background-color: #eb8f00 ">&nbsp;&nbsp;&nbsp;&nbsp;</span>&nbsp;En Déploiement</a>&nbsp;<a href="#" onclick="loadtodiv('#right-content','bts.jsp?q=status3');"><span style="background-color: #6da827 ">&nbsp;&nbsp;&nbsp;&nbsp;</span>&nbsp;En Service</a> </div>
					
				
				
				<div class="clear"></div>
				<div class="lines-dotted-short"></div>
				
				
			
					<div class="search" >
                                            <h5>Autre Recherche:</h5>
                                            <br/>
                                            <select name="typesearch" id="typesearch" style="width: 100%"  onchange="if(document.getElementById('typeadd').value != '') document.getElementById('idadd').style.visibility = 'visible'; else document.getElementById('idadd').style.visibility = 'hidden';">
                
                <% if(act.isAdmin(session.getAttribute("user").toString())){ %><option value="user">Utilisateur</option><%}%>
                
                <option value="rbs">RBS</option>
                <option value="bsc">BSC</option>
                <option value="msc">MSC</option>
                <option value="antenna">Antenne</option>
                <option value="batteries">Batterie</option>
                <option value="climatisation">Climatisation</option>
                <option value="compteur">Compteur</option>
                <option value="redresseur">Redresseur</option>
            </select>
                                            <br/>
                                            <input type="text" id="txtsearchall" />
                                            
                                            
                                            <button onclick="loadtodiv('#right-content',document.getElementById('typesearch').value+'.jsp?q='+document.getElementById('txtsearchall').value);">Chercher</button> </div>
					
			
				<div class="clear"></div>
				
			</div>
			<!-- end related-act-inner -->
			<div class="clear"></div>
		
		</div>
		<!-- end related-act-bottom -->
	
	</div>
	<!-- end related-activities -->
       
        <div id="map_canvas" style="position: absolute;  margin-left: 22%;margin-right: 0 ;z-index: 1000;width: 72%;height: 400px"></div>        
        
<div id="right-content">
    
</div>
	<!--  start content-table-inner -->
       </div>
<div class="clear"></div>
 


<!--  end content-table-inner  -->










 






</div>
<!--  end content -->
</div>
<!--  end content-outer -->

    
<!-- start footer -->         
<div id="footer">
	<!--  start footer-left -->
	<div id="footer-left">
            | <a href="mailto:wa.evolution@gmail.com" target="_blank">WAHAB Hakeem</a> &copy; Copyright <a href="http://www.evogroup.hostoi.com/" target="_blank">EVO Group</a>. All rights reserved 2012</div>
	<!--  end footer-left -->
	<div class="clear">&nbsp;</div>
</div>
<!-- end footer -->

        
        
   
    <div id="dialog-modal" title="Informations" style="margin-left:0;margin-right: 0;margin-top: 0;margin-bottom: 0; background-color: #fff;">
        <iframe id="frminfo" style="width: 100%;height: 100%;" frameborder="0">
        
        </iframe>
</div>
    <iframe id="frmsub" style="width: 0%;height: 0%;visibility: hidden;" frameborder="0">
        
        </iframe>
        <div id="divsite" style="position:absolute;left: 350px;top: 250px;width: 70%;height: 55%;display: none;">
            <iframe id="frmsite" src="addsite.jsp?ids=site01" style="width: 100%;height: 100%;" frameborder="0">
        
        </iframe>
        </div>
    </body>
    <%}%>
</html>

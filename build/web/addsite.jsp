<%-- 
    Document   : addsite
    Created on : Jul 13, 2012, 12:27:02 PM
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
        <title>Ajout/Modification d'un site</title>
        <link rel="stylesheet" href="css/screen.css" type="text/css" media="screen" title="default" />
        <meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
        <style type="text/css">
      html { height: 100% }
      body { height: 100%; margin: 0; padding: 0 }
      #map_canvas { height: 100% }
    </style>
    <%
    ActionsDef act = new ActionsDef();
    String noedit="";
    if(!act.isAdmin(session.getAttribute("user").toString())){
        noedit = "editable=false";
    }
        
        
        String inf1="",inf2="0.0",inf3="0.0",inf4="",inf5="",inf6="1",infv="",dis="",sub="",ids="";
        if(request.getParameter("ids")!=null){
        ids = request.getParameter("ids");
        if(request.getParameter("edit")==null){
        dis = "disabled";
        infv = "style='visibility: hidden'";
                      }else{
            dis="";
            infv = "";
                       }
        DBconnect db = new DBconnect();
        db.liaison();
        db.S = db.conn.createStatement();
        Double lat=0.0,lon=0.0;
        ResultSet rs;
        rs = db.S.executeQuery("Select * from site where idsite='"+ids+"'");
        if(rs.next()){
            
        inf1=rs.getString(2);
        inf2 = rs.getString(3);
        inf3 = rs.getString(4);
        inf4 = rs.getString(5);
        inf5 = rs.getString(6);
        inf6 = rs.getString(7);
        //dis = "editable=false";
        sub = "style=\"visibility:hidden\"";
                      }
               }else{
            ids="";
            inf1="";
        
        inf4 = "";
        inf5 = "";
            inf2 = "0.0";
            inf3 = "0.0";
            inf6 = "1";
            dis = "";
            sub = "action=\"add\"";
               }
        %>
    <script type="text/javascript" src="http://maps.googleapis.com/maps/api/js?key=AIzaSyCFprLbFmAvJbDaoI2I0Q1SbC542I6G1CE&sensor=false"></script>
       <script type="text/javascript">
                function initialize(lat, lng) {
           var myLatlng = new google.maps.LatLng(lat,lng);
  var myOptions = {
    zoom: 7,
    center: myLatlng,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  }
  var map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);
  
  //var image = 'img/bts.png';
  var myMarker = new google.maps.Marker({
      position: new google.maps.LatLng(lat,lng),
      map: map,
      draggable: true
      //icon: image
  });
  
  function placeMarker(location) {
    if ( myMarker ) {
        myMarker.setPosition(location);
    } else {
        myMarker = new google.maps.Marker({
        position: location,
        map: map
        });
        }
    }
    google.maps.event.addListener(myMarker, 'dragend', function(evt){
    document.getElementById('txtx').value = evt.latLng.lat().toFixed(3);
    document.getElementById('txty').value = evt.latLng.lng().toFixed(3);
});

map.setCenter(myMarker.position);
myMarker.setMap(map);
  }
  function updatePosition(){
    var lat = parseFloat(document.getElementById("txtx").value);
    var lon = parseFloat(document.getElementById("txty").value);
    if (lat && lon) {
        //var newPosition = new google.maps.LatLng(lat,lon);
        //placeMarker(newPosition);
        initialize(lat,lon);
    }
}
    </script>
    </head>
    <body onload='initialize(parseFloat(<%=inf2%>),parseFloat(<%=inf3%>))'>
        
    <center>
        <div style="float: left;">
            <form method="post" action="actions?action=editsite" >
        <table border="0" cellpadding="0" cellspacing="0"  id="id-form">
		<tr>
			<th valign="top">ID site:</th>
                        <td><input type="text" name="ids" <%=dis%> value="<%=ids%>"  class="inp-form" /></td>
			<td rowspan="6"></td>
		</tr>
                <tr>
			<th valign="top">Description:</th>
                        <td><input type="text" name="desc" <%=dis%> value="<%=inf1%>" class="inp-form" /></td>
			<td></td>
		</tr>
                <tr>
			<th valign="top">X:</th>
                        <td><input type="text" name="txtx" <%=dis%> value="<%=inf2%>" id="txtx" class="inp-form" onchange='updatePosition()'/></td>
                        <td ></td>
		</tr>
                <tr>
			<th valign="top">Y:</th>
			<td><input type="text" name="txty" <%=dis%> value="<%=inf3%>" id="txty" class="inp-form" onchange='updatePosition()'/></td>
			<td></td>
		</tr>
                <tr>
			<th valign="top">Type:</th>
                        
			<td>
                            <select name="typ" style="width:100%" <%=dis%>> 
                                <option value="indoor" <% if(inf4.compareToIgnoreCase("indoor")==0) out.print("selected"); %>>Indoor</option>
                                <option value="outdoor" <% if(inf4.compareToIgnoreCase("outdoor")==0) out.print("selected"); %>>Outdoor</option>
                                <option value="shalter" <% if(inf4.compareToIgnoreCase("shalter")==0) out.print("selected"); %>>Shalter</option>
                            </select>
                        </td>
                        <td></td>
		</tr>
                <tr>
			<th valign="top">Propriété:</th>
                        <td><input type="text" name="prop" <%=dis%> value="<%=inf5%>" class="inp-form" /></td>
			<td></td>
		</tr>
                <tr>
			<th valign="top">Etat:</th>
                        <td>
                            <select name="status" style="width:100%" <%=dis%> <%=noedit%>> 
                                <option value="1" <% if(Integer.parseInt(inf6)==1){%> selected <%} %>>Etude</option>
                                <option value="2" <% if(Integer.parseInt(inf6)==2){%> selected <%} %>>Déploiement</option>
                                <option value="3" <% if(Integer.parseInt(inf6)==3){%> selected <%} %>>Service</option>
                            </select>
                            
                        <td ></td>
		</tr>
                <tr>
		<th>&nbsp;</th>
		<td valign="top" <%=sub%>>
			<input type="submit" value="" class="form-submit" />
			<input type="reset" value="" class="form-reset"  />
		</td>
		<td></td>
	</tr>

        </table>
                        </form>
            </div>
        <div id="map_canvas" style="background-color: #1c94c4 ;position: relative; z-index: 1000; width:40%;height:250px; float: left;"></div>
    </center>
    </body>
</html>

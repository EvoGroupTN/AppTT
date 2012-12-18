<%-- 
    Document   : getsite
    Created on : Jul 13, 2012, 11:49:51 AM
    Author     : hakeem
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="evo.db.DBconnect"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
        <style type="text/css">
      html { height: 100% }
      body { height: 100%; margin: 0; padding: 0 }
      #map_canvas { height: 50% }
    </style>
    <script type="text/javascript" src="http://maps.googleapis.com/maps/api/js?key=AIzaSyCFprLbFmAvJbDaoI2I0Q1SbC542I6G1CE&sensor=false"></script>
        <title>JSP Page</title>
        <%
        String ids = request.getParameter("ids");
        DBconnect db = new DBconnect();
        db.liaison();
        db.S = db.conn.createStatement();
        Double lat=0.0,lon=0.0;
        ResultSet rs;
        rs = db.S.executeQuery("Select xsite,ysite from site where idsite='"+ids+"'");
        if(rs.next()){
        lat=rs.getDouble(1);
        lon = rs.getDouble(2);
                      }
        %>
        <script type="text/javascript">
                function initialize() {
           var myLatlng = new google.maps.LatLng(<%=lat%>,<%=lon%>);
  var myOptions = {
    zoom: 17,
    center: myLatlng,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  }
  var map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);
  window.alert(document.getElementById("map_canvas").textContent);
  var image = 'img/bts.png';
  var btsMarker = new google.maps.Marker({
      position: new google.maps.LatLng(<%=lat%>,<%=lon%>),
      map: map,
      icon: image
  });
  }
    </script>
    </head>
    <body  onload="initialize()">
        <div id="map_canvas" style="position: absolute; z-index: 100; width:100%;height:80%;">tessst</div>
        <p><% 
        
            
        rs = db.S.executeQuery("select * from site where idsite = '"+ids+"'");
        String [] txt = new String[6];
        txt[0]="id";txt[1]="Description";txt[2]="X";txt[3]="Y";txt[4]="Type du site";txt[5]="Propriété";
        while(rs.next()){
            for(int i=0;i<6;i++)
                out.print(txt[i]+" : "+rs.getString(i+1)+" | ");
        }
    %></p>
    </body>
</html>

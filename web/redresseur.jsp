<%-- 
    Document   : sites
    Created on : Jul 17, 2012, 11:56:55 AM
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
        <title>Les redresseurs</title>
        
    </head>
    
    <body onload="$('#step-holder').hide('slow')">
        	 
	
	
        
        <div class="clear">&nbsp;</div>
        <br/> 
	
		<!-- start id-form -->
                <%
                DBconnect db = new DBconnect();
        db.liaison();
        db.S = db.conn.createStatement();
        String vis;
        ActionsDef ad = new ActionsDef();
        if(ad.isAdmin(session.getAttribute("user").toString()))
            vis = "visibility: visible;";
        else
            vis = "visibility: hidden;";
        ResultSet rs,rs1;
        if(request.getParameter("q")!=null){
            String q = request.getParameter("q");
            rs = db.S.executeQuery("Select * from redresseur where idredresseur like '%"+q+"%' or marque like '%"+q+"%' or puissance like '%"+q+"%' or consommation like '%"+q+"%' or descredresseur like '%"+q+"%' or status like '%"+q+"%' or idenv like '%"+q+"%'");
            
                               }else{
            rs = db.S.executeQuery("select * from redresseur");
                               }
        int i=0;
        //String [] txt = new String[6];
        //txt[0]="id";txt[1]="Description";txt[2]="X";txt[3]="Y";txt[4]="Type du site";txt[5]="Propriété";
        while(rs.next()){
            //for(int i=0;i<6;i++)
            i++;
            String ids = rs.getString(1);
            //String info2 = rs.getString(5);
            String info3="";
            String stat="";
            if(rs.getString(6).compareToIgnoreCase("disabled") ==0) stat="dis";
            //int st = rs.getInt(5);
            if ((i % 2) != 0)
                info3="style='clear: both;'";
            %>
            <div id="<%=ids%>" <%=info3 %> class="contentrow<%=stat%>">
                <h1><%=ids%></h1>
                <p class="txtinfo"><b>Marque:</b> <%=rs.getString(3) %> | <b>Puissance:</b> <%=rs.getString(4) %> | <b>Consommation (en DC):</b> <%=rs.getString(7) %></p>
                <p class="txtinfo"><b>Description ou remarques:</b> <%=rs.getString(5) %></p>
                
                    <div style="float: left;"><a  href='#' onclick="showsiteinfo('getredresseur.jsp?idb=<%=ids%>');">Afficher</a></div>&nbsp;<div style="float: left;<%=vis%>">&nbsp;| <a href='getredresseur.jsp?edit&idb=<%=ids%>' target='frminfo' onclick="showinfo()">Modifier</a> | <a href="actions?action=delete&what=redresseur&ids=<%=ids%>" target='frmsub' onclick="loadtodiv('#<%=ids%>','done.html')">Supprimer</a></div><br/>
                
	<!-- end id-form  -->
            </div> 
                <%
        }
                %>
 
    </body>
</html>

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
        <title>Les compteurs</title>
        
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
            rs = db.S.executeQuery("Select * from compteur where idcompteur like '%"+q+"%' or status like '%"+q+"%' or idenv like '%"+q+"%'");
            
                               }else{
            rs = db.S.executeQuery("select * from compteur");
                               }
        int i=0;
        //String [] txt = new String[6];
        //txt[0]="id";txt[1]="Description";txt[2]="X";txt[3]="Y";txt[4]="Type du site";txt[5]="Propriété";
        while(rs.next()){
            //for(int i=0;i<6;i++)
            i++;
            String ids = rs.getString(1);
            String info1 = rs.getString(3);
            String info = rs.getString(4);
            String info2 = rs.getString(5);
            String info3="";
            String stat="";
            if(rs.getString(6).compareToIgnoreCase("disabled") ==0) stat="dis";
            //int st = rs.getInt(5);
            if ((i % 2) != 0)
                info3="style='clear: both;'";
            %>
            <div id="<%=ids%>" <%=info3 %> class="contentrow<%=stat%>">
                <h1><%=ids%></h1>
                <p class="txtinfo"><b>Mois:</b> <%=info1%> | <b>Dernier index:</b> <%=info%></p>
                <p class="txtinfo"><b>Description ou remarques:</b> <%=info2%></p>
                
                    <div style="float: left;"><a  href='#' onclick="showsiteinfo('getcompteur.jsp?idb=<%=ids%>');">Afficher</a>&nbsp;|&nbsp;<a  href='compteurhist.jsp?ids=<%=ids%>' target='frminfo' onclick="showinfo()">Afficher l'historique</a></div>&nbsp;<div style="float: left;<%=vis%>">&nbsp;| <a href='getcompteur.jsp?edit&idb=<%=ids%>' target='frminfo' onclick="showinfo()">Modifier</a> | <a href="actions?action=delete&what=compteur&ids=<%=ids%>" target='frmsub' onclick="loadtodiv('#<%=ids%>','done.html')">Supprimer</a></div><br/>
                
	<!-- end id-form  -->
            </div> 
                <%
        }
                %>
 
    </body>
</html>

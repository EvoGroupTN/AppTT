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
        <title>Les RBS</title>
        
    </head>
    
    <body>
        	 
	
	
        
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
        ResultSet rs;
        if(request.getParameter("q")!=null){
            String q = request.getParameter("q");
            rs = db.S.executeQuery("Select * from RBS where idRBS like '%"+q+"%' or idsite like '%"+q+"%' or utrancell like '%"+q+"%' or descRBS like '%"+q+"%'");
            /*if(q.compareToIgnoreCase("status1") == 0)
                rs = db.S.executeQuery("Select * from BTS where status=1");
            if(q.compareToIgnoreCase("status2") == 0)
                rs = db.S.executeQuery("Select * from BTS where status=2");
            if(q.compareToIgnoreCase("status3") == 0)
                rs = db.S.executeQuery("Select * from BTS where status=3");
            */
                               }else{
            rs = db.S.executeQuery("select * from RBS");
                               }
        //String [] txt = new String[6];
        //txt[0]="id";txt[1]="Description";txt[2]="X";txt[3]="Y";txt[4]="Type du site";txt[5]="Propriété";
         int i=0;
        //String [] txt = new String[6];
        //txt[0]="id";txt[1]="Description";txt[2]="X";txt[3]="Y";txt[4]="Type du site";txt[5]="Propriété";
        while(rs.next()){
            //for(int i=0;i<6;i++)
            i++;
            String ids = rs.getString(1);
            String info1 = rs.getString(3);
            String info = rs.getString(4);
            //String info2 = rs.getString(5);
            String info3="";
            //int st = rs.getInt(5);
            if ((i % 2) != 0)
                info3="style='clear: both;'";
            %>
            <div id="<%=ids%>" <%=info3 %> class="contentrow">
                <h1><%=ids%></h1>
                <p class="txtinfo"><b>UtranCell: </b> <%=info1%></p>
                <p class="txtinfo"><b>Description ou remarques:</b> <%=info%></p>
                <div style="float: left;"><a  href='getRBS.jsp?ids=<%=ids%>' target="_blank">Afficher configuration</a></div>&nbsp;<div style="float: left;<%=vis%>">&nbsp;| <a href="actions?action=delete&what=RBS&ids=<%=ids%>" target='frmsub' onclick="loadtodiv('#<%=ids%>','done.html')">Supprimer</a></div><br/>
               
	<!-- end id-form  -->
            </div> 
                <%
        }
                %>
 
    </body>
</html>

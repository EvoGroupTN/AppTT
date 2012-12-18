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
        <title>Les BSC</title>
        
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
            rs = db.S.executeQuery("Select * from BSC where idBSC like '%"+q+"%' or idMSC like '%"+q+"%' or idequipement like '%"+q+"%' or configuration like '%"+q+"%'");
            /*if(q.compareToIgnoreCase("status1") == 0)
                rs = db.S.executeQuery("Select * from BTS where status=1");
            if(q.compareToIgnoreCase("status2") == 0)
                rs = db.S.executeQuery("Select * from BTS where status=2");
            if(q.compareToIgnoreCase("status3") == 0)
                rs = db.S.executeQuery("Select * from BTS where status=3");
            */
                               }else{
            rs = db.S.executeQuery("select * from BSC");
                               }
        //String [] txt = new String[6];
        //txt[0]="id";txt[1]="Description";txt[2]="X";txt[3]="Y";txt[4]="Type du site";txt[5]="Propriété";
        while(rs.next()){
            //for(int i=0;i<6;i++)
            String ids = rs.getString(1);
            String info = rs.getString(2);
            //int st = rs.getInt(5);
            /*String styleclass;
            if(st==1){
                styleclass = "btsdep";
            }else{
                if(st == 2){
                    styleclass = "btsetude";
                }else{
                    styleclass = "btsmes";
                }
            }*/
            %>
            <div id="<%=ids%>" class="contentrow">
                <h1><%=ids%></h1>
                <p class="txtinfo"><%=info%></p>
                <div style="float: left;"><a  href='#' onclick="showsiteinfo('getbsc.jsp?idb=<%=ids%>');">Afficher</a></div>&nbsp;<div style="float: left;<%=vis%>">&nbsp;| <a href='getbsc.jsp?edit&idb=<%=ids%>' target='frminfo' onclick="showinfo()">Modifier</a> | <a href="actions?action=delete&what=BSC&ids=<%=ids%>" target='frmsub' onclick="loadtodiv('#<%=ids%>','done.html')"">Supprimer</a></div><br/>
               
	<!-- end id-form  -->
            </div> 
                <%
        }
                %>
 
    </body>
</html>

<%-- 
    Document   : compteurhist
    Created on : Aug 2, 2012, 12:27:31 PM
    Author     : hakeem
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="evo.db.DBconnect"%>
<%@page import="evo.actions.ActionsDef"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Historique d'un compteur</title>
         <link rel="stylesheet" href="css/screen.css" type="text/css" media="screen" title="default" />
    </head>
    <%
    ActionsDef act = new ActionsDef();
    String noedit="";
    if(!act.isAdmin(session.getAttribute("user").toString())){
        noedit = "editable=false";
    }
        String inf1="",inf2="",inf3="",infv="",inf4="",inf5="",inf6="",dis="",sub="",ids="",dis_id="";
        DBconnect db = new DBconnect();
        db.liaison();
        ResultSet rs;
        if(request.getParameter("ids")!=null){
        ids = request.getParameter("ids");
        if(request.getParameter("date")!=null){
        if(!request.getParameter("date").isEmpty()) inf1 = " and date='"+request.getParameter("date")+"' ";
               }
        
        
        
        db.S = db.conn.createStatement();
        %>
        
    <body>
        <table>
            <tr>
                <td colspan="3" align="right">
                    <div class="search" style="float: right" >
                        <form method="GET" id="frm">
                                            Chercher l'index d'un mois (ex. 02/2012):
                                            <input type="hidden" name="ids" value="<%=ids%>">
                                            <input type="text" name="date" style="width: 75px" id="txtsearchsite" />
                                            
                                            <button onclick="frm.submit();">Chercher</button>
                    </form>
                    </div>
					
                </td>
            </tr>
            <tr>
            <th style="width: 30%">Mois</th>
            <th style="width: 30%">Index</th>
            <th style="width: 30%">Consommation</th>
            </tr>
            <%
            //sub = "action=\"actions?action=editbat&ids="+ids+"\"";
        rs = db.S.executeQuery("Select * from historiquecompteur where idcompteur='"+ids+"'"+inf1);
        long previndex = 0;
        while(rs.next()){
        
        %>
            <tr>
                <th align="middle"><%=rs.getString(3)%> </th>
                <td align="middle"><%=rs.getLong(4) %> </td>
                <td align="middle"><%=rs.getLong(5)%></td>
            </tr>
            <% 
            previndex = rs.getLong(4);
                } 
           }%>
        </table>
    </body>
</html>

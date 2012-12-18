<%-- 
    Document   : addsite
    Created on : Jul 13, 2012, 12:27:02 PM
    Author     : hakeem
--%>

<%@page import="java.util.Vector"%>
<%@page import="evo.actions.ActionsDef"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="evo.db.DBconnect"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Ajout/Modification d'un BTS</title>
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
        String inf1="",inf2="",inf3="0",inf4="",inf5="",inf6="",dis="",sub="",ids="",dis_id="";
        DBconnect db = new DBconnect();
        db.liaison();
        ResultSet rs;
        Vector<String> vl = new Vector(100);
        if(request.getParameter("idb")!=null){
        ids = request.getParameter("idb");
        vl.add("");
        vl.add("");
        vl.add("");
        vl.add("");
        vl.add("");
        vl.add("");
        vl.add("");
        vl.add("");
        vl.add("");
        if(request.getParameter("edit")==null){
        dis = "disabled";
        inf4 = "style='visibility: hidden'";
                      }else{
            dis="";
            inf4 = "";
                       }
        
        
        db.S = db.conn.createStatement();
        
        rs = db.S.executeQuery("Select * from BTS where idBTS='"+ids+"'");
        if(rs.next()){
            vl.removeAllElements();
        vl.add(rs.getString(2));
        vl.add(rs.getString(3));
        
        
        vl.add(rs.getString(6));
        vl.add(rs.getString(7));
        vl.add(rs.getString(8));
        vl.add(rs.getString(9));
        vl.add(rs.getString(10));
        vl.add(rs.getString(11));
        inf1=rs.getString(2);
        inf2 = rs.getString(3);
        inf3 = rs.getString(5);
        //inf4 = "\""+rs.getString(5)+"\"";
        //inf5 = "\""+rs.getString(6)+"\"";
        dis_id = "disabled";
        sub = "action=\"modif?ids="+ids+"\"";
                      }
               }else{
            ids="\"\"";
            inf1="";
        inf2 = "";
        inf3 = "0";
            dis = "";
            sub = "action=\"add\"";
               }
        %>
   
       
    </head>
    <body  >
        
    <center>
        
        <div id="btsetude" style="padding-left: 20%;position: absolute;z-index: 3">
            <form id="frm" method="post" action="actions?action=editbts&ids=<%=ids%>">
        <table border="0" cellpadding="0" cellspacing="0"  id="id-form">
		<tr>
			<th valign="top">ID BTS:</th>
                        <td><input type="text" name="ids" <%=dis_id%> <%=noedit%> value="<%=ids%>"  class="inp-form" /></td>
			<td rowspan="6"></td>
		</tr>
                <tr>
			<th valign="top">ID BSC:</th>
                        <td>
                            <select name="idbsc" style="width:100%" <%=dis%> <%=noedit%>> 
                                <%
                                    rs = db.S.executeQuery("Select idBSC from BSC");
                                    while(rs.next()){
                                %>
                                <option value="<%=rs.getString(1)%>" <% if(vl.get(0).compareToIgnoreCase(rs.getString(1))==0) out.print("selected"); %>><%=rs.getString(1)%></option>
                                <%}%>
                            </select>
                        </td>
			<td></td>
		</tr>
                <tr>
			<th valign="top">Etat:</th>
                        <td>
                            <select name="status" style="width:100%" <%=dis%> <%=noedit%>> 
                                <option value="1" <% if(Integer.parseInt(inf3)==1){%> selected <%} %>>Etude</option>
                                <option value="2" <% if(Integer.parseInt(inf3)==2){%> selected <%} %>>Déploiement</option>
                                <option value="3" <% if(Integer.parseInt(inf3)==3){%> selected <%} %>>Service</option>
                            </select>
                            
                        <td ></td>
		</tr>
                <tr>
			<th valign="top">Description:</th>
			<td><input type="text" name="desc" value="<%=vl.get(1)%>" id="txty" class="inp-form" <%=dis%>/></td>
			<td></td>
		</tr>
                <tr>
			<th valign="top">Configuration:</th>
                        <% 
                            String[] xyz = new String[3];
                            if(vl.get(2).compareToIgnoreCase("")==0){
                                xyz[0]="0";
                                xyz[1]="0";
                                xyz[2]="0";
                            }else
                                xyz = vl.get(2).split(",");
                        %>
                        <td><input type="text" name="xyz0" value="<%=xyz[0]%>" id="txty" class="inp-form" style="width:50px"<%=dis%>/><input type="text" name="xyz1" value="<%=xyz[1]%>" id="txty" class="inp-form" style="width:50px"<%=dis%>/><input type="text" name="xyz2" value="<%=xyz[2]%>" id="txty" class="inp-form" style="width:50px"<%=dis%>/></td>
			<td></td>
		</tr>
                <tr>
			<th valign="top">Support transmission:</th>
			<td><input type="text" name="s_trans" value="<%=vl.get(3)%>" id="txty" class="inp-form" <%=dis%>/></td>
			<td></td>
		</tr>
                <tr>
			<th valign="top">Abis:</th>
			<td><input type="text" name="abis" value="<%=vl.get(4)%>" id="txty" class="inp-form" <%=dis%>/></td>
			<td></td>
		</tr>
                <tr>
			<th valign="top">Port:</th>
			<td><input type="text" name="port" value="<%=vl.get(5)%>" id="txty" class="inp-form" <%=dis%>/></td>
			<td></td>
		</tr>
                <tr>
			<th valign="top">TRX:</th>
			<td><input type="text" name="trx" value="<%=vl.get(6)%>" id="txty" class="inp-form" <%=dis%>/></td>
			<td></td>
		</tr>
                <tr>
			<th valign="top">Date mise en service:</th>
			<td><input type="text" name="dmes" value="<%=vl.get(7)%>" id="txty" class="inp-form" <%=dis%>/></td>
			<td></td>
		</tr>
                <tr>
		<th>&nbsp;</th>
		<td valign="top" <%=inf4%>>
                    <input type="button" value="" class="form-submit" onclick="frm.submit();loadtodiv('#right-content','done.html');" />
			<input type="reset" value="" class="form-reset"  />
		</td>
		<td></td>
	</tr>

        </table>
                        </form>
            </div>
           
    </center>
    </body>
</html>

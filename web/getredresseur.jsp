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
        <title>Ajout/Modification d'un redresseur</title>
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
        String inf1="",inf2="",inf3="",inf4="",infv="",inf5="",inf6="",dis="",sub="",ids="",dis_id="";
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
        if(request.getParameter("edit")==null){
            
        dis = "disabled";
        infv = "style='visibility: hidden'";
                      }else{
            dis="";
            infv = "";
                       }
        
        
        db.S = db.conn.createStatement();
        Double lat=0.0,lon=0.0;
        
        //sub = "action=\"actions?action=editbat&ids="+ids+"\"";
        rs = db.S.executeQuery("Select * from redresseur where idredresseur='"+ids+"'");
        if(rs.next()){
            vl.removeAllElements();
        vl.add(rs.getString(2));
        vl.add(rs.getString(3));
        vl.add(rs.getString(4));
        vl.add(rs.getString(5));
        vl.add(rs.getString(6));
        vl.add(rs.getString(7));
        vl.add(rs.getString(8));
        //inf5 = rs.getString(6);
        dis_id = "disabled";
                      }
               }else{
            vl.add("");
        vl.add("");
        vl.add("");
        vl.add("");
        vl.add("");
        vl.add("");
        vl.add("");
        vl.add("");
            ids="";
            inf1="";
        inf2 = "";
        inf3 = "";
            dis = "";
               }
        %>
   
       
    </head>
    <body  >
        
    <center>
        
        <div  style="padding-left: 20%;position: absolute;z-index: 3">
            <form method="post" action="actions?action=editredresseur&ids=<%=ids%>" >
        <table border="0" cellpadding="0" cellspacing="0"  id="id-form">
		<tr>
			<th valign="top">ID Redresseur:</th>
                        <td><input type="text" name="ids" <%=dis_id%> <%=noedit%> value="<%=ids%>"  class="inp-form" /></td>
			<td rowspan="6"></td>
		</tr>
                <tr>
			<th valign="top">Etat:</th>
                        <td>
                            <select name="status" style="width:100%" <%=dis%> <%=noedit%>> 
                                <option value="disabled" <% if(vl.get(4).compareToIgnoreCase("disabled")==0) out.print("selected"); %>>Désactivée</option>
                                <option value="enabled" <% if(vl.get(4).compareToIgnoreCase("enabled")==0) out.print("selected"); %>>Prete</option>
                            </select>
                        </td>
			<td></td>
		</tr>
                <tr>
			<th valign="top">ID Site:</th>
                        <td>
                            <select name="idsite" style="width:100%" <%=dis%> <%=noedit%>> 
                                <%
                                    rs = db.S.executeQuery("Select * from environnement");
                                    while(rs.next()){
                                %>
                                <option value="<%=rs.getString(1)%>" <% if(vl.get(0).compareToIgnoreCase(rs.getString(1))==0) out.print("selected"); %>><%=rs.getString(2)%></option>
                                <%}%>
                            </select>
                        </td>
			<td></td>
		</tr>
                
                <tr>
			<th valign="top">Marque:</th>
			<td><input type="text" name="mrk" value="<%=vl.get(1)%>" id="txty" <%=dis%> <%=noedit%> class="inp-form"/></td>
			<td></td>
		</tr>
                <tr>
			<th valign="top">Puissance:</th>
			<td><input type="text" name="puis" value="<%=vl.get(2)%>" id="txty" <%=dis%> <%=noedit%> class="inp-form"/></td>
			<td></td>
		</tr>
                <tr>
			<th valign="top">Consommation (en DC):</th>
			<td><input type="text" name="cons" value="<%=vl.get(5)%>" id="txty" <%=dis%> <%=noedit%> class="inp-form"/></td>
			<td></td>
		</tr>
                <tr>
			<th valign="top">Date mise en service:</th>
			<td><input type="text" name="dm" value="<%=vl.get(6)%>" id="txty" <%=dis%> <%=noedit%> class="inp-form"/></td>
			<td></td>
		</tr>
                <tr>
			<th valign="top">Description:</th>
                        <td><input type="text" name="prop" value="<%=vl.get(3)%>" <%=dis%> <%=noedit%> class="inp-form" /></td>
			<td></td>
		</tr>
                <tr>
		<th>&nbsp;</th>
		<td valign="top" <%=infv%>>
			<input type="submit" value="" class="form-submit" />
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

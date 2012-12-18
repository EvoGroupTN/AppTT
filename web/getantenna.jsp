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
        <title>Ajout/Modification d'une antenne</title>
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
        Vector<String> vl = new Vector(100);
        DBconnect db = new DBconnect();
        db.liaison();
        ResultSet rs;
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
        rs = db.S.executeQuery("Select * from Antenne where idAntenne='"+ids+"'");
        if(rs.next()){
            vl.removeAllElements();
        vl.add(rs.getString(2));
        vl.add(rs.getString(3));
        vl.add(rs.getString(4));
        vl.add(rs.getString(5));
        vl.add(rs.getString(6));
        vl.add(rs.getString(7));
        //inf4 = rs.getString(9);
        //inf5 = rs.getString(6);
        dis_id = "disabled";
                      }
               }else{
            ids="";
                
            dis = "";
               }
        %>
   
       
    </head>
    <body  >
        
    <center>
        
        <div  style="padding-left: 20%;position: absolute;z-index: 3">
            <form method="post" action="actions?action=editantenne&ids=<%=ids%>" >
        <table border="0" cellpadding="0" cellspacing="0"  id="id-form">
		<tr>
			<th valign="top">ID Antenne:</th>
                        <td><input type="text" name="ids" <%=dis_id%> <%=noedit%> value="<%=ids%>"  class="inp-form" /></td>
			<td rowspan="6"></td>
		</tr>
                <tr>
			<th valign="top">Type:</th>
                        <td>
                            <select name="typeband" style="width:100%" <%=dis%>> 
                                <option value="monoband" <% if(vl.get(1).compareToIgnoreCase("monoband")==0) out.print("selected"); %>>Mono-Band</option>
                                <option value="biband" <% if(vl.get(1).compareToIgnoreCase("biband")==0) out.print("selected"); %>>Bi-Band</option>
                                <option value="triband" onclick="document.getElementsByName('bnd900')[0].checked=true;document.getElementsByName('bnd1800')[0].checked=true;document.getElementsByName('bnd2100')[0].checked=true;" <% if(vl.get(1).compareToIgnoreCase("triband")==0) out.print("selected"); %>>Tri-Band</option>
                            </select>
                        </td>
			<td></td>
		</tr>
                <tr>
			<th valign="top">ID BTS:</th>
                        <td>
                            <select name="idbts" style="width:100%" <%=dis%> <%=noedit%>> 
                                <%
                                    rs = db.S.executeQuery("Select * from BTS");
                                    while(rs.next()){
                                %>
                                <option value="<%=rs.getString(1)%>" <% if(vl.get(5).compareToIgnoreCase(rs.getString(1))==0) out.print("selected"); %>><%=rs.getString(1)%></option>
                                <%}%>
                            </select>
                        </td>
			<td></td>
		</tr>
                
                <tr>
			<th valign="top">Band:</th>
                        <td>
                            <input type="checkbox" name="bnd900" value="band 900" <% if(vl.get(2).compareToIgnoreCase("band 900")==0) out.print("checked"); %> <%=dis%>>Band 900 | <input type="checkbox" name="bnd1800" value="band 1800" <% if(vl.get(3).compareToIgnoreCase("band 1800")==0) out.print("checked"); %> <%=dis%>>Band 1800 | <input type="checkbox" name="bnd2100" value="band 2100" <% if(vl.get(4).compareToIgnoreCase("band 2100")==0) out.print("checked"); %> <%=dis%>>Band 2100
                        </td>
			<td></td>
		</tr>
                
                <tr>
			<th valign="top">Description:</th>
			<td><input type="text" name="desc" value="<%=vl.get(0)%>" id="txty" <%=dis%> <%=noedit%> class="inp-form"/></td>
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

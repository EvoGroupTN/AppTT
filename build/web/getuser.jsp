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
        <title>Ajout/Modification d'un utilisateur</title>
        <link rel="stylesheet" href="css/screen.css" type="text/css" media="screen" title="default" />
        <meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
        <style type="text/css">
      html { height: 100% }
      body { height: 100%; margin: 0; padding: 0 }
      #map_canvas { height: 100% }
    </style>
    <%
    ActionsDef act = new ActionsDef();
    String noedit="",noshow="";
    if(!act.isAdmin(session.getAttribute("user").toString())){
        noedit = "editable=false";
        
    }
        String inf1="",inf2="",inf3="",inf4="",infv="",inf5="",inf6="",dis="",sub="",ids="",dis_id="";
        DBconnect db = new DBconnect();
        db.liaison();
        ResultSet rs;
        if(request.getParameter("idb")!=null){
        ids = request.getParameter("idb");
        
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
        rs = db.S.executeQuery("Select * from users where login='"+ids+"'");
        if(rs.next()){
            
        inf1=rs.getString(2);
        inf2 = rs.getString(3);
        inf3 = rs.getString(4);
        //inf4 = rs.getString(5);
        //inf5 = rs.getString(6);
        dis_id = "editable=false";
                      }
               }else{
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
            <form method="post" action="actions?action=edituser&ids=<%=ids%>" >
        <table border="0" cellpadding="0" cellspacing="0"  id="id-form">
		<tr>
			<th valign="top">Login:</th>
                        <td><input type="text" name="ids" <%=dis_id%> <%=dis%> <%=noedit%> value="<%=ids%>"  class="inp-form" /></td>
			<td rowspan="6"></td>
		</tr>
                
                
                <tr >
			<th valign="top">Mot de passe:</th>
			<td><input type="text" name="txty" value="<%=inf1%>" id="txty" <%=dis%> <%=noedit%> class="inp-form"/></td>
			<td></td>
		</tr>
                <tr>
			<th valign="top">Type:</th>
                        <td>
                            <select name="status" style="width:100%" <%=dis%> <%=noedit%>> 
                                <option value="admin" <% if(inf2.compareToIgnoreCase("admin")==0) out.print("selected"); %>>Administrateur</option>
                                <option value="user" <% if(inf2.compareToIgnoreCase("user")==0) out.print("selected"); %>>Simple utilisateur</option>
                            </select>
                        </td>
                        <td></td>
		</tr>
                <tr>
			<th valign="top">Description:</th>
                        <td><input type="text" name="prop" value="<%=inf3%>" <%=dis%> <%=noedit%> class="inp-form" /></td>
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

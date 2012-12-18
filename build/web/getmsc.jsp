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
        <title>Ajout/Modification d'un MSC</title>
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
        String inf1="",inf2="",inf3="",inf4="",inf5="",inf6="",dis="",sub="",ids="",dis_id="";
        DBconnect db = new DBconnect();
        db.liaison();
        ResultSet rs;
        if(request.getParameter("idb")!=null){
        ids = request.getParameter("idb");
        
        if(request.getParameter("edit")==null){
        dis = "disabled";
        inf4 = "style='visibility: hidden'";
                      }else{
            dis="";
            inf4 = "";
                       }
        
        
        
        
        rs = db.S.executeQuery("Select * from MSC where idMSC='"+ids+"'");
        if(rs.next()){
            
        inf1=rs.getString(2);
        inf2 = rs.getString(3);
        inf3 = rs.getString(4);
        //inf4 = rs.getString(5);
        //inf5 = rs.getString(6);
        dis_id = "disabled";
        sub = "action=\"modif?ids="+ids+"\"";
                      }
               }else{
            ids="\"\"";
            inf1="\"\"";
        inf2 = "\"\"";
        inf3 = "\"\"";
            dis = "\"\"";
            sub = "action=\"add\"";
               }
        %>
   
       
    </head>
    <body  >
        
    <center>
        
        <div  style="float: left;">
            <form method="post" action="actions?action=editmsc" >
        <table border="0" cellpadding="0" cellspacing="0"  id="id-form">
		<tr>
			<th valign="top">ID MSC:</th>
                        <td><input type="text" name="ids" <%=dis_id%> <%=noedit%> value="<%=ids%>"  class="inp-form" /></td>
			<td rowspan="6"></td>
		</tr>
                <tr>
			<th valign="top">ID Site:</th>
                        <td>
                            <select name="idsite" style="width:100%" <%=dis%> <%=noedit%>> 
                                <%
                                    rs = db.S.executeQuery("Select * from equipement");
                                    while(rs.next()){
                                %>
                                <option value="<%=rs.getString(1)%>" <% if(inf1.compareToIgnoreCase(rs.getString(1))==0) out.print("selected"); %>><%=rs.getString(2)%></option>
                                <%}%>
                            </select>
                        </td>
			<td></td>
		</tr>
                <tr>
			<th valign="top">Date mise en service:</th>
                        <td>
                            <input type="text" name="dmes" value="<%=inf2%>" id="txty" class="inp-form"/>
                        </td>
                        <td ></td>
		</tr>
                <tr>
			<th valign="top">Configuration:</th>
			<td><input type="text" name="conf" value="<%=inf3%>" id="txty" class="inp-form"/></td>
			<td></td>
		</tr>
                <tr>
		<th>&nbsp;</th>
		<td valign="top" <%=inf4%>>
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

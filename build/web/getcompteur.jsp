<%-- 
    Document   : addsite
    Created on : Jul 13, 2012, 12:27:02 PM
    Author     : hakeem
--%>




<%@page import="java.util.Calendar"%>
<%@page import="java.util.GregorianCalendar"%>
<%@page import="evo.actions.ActionsDef"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="evo.db.DBconnect"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Ajout/Modification d'un compteur</title>
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
        String inf1="",inf2="",inf3="",infv="",inf4="",inf5="",inf6="",dis="",dt="",sub="",ids="",dis_id="";
        DBconnect db = new DBconnect();
        db.liaison();
        ResultSet rs;
        long old_index = 0;
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
        Calendar c = new GregorianCalendar();
        if(c.getTime().getMonth()+1>9)
                inf6 = (c.getTime().getMonth()+1) + "/" + (c.getTime().getYear() + 1900);
                else
                    inf6 = "0"+ (c.getTime().getMonth()+1) + "/" + (c.getTime().getYear() + 1900);
        int m = c.getTime().getMonth();
        if(c.getTime().getMonth() == 0) m=12;
        if(m>9)
                dt = (m) + "/" + (c.getTime().getYear() + 1900);
                else
                    dt = "0"+ (m) + "/" + (c.getTime().getYear() + 1900);
        //inf6 = d.getMonth() + "/" + d.getYear();
        //sub = "action=\"actions?action=editbat&ids="+ids+"\"";
        rs = db.S.executeQuery("Select * from historiquecompteur where idcompteur='"+ids+"' and date='"+dt+"'");
       
        if(rs.next()){
            old_index=rs.getLong(4);
        }
        //out.println(dt);
        rs = db.S.executeQuery("Select * from compteur where idcompteur='"+ids+"'");
        if(rs.next()){
            
        inf1=rs.getString(2);
        inf2 = rs.getString(3);
        inf3 = rs.getString(4);
        inf4 = rs.getString(5);
        inf5 = rs.getString(6);
        dis_id = "disabled";
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
            <form method="post" action="actions?action=editcompteur&ids=<%=ids%>" >
        <table border="0" cellpadding="0" cellspacing="0"  id="id-form">
		<tr>
			<th valign="top">ID Compteur:</th>
                        <td><input type="text" name="ids" <%=dis_id%> <%=noedit%> value="<%=ids%>"  class="inp-form" /></td>
			<td rowspan="6"></td>
		</tr>
                <tr>
			<th valign="top">Etat:</th>
                        <td>
                            <select name="status" style="width:100%" <%=dis%> <%=noedit%>> 
                                <option value="disabled" <% if(inf5.compareToIgnoreCase("disabled")==0) out.print("selected"); %>>Désactivée</option>
                                <option value="enabled" <% if(inf5.compareToIgnoreCase("enabled")==0) out.print("selected"); %>>Prete</option>
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
                                <option value="<%=rs.getString(1)%>" <% if(inf1.compareToIgnoreCase(rs.getString(1))==0) out.print("selected"); %>><%=rs.getString(2)%></option>
                                <%}%>
                            </select>
                        </td>
			<td></td>
		</tr>
                
                <tr>
			<th valign="top">Mois:</th>
			<td><input type="text" name="txty" value="<%=inf6%>" id="txty" <%=dis%> <%=noedit%> class="inp-form"/></td>
			<td></td>
		</tr>
                <tr>
			<th valign="top">Nouveau Index:</th>
                        <td><input type="text" name="typ" id="typ" onchange="document.getElementById('consom').value = (document.getElementById('typ').value - <%=old_index%>).toString()" onkeyup="document.getElementById('consom').value = (document.getElementById('typ').value - <%=old_index%>).toString()" value="<%=inf3%>"  class="inp-form" /></td>
                        <td>Consommation: <input type="text" name="cons" id="consom" locked=true ></td>
		</tr>
                <tr>
			<th valign="top">Description:</th>
                        <td><input type="text" name="prop" value="<%=inf4%>" <%=dis%> <%=noedit%> class="inp-form" /></td>
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

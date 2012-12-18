<%-- 
    Document   : site
    Created on : Jul 16, 2012, 12:32:41 PM
    Author     : hakeem
--%>

<%@page import="evo.db.DBconnect"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Equipement</title>
        <%
        String inf1="",inf2="",inf3="",inf4="",inf5="",inf6="",dis="",sub="",ids="",idequip="";
        if(request.getParameter("ids")!=null){
        ids = request.getParameter("ids");
        
        DBconnect db = new DBconnect();
        db.liaison();
        db.S = db.conn.createStatement();
        Double lat=0.0,lon=0.0;
        ResultSet rs;
        rs = db.S.executeQuery("Select * from site where idsite='"+ids+"'");
        if(rs.next()){
            
        inf1=rs.getString(2);
        inf2 = rs.getString(3);
        inf3 = rs.getString(4);
        inf4 = rs.getString(5);
        inf5 = rs.getString(6);
               }
        rs = db.S.executeQuery("Select idequipement from equipement where idsite='"+ids+"'");
        
        if(rs.next()){
            idequip = rs.getString(1);
        }else{
            idequip = "equip999999999";
        }
               }
               %>
               <script type="text/javascript">
                   
               </script>
    </head>
    <body onload="$('#step-holder').hide('slow')">
        <div >
            <a id='loaddata' href='#' onclick="loadtodiv('#right-content','sites.jsp');">Retour</a> | <a id='loaddata' href='#' onclick="window.print() ">Imprimer</a>
        <h1><%=ids%></h1>
        <h2><%=inf1%></h2>
        </div>
        <div style="clear: both;">
            <p  style="background-color: #f1faff ; width: 100;font-size: 5">RBS: <a href='#' onclick="loadtodiv('#rbsdiv','rbs.jsp?q=<%=ids%>');">afficher</a>&nbsp;&nbsp;/&nbsp; <a href="#" onclick="$('#rbsdiv').slideUp('medium');"> masquer </a>&nbsp;&nbsp;&nbsp; </p>
        <div id="rbsdiv">
            
        </div>
        </div>
        <br/>
        <div style="clear: both;">
            <p>&nbsp;</p>
            <p  style="background-color: #f1faff ; width: 100;font-size: 5">Antennes: <a href='#' onclick="loadtodiv('#antdiv','antenna.jsp?q=<%=idequip%>');">afficher</a>&nbsp;&nbsp;/&nbsp; <a href="#" onclick="$('#antdiv').slideUp('medium');"> masquer </a></p>
        <div id="antdiv">
            
        </div>
        </div>
        <br/>
        <div style="clear: both;">
            <p>&nbsp;</p>
            <p  style="background-color: #f1faff ; width: 100;font-size: 5">BTS: <a href='#' onclick="loadtodiv('#btsdiv','bts.jsp?q=<%=idequip%>');">afficher</a>&nbsp;&nbsp;/&nbsp; <a href="#" onclick="$('#btsdiv').slideUp('medium');"> masquer </a></p>
        <div id="btsdiv">
            
        </div>
        </div>
        
        <br/>
        <div style="clear: both;">
            <p>&nbsp;</p>
            <p  style="background-color: #f1faff ; width: 100;">BSC: <a id='loaddata' href='#' onclick="loadtodiv('#bscdiv','bsc.jsp?q=<%=idequip%>');">afficher</a>&nbsp;&nbsp;/&nbsp; <a href="#" onclick="$('#bscdiv').slideUp('medium');"> masquer </a></p>
        <div id="bscdiv">
            
        </div>
        </div>
        <p></p>
        <br/>
        <div style="clear: both;">
            <p>&nbsp;</p>
            <p  style="background-color: #f1faff ; width: 100;">MSC: <a id='loaddata' href='#' onclick="loadtodiv('#mscdiv','msc.jsp?q=<%=idequip%>');">afficher</a>&nbsp;&nbsp;/&nbsp; <a href="#" onclick="$('#mscdiv').slideUp('medium');"> masquer </a></p>
        <div id="mscdiv">
            
        </div>
        </div>
    </body>
</html>

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
        <title>Environnement</title>
        <%
        String inf1="",inf2="",inf3="",inf4="",inf5="",inf6="",dis="",sub="",ids="",idenv="";;
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
        rs = db.S.executeQuery("Select idenv from environnement where idsite='"+ids+"'");
        
        if(rs.next()){
            idenv = rs.getString(1);
        }else{
            idenv = "equip999999999";
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
            <p  style="background-color: #f1faff ; width: 100;font-size: 5">Batteries: <a href='#' onclick="loadtodiv('#batdiv','batteries.jsp?q=<%=idenv%>');">afficher</a>&nbsp;&nbsp;/&nbsp; <a href="#" onclick="$('#batdiv').slideUp('medium');"> masquer </a></p>
        <div id="batdiv">
            
        </div>
        </div>
        
        <br/>
        <div style="clear: both;">
            <p>&nbsp;</p>
            <p  style="background-color: #f1faff ; width: 100;">Climatisation: <a id='loaddata' href='#' onclick="loadtodiv('#clidiv','climatisation.jsp?q=<%=idenv%>');">afficher</a>&nbsp;&nbsp;/&nbsp; <a href="#" onclick="$('#clidiv').slideUp('medium');"> masquer </a></p>
        <div id="clidiv">
            
        </div>
        </div>
        <p></p>
        <br/>
        <div style="clear: both;">
            <p>&nbsp;</p>
            <p  style="background-color: #f1faff ; width: 100;">Compteurs: <a id='loaddata' href='#' onclick="loadtodiv('#cmptdiv','compteur.jsp?q=<%=idenv%>');">afficher</a>&nbsp;&nbsp;/&nbsp; <a href="#" onclick="$('#cmptdiv').slideUp('medium');"> masquer </a></p>
        <div id="cmptdiv">
            
        </div>
        </div>
        <p></p>
        <br/>
        
        <div style="clear: both;">
            <p>&nbsp;</p>
            <p  style="background-color: #f1faff ; width: 100;">Redresseurs: <a id='loaddata' href='#' onclick="loadtodiv('#reddiv','redresseur.jsp?q=<%=idenv%>');">afficher</a>&nbsp;&nbsp;/&nbsp; <a href="#" onclick="$('#reddiv').slideUp('medium');"> masquer </a></p>
        <div id="reddiv">
            
        </div>
        </div>
    </body>
</html>

<%-- 
    Document   : add2
    Created on : Jul 29, 2012, 10:26:23 AM
    Author     : hakeem
--%>

<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="evo.db.DBconnect"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title></title>
        <script src="js/jquery-1.7.2.min.js"></script>
        <script src="js/jquery-ui-1.8.21.custom.min.js"></script>
        <link rel="stylesheet" type="text/css" href="css/ui-lightness/jquery-ui-1.8.21.custom.css">
        <link rel="stylesheet" href="css/screen.css" type="text/css" title="default" />
    <script type="text/javascript">
        function initialize(){
            <%
        String ids="",pos="",ide="999999";
        DBconnect db = new DBconnect();
        db.liaison();
        ResultSet rs,rs1,rs2;
        Statement S3 = null;
        if((request.getParameter("typeadd")!=null)&&(request.getParameter("idadd")!=null)){
        ids = request.getParameter("typeadd");
            pos = request.getParameter("idadd");  
            if(ids.compareToIgnoreCase("user")==0){
                rs = db.S.executeQuery("Select * from users where login='"+pos+"'");
            }else{
            rs = db.S.executeQuery("Select * from "+ids+" where id"+ids+"='"+pos+"'");
                       }
            if(rs.next()){ %>
                    window.alert("Cet ID est déjà utilisé. Vueillez choisir un autre");
                    document.location = "add.jsp";
                             <%  }else{
                
                if(ids.compareToIgnoreCase("site")==0){
                    
                    response.sendRedirect("addsite.jsp?edit&ids="+pos);
                }
                if(ids.compareToIgnoreCase("bts")==0) response.sendRedirect("getbts.jsp?edit&idb="+pos);
                if(ids.compareToIgnoreCase("antenne")==0) response.sendRedirect("getantenna.jsp?edit&idb="+pos);
                if(ids.compareToIgnoreCase("msc")==0) response.sendRedirect("getmsc.jsp?edit&idb="+pos);
                if(ids.compareToIgnoreCase("bsc")==0) response.sendRedirect("getbsc.jsp?edit&idb="+pos);
                if(ids.compareToIgnoreCase("rbs")==0) response.sendRedirect("getRBS.jsp?edit&ids="+pos);
                if(ids.compareToIgnoreCase("batterie")==0) response.sendRedirect("getbatterie.jsp?edit&idb="+pos);
                if(ids.compareToIgnoreCase("compteur")==0) response.sendRedirect("getcompteur.jsp?edit&idb="+pos);
                if(ids.compareToIgnoreCase("redresseur")==0) response.sendRedirect("getredresseur.jsp?edit&idb="+pos);
                if(ids.compareToIgnoreCase("climatisation")==0) response.sendRedirect("getclimatisation.jsp?edit&idb="+pos);
                if(ids.compareToIgnoreCase("user")==0) response.sendRedirect("getuser.jsp?edit&idb="+pos);
                /*if(ids.compareToIgnoreCase("site")==0) response.sendRedirect("addsite.jsp?ids="+pos);
                if(ids.compareToIgnoreCase("site")==0) response.sendRedirect("addsite.jsp?ids="+pos);*/
                             }
                             }
            %>
                    
        }
        
    </script>
    </head>
    
        
            <body onload="initialize()">
                <div id="cntnt"></div>
    </body>
</html>

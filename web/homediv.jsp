<%-- 
    Document   : getsite
    Created on : Jul 13, 2012, 11:49:51 AM
    Author     : hakeem
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="evo.db.DBconnect"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
        
      <title>Instructions</title>
        
    </head>
    <body >
        <div style="margin-top: 30px; margin-left: 20px">
            <h1>Bienvenue à l'application de gestion d'équipement et d'environnement de Tunisie Telecom. Dans cette application vous pouvez:</h1><br/><br/>
            <div id="inst1"><a href="#">Consulter (par liste ou sur Google Maps), modifier et supprimer les sites</a><br/><br/>
                <div id="arrow1"><img src="img/pathsite.png"></div></div>
            <div id="inst2"><a href="#" >Consulter, modifier et supprimer les élements d'équipement</a><br/><br/>
                <div id="arrow2"><img src="img/pathequip.png"></div></div>
            <div id="inst3"><a href="#" >Consulter, modifier et supprimer les RBS</a><br/><br/>
            <div id="arrow3"><img src="img/pathrbs.png"></div></div>
            <div id="inst4"><a href="#" >Consulter, modifier et supprimer les élements d'environnement</a><br/><br/>
            <div id="arrow4"><img src="img/pathenv.png"></div></div>
            <div id="inst5"><a href="#" >Utiliser l'assistant pour ajouter des sites, des utilisateurs ou des élements (admin seulement)</a><br/><br/>
            <div id="arrow5"><img src="img/pathadd.png"></div></div>
            <div id="inst6"><a href="#" >Consulter, modifier et supprimer les utilisateurs (pour les simples utilisateurs, consulter son compte seulement)</a><br/><br/>
            <div id="arrow6"><img src="img/pathuser.png"></div></div>
            <div id="inst7"><a href="#" >Chercher un site, un élement ou un utilisateur</a><br/><br/>
            <div id="arrow7"><img src="img/pathsrch.png"></div></div>
        </div>
    </body>
</html>

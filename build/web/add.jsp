<%-- 
    Document   : add
    Created on : Jul 29, 2012, 10:08:34 AM
    Author     : hakeem
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Assistant d'Ajout</title>
        <script src="js/jquery-1.7.2.min.js"></script>
        <script src="js/jquery-ui-1.8.21.custom.min.js"></script>
        <link rel="stylesheet" type="text/css" href="css/ui-lightness/jquery-ui-1.8.21.custom.css">
        <link rel="stylesheet" href="css/screen.css" type="text/css" title="default" />
    </head>
    <body>
        <h1>Bienvenue dans l'assistant d'ajout</h1>
        <p>&nbsp;</p>
        <p>&nbsp;</p>
        <p>&nbsp;</p>
        <p>&nbsp;</p>
    <center>
        <h2>Que voulez-vous ajouter?</h2>
        <p>&nbsp;</p>
        <form action="add2.jsp" method="GET">
            <select name="typeadd" id="typeadd" style="width: 230px"  onchange="if(document.getElementById('typeadd').value != '') document.getElementById('idadd').style.visibility = 'visible'; else document.getElementById('idadd').style.visibility = 'hidden';">
                <option value=""></option>
                <option value="user">Utilisateur</option>
                <option value="site">Site</option>
                <option value="RBS">RBS</option>
                <option value="BTS">BTS</option>
                <option value="BSC">BSC</option>
                <option value="MSC">MSC</option>
                <option value="Antenne">Antenne</option>
                <option value="Batterie">Batterie</option>
                <option value="climatisation">Climatisation</option>
                <option value="compteur">Compteur</option>
                <option value="redresseur">Redresseur</option>
            </select>
    
            <p>&nbsp;</p>
            <div style="visibility: hidden; left: 40% "  id="idadd">Donner ID: <input type="text" name="idadd" value=""></div>
            <p>&nbsp;</p>
    </center>
            <p>&nbsp;</p>
            <p>&nbsp;</p>
            <p>&nbsp;</p>
            <p>&nbsp;</p>
            <p align="right"> <input type="submit" value="Suivant >"></p>
        </form>
    </body>
</html>

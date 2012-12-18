<%-- 
    Document   : login
    Created on : Jul 11, 2012, 10:50:21 AM
    Author     : hakeem
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="css/reset.css">
<link rel="stylesheet" type="text/css" href="css/structure.css">
        <title>Système de Gestion d'Equipement et d'Environnement | Connexion</title>
    </head>
    <body>
        <%if(session.getAttribute("user")!=null){%>
        
        <%response.sendRedirect("index.jsp");
        }
        String msg="";
        if(request.getParameter("err")!=null){
            msg = "Login ou mot de passe invalide!";
        }else{
            msg = "";
        }
        %>
        
        <form class="box login" method="post" action="actions?action=login">
            <fieldset class="boxNotif">
                <%=msg%>
            </fieldset>    
	<fieldset class="boxBody">
	  <label>Login</label>
	  <input type="text" name="login" tabindex="1" placeholder="Taper votre login" required>
	  <label>Mot de passe</label>
          <input type="password" name="pwd" tabindex="2" required>
	</fieldset>
	<footer>
	  
	  <input type="submit" class="btnLogin" value="Login" tabindex="3">
	</footer>
</form>
<footer id="main">
  <a>Système de Gestion d'Equipement et d'Environnement </a> | <a href="mailto:wa.evolution@gmail.com" target="_blank">WAHAB Hakeem</a> &copy; Copyright <a href="http://www.evogroup.hostoi.com/" target="_blank">EVO Group</a>. All rights reserved 2012
</footer>
    </body>
</html>

<%-- 
    Document   : getports
    Created on : Jul 25, 2012, 11:36:48 PM
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
        <title>Ajout/Modification des ports d'un RBS</title>
        
        <script src="js/jquery-1.7.2.min.js"></script>
        <script src="js/jquery-ui-1.8.21.custom.min.js"></script>
        <link rel="stylesheet" type="text/css" href="css/ui-lightness/jquery-ui-1.8.21.custom.css">
        <link rel="stylesheet" href="css/screen.css" type="text/css" title="default" />
        <style>
	.ui-autocomplete {
		max-height: 200px;
		overflow-y: auto;
		/* prevent horizontal scrollbar */
		overflow-x: hidden;
		/* add padding to account for vertical scrollbar */
		padding-right: 20px;
	}
	/* IE 6 doesn't support max-height
	 * we use height instead, but this forces the menu to always be this tall
	 */
	* html .ui-autocomplete {
		height: 100px;
	}
	</style>
        <script type="text/javascript">
        <%
        String ids="",pos="",ide="999999";
        DBconnect db = new DBconnect();
        db.liaison();
        ResultSet rs,rs1,rs2;
        Statement S3 = null;
        if((request.getParameter("ids")!=null)&&(request.getParameter("pos")!=null)){
        ids = request.getParameter("ids");
            pos = request.getParameter("pos");   
            rs = db.S.executeQuery("Select ideRBS from elementRBS where idRBS='"+ids+"' and position="+pos);
            if(rs.next()){
                ide = rs.getString(1);
                               }else{
            %>
                window.alert("Vueillez reserver ce slot d'abord");
                document.location = "error.html";
            <% } 
            rs = db.S.executeQuery("Select * from portsRBS");
                /*while(rs.next()){
                    String idp = rs.getString(1);
                    String pname = rs.getString(3);
                    String portlinked;*/
            %>
                        $(function() {
                            var availableTags = [
                                <%
                                S3 = db.conn.createStatement();
                                    rs1 = S3.executeQuery("Select * from elementRBS where idRBS='"+ids+"'");
                                    //System.out.println("Select * from elementRBS where idRBS='"+ids+"'");
                                    while(rs1.next()){
                                        String idel =rs1.getString(1);
                                        //System.out.println(idp + "   " + idel);
                                        db.S2 = db.conn.createStatement();
                                    rs2 = db.S2.executeQuery("Select * from portsRBS where ideRBS="+idel+" or ideRBS='' and status=0");
                                    while(rs2.next()){
                                        String nm = rs2.getString(3);
                                        //System.out.println(nm);
                                %>
                                "<%="[@"+rs1.getString(4)+"]"+ids+"."+rs1.getString(3)+"." +nm%>",
                                <%}
                                    
                                   }%>
                                                ""
                        ];
                        for(i=1;i<=document.getElementsByName("prt").length;i++){
		$( "#tags"+i ).autocomplete({
			source: availableTags
		});
                        }
	});
        
        function newprt(){
                    var n = document.getElementsByName("prt").length;
                    //var newTextBoxDiv = $(document.createElement('div')).attr("id", 'TextBoxDiv' + n);
                    //window.alert('<input type="hidden" value="" name="infop"><input name="np" value=""><input id="tags'+(n+1)+'" name="prt" value="">');
                    //window.alert(newTextBoxDiv );
                           // newTextBoxDiv.after().html('<input type="hidden" value="" name="infop"><input name="np" value=""><input id="tags'+(n+1)+'" name="prt" value="">');
                    
                    //newTextBoxDiv.appendTo("#newelem");
                    document.getElementById("newelem").innerHTML = document.getElementById("newelem").innerHTML + '<tr><td><input name="np" value=""></td><td><input id="tags'+(n+1)+'" name="prt" value=""></td></tr>' ;
                }
	</script>
        
    </head>
    <body>
        
            <div  style="float: left;">
                <form method="post" action="actions?action=savePorts&ide=<%=ide%>">
                   <div class="ui-widget"> 
                       <table id="newelem">
                        <tr>
                            <td>
                <input type="hidden" value="<%=ide%>" name="infoe">
                </td>
                <td></td>
                </tr>
                
	
	
            
		<% rs = db.S.executeQuery("Select * from portsRBS where ideRBS="+ide);
                int i=0;
                while(rs.next()){
                    String idp = rs.getString(1);
                    String pname = rs.getString(3);
                    String l2 = rs.getString(5);
                    i++;
            %>
            <tr>
            
                <td><input type="hidden" value="<%=idp%>" name="infop">
                    <label for="tags<%=i%>"><a href="actions?action=delPort&idp=<%=idp%>">[x]</a> <%=pname%> </label>
                </td>
                <td>
                <input id="tags<%=i%>" name="prt" value="<%=l2%>">
                </td>
                    
              </tr>
                       
                <%
                                               }
                db.closeData();
                               
                       }
                       
                %>
                
                       </table>
                <br/>
                <table>
                <tr>
                    <td>
                <a href="#" onclick="newprt()">[ + ] Ajouter port</a>
                    </td>
                    <td></td>
                </tr>
                <tr>
                    <td>
			<input type="submit" value="Valider" class="form-submit" />
                    </td>
                    <td>
			<input type="reset" value="" class="form-reset"  />
                    </td>
                </tr>
		
                </table>
                   </div>
                        </form>
            </div>
               
               <br/>
        
    </body>
    
</html>

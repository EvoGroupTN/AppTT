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
        <title>Configuration d'un RBS</title>
        <link rel="stylesheet" href="css/screen.css" type="text/css" title="default" />
        <link rel="stylesheet" type="text/css" href="css/ui-lightness/jquery-ui-1.8.21.custom.css">
        <meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
        <style type="text/css">
      html { height: 100% }
      body { height: 100%; margin: 0; padding: 0 }
      #map_canvas { height: 100% }
    </style>
    
        <script src="js/jquery-1.7.2.min.js"></script>
        <script src="js/jquery-ui-1.8.21.custom.min.js"></script>
    
        <script type="text/javascript">
            $(function() {
		
		$( "#dialog-modal" ).dialog({
			height: 400,
                        width: 650,
                        autoOpen: false,
			modal: true
		});
                
	});
            function setval(n,t){
                for(i=0;i<document.getElementsByName(n).length;i++ ){
                    document.getElementsByName(n)[i].value = t[i];
                }
            }
            function fillall(){
                
            
            <%
    ActionsDef act = new ActionsDef();
    String noedit="";
    String idst = "";
    if(!act.isAdmin(session.getAttribute("user").toString())){
        noedit = "editable=false";
    }
        String inf1="",inf2="",inf3="",inf4="",inf5="",inf6="",dis="",sub="",ids="",dis_id="";
        DBconnect db = new DBconnect();
        db.liaison();
        ResultSet rs;
        if(request.getParameter("ids")!=null){
        ids = request.getParameter("ids");
               
        if(request.getParameter("edit")==null){
        //dis = "disabled";
        inf4 = "style='visibility: hidden'";
                      }else{
            dis="";
            inf4 = "";
                       }
        
        
        db.S = db.conn.createStatement();
        
        out.println("document.getElementById('rbsn').textContent = '"+ids+"';");
        /*if(rs.next()){
            
        inf1=rs.getString(2);
        inf2 = rs.getString(3);
        inf3 = rs.getString(5);
        //inf4 = rs.getString(5);
        inf5 = rs.getString(6);
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
               }*/
        //out.println("document.getElementsByName('info')[2].value = '"+ids+"';");
            rs = db.S.executeQuery("Select * from RBS where idRBS='"+ids+"'");
            if(rs.next()){
                idst = rs.getString(2);
                %>
                        var n = new Array("<%=rs.getString(4).replaceAll("\n", "+") %>","<%=rs.getString(2) %>","<%=ids%>","<%=rs.getString(3)%>");
                        setval("info",n);
                        
                        <%
            }
                rs = db.S.executeQuery("Select * from elementRBS where idRBS='"+ids+"' ORDER BY position");
                while(rs.next()){
                    String a1=rs.getString(3);
                    String a2=rs.getString(4);
                    String a3=rs.getString(5);
                    String a4=rs.getString(6);
                    String a5=rs.getString(7);
                    String a6=rs.getString(8);
                
            %>
                    var t = new Array("<%=a2%>","<%=a1%>","<%=a3%>","<%=a4%>","<%=a5%>","<%=a6%>");
                    var n = "part"+"<%=Integer.parseInt(a2)%>";
                    setval(n,t);
                        <%
                                               }
                %>
                        }
                        <%
                
                               }
                %>
                    
            
            function loadports(n){
                //window.alert(document.getElementsByName("part"+n)[1].value);
                //$("#divport").load("getports.jsp?ids="+"<%=ids%>"+"&pos="+n);
                document.getElementById("frminfo").src = "getports.jsp?ids="+"<%=ids%>"+"&pos="+n;
                $("#dialog-modal").dialog("open");
            }
        </script>
    </head>
    <body  onload="fillall();">
        
            <div class="tools" >
                <input type="text" value="100%" id="zm" style="width: 40px">
                <button onclick="document.getElementById('rbs').style.zoom = document.getElementById('zm').value; ">Zoom</button> | 
                <button onclick="document.getElementById('frms').submit(); ">Enregistrer RBS</button>
                <button onclick="document.location = 'actions?action=delete&what=RBS&ids='+document.getElementsByName('info')[2].value;">Supprimer RBS</button>
                <div id="rbsn" style="float: right;color: white; font-size: larger"></div>
            </div>
            <div style="clear:both">&nbsp;</div>
        <div  style="float: left" id="rbs">
            
            <form id="frms" method="post" action="actions?action=saveRBSconf" >
        <div  class="partM">
            
                <input type="hidden" style="width:0%;height:0%" value="1" name="part1">
                <div><input type="text" class="title" value="Dummy" name="part1"><br/></div>
                <div class="rotatecontentS">
                <input type="text" value="(R)" name="part1"><br/>
                <input type="text" value="0" name="part1"><br/>
                <input type="text" value="(D)" name="part1"><br/>
                <input type="text" value="(S)" name="part1"><br/>
                </div>
                <div class="tool"><a href="#" onclick="loadports(1)" style="color:white">Ports</a></div>
            </div>
         <div  class="partB">
                <input type="hidden" style="width:0%;height:0%" value="2" name="part2">
                <div><input type="text" class="title" value="Dummy" name="part2"><br/></div>
                <div class="rotatecontentB">
                <input type="text" value="(R)" name="part2"><br/>
                <input type="text" value="0" name="part2"><br/>
                <input type="text" value="(D)" name="part2"><br/>
                <input type="text" value="(S)" name="part2"><br/>
                </div>
                <div class="tool"><a href="#" onclick="loadports(2)" style="color:white">Ports</a></div>
            </div>
        <div  class="partM">
                <input type="hidden" style="width:0%;height:0%" value="3" name="part3">
                <div><input type="text" class="title" value="Dummy" name="part3"><br/></div>
                <div class="rotatecontentS">
                <input type="text" value="(R)"  name="part3"><br/>
                <input type="text" value="0"  name="part3"><br/>
                <input type="text" value="(D)"  name="part3"><br/>
                <input type="text" value="(S)"  name="part3"><br/>
                </div>
                <div class="tool"><a href="#" onclick="loadports(3)" style="color:white">Ports</a></div>
            </div>
         <div  class="partB">
                <input type="hidden" style="width:0%;height:0%" value="4" name="part4">
                <div><input type="text" class="title" value="Dummy" name="part4"><br/></div>
                <div class="rotatecontentB">
                <input type="text" value="(R)" name="part4"><br/>
                <input type="text" value="0" name="part4"><br/>
                <input type="text" value="(D)" name="part4"><br/>
                <input type="text" value="(S)" name="part4"><br/>
                </div>
                <div class="tool"><a href="#" onclick="loadports(4)" style="color:white">Ports</a></div>
            </div>
        
        <div style="clear: both">&nbsp;</div>
        <div style="width: 100%">
        <div  class="partM">
                <input type="hidden" style="width:0%;height:0%" value="5" name="part5">
                <div><input type="text" class="title" value="Dummy" name="part5"><br/></div>
                <div class="rotatecontentS">
                <input type="text" value="(R)" name="part5"><br/>
                <input type="text" value="0" name="part5"><br/>
                <input type="text" value="(D)" name="part5"><br/>
                <input type="text" value="(S)" name="part5"><br/>
                </div>
                <div class="tool"><a href="#" onclick="loadports(5)" style="color:white">Ports</a></div>
            </div>
        <div  class="partS">
                <input type="hidden" style="width:0%;height:0%" value="6" name="part6">
                <div><input type="text" class="title" value="Dummy" name="part6"><br/></div>
                <div class="rotatecontentS">
                <input type="text" value="(R)" name="part6"><br/>
                <input type="text" value="(D)" name="part6"><br/>
                <input type="text" value="(S)" name="part6"><br/>
                </div>
                <div class="tool"><a href="#" onclick="loadports(6)" style="color:white">Ports</a></div>
            </div>
        <div  class="partS">
                <input type="hidden" style="width:0%;height:0%" value="7" name="part7">
                <div><input type="text" class="title" value="Dummy" name="part7"><br/></div>
                <div class="rotatecontentS">
                <input type="text" value="(R)" name="part7"><br/>
                <input type="text" value="(D)" name="part7"><br/>
                <input type="text" value="(S)" name="part7"><br/>
                </div>
                <div class="tool"><a href="#" onclick="loadports(7)" style="color:white">Ports</a></div>
            </div>
        <div  class="partS">
                <input type="hidden" style="width:0%;height:0%" value="8" name="part8">
                <div><input type="text" class="title" value="Dummy" name="part8"><br/></div>
                <div class="rotatecontentS">
                <input type="text" value="(R)" name="part8"><br/>
                <input type="text" value="(D)" name="part8"><br/>
                <input type="text" value="(S)" name="part8"><br/>
                </div>
                <div class="tool"><a href="#" onclick="loadports(8)" style="color:white">Ports</a></div>
            </div>
        <div  class="partS">
                <input type="hidden" style="width:0%;height:0%" value="9" name="part9">
                <div><input type="text" class="title" value="Dummy" name="part9"><br/></div>
                <div class="rotatecontentS">
                <input type="text" value="(R)" name="part9"><br/>
                <input type="text" value="(D)" name="part9"><br/>
                <input type="text" value="(S)" name="part9"><br/>
                </div>
                <div class="tool"><a href="#" onclick="loadports(9)" style="color:white">Ports</a></div>
            </div>
        <div  class="partS">
                <input type="hidden" style="width:0%;height:0%" value="10" name="part10">
                <div><input type="text" class="title" value="Dummy" name="part10"><br/></div>
                <div class="rotatecontentS">
                <input type="text" value="(R)" name="part10"><br/>
                <input type="text" value="(D)" name="part10"><br/>
                <input type="text" value="(S)" name="part10"><br/>
                </div>
                <div class="tool"><a href="#" onclick="loadports(10)" style="color:white">Ports</a></div>
            </div>
        <div  class="partS">
                <input type="hidden" style="width:0%;height:0%" value="11" name="part11">
                <div><input type="text" class="title" value="Dummy" name="part11"><br/></div>
                <div class="rotatecontentS">
                <input type="text" value="(R)" name="part11"><br/>
                <input type="text" value="(D)" name="part11"><br/>
                <input type="text" value="(S)" name="part11"><br/>
                </div>
                <div class="tool"><a href="#" onclick="loadports(11)" style="color:white">Ports</a></div>
            </div>
        <div  class="partS">
                <input type="hidden" style="width:0%;height:0%" value="12" name="part12">
                <div><input type="text" class="title" value="Dummy" name="part12"><br/></div>
                <div class="rotatecontentS">
                <input type="text" value="(R)" name="part12"><br/>
                <input type="text" value="(D)" name="part12"><br/>
                <input type="text" value="(S)" name="part12"><br/>
                </div>
                <div class="tool"><a href="#" onclick="loadports(12)" style="color:white">Ports</a></div>
            </div>
        <div  class="partS">
                <input type="hidden" style="width:0%;height:0%" value="13" name="part13">
                <div><input type="text" class="title" value="Dummy" name="part13"><br/></div>
                <div class="rotatecontentS">
                <input type="text" value="(R)" name="part13"><br/>
                <input type="text" value="(D)" name="part13"><br/>
                <input type="text" value="(S)" name="part13"><br/>
                </div>
                <div class="tool"><a href="#" onclick="loadports(13)" style="color:white">Ports</a></div>
            </div>
    </div>
        <div style="clear: both"></div>
        <div class="partV">
                <input type="hidden" style="width:0%;height:0%" value="14" name="part14">
                <div><input type="text" class="title" value="Dummy" name="part14"></div>
                <div class="rotatecontentS">
                <input type="text" value="(R)" name="part14">
                <input type="text" value="0" name="part14"><br/>
                <input type="text" value="(D)" name="part14">
                <input type="text" value="(S)" name="part14">
                </div>
                <div class="tool"><a href="#" onclick="loadports(14)" style="color:white">Ports</a></div>
        </div>
        <div style="clear: both;"><p></p></div>
        <div style="width: 100%">
        <div  class="partM">
                <input type="hidden" style="width:0%;height:0%" value="15" name="part15">
                <div><input type="text" class="title" value="Dummy" name="part15"><br/></div>
                <div class="rotatecontentS">
                <input type="text" value="(R)" name="part15"><br/>
                <input type="text" value="0" name="part15"><br/>
                <input type="text" value="(D)" name="part15"><br/>
                <input type="text" value="(S)" name="part15"><br/>
                </div>
                <div class="tool"><a href="#" onclick="loadports(15)" style="color:white">Ports</a></div>
            </div>
            <div  class="partM">
                <input type="hidden" style="width:0%;height:0%" value="16" name="part16">
                <div><input type="text" class="title" value="Dummy" name="part16"><br/></div>
                <div class="rotatecontentS">
                <input type="text" value="(R)" name="part16"><br/>
                <input type="text" value="0" name="part16"><br/>
                <input type="text" value="(D)" name="part16"><br/>
                <input type="text" value="(S)" name="part16"><br/>
                </div>
                <div class="tool"><a href="#" onclick="loadports(16)" style="color:white">Ports</a></div>
            </div>
            <div  class="partM">
                <input type="hidden" style="width:0%;height:0%" value="17" name="part17">
                <div><input type="text" class="title" value="Dummy" name="part17"><br/></div>
                <div class="rotatecontentS">
                <input type="text" value="(R)" name="part17"><br/>
                <input type="text" value="0" name="part17"><br/>
                <input type="text" value="(D)" name="part17"><br/>
                <input type="text" value="(S)" name="part17"><br/>
                </div>
                <div class="tool"><a href="#" onclick="loadports(17)" style="color:white">Ports</a></div>
            </div>
            <div  class="partM">
                <input type="hidden" style="width:0%;height:0%" value="18" name="part18">
                <div><input type="text" class="title" value="Dummy" name="part18"><br/></div>
                <div class="rotatecontentS">
                <input type="text" value="(R)" name="part18"><br/>
                <input type="text" value="0" name="part18"><br/>
                <input type="text" value="(D)" name="part18"><br/>
                <input type="text" value="(S)" name="part18"><br/>
                </div>
                <div class="tool"><a href="#" onclick="loadports(18)" style="color:white">Ports</a></div>
            </div>
            <div  class="partM">
                <input type="hidden" style="width:0%;height:0%" value="19" name="part19">
                <div><input type="text" class="title" value="Dummy" name="part19"><br/></div>
                <div class="rotatecontentS">
                <input type="text" value="(R)" name="part19"><br/>
                <input type="text" value="0" name="part19"><br/>
                <input type="text" value="(D)" name="part19"><br/>
                <input type="text" value="(S)" name="part19"><br/>
                </div>
                <div class="tool"><a href="#" onclick="loadports(19)" style="color:white">Ports</a></div>
            </div>
            <div  class="partM">
                <input type="hidden" style="width:0%;height:0%" value="20" name="part20">
                <div><input type="text" class="title" value="Dummy" name="part20"><br/></div>
                <div class="rotatecontentS">
                <input type="text" value="(R)" name="part20"><br/>
                <input type="text" value="0" name="part20"><br/>
                <input type="text" value="(D)" name="part20"><br/>
                <input type="text" value="(S)" name="part20"><br/>
                </div>
                <div class="tool"><a href="#" onclick="loadports(20)" style="color:white">Ports</a></div>
            </div>
            <div  class="partM">
                <input type="hidden" style="width:0%;height:0%" value="21" name="part21">
                <div><input type="text" class="title" value="Dummy" name="part21"><br/></div>
                <div class="rotatecontentS">
                <input type="text" value="(R)" name="part21"><br/>
                <input type="text" value="0" name="part21"><br/>
                <input type="text" value="(D)" name="part21"><br/>
                <input type="text" value="(S)" name="part21"><br/>
                </div>
                <div class="tool"><a href="#" onclick="loadports(21)" style="color:white">Ports</a></div>
            </div>
        </div>
        <div style="clear: both"></div>
        <div class="partV">
                <input type="hidden" style="width:0%;height:0%" value="22" name="part22">
                <div><input type="text" class="title" value="Dummy" name="part22"></div>
                <div class="rotatecontentS">
                <input type="text" value="(R)" name="part22">
                <input type="text" value="0" name="part22"><br/>
                <input type="text" value="(D)" name="part22">
                <input type="text" value="(S)" name="part22">
                </div>
                <div class="tool"><a href="#" onclick="loadports(22)" style="color:white">Ports</a></div>
        </div>
        <div style="clear: both;"><p></p></div>
        <div style="width: 100%">
        <div  class="partM">
                <input type="hidden" style="width:0%;height:0%" value="23" name="part23">
                <div><input type="text" class="title" value="Dummy" name="part23"><br/></div>
                <div class="rotatecontentS">
                <input type="text" value="(R)" name="part23"><br/>
                <input type="text" value="0" name="part23"><br/>
                <input type="text" value="(D)" name="part23"><br/>
                <input type="text" value="(S)" name="part23"><br/>
                </div>
                <div class="tool"><a href="#" onclick="loadports(23)" style="color:white">Ports</a></div>
            </div>
            <div  class="partM">
                <input type="hidden" style="width:0%;height:0%" value="24" name="part24">
                <div><input type="text" class="title" value="Dummy" name="part24"><br/></div>
                <div class="rotatecontentS">
                <input type="text" value="(R)" name="part24"><br/>
                <input type="text" value="0" name="part24"><br/>
                <input type="text" value="(D)" name="part24"><br/>
                <input type="text" value="(S)" name="part24"><br/>
                </div>
                <div class="tool"><a href="#" onclick="loadports(24)" style="color:white">Ports</a></div>
            </div>
            <div  class="partM">
                <input type="hidden" style="width:0%;height:0%" value="25" name="part25">
                <div><input type="text" class="title" value="Dummy" name="part25"><br/></div>
                <div class="rotatecontentS">
                <input type="text" value="(R)" name="part25"><br/>
                <input type="text" value="0" name="part25"><br/>
                <input type="text" value="(D)" name="part25"><br/>
                <input type="text" value="(S)" name="part25"><br/>
                </div>
                <div class="tool"><a href="#" onclick="loadports(25)" style="color:white">Ports</a></div>
            </div>
            <div  class="partM">
                <input type="hidden" style="width:0%;height:0%" value="26" name="part26">
                <div><input type="text" class="title" value="Dummy" name="part26"><br/></div>
                <div class="rotatecontentS">
                <input type="text" value="(R)" name="part26"><br/>
                <input type="text" value="0" name="part26"><br/>
                <input type="text" value="(D)" name="part26"><br/>
                <input type="text" value="(S)" name="part26"><br/>
                </div>
                <div class="tool"><a href="#" onclick="loadports(26)" style="color:white">Ports</a></div>
            </div>
            <div  class="partM">
                <input type="hidden" style="width:0%;height:0%" value="27" name="part27">
                <div><input type="text" class="title" value="Dummy" name="part27"><br/></div>
                <div class="rotatecontentS">
                <input type="text" value="(R)" name="part27"><br/>
                <input type="text" value="0" name="part27"><br/>
                <input type="text" value="(D)" name="part27"><br/>
                <input type="text" value="(S)" name="part27"><br/>
                </div>
                <div class="tool"><a href="#" onclick="loadports(27)" style="color:white">Ports</a></div>
            </div>
            <div  class="partM">
                <input type="hidden" style="width:0%;height:0%" value="28" name="part28">
                <div><input type="text" class="title" value="Dummy" name="part28"><br/></div>
                <div class="rotatecontentS">
                <input type="text" value="(R)" name="part28"><br/>
                <input type="text" value="0" name="part28"><br/>
                <input type="text" value="(D)" name="part28"><br/>
                <input type="text" value="(S)" name="part28"><br/>
                </div>
                <div class="tool"><a href="#" onclick="loadports(28)" style="color:white">Ports</a></div>
            </div>
            <div  class="partM">
                <input type="hidden" style="width:0%;height:0%" value="29" name="part29">
                <div><input type="text" class="title" value="Dummy" name="part29"><br/></div>
                <div class="rotatecontentS">
                <input type="text" value="(R)" name="part29"><br/>
                <input type="text" value="0" name="part29"><br/>
                <input type="text" value="(D)" name="part29"><br/>
                <input type="text" value="(S)" name="part29"><br/>
                </div>
                <div class="tool"><a href="#" onclick="loadports(29)" style="color:white">Ports</a></div>
            </div>
        </div>
        <div style="clear: both"></div>
        <div class="partV">
                <input type="hidden" value="30" name="part30">
                <div><input type="text" class="title" value="Dummy" name="part30"></div>
                <div class="rotatecontentS">
                <input type="text" value="(R)" name="part30">
                <input type="text" value="0" name="part30"><br/>
                <input type="text" value="(D)" name="part30">
                <input type="text" value="(S)" name="part30">
                </div>
                <div class="tool"><a href="#" onclick="loadports(30)" style="color:white">Ports</a></div>
        </div>
        <div style="clear: both"></div>
        <div class="partV">
                
            <div style="float:left; "  ><textarea style="width:450px;height: 50px;background-color: transparent;border: none" name="info"></textarea></div>
                <div style="float:left">
                    <select name="info" <%=dis%>> 
                                <%
                                    rs = db.S.executeQuery("Select * from equipement");
                                    while(rs.next()){
                                %>
                                <option value="<%=rs.getString(2)%>" <% if(idst.compareToIgnoreCase(rs.getString(2))==0) out.print("selected"); %>><%=rs.getString(2)%></option>
                                <%}%>
                            </select>
                <br/>
                <input type="hidden" value="<%=ids%>" name="info" style="display: none; height: 0px"><br/>
                <input type="text" value="Utrancell" name="info">
                </div>
            
        </div>
        </form>
            </div>
            <div id="dialog-modal" title="Informations sur les ports" style="margin-left:0;margin-right: 0;margin-top: 0;margin-bottom: 0; background-color: #fff;">
        <iframe id="frminfo" style="width: 100%;height: 95%;" frameborder="0">
        
        </iframe>
</div>
       
    </body>
</html>

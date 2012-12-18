<%-- 
    Document   : equipview
    Created on : Jul 19, 2012, 10:56:08 AM
    Author     : hakeem
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="evo.actions.ActionsDef"%>
<%@page import="evo.db.DBconnect"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!DOCTYPE html>
<!-- saved from url=(0039)http://www.lutzroeder.com/html5/netron/ -->
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en-US" lang="en-US"><head><meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Diagramme d'équipement</title>
<script type="text/javascript" src="js/ga.js"></script>
<script type="text/javascript">try { _gat._getTracker("UA-54146-8")._trackPageview(); } catch (e) { }</script>
<meta http-equiv="X-UA-Compatible" content="IE=9">
<style type="text/css">
body { background-color: #fff; margin-left: 0; margin-right: 0; margin-top: 0; }
.center { margin-left: auto; margin-right: auto; width: 100%; }
input[type="text"] { text-align: center; border: none; background: #000; color: #fff; font-family: Verdana; font-size: 10px; font-weight: bold; outline: none; }
input[type="button"] { border: 1px solid #555; background: #555; color: #000; font-family: Verdana; font-size: 10px; font-weight: bold; outline: none; }
input[type="button"]:hover { border: 1px solid #999; background: #999; color: #000; cursor: pointer; }
input[type="button"]:active { border: 1px solid #ccc; background: #ccc; margin: 0; padding: 0; }
input[type="button"]::-moz-focus-inner { border: none; }
#canvas { outline: 1px solid #383838; }
#canvas:focus { outline: 1px solid #404040; }
</style>
<script type="text/javascript" src="js/netron.js"></script>
<script type="text/javascript">
//<![CDATA[

var graph = null;

function document_load()
{
	graph = new Graph(document.getElementById("canvas"));
 	graph.setTheme({ background: "#111", connection: "#fff", selection: "#888", connector: "#fff", connectorBorder: "#000", connectorHoverBorder: "#000", connectorHover: "#0c0" });
        <%
                DBconnect db = new DBconnect();
        db.liaison();
        db.S = db.conn.createStatement();
        String vis;
        
        ResultSet rs;
        
            rs = db.S.executeQuery("Select * from MSC");
            rs.last();
            int nb = rs.getRow();
            System.out.print(nb);
            int i=1;
            double prt = 800/(nb+1) - 50;
            rs = db.S.executeQuery("Select * from MSC");
            while(rs.next()){
   %>              
           var <%=rs.getString(1)%> = graph.addElement(personTemplate, { x:<%=prt%>, y:700 }, "<%=rs.getString(1)%>");
           <%
            prt = prt + 800/(nb+1);
            }%>
                    
            <%
            rs = db.S.executeQuery("Select * from BSC");
            rs.last();
            nb = rs.getRow();
            System.out.print(nb);
            prt = 800/(nb+1) - 50;
            rs = db.S.executeQuery("Select * from BSC ORDER BY BSC.idMSC");
            while(rs.next()){
   %>              
           var <%=rs.getString(1)%> = graph.addElement(personTemplate, { x:<%=prt%>, y:500 }, "<%=rs.getString(1)%>");
           var <%=rs.getString(1)%>_<%=rs.getString(2)%> = graph.addConnection(<%=rs.getString(1)%>.getConnector("OUT"), <%=rs.getString(2)%>.getConnector("IN"));
           <%
            prt = prt + 800/(nb+1);
            
            }%>
                    
            <%
            rs = db.S.executeQuery("Select * from BTS");
            rs.last();
            nb = rs.getRow();
            System.out.print(nb);
            prt = 800/(nb+1) - 50;
            rs = db.S.executeQuery("Select * from BTS ORDER BY BTS.idBSC");
            while(rs.next()){
   %>              
           var <%=rs.getString(1)%> = graph.addElement(personTemplate, { x:<%=prt%>, y:300 }, "<%=rs.getString(1)%>");
           var <%=rs.getString(1)%>_<%=rs.getString(2)%> = graph.addConnection(<%=rs.getString(1)%>.getConnector("OUT"), <%=rs.getString(2)%>.getConnector("IN"));
          
            <%
            prt = prt + 800/(nb+1);
                       
            }%>
            
            <%
            rs = db.S.executeQuery("Select * from Antenne");
            rs.last();
            nb = rs.getRow();
            System.out.print(nb);
            prt = 800/(nb+1) - 50;
            rs = db.S.executeQuery("Select * from Antenne ORDER BY Antenne.idBTS");
            while(rs.next()){
   %>              
           var <%=rs.getString(1)%> = graph.addElement(personTemplate, { x:<%=prt%>, y:100 }, "<%=rs.getString(1)%>");
           var <%=rs.getString(1)%>_<%=rs.getString(7)%> = graph.addConnection(<%=rs.getString(1)%>.getConnector("OUT"), <%=rs.getString(7)%>.getConnector("IN"));
          
            <%
            prt = prt + 800/(nb+1);
                       
            }%>
            
            
	//var e2 = graph.addElement(personTemplate, { x:, y:500 }, "BTS");
	/*var e3 = graph.addElement(personTemplate, { x:300, y:200 }, "BSC");
	//var e4 = graph.addElement(personTemplate, { x:325, y:300 }, "MSC");
	//var c1 = graph.addConnection(e1.getConnector("OUT"), e3.getConnector("IN"));*/
	//var c2 = graph.addConnection(e2.getConnector("children"), e3.getConnector("mother"));
        
	graph.update();
        
}

var personTemplate = new PersonTemplate();

function PersonTemplate()
{
	this.resizable = false;
	this.defaultWidth = 150;
	this.defaultHeight = 30;
	this.defaultContent = "";
	this.connectorTemplates = [
		{ name: "IN", type: "Person [out] [array]", description: "IN", position: function(element) { return { x: Math.floor(element.getRectangle().width / 2), y: 0 } } },
		{ name: "OUT",   type: "Person [in]",          description: "OUT",   position: function(element) { return { x: Math.floor(element.getRectangle().width / 2), y: element.getRectangle().height } } }
		
		
	];
}

PersonTemplate.prototype.paint = function(element, context)
{
	var rectangle = element.getRectangle();
	context.fillStyle = "#000";
	context.strokeStyle = element.selected ? "#888" : "#fff";
	context.lineWidth = 2;
	context.fillRect(rectangle.x, rectangle.y, rectangle.width, rectangle.height);
	context.strokeRect(rectangle.x, rectangle.y, rectangle.width, rectangle.height);
	context.font = "bold 10px Verdana";
	context.fillStyle = context.strokeStyle;
	context.textBaseline = "bottom";
	context.textAlign = "center";
	context.fillText(element.getContent(), rectangle.x + (rectangle.width / 2), rectangle.y + 20);
};

PersonTemplate.prototype.edit = function(element, point)
{
    
	contentEditor.start(element);
        
};

var contentEditor = new ContentEditor();

function ContentEditor()
{
	this.input = null;
}

ContentEditor.prototype.start = function(element)
{
	var rectangle = element.getPageRectangle();
	this.element = element;
	this.input = document.createElement('input');
	this.input.type = "text";
	this.input.style.position = "absolute";
	this.input.style.zIndex = 1;
	this.input.style.top = (rectangle.y + 8) + "px";
	this.input.style.left = (rectangle.x + 2) + "px";
	this.input.style.width = (rectangle.width - 5) + "px";
	/*this.input.onblur = function(e) 
	{ 
		contentEditor.commit(); 
	}*/
	this.input.onkeydown = function(e) 
	{ 
		if (e.keyCode == 13) { contentEditor.commit(); } // Enter
		if (e.keyCode == 27) { contentEditor.cancel(); } // ESC
	};
	this.element.owner.canvas.parentNode.appendChild(this.input);
        
	this.input.value = element.getContent();
	this.input.select();
	this.input.focus();	
	
};

ContentEditor.prototype.commit = function()
{
	this.element.setContent(this.input.value);
        window.alert(this.element.getContent());
	this.cancel();
}

ContentEditor.prototype.cancel = function()
{
	if (this.input !== null)
	{	
		var input = this.input;
		this.input = null;
		this.element.owner.canvas.parentNode.removeChild(input);
		this.element = null;
	}
};

//]]>
</script>

<link type="text/css" rel="stylesheet" href="chrome-extension://cpngackimfmofbokmjmljamhdncknpmg/style.css"><script type="text/javascript" charset="utf-8" src="chrome-extension://cpngackimfmofbokmjmljamhdncknpmg/page_context.js"></script></head>

<body onload="document_load()" screen_capture_injected="true">

<div class="center" style="position: relative;">
<canvas style="position: absolute; background-color: rgb(17, 17, 17); cursor: default; background-position: initial initial; background-repeat: initial initial; " id="canvas" width="800" height="800" tabindex="0"></canvas>

</div>



</body></html>

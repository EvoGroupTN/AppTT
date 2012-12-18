/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

import evo.actions.ActionsDef;
import evo.actions.actionSite;
import evo.db.DBconnect;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author hakeem
 */
@WebServlet(name = "actions", urlPatterns = {"/actions"})
public class actions extends HttpServlet {

    /**
     * Processes requests for both HTTP
     * <code>GET</code> and
     * <code>POST</code> methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            
            String action = request.getParameter("action");
            HttpSession s = request.getSession(true);
            if(action.compareToIgnoreCase("login") == 0){
            String usr = request.getParameter("login");
            String pwd = request.getParameter("pwd");
            DBconnect db = new DBconnect();
            db.liaison();
            if(!db.conn.isClosed())
                out.println(usr+" "+pwd);
             PreparedStatement stmt = db.conn.prepareStatement("select * from users where login like ? and password like ?");
      stmt.setString(1, usr);
      stmt.setString(2, pwd);
      ResultSet rs = stmt.executeQuery();
            //ResultSet rs = db.S.executeQuery("select * from users where login like '"+usr+"' and password like '"+pwd+"'");
            
            if(rs.next()){
                s.setAttribute("user",usr);
                s.setAttribute("type", rs.getString("type"));
                db.closeData();
                response.sendRedirect("index.jsp");
            }else{
                db.closeData();
                response.sendRedirect("login.jsp?err=1");
            }
            }
            
            //****************************************************
            
            if(action.compareToIgnoreCase("logout") == 0){
                s.removeAttribute("user");
                response.sendRedirect("index.jsp");
            }
            
            //*****************************************************
            
            if(action.compareToIgnoreCase("addsite") == 0){
                ActionsDef act = new ActionsDef();
                s = request.getSession(true);
                if(act.isAdmin(s.getAttribute("user").toString())){
                    actionSite acts = new actionSite();
                    String ids = request.getParameter("ids");
                    String desc = request.getParameter("desc");
                    String x = request.getParameter("txtx");
                    String y = request.getParameter("txty");
                    String typ = request.getParameter("typ");
                    String prop = request.getParameter("prop");
                    String st = request.getParameter("status");
                    int i = acts.addsite(ids, desc, x, y, typ, prop,st);
                    if(i==1) response.sendRedirect("done.html");
                }else{
                    response.sendRedirect("error.html");
                }
            }
            
            //*****************************************************
            
            if(action.compareToIgnoreCase("editsite") == 0){
                ActionsDef act = new ActionsDef();
                s = request.getSession(true);
                if(act.isAdmin(s.getAttribute("user").toString())){
                    actionSite acts = new actionSite();
                    String ids = request.getParameter("ids");
                    String desc = request.getParameter("desc");
                    String x = request.getParameter("txtx");
                    String y = request.getParameter("txty");
                    String typ = request.getParameter("typ");
                    String prop = request.getParameter("prop");
                    String st = request.getParameter("status");
                    int i = acts.addsite(ids, desc, x, y, typ, prop,st);
                    if(i==1) response.sendRedirect("done.html");
                    else response.sendRedirect("error.html");
                }else{
                    response.sendRedirect("error.html");
                }
            }
            
            //*****************************************************
            
            if (action.compareToIgnoreCase("editbatterie") == 0) {
                ActionsDef act = new ActionsDef();
                s = request.getSession(true);
                if (act.isAdmin(s.getAttribute("user").toString())) {
                    actionSite acts = new actionSite();
                    String ids = request.getParameter("ids");
                    String st = request.getParameter("status");
                    String desc = request.getParameter("idsite");
                    String y = request.getParameter("txty");
                    String typ = request.getParameter("typ");
                    String prop = request.getParameter("prop");
                    String cap = request.getParameter("cap");
                    String dm = request.getParameter("dm");
                    DBconnect db = new DBconnect();
                    db.liaison();
                    PreparedStatement stmt = db.conn.prepareStatement("select * from Batterie where idbatterie = ?");
                    stmt.setString(1, ids);

                    //stmt.setString(2, pwd);
                    ResultSet rs = stmt.executeQuery();
                    //        ResultSet rs = db.S.executeQuery("select * from site where idsite = '"+ids+"'");
                    if (rs.next()) {
                        db.S.execute("update Batterie set idenv='" + desc + "', type='" + y + "', marque='" + typ + "', capacite='" + cap + "', date_mes='" + dm + "', descbat='" + prop + "', status='" + st + "' where idbatterie='" + ids + "'");
                        response.sendRedirect("done.html");
                    } else {
                        db.S.execute("insert into Batterie values ('" + ids + "','" + desc + "'," + y + ",'" + typ + "','" + prop + "','" + st + "','"+cap+"','"+dm+"')");

                        response.sendRedirect("done.html");

                    }

                } else {
                    response.sendRedirect("error.html");
                }
            }
            
            //*****************************************************
            
            if (action.compareToIgnoreCase("editclimatisation") == 0) {
                ActionsDef act = new ActionsDef();
                s = request.getSession(true);
                if (act.isAdmin(s.getAttribute("user").toString())) {
                    actionSite acts = new actionSite();
                    String ids = request.getParameter("ids");
                    String st = request.getParameter("status");
                    String desc = request.getParameter("idsite");
                    String tp = request.getParameter("type");
                    String mrk = request.getParameter("marque");
                    String dm = request.getParameter("date_mes");
                    String ca = request.getParameter("contrat_avec");
                    String y = request.getParameter("txty");
                    String prop = request.getParameter("prop");
                    DBconnect db = new DBconnect();
                    db.liaison();
                    PreparedStatement stmt = db.conn.prepareStatement("select * from climatisation where idclimatisation = ?");
                    stmt.setString(1, ids);

                    //stmt.setString(2, pwd);
                    ResultSet rs = stmt.executeQuery();
                    //        ResultSet rs = db.S.executeQuery("select * from site where idsite = '"+ids+"'");
                    if (rs.next()) {
                        db.S.execute("update climatisation set idenv='" + desc + "', type='" + tp + "', marque='" + mrk + "', date_mes='" + dm + "', contrat_avec='" + ca + "', puissance=" + y + ", descclimatisation='" + prop + "', status='" + st + "' where idclimatisation='" + ids + "'");
                        response.sendRedirect("done.html");
                    } else {
                        db.S.execute("insert into climatisation values ('" + ids + "','" + desc +"','"+ tp +"','"+mrk+"','"+dm+"'," + y + ",'"+ca+"','" + prop + "','" + st + "')");

                        response.sendRedirect("done.html");

                    }

                } else {
                    response.sendRedirect("error.html");
                }
            }
            
            //*****************************************************
            
            if (action.compareToIgnoreCase("editbts") == 0) {
                ActionsDef act = new ActionsDef();
                s = request.getSession(true);
                if (act.isAdmin(s.getAttribute("user").toString())) {
                    String ids = request.getParameter("ids");
                    String st = request.getParameter("status");
                    String idbsc = request.getParameter("idbsc");
                    String desc = request.getParameter("desc");
                    String x0 = request.getParameter("xyz0");
                    String y0 = request.getParameter("xyz1");
                    String z0 = request.getParameter("xyz2");
                    String strans = request.getParameter("s_trans");
                    String abis = request.getParameter("abis");
                    String prt = request.getParameter("port");
                    String trx = request.getParameter("trx");
                    String dmes = request.getParameter("dmes");
                    DBconnect db = new DBconnect();
                    db.liaison();
                    PreparedStatement stmt = db.conn.prepareStatement("select * from BTS where idBTS = ?");
                    stmt.setString(1, ids);

                    //stmt.setString(2, pwd);
                    ResultSet rs = stmt.executeQuery();
                    ResultSet rs1 = db.S2.executeQuery("select idequipement from BSC where idBSC='"+idbsc+"'");
                    String ide="";
                    if(rs1.next())
                        ide = rs1.getString(1);
                    //        ResultSet rs = db.S.executeQuery("select * from site where idsite = '"+ids+"'");
                    if (rs.next()) {
                        db.S.execute("update BTS set idequipement='" + ide + "', idBSC='" + idbsc + "', descbts='" + desc + "', date_mes='" + dmes + "', status=" + st + ", configuration='" + x0+","+y0+","+z0 + "', suppTrans='" + strans + "', abis=" + abis + ",port="+prt+",trx="+trx+" where idBTS='" + ids + "'");
                        response.sendRedirect("done.html");
                    } else {
                        db.S.execute("insert into BTS values ('" + ids + "','" + idbsc +"','"+ desc +"','"+ide+"',"+st+",'" + x0+","+y0+","+z0+ "','"+strans+"'," + abis + "," + prt + ","+trx+",'"+dmes+"')");

                        response.sendRedirect("done.html");

                    }

                } else {
                    response.sendRedirect("error.html");
                }
            }
            
            //*****************************************************
            
            if (action.compareToIgnoreCase("editbsc") == 0) {
                ActionsDef act = new ActionsDef();
                s = request.getSession(true);
                if (act.isAdmin(s.getAttribute("user").toString())) {
                    String ids = request.getParameter("ids");
                    String idmsc = request.getParameter("idmsc");
                    String desc = request.getParameter("desc");
                    String conf = request.getParameter("conf");
                    String dmes = request.getParameter("dmes");
                    DBconnect db = new DBconnect();
                    db.liaison();
                    PreparedStatement stmt = db.conn.prepareStatement("select * from BSC where idBSC = ?");
                    stmt.setString(1, ids);

                    //stmt.setString(2, pwd);
                    ResultSet rs = stmt.executeQuery();
                    ResultSet rs1 = db.S2.executeQuery("select idequipement from MSC where idMSC='"+idmsc+"'");
                    String ide="";
                    if(rs1.next())
                        ide = rs1.getString(1);
                    //        ResultSet rs = db.S.executeQuery("select * from site where idsite = '"+ids+"'");
                    if (rs.next()) {
                        db.S.execute("update BSC set idequipement='" + ide + "', idmSC='" + idmsc + "', descbsc='" + desc + "', date_mes='" + dmes + "', configuration='" +conf + "' where idBSC='" + ids + "'");
                        response.sendRedirect("done.html");
                    } else {
                        db.S.execute("insert into BSC values ('" + ids + "','" + idmsc +"','"+ desc +"','"+ide+"','"+dmes+"','" +conf+ "')");

                        response.sendRedirect("done.html");

                    }

                } else {
                    response.sendRedirect("error.html");
                }
            }
            
            //*****************************************************
            
            if (action.compareToIgnoreCase("edituser") == 0) {
                ActionsDef act = new ActionsDef();
                s = request.getSession(true);
                if (act.isAdmin(s.getAttribute("user").toString())) {
                    String ids = request.getParameter("ids");
                    String st = request.getParameter("status");
                    String y = request.getParameter("txty");
                    String prop = request.getParameter("prop");
                    DBconnect db = new DBconnect();
                    db.liaison();
                    PreparedStatement stmt = db.conn.prepareStatement("select * from users where login = ?");
                    stmt.setString(1, ids);

                    //stmt.setString(2, pwd);
                    ResultSet rs = stmt.executeQuery();
                    //        ResultSet rs = db.S.executeQuery("select * from site where idsite = '"+ids+"'");
                    if (rs.next()) {
                        db.S.execute("update users set password='" + y + "', descuser='" + prop + "', type='" + st + "' where login='" + ids + "'");
                        response.sendRedirect("done.html");
                    } else {
                        db.S.execute("insert into users values ('" + ids + "','" + y + "','"+st+"','" + prop + "')");

                        response.sendRedirect("done.html");

                    }

                } else {
                    response.sendRedirect("error.html");
                }
            }
            
            //*****************************************************
            
            if (action.compareToIgnoreCase("editredresseur") == 0) {
                ActionsDef act = new ActionsDef();
                s = request.getSession(true);
                if (act.isAdmin(s.getAttribute("user").toString())) {
                    actionSite acts = new actionSite();
                    String ids = request.getParameter("ids");
                    String st = request.getParameter("status");
                    String desc = request.getParameter("idsite");
                    String mrk = request.getParameter("mrk");
                    String typ = request.getParameter("puis");
                    String dm = request.getParameter("dm");
                    String cons = request.getParameter("cons");
                    String prop = request.getParameter("prop");
                    DBconnect db = new DBconnect();
                    db.liaison();
                    PreparedStatement stmt = db.conn.prepareStatement("select * from redresseur where idredresseur = ?");
                    stmt.setString(1, ids);

                    //stmt.setString(2, pwd);
                    ResultSet rs = stmt.executeQuery();
                    //        ResultSet rs = db.S.executeQuery("select * from site where idsite = '"+ids+"'");
                    if (rs.next()) {
                        db.S.execute("update redresseur set idenv='" + desc + "', puissance='" + typ + "', marque='" + mrk + "',consommation='" + cons + "', date_mes='" + dm + "', descredresseur='" + prop + "', status='" + st + "' where idredresseur='" + ids + "'");
                        response.sendRedirect("done.html");
                    } else {
                        db.S.execute("insert into redresseur values ('" + ids + "','" + desc + "','"+mrk+"','" + typ + "','" + prop + "','" + st + "','"+cons+"','"+dm+"')");

                        response.sendRedirect("done.html");

                    }

                } else {
                    response.sendRedirect("error.html");
                }
            }
            
            //*****************************************************
            
            if (action.compareToIgnoreCase("editantenne") == 0) {
                ActionsDef act = new ActionsDef();
                s = request.getSession(true);
                if (act.isAdmin(s.getAttribute("user").toString())) {
                    actionSite acts = new actionSite();
                    String ids = request.getParameter("ids");
                    String st = request.getParameter("typeband");
                    String idsite = request.getParameter("idsite");
                    String idbts = request.getParameter("idbts");
                    String bnd1 = request.getParameter("bnd900");
                    String bnd2 = request.getParameter("bnd1800");
                    String bnd3 = request.getParameter("bnd2100");
                    String desc = request.getParameter("desc");
                    DBconnect db = new DBconnect();
                    db.liaison();
                    PreparedStatement stmt = db.conn.prepareStatement("select * from Antenne where idAntenne = ?");
                    stmt.setString(1, ids);
                    ResultSet rs1 = db.S2.executeQuery("select idequipement from BTS where idBTS='"+idbts+"'");
                    String ide="";
                    if(rs1.next())
                        ide = rs1.getString(1);
                    //stmt.setString(2, pwd);
                    ResultSet rs = stmt.executeQuery();
                    //        ResultSet rs = db.S.executeQuery("select * from site where idsite = '"+ids+"'");
                    if (rs.next()) {
                        db.S.execute("update Antenne set idequipement='" + ide + "', idBTS='" + idbts + "', typeAnt='" + st + "',Ant900='" + bnd1 + "', Ant1800='" + bnd2 + "', Ant2100='" + bnd3 + "', descAnt='" + desc + "' where idAntenne='" + ids + "'");
                        response.sendRedirect("done.html");
                    } else {
                        db.S.execute("insert into Antenne values ('" + ids + "','" + desc + "','"+st+"','" + bnd1 + "','" + bnd2 + "','" + bnd3 + "','"+idbts+"','"+ide+"')");

                        response.sendRedirect("done.html");

                    }

                } else {
                    response.sendRedirect("error.html");
                }
            }
            
            
            //*****************************************************
            
            if (action.compareToIgnoreCase("editmsc") == 0) {
                ActionsDef act = new ActionsDef();
                s = request.getSession(true);
                if (act.isAdmin(s.getAttribute("user").toString())) {
                    actionSite acts = new actionSite();
                    String ids = request.getParameter("ids");
                    String idsite = request.getParameter("idsite");
                    String dmes = request.getParameter("dmes");
                    String conf = request.getParameter("conf");
                    DBconnect db = new DBconnect();
                    db.liaison();
                    PreparedStatement stmt = db.conn.prepareStatement("select * from MSC where idMSC = ?");
                    stmt.setString(1, ids);

                    //stmt.setString(2, pwd);
                    ResultSet rs = stmt.executeQuery();
                    //        ResultSet rs = db.S.executeQuery("select * from site where idsite = '"+ids+"'");
                    if (rs.next()) {
                        db.S.execute("update MSC set idequipement='" + idsite + "', date_mes='" + dmes + "', configuration='" + conf + "' where idMSC='" + ids + "'");
                        response.sendRedirect("done.html");
                    } else {
                        db.S.execute("insert into MSC values ('" + ids + "','" + idsite + "','"+dmes+"','" + conf + "')");

                        response.sendRedirect("done.html");

                    }

                } else {
                    response.sendRedirect("error.html");
                }
            }
            
            
            //*****************************************************
            
            if(action.compareToIgnoreCase("editcompteur") == 0){
                ActionsDef act = new ActionsDef();
                s = request.getSession(true);
                if(act.isAdmin(s.getAttribute("user").toString())){
                    String ids = request.getParameter("ids");
                    String st = request.getParameter("status");
                    String desc = request.getParameter("idsite");
                    String y = request.getParameter("txty");
                    String typ = request.getParameter("typ");
                    String prop = request.getParameter("prop");
                    String cons = request.getParameter("cons");
                    DBconnect db = new DBconnect();
                db.liaison();
                    PreparedStatement stmt = db.conn.prepareStatement("select * from compteur where idcompteur = ?");
      stmt.setString(1, ids);
      
      //stmt.setString(2, pwd);
      ResultSet rs = stmt.executeQuery();
        //        ResultSet rs = db.S.executeQuery("select * from site where idsite = '"+ids+"'");
                if(rs.next()){
                    
                    db.S.execute("update compteur set idenv='"+desc+"', date='"+y+"', indexcompteurNEW='"+typ+"', desccompteur='"+prop+"', status='"+st+"' where idcompteur='"+ids+"'");
                    rs = db.S.executeQuery("select * from historiquecompteur where idcompteur='"+ids+"' and date='"+y+"'");
                    if(rs.next()){
                        db.S.execute("update historiquecompteur set indexn="+typ+",date='"+y+"', consom="+cons+" where idhist="+rs.getString(1));
                    }else{
                        
                        db.S.execute("insert into historiquecompteur values (null,'"+ids+"','"+y+"',"+typ+","+cons+")");
                    }
                    response.sendRedirect("done.html");
                }else{
                    db.S.execute("insert into compteur values ('"+ids+"','"+desc+"','"+y+"','"+typ+"','"+prop+"','"+st+"')");
                    db.S.execute("insert into historiquecompteur values (null,'"+ids+"','"+y+"',"+typ+","+cons+")");
                    response.sendRedirect("done.html");
                    
                }
                }else{
                    response.sendRedirect("error.html");
                }
            }
            
            //*****************************************************
            
            if(action.compareToIgnoreCase("delsite") == 0){
                ActionsDef act = new ActionsDef();
                s = request.getSession(true);
                if(act.isAdmin(s.getAttribute("user").toString())){
                    actionSite acts = new actionSite();
                    String ids = request.getParameter("ids");
                    int i = acts.delsite(ids);
                    
                }
            }
            
            //*****************************************************
            
            if(action.compareToIgnoreCase("delete") == 0){
                ActionsDef act = new ActionsDef();
                s = request.getSession(true);
                if(act.isAdmin(s.getAttribute("user").toString())){
                    actionSite acts = new actionSite();
                    String typ = request.getParameter("what");
                    String ids = request.getParameter("ids");
                    String idname="";
                    if(typ.compareToIgnoreCase("batterie")==0) idname="idbatterie";
                    if(typ.compareToIgnoreCase("compteur")==0) idname="idcompteur";
                    if(typ.compareToIgnoreCase("climatisation")==0) idname="idclimatisation";
                    if(typ.compareToIgnoreCase("users")==0) idname="login";
                    if(typ.compareToIgnoreCase("redresseur")==0) idname="idredresseur";
                    if(typ.compareToIgnoreCase("rbs")==0) idname="idRBS";
                    if(typ.compareToIgnoreCase("bts")==0) idname="idBTS";
                    if(typ.compareToIgnoreCase("bsc")==0) idname="idBSC";
                    if(typ.compareToIgnoreCase("msc")==0) idname="idMSC";
                    if(typ.compareToIgnoreCase("antenne")==0) idname="idAntenne";
                    String q="delete from "+typ+" where "+idname+"='"+ids+"'";
                    DBconnect db = new DBconnect();
                    db.liaison();
                    //System.out.println(q);
                    db.S.execute(q);
                    
                    
                }
            }
            
            //************************************************************
            if (action.compareToIgnoreCase("saveRBSconf") == 0) {
                ActionsDef act = new ActionsDef();
                s = request.getSession(true);
                if (act.isAdmin(s.getAttribute("user").toString())) {

                    DBconnect db = new DBconnect();
                    db.liaison();
                    String[] st1 = request.getParameterValues("info");
                    ResultSet rs = db.S.executeQuery("select * from RBS where idRBS='"+st1[2]+"'") ;
                    if(rs.next()) db.S.executeUpdate("update RBS set idsite='" + st1[1] + "', utrancell='" + st1[3] + "', descRBS='" + st1[0] + "' where idRBS='"+st1[2]+"'");
                    else{
                        System.out.println("insert into RBS values('"+st1[2]+"','" + st1[1] + "','" + st1[3] + "','" + st1[0] + "')");
                        db.S.execute("insert into RBS values('"+st1[2]+"','" + st1[1] + "','" + st1[3] + "','" + st1[0] + "','indoor')");
                    }
                    for (int i = 0; i < 30; i++) {
                        String[] st = request.getParameterValues("part" + (i + 1));
                        
                        if ((st[1].compareToIgnoreCase("dummy") != 0) && (st[1].compareToIgnoreCase("") != 0)) {
                            //out.println(i + " select * from elementRBS where position = " + s[0]+"  "+s.length+"<br/>");
                            rs = db.S.executeQuery("select * from elementRBS where position = " + st[0]+ " and idRBS='"+st1[2]+"'") ;
                            if (rs.next()) {
                                db.S.executeUpdate("update elementRBS set nomeRBS='" + st[1] + "', val1='" + st[2] + "', val2='" + st[3] + "', val3='" + st[4] + "', val4='" + st[5] + "' where position=" + st[0]+ " and idRBS='"+st1[2]+"'");
                            } else {
                                
                                if(st.length == 4)
                                    db.S.execute("insert into elementRBS(idRBS,nomeRBS,position,val1,val2,val3,val4) values ('" + request.getParameterValues("info")[2].toString() + "','" + st[1] + "'," + st[0] + ",'" + st[2] + "','" + st[3] + "','" + st[4] + "','" + st[5] + "')");
                                else
                                    db.S.execute("insert into elementRBS(idRBS,nomeRBS,position,val1,val2,val3,val4) values ('" + request.getParameterValues("info")[2].toString() + "','" + st[1] + "'," + st[0] + ",'" + st[2] + "','" + st[3] + "','" + st[4] + "','')");
                            }

                        }else{
                            rs = db.S.executeQuery("select * from elementRBS where position = " + st[0]+ " and idRBS='"+st1[2]+"'");
                            if (rs.next()) {
                                db.S.executeUpdate("delete from elementRBS where position=" + st[0]+ " and idRBS='"+st1[2]+"'");
                            }
                        }
                        
                    }
                    //db.closeData();
                        response.sendRedirect("getRBS.jsp?ids="+st1[2]);
                }else
                    response.sendRedirect("error.html");
            }
            
            //************************************************************
            if (action.compareToIgnoreCase("savePorts") == 0) {
                ActionsDef act = new ActionsDef();
                s = request.getSession(true);
                if (act.isAdmin(s.getAttribute("user").toString())) {

                    DBconnect db = new DBconnect();
                    db.liaison();
                    String[] st = request.getParameterValues("infop");
                    String[] st1 = request.getParameterValues("infoe");
                    String[] st2 = request.getParameterValues("prt");
                    String ide = request.getParameter("ide");
                    String[] st3=new String[100];
                    
                    int n;
                    if(st != null){
                        n=st.length;
                    }else{
                        n=0;
                    }
                    if(request.getParameterValues("np")!=null)
                        st3 = request.getParameterValues("np");
                    for (int i = 0; i < st2.length; i++) {
                        
                        if(i<n){
                        ResultSet rs = db.S.executeQuery("select * from portsRBS where idport = " + st[i]);
                        if (rs.next()) {
                            ide = rs.getString(2);
                            if(st2[i].compareToIgnoreCase("")!=0)
                                db.S.executeUpdate("update portsRBS set status='1', linkedto='" + st2[i] + "' where idport=" + st[i]);
                            else
                                db.S.executeUpdate("update portsRBS set status='0', linkedto='' where idport=" + st[i]);
                        }
                        } else {
                            
                            if (st3[i - (n)].compareToIgnoreCase("") != 0) {
                                
                                if (st2[i].compareToIgnoreCase("") != 0) {
                                    db.S.execute("insert into portsRBS(ideRBS,nomport,status,linkedto) values ('" + st1[0] + "','" + st3[i - (n)] + "',1,'" + st2[i] + "')");
                                    //System.out.println("insert into portsRBS(ideRBS,nomport,status,linkedto) values ('" + st1[0] + "','" + st3[i - (st.length)] + "',1,'" + st2[i] + "')");
                                } else {
                                    db.S.execute("insert into portsRBS(ideRBS,nomport,status,linkedto) values ('" + st1[0] + "','" + st3[i - (n)] + "',0,'')");
                                    //System.out.println("insert into portsRBS(ideRBS,nomport,status,linkedto) values ('" + st1[0] + "','" + st3[i - (st.length)] + "',0,'')");
                                }
                            }
                        }

                    }
                    ResultSet rs = db.S.executeQuery("select * from elementRBS where ideRBS = " +ide);
                    if(rs.next()) response.sendRedirect("getports.jsp?ids="+rs.getString(2) +"&pos="+rs.getString(4));
                }else
                    response.sendRedirect("error.html");

                //

            }
            
            
            //***************************************************************************
            if (action.compareToIgnoreCase("delPort") == 0) {
                ActionsDef act = new ActionsDef();
                s = request.getSession(true);
                if (act.isAdmin(s.getAttribute("user").toString())) {

                    DBconnect db = new DBconnect();
                    db.liaison();
                    ResultSet rs;
                    String ide="";
                    String st = request.getParameter("idp");
                    rs = db.S.executeQuery("select * from portsRBS where idport = " + st);
                    if (rs.next()) {
                        ide = rs.getString(2);
                        db.S.execute("delete from portsRBS where idport = " + st);
                    }
                    rs = db.S.executeQuery("select * from elementRBS where ideRBS = " + ide);
                    if (rs.next()) {
                        response.sendRedirect("getports.jsp?ids=" + rs.getString(2) + "&pos=" + rs.getString(4));
                    }
                }else
                    response.sendRedirect("error.html");
                
            }
            
            
            
        } finally {            
            out.close();
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP
     * <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(actions.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Handles the HTTP
     * <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(actions.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}

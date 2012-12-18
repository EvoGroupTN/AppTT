/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package evo.actions;

import evo.db.DBconnect;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author hakeem
 */
public class actionSite implements actionSites{

    @Override
    public int addsite(String ids,String desc,String x,String y,String typ,String prop,String st) {
        try {
            
            DBconnect db = new DBconnect();
                db.liaison();
                PreparedStatement stmt = db.conn.prepareStatement("select * from site where idsite = ?");
      stmt.setString(1, ids);
      //stmt.setString(2, pwd);
      ResultSet rs = stmt.executeQuery();
        //        ResultSet rs = db.S.executeQuery("select * from site where idsite = '"+ids+"'");
                if(rs.next()){
                    db.S.execute("update site set descsite='"+desc+"', xsite="+x+", ysite="+y+", typesite='"+typ+"', propsite='"+prop+"',status="+st+" where idsite='"+ids+"'");
                    return 1;
                }else{
                    db.S.execute("insert into site values ('"+ids+"','"+desc+"',"+x+","+y+",'"+typ+"','"+prop+"',"+st+")");
                    db.S.execute("insert into equipement values ('equip01"+ids+"','"+ids+"')");
                    db.S.execute("insert into environnement values ('env01"+ids+"','"+ids+"')");
                    
                    return 1;
                }
               
              
            
        } catch (SQLException ex) {
            
            Logger.getLogger(actionSite.class.getName()).log(Level.SEVERE, null, ex);
            return 0;
        }
      
    }
    
    public int delsite(String ids) {
        try {
            
            DBconnect db = new DBconnect();
                db.liaison();
                PreparedStatement stmt = db.conn.prepareStatement("select * from site where idsite = ?");
      stmt.setString(1, ids);
      //stmt.setString(2, pwd);
      ResultSet rs = stmt.executeQuery();
        //        ResultSet rs = db.S.executeQuery("select * from site where idsite = '"+ids+"'");
                if(rs.next()){
                    db.S.execute("delete from site where idsite='"+ids+"'");
                    return 1;
                }else{
                    return 0;
                }
               
              
            
        } catch (SQLException ex) {
            
            Logger.getLogger(actionSite.class.getName()).log(Level.SEVERE, null, ex);
            return 0;
        }
      
    }
}

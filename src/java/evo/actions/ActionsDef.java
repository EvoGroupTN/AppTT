/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package evo.actions;

import evo.db.DBconnect;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author hakeem
 */
public class ActionsDef implements Actions{

    @Override
    public boolean isAdmin(String idu) {
        try {
            DBconnect db = new DBconnect();
            db.liaison();
            ResultSet rs = db.S.executeQuery("select * from users where login like '"+idu+"'");
            if(rs.next()){
                if(rs.getString(3).toString().compareToIgnoreCase("admin")==0){
                    return true;
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(ActionsDef.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
    
}

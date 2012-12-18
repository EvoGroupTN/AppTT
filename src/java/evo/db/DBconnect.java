package evo.db;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author hakeem
 */
public class DBconnect {
    /*String username = "root";
    String password ="hkmwhb";
    String url ="jdbc:mysql://localhost";
    String driver= "com.mysql.jdbc.Driver";
    Connection con =null;
        try
    	{
   		 Class.forName(driver);
   		 conn=DriverManager.getConnection (url,username,password) ;
	 	 S= conn.createStatement() ;
                 S2= conn.createStatement() ;
		}
		catch(Exception e)
		{
		System.out.print("Erreur");
		}
}*/
     public Connection conn;
    public Statement S = null;
    public Statement S2 = null;
    public ResultSet rs,rs2;

public void liaison(){
    try
    	{
   		 Class.forName("com.mysql.jdbc.Driver");
   		 conn=DriverManager.getConnection ("jdbc:mysql://localhost/telecom","root","hkmwhb") ;
	 	 S= conn.createStatement() ;
                 S2 = conn.createStatement();
		}
		catch(Exception e)
		{
		System.out.print("Erreur");
		}
}
public void closeData() throws SQLException{
    S.close();
    conn.close();
        

}
}

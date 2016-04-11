package cs5530;

import java.sql.*;

public class Login {
	
	public Login() {}
	
	public String verifyLogin(String _login, String _password, Statement stmt) {
		String sql="SELECT login, password, type FROM Users "
				+  "WHERE login ='" +_login +"'";
		String output="";
		ResultSet rs = null;
		int count = 0;
		
//		System.out.println("executing "+sql);
	 	try {
	 		rs = stmt.executeQuery(sql);
	 		while (rs.next()) {
//	 			System.out.println(rs.getString("password"));
// 				System.out.println(_password);
	 			if(rs.getString("password").equals(_password)) {
	 				output = rs.getString("type");
	 			}
	 			else {
	 				return "false";
	 			}
	 			count++;
	 		}
	 		
	 		// Check to see if query was empty
	 		if (count < 1) {    
	 			 return "mismatch";
	 		}
	 		rs.close();
	 	}
	 	catch(Exception e) {
	 		System.out.println("Database error. Please contact System Administrator");
	 		System.err.println(e.getMessage());
	 	}
	 	finally {
 			try {
	 			if (rs!=null && !rs.isClosed())
	 				rs.close();
	 		}
	 		catch(Exception e) {
	 			System.out.println("Can not close resultset");
	 		}
	 	}
	    return output;
	}
}

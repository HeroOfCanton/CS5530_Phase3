package cs5530;

import java.sql.*;

public class Register {
	
	public Register() {}
	
	public boolean registerUser(String _login, 
							 String _realName, 
							 String _password1, 
							 String _city, 
							 String _state, 
							 String _telephone, 
							 Statement stmt) {
		
		String sql="INSERT INTO Users (login, name, password, city, state, telephone, type) "
				+  "VALUES ('" +_login +"','" +_realName +"','" +_password1 +"','" +_city + "','" +_state +"','" +_telephone +"','user');";
		
		int rs = 0;
		//System.out.println("executing "+ sql);
	 	try {
	 		rs = stmt.executeUpdate(sql);
	 		
	 		if(rs > 0) {
	 			return true;
	 		}
	 		else {
	 			return false;
	 		}
	 	}
	 	catch(Exception e) {
	 		if(e.getMessage().equals("Duplicate entry '"+_login+"' for key 'PRIMARY'")) {
	 			System.out.println("Duplicate login name detected");
	 		}
	 	}
		return false;
	}
}

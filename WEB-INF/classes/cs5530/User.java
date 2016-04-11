package cs5530;

import java.sql.*;
import java.util.ArrayList;

public class User {
	
	public User () {}
	
	public String getLogin(String realName, Statement stmt) {
		String login = "";
		String sql = "SELECT login FROM Users"
				+ 	 " WHERE name = '" +realName + "';";
		
		ResultSet rs = null;
		int count = 0;
		
//		System.out.println("executing "+sql);
	 	try {
	 		rs = stmt.executeQuery(sql);
	 		while (rs.next()) {
	 			login = rs.getString("login");
	 			count++;
	 		}	 		
	 		// Check to see if query was empty
	 		if (count < 1) {    
	 			 return "";
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
		return login;
	}

	public boolean setTrust(String userName, String otherLogin, String trustVar, Statement stmt) {
		int trustVal;
		
		if(trustVar.equals("trusted")) {
			trustVal = 1;
		}
		else {
			trustVal = 0;
		}
		
		String sql="INSERT INTO Trust (login1, login2, isTrusted) "
				  + "VALUES ('" +userName +"', '" +otherLogin +"', '" +trustVal +"');";
				
		int success = 0;
//				System.out.println("executing "+ sql);
	 	try {
	 		success = stmt.executeUpdate(sql);
	 		
	 		if(success > 0) {
	 			return true;
	 		}
	 		else {
	 			return false;
	 		}
	 	}
	 	catch(Exception e) {
	 		if(e.getMessage().equals("Duplicate entry '"+userName +"' for key 'PRIMARY'")) {
	 			System.out.println("Duplicate trust attempt detected");
	 		}
	 		else {
	 			System.out.println(e.getMessage());
	 		}
	 	}
		return false;
	}

	public ArrayList<String> separationOne(String userOne, Statement stmt) {
		String login = getLogin(userOne, stmt);
		ArrayList<String> userList = new ArrayList<String>();
		
		String sql = "SELECT Users.name FROM Favorites"
				+ 	 " LEFT JOIN Users"
				+ 	 " ON Favorites.login = Users.Login"
				+ 	 " WHERE Favorites.pid IN"
				+ 	 " 	(SELECT f1.pid FROM Favorites f1, Favorites f2"
				+ 	 " 	WHERE f1.login != f2.login AND f1.login = '"+login+"' AND f1.pid = f2.pid)"
				+ 	 " AND Favorites.login != '"+login+"'";
		
		ResultSet rs = null;		
//		System.out.println("executing "+sql);
	 	try {
	 		rs = stmt.executeQuery(sql);
	 		while (rs.next()) {
	 			userList.add(rs.getString("name"));
	 		}	 		
	 		// Check to see if query was empty
	 		if (userList.isEmpty()) {    
	 			 return userList;
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
		return userList;
	}

	public ArrayList<String> separationTwo(String userOne, String userTwo, Statement stmt) {
		String firstLogin = getLogin(userOne, stmt);
		String secondLogin = getLogin(userTwo, stmt);
		ArrayList<String> userListOne = new ArrayList<String>();
		ArrayList<String> userListTwo = new ArrayList<String>();
		ArrayList<String> userListThree = new ArrayList<String>();
		
		String sql = "SELECT Users.name FROM Favorites"
				+ 	 " LEFT JOIN Users"
				+ 	 " ON Favorites.login = Users.Login"
				+ 	 " WHERE Favorites.pid IN"
				+ 	 " 	(SELECT f1.pid FROM Favorites f1, Favorites f2"
				+ 	 " 	WHERE f1.login != f2.login AND f1.login = '"+userOne+"' AND f1.pid = f2.pid)"
				+ 	 " AND Favorites.login != '"+userOne+"'";
		
		ResultSet rs = null;		
//		System.out.println("executing "+sql);
	 	try {
	 		rs = stmt.executeQuery(sql);
	 		while (rs.next()) {
	 			userListOne.add(rs.getString("name"));
	 		}	 		
	 		// Check to see if query was empty
	 		if (userListOne.isEmpty()) {    
	 			 return userListOne;
	 		}
	 		rs.close();
	 	}
	 	catch(Exception e) {
	 		System.out.println("Database error. Please contact System Administrator");
	 		System.err.println(e.getMessage());
	 	}
	 	
	 	sql = "SELECT Users.name FROM Favorites"
				+ 	 " LEFT JOIN Users"
				+ 	 " ON Favorites.login = Users.Login"
				+ 	 " WHERE Favorites.pid IN"
				+ 	 " 	(SELECT f1.pid FROM Favorites f1, Favorites f2"
				+ 	 " 	WHERE f1.login != f2.login AND f1.login = '"+userTwo+"' AND f1.pid = f2.pid)"
				+ 	 " AND Favorites.login != '"+userTwo+"'";
	 	
	 	try {
	 		rs = stmt.executeQuery(sql);
	 		while (rs.next()) {
	 			userListTwo.add(rs.getString("name"));
	 		}	 		
	 		// Check to see if query was empty
	 		if (userListTwo.isEmpty()) {    
	 			 return userListTwo;
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
	 	
	 	for(String string : userListOne) {
	 		if(userListTwo.contains(string)) {
	 			userListThree.add(string);
	 		}
	 	}
		return userListThree;
	}
}

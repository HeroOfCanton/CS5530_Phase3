package cs5530;

import java.sql.*;
import java.util.ArrayList;

public class Awards {
	
	public Awards() {}
	
	public ArrayList<String []> getTrusted(int numOfRecords, Statement stmt) {
		String[] trust = new String[2];
		ArrayList<String []> arr = new ArrayList<String []> ();
		String sql="SELECT Users.name, SUM(Trust.isTrusted) AS Total FROM Trust"
				+ " LEFT JOIN Users"
				+ " ON Trust.login2 = Users.login"
				+ " group by name"
				+ " order by Total desc"
				+ " LIMIT " +numOfRecords;
		
		ResultSet rs = null;
//		System.out.println("executing "+sql);
	 	try {
	 		rs = stmt.executeQuery(sql);
	 		while (rs.next()) {
	 			trust = new String[2];
	 			trust[0] = rs.getString("name");
	 			trust[1] = rs.getString("Total");
	 			arr.add(trust);
	 		}
	 		return arr;
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
		return arr;		
	}
	
	public ArrayList<String[]> getUseful(int numOfRecords, Statement stmt) {
		String[] useful = new String[2];
		ArrayList<String []> arr = new ArrayList<String []> ();
		String sql="SELECT Users.name, avg(Rates.rating) AS Average FROM Rates"
				+ " LEFT JOIN Feedback"
				+ " ON Rates.fid = Feedback.fid"
				+ " LEFT JOIN Users"
				+ " ON Users.login = Feedback.login"
				+ " group by name"
				+ " order by average desc"
				+ " LIMIT " +numOfRecords;
		
		ResultSet rs = null;
//		System.out.println("executing "+sql);
	 	try {
	 		rs = stmt.executeQuery(sql);
	 		while (rs.next()) {
	 			useful = new String[2];
	 			useful[0] = rs.getString("name");
	 			useful[1] = rs.getString("Average");
	 			arr.add(useful);
	 		}
	 		return arr;
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
		return arr;	
	}

}

package cs5530;

import java.sql.*;
import java.util.ArrayList;

public class Feedback {
	
	public Feedback() {}
	
	public boolean canGiveFeedback(String pid, String login, Statement stmt) {
		
		String sql="SELECT fid FROM Feedback "
				+  "WHERE pid ='" +pid +"' AND login = '" +login +"'";
		
		ResultSet rs = null;
		int count = 0;
		
//		System.out.println("executing "+sql);
	 	try {
	 		rs = stmt.executeQuery(sql);
	 		while (rs.next()) {
	 			String fid = rs.getString("fid");
	 			count++;
	 		}	 		
	 		// If count is < 1, that means there were no fid's to be found
	 		// for that pid and login. Thus, return true, as user can leave
	 		// feedback for that pid
	 		if (count < 1) {    
	 			 return true;
	 		}
	 		// There is an existing fid for that pid and login
	 		// return false, they can't leave more than one feedback
	 		else {
	 			return false;
	 		}
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
		return false;
	}

	public boolean addFeedback(String pid, 
							   String userName, 
							   String text, 
							   String score, 
							   String fbdate, 
							   Statement stmt) {
		
		String sql="INSERT INTO Feedback (pid, login, text, score, fbdate) "
				+  "VALUES ('" +pid +"','" +userName +"','" +text +"','" +score + "','" +fbdate +"');";
		
		int rs = 0;
//		System.out.println("executing "+ sql);
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
	 		if(e.getMessage().equals("Duplicate entry '"+pid +"' for key 'PRIMARY'")) {
	 			System.out.println("Duplicate feedback attempt detected");
	 		}
	 	}
		return false;
	}

	public ArrayList<String []> getPOIFeedback(String pid, String amount, String userName, Statement stmt) {
		ArrayList<String []> arr = new ArrayList<String []> ();
		String[] fb = new String[3];
		
		// Rating query
		if(amount.equals("all")) {
			String sql="SELECT fid, text, score FROM Feedback "
					+  "WHERE pid ='" +pid +"' AND NOT login = '" +userName + "';";
			
			ResultSet rs = null;
//			System.out.println("executing "+sql);
		 	try {
		 		rs = stmt.executeQuery(sql);
		 		while (rs.next()) {
		 			fb = new String[3];
		 			fb[0] = rs.getString("fid");
		 			fb[1] = rs.getString("text");
		 			fb[2] = rs.getString("score");
		 			arr.add(fb);
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
		else {
			int count = Integer.parseInt(amount);
			fb = new String[2];
			
			String sql = "SELECT DISTINCT f.text, f.score FROM Rates r, Feedback f"
					+    " WHERE f.fid IN (SELECT fid from Feedback WHERE pid = '" +pid +"')"
					+    " order by r.rating"
					+    " LIMIT " +count +";";
			
			ResultSet rs = null;
//			System.out.println("executing "+sql);
		 	try {
		 		rs = stmt.executeQuery(sql);
		 		while (rs.next()) {
		 			fb = new String[2];
		 			fb[0] = rs.getString("text");
		 			fb[1] = rs.getString("score");
		 			arr.add(fb);
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

	public boolean rateFeedback(String userName, String fid, String rating, Statement stmt) {
		String sql="INSERT INTO Rates (login, fid, rating) "
				+  "VALUES ('" +userName +"','" +fid +"','" +rating +"');";
		
		int rs = 0;
//		System.out.println("executing "+ sql);
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
	 		if(e.getMessage().equals("Duplicate entry '"+userName +"' for key 'PRIMARY'")) {
	 			System.out.println("Duplicate rating attempt detected");
	 		}
	 	}
		return false;
	}

}

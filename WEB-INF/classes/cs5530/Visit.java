package cs5530;

import java.sql.*;
import java.util.ArrayList;

public class Visit {
	
	public Visit() {}
	
	/**
	 * Takes in userName, pid, cost, numofheads, and visitdate
	 * Calls addtoVisEvent, which returns the vid we need to add
	 * this information to the Visit table. Returns true only if insert
	 * to VisEvent happened, and if this insert happens
	 * 
	 * @param userName
	 * @param pid
	 * @param cost
	 * @param numofheads
	 * @param visitdate
	 * @param stmt
	 * @return boolean
	 */
	public boolean addtoDB(String userName, 
						   String pid, 
						   String cost, 
						   String numofheads, 
						   String visitdate,
						   Statement stmt) {
		

		String vid = addtoVisEvent(cost, numofheads, stmt);
		
		if(vid.equals("") || vid.equals(null)) {
			return false;
		}
		
		String sql="INSERT INTO Visit (login, pid, vid, visitdate) "
				  + "VALUES ('"+userName +"', '" +pid +"', '" +vid +"', '" +visitdate +"');";
				
		int success = 0;
//		System.out.println("executing "+ sql);
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
	 		System.out.println(e.getMessage());
	 	}		
		return false;
	}
	
	/**
	 * Helper method to add cost and numofheads into VisEvent DB; returns
	 * the vid from that INSERT
	 * 
	 * @param cost
	 * @param numofheads
	 * @param stmt
	 * @return String
	 */
	private String addtoVisEvent(String cost, String numofheads, Statement stmt) {
		String autovalue;
		String sql = "INSERT INTO VisEvent (cost, numofheads) "
				+    "VALUES('" +cost +"', '" +numofheads +"');";
		
		int success = 0;
//		System.out.println("executing "+ sql);
	 	try {
	 		
	 		success = stmt.executeUpdate(sql);
	 		
	 		if(success > 0) {
	 			autovalue = lastid(stmt);
	 			return autovalue;
	 		}
	 		else {
	 			return "";
	 		}
	 	}
	 	catch(Exception e) {
	 		System.out.println(e.getMessage());
	 	}		
		return "";
	}
	
	/**
	 * Helper method to get the auto increment ID of the last
	 * thing inserted into the database
	 * 
	 * @param stmt
	 * @return
	 */
	private String lastid(Statement stmt) {
		String sql="SELECT last_insert_id()";
		String output="";
		ResultSet rs = null;
		int count = 0;
		
//		System.out.println("executing "+sql);
	 	try {
	 		rs = stmt.executeQuery(sql);
	 		while (rs.next()) {
	 			output = rs.getString("last_insert_id()");
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
	    return output;
	}
	
	public ArrayList<String []> getVisitSuggestions(String pid, Statement stmt) {
		
		ArrayList<String []> arr = new ArrayList<String []> ();
		String[] suggestions = new String[3];
		
		String sql = "SELECT Visit.PID, POI.name, count(*) AS visits FROM Visit"
				+ 	 " LEFT JOIN POI"
				+ 	 " ON Visit.pid = POI.pid"
				+ 	 " WHERE login IN"
				+  	 "	(SELECT distinct login from Visit WHERE pid = '" +pid +"')"
				+ 	 " AND NOT POI.pid = '" +pid +"'"
				+ 	 " group by pid"
				+ 	 " order by visits desc;";

		ResultSet rs = null;
//		System.out.println("executing "+sql);
	 	try {
	 		rs = stmt.executeQuery(sql);
	 		while (rs.next()) {
	 			suggestions = new String[3];
	 			suggestions[0] = rs.getString("name");
	 			suggestions[1] = rs.getString("visits");
	 			arr.add(suggestions);
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

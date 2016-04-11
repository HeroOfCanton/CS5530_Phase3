package cs5530;

import java.sql.*;
import java.util.Date;
import java.text.DateFormat;
import java.text.SimpleDateFormat;

public class Favorite {

	public Favorite() {}
	
	public String hasFavorite(String login, Statement stmt) {
		
		String sql="SELECT POI.name from POI " 
				  +"WHERE pid IN "
				  +"(SELECT pid from Favorites WHERE login = '" +login +"');";
		
		String output="";
		ResultSet rs = null;
		int count = 0;
		
//		System.out.println("executing "+sql);
	 	try {
	 		rs = stmt.executeQuery(sql);
	 		while (rs.next()) {
	 			output = rs.getString("name");
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

	public boolean saveFavorite(String userName, String newFavorite, Statement stmt) {
		
		DateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy");
		Date date = new Date();
		String currentDate = dateFormat.format(date);
		String sql="INSERT INTO Favorites (pid, login, fvdate) "
		  + "VALUES ((SELECT pid from POI WHERE name ='"+newFavorite +"'), '" +userName +"', '" +currentDate +"');";
		
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
	 * Function to change user's favorite POI. 
	 * @param userName - current user
	 * @param changeVar - user's new favorite
	 * @param stmt - a statement
	 */
	public boolean changeFavorite(String userName, String changeVar, Statement stmt) {
		
		DateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy");
		Date date = new Date();
		String currentDate = dateFormat.format(date);
		
		String sql = "UPDATE Favorites "
					+"SET pid = (SELECT pid from POI WHERE name ='" +changeVar +"'), fvdate ='" +currentDate +"'"
					+" WHERE login='" +userName +"';";
	
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
	 		System.err.println(e.getMessage());
	 	}
		return false;
	}
}

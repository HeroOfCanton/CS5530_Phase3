package cs5530;

import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

public class POI {
	public POI() {}
	
	public boolean newPOI(String name, 
						  String city, 
						  String state, 
						  String url, 
						  String telephone, 
						  String yearest, 
						  String hours, 
						  String price, 
						  String category, 
						  Statement stmt) {
		
		String sql="INSERT INTO POI (name, city, state, url, telephone, yearest, hours, price, category) "
				+  "VALUES ('" +name +"','" +city +"','" +state +"','" +url + "','" +telephone +"','" +yearest +"','" +hours +"','" +price + "','" +category +"');";
		
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
	 		if(e.getMessage().equals("Duplicate entry '"+name+"' for key 'PRIMARY'")) {
	 			System.out.println("Duplicate POI name detected");
	 		}
	 		else {
	 			System.err.println(e.getMessage());
	 		}
	 	}
		return false;
	}

	public boolean updatePOI(String name, 
							 String updateField, 
							 String updateVar,
							 Statement stmt) {
		
		String sql = "UPDATE POI "
					+"SET " +updateField +"='" +updateVar +"'"
					+" WHERE name='" +name +"';";
		
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
	
	public String getPid (String name, Statement stmt) {
		String pid = "";		
		String sql="SELECT pid FROM POI "
				+  "WHERE name ='" +name +"'";		
		ResultSet rs = null;
		int count = 0;
		
//		System.out.println("executing "+sql);
	 	try {
	 		rs = stmt.executeQuery(sql);
	 		while (rs.next()) {
	 			pid = rs.getString("pid");
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
		return pid;
	}
	
	public ArrayList<String> getCategories(Statement stmt) {
		ArrayList<String> categories = new ArrayList<String>();

		ResultSet rs = null;
		String sql = "SELECT category FROM POI"
				+    " group by category";
		
		try {
	 		rs = stmt.executeQuery(sql);
	 		while (rs.next()) {
	 			categories.add(rs.getString("category"));
	 		}
		}
		
	 	catch(Exception e) {
		 		System.out.println("Database error. Please contact System Administrator");
		 		System.err.println(e.getMessage());
		}
		return categories;
	}

	public ArrayList<String[]> getPopular(String _limit, Statement stmt) {
		int limit = Integer.parseInt(_limit);
		ArrayList<String []> arr = new ArrayList<String []> ();
		ArrayList<String> categories = new ArrayList<String>();
		String[] popular = new String[3];
		ResultSet rs = null;
		
		String sql = "SELECT category FROM POI"
				+    " group by category";
		
		try {
	 		rs = stmt.executeQuery(sql);
	 		while (rs.next()) {
	 			categories.add(rs.getString("category"));
	 		}
		}
		
	 	catch(Exception e) {
		 		System.out.println("Database error. Please contact System Administrator");
		 		System.err.println(e.getMessage());
		}
		
		for(String category : categories) {
			sql = "SELECT POI.name, POI.category, count(*) AS Visits FROM VisEvent"
					+ " LEFT JOIN Visit"
					+ " ON Visit.vid = VisEvent.vid"
					+ " LEFT Join POI"
					+ " ON POI.pid = Visit.pid"
					+ " WHERE POI.Category = '" +category +"'"
					+ " group by name"
					+ " order by POI.category, Visits desc"
					+ " LIMIT " +limit;
	
			rs = null;
	//		System.out.println("executing "+sql);
		 	try {
		 		rs = stmt.executeQuery(sql);
		 		while (rs.next()) {
		 			popular = new String[3];
		 			popular[0] = rs.getString("name");
		 			popular[1] = rs.getString("category");
		 			popular[2] = rs.getString("Visits");
		 			arr.add(popular);
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
		}
		return arr;
	}

	public ArrayList<String[]> getExpensive(String _limit, Statement stmt) {
		int limit = Integer.parseInt(_limit);
		ArrayList<String []> arr = new ArrayList<String []> ();
		ArrayList<String> categories = new ArrayList<String>();
		String[] expensive = new String[3];
		ResultSet rs = null;
		
		String sql = "SELECT category FROM POI"
				+    " group by category";
		
		try {
	 		rs = stmt.executeQuery(sql);
	 		while (rs.next()) {
	 			categories.add(rs.getString("category"));
	 		}
		}
		
	 	catch(Exception e) {
		 		System.out.println("Database error. Please contact System Administrator");
		 		System.err.println(e.getMessage());
		}
		
		for(String category : categories) {
			sql = "SELECT POI.name, POI.category, avg(VisEvent.cost) AS Average FROM VisEvent"
					+ " LEFT JOIN Visit"
					+ " ON Visit.vid = VisEvent.vid"
					+ " LEFT Join POI"
					+ " ON POI.pid = Visit.pid"
					+ " WHERE POI.Category = '" +category +"'"
					+ " group by name"
					+ " order by POI.category, Average desc"
					+ " LIMIT " +limit;
	
			rs = null;
	//		System.out.println("executing "+sql);
		 	try {
		 		rs = stmt.executeQuery(sql);
		 		while (rs.next()) {
		 			expensive = new String[3];
		 			expensive[0] = rs.getString("name");
		 			expensive[1] = rs.getString("category");
		 			expensive[2] = rs.getString("Average");
		 			arr.add(expensive);
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
		}
		return arr;
	}

	public ArrayList<String[]> getRated(String _limit, Statement stmt) {
		int limit = Integer.parseInt(_limit);
		ArrayList<String []> arr = new ArrayList<String []> ();
		ArrayList<String> categories = new ArrayList<String>();
		String[] expensive = new String[3];
		ResultSet rs = null;
		
		String sql = "SELECT category FROM POI"
				+    " group by category";
		
		try {
	 		rs = stmt.executeQuery(sql);
	 		while (rs.next()) {
	 			categories.add(rs.getString("category"));
	 		}
		}
		
	 	catch(Exception e) {
		 		System.out.println("Database error. Please contact System Administrator");
		 		System.err.println(e.getMessage());
		}
		
		for(String category : categories) {
			sql = "SELECT POI.name, POI.category, avg(Rates.rating) AS Rating FROM Rates"
					+ " LEFT JOIN Feedback"
					+ " ON Rates.fid = Feedback.fid"
					+ " LEFT Join POI"
					+ " ON POI.pid = Feedback.pid"
					+ " WHERE POI.Category = '" +category +"'"
					+ " group by name"
					+ " order by POI.category, Rating desc"
					+ " LIMIT " +limit;
	
			rs = null;
	//		System.out.println("executing "+sql);
		 	try {
		 		rs = stmt.executeQuery(sql);
		 		while (rs.next()) {
		 			expensive = new String[3];
		 			expensive[0] = rs.getString("name");
		 			expensive[1] = rs.getString("category");
		 			expensive[2] = rs.getString("Rating");
		 			arr.add(expensive);
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
		}
		return arr;
	}

	public ArrayList<String> getAdr(String adrvar, String adrchoice, String sort, Statement stmt) {
		ArrayList<String> results = new ArrayList<String> ();
		String sql = null;
		if(adrchoice.equals("city") || adrchoice.equals("City")) {
			if(sort.equals("feedback")) {
				sql = "SELECT POI.name FROM (SELECT pid FROM POI"
						+ " WHERE city like '%"+adrvar+"%') AS poikeys "
						+ " INNER JOIN ("
						+ " SELECT POI.pid, avg(Rates.rating) AS Rating FROM Rates"
						+ " LEFT JOIN Feedback"
						+ " ON Rates.fid = Feedback.fid"
						+ " LEFT Join POI"
						+ " ON POI.pid = Feedback.pid"
						+ " group by name) AS poid"
						+ " ON poikeys.pid = poid.pid"
						+ " LEFT JOIN POI"
						+ " ON POI.pid = poikeys.pid"
						+ " order by Rating desc";
			}
			else {
				sql = "SELECT POI.name FROM (SELECT pid FROM POI"
						+ " WHERE city like '%"+adrvar+"%') AS poikeys "
						+ " INNER JOIN ("
						+ " SELECT POI.pid, avg(VisEvent.cost) AS Average FROM VisEvent"
						+ " LEFT JOIN Visit"
						+ " ON Visit.vid = VisEvent.vid"
						+ " LEFT Join POI"
						+ " ON POI.pid = Visit.pid"
						+ " group by name) AS poid"
						+ " ON poikeys.pid = poid.pid"
						+ " LEFT JOIN POI"
						+ " ON POI.pid = poikeys.pid"
						+ " order by Average desc";
			}
		}
		else {
			if(sort.equals("feedback")) {
				sql = "SELECT POI.name FROM (SELECT pid FROM POI"
						+ " WHERE state like '%"+adrvar+"%') AS poikeys "
						+ " INNER JOIN ("
						+ " SELECT POI.pid, avg(Rates.rating) AS Rating FROM Rates"
						+ " LEFT JOIN Feedback"
						+ " ON Rates.fid = Feedback.fid"
						+ " LEFT Join POI"
						+ " ON POI.pid = Feedback.pid"
						+ " group by name) AS poid"
						+ " ON poikeys.pid = poid.pid"
						+ " LEFT JOIN POI"
						+ " ON POI.pid = poikeys.pid"
						+ " order by Rating desc";
			}
			else {
				sql = "SELECT POI.name FROM (SELECT pid FROM POI"
						+ " WHERE state like '%"+adrvar+"%') AS poikeys "
						+ " INNER JOIN ("
						+ " SELECT POI.pid, avg(VisEvent.cost) AS Average FROM VisEvent"
						+ " LEFT JOIN Visit"
						+ " ON Visit.vid = VisEvent.vid"
						+ " LEFT Join POI"
						+ " ON POI.pid = Visit.pid"
						+ " group by name) AS poid"
						+ " ON poikeys.pid = poid.pid"
						+ " LEFT JOIN POI"
						+ " ON POI.pid = poikeys.pid"
						+ " order by Average desc";
			}
		}
		
		ResultSet rs = null;
		
		try {
	 		rs = stmt.executeQuery(sql);
	 		while (rs.next()) {
	 			results.add(rs.getString("name"));
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
		return results;
	}
	

	public ArrayList<String> getPrice(String lowPrice, String highPrice, String sort, Statement stmt) {
		return null;
		// TODO Auto-generated method stub
		
	}

	public ArrayList<String> getCat(String catvar, String sort, Statement stmt) {
		ArrayList<String> results = new ArrayList<String> ();
		String sql = null;
		
		if(sort.equals("feedback")) {
			sql = "SELECT POI.name FROM (SELECT pid FROM POI"
					+ " WHERE category like '%"+catvar+"%') AS poikeys "
					+ " INNER JOIN ("
					+ " SELECT POI.pid, avg(Rates.rating) AS Rating FROM Rates"
					+ " LEFT JOIN Feedback"
					+ " ON Rates.fid = Feedback.fid"
					+ " LEFT Join POI"
					+ " ON POI.pid = Feedback.pid"
					+ " group by name) AS poid"
					+ " ON poikeys.pid = poid.pid"
					+ " LEFT JOIN POI"
					+ " ON POI.pid = poikeys.pid"
					+ " order by Rating desc";
		}
		else {
			sql = "SELECT POI.name FROM (SELECT pid FROM POI"
					+ " WHERE category like '%"+catvar+"%') AS poikeys "
					+ " INNER JOIN ("
					+ " SELECT POI.pid, avg(VisEvent.cost) AS Average FROM VisEvent"
					+ " LEFT JOIN Visit"
					+ " ON Visit.vid = VisEvent.vid"
					+ " LEFT Join POI"
					+ " ON POI.pid = Visit.pid"
					+ " group by name) AS poid"
					+ " ON poikeys.pid = poid.pid"
					+ " LEFT JOIN POI"
					+ " ON POI.pid = poikeys.pid"
					+ " order by Average desc";
		}
		ResultSet rs = null;
		
		try {
	 		rs = stmt.executeQuery(sql);
	 		while (rs.next()) {
	 			results.add(rs.getString("name"));
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
		return results;
	}

	public ArrayList<String> getKeywords(String keyvar, String sort, Statement stmt) {
		
		ArrayList<String> results = new ArrayList<String> ();
		String sql = null;
		if(sort.equals("feedback")) {
			sql = "SELECT POI.name FROM (SELECT POI.pid FROM HasKeywords"
				+ " LEFT JOIN Keywords"
				+ " ON Keywords.wid = HasKeywords.wid"
				+ " LEFT JOIN POI"
				+ " ON POI.pid = HasKeywords.pid "
				+ " WHERE word like '%"+keyvar+"%') AS poikeys"
				+ " INNER JOIN ("
				+ " SELECT POI.pid, avg(Rates.rating) AS Rating FROM Rates"
				+ " LEFT JOIN Feedback"
				+ " ON Rates.fid = Feedback.fid"
				+ " LEFT Join POI"
				+ " ON POI.pid = Feedback.pid"
				+ " group by name) AS poid"
				+ " ON poikeys.pid = poid.pid"
				+ " LEFT JOIN POI"
				+ " ON POI.pid = poikeys.pid"
				+ " order by Rating desc";
		}
		else {
			sql = "SELECT POI.name FROM (SELECT POI.pid FROM HasKeywords"
				+ " LEFT JOIN Keywords"
				+ " ON Keywords.wid = HasKeywords.wid"
				+ " LEFT JOIN POI"
				+ " ON POI.pid = HasKeywords.pid"
				+ " WHERE word like '%"+keyvar+"%') AS poikeys"
				+ " INNER JOIN ("
				+ " SELECT POI.pid, avg(VisEvent.cost) AS Average FROM VisEvent"
				+ " LEFT JOIN Visit"
				+ " ON Visit.vid = VisEvent.vid"
				+ " LEFT Join POI"
				+ " ON POI.pid = Visit.pid"
				+ " group by name) AS poid"
				+ " ON poikeys.pid = poid.pid"
				+ " LEFT JOIN POI"
				+ " ON POI.pid = poikeys.pid"
				+ " order by Average desc";
		}

		ResultSet rs = null;
		
		try {
	 		rs = stmt.executeQuery(sql);
	 		while (rs.next()) {
	 			results.add(rs.getString("name"));
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
		return results;
	}
}

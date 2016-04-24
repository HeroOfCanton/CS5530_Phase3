<%@ page language="java" import="cs5530.*" %>
<%@ page import="java.util.ArrayList" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>Statistics</title>
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

		<meta name="AUTHOR"      content="Ryan Welling"/>
		<meta name="keywords"    content="University of Utah, Spring 2016"/>
		<meta name="description" content="Statistics"/>

		<!-- ALL CSS FILES -->
		<!-- Latest compiled and minified CSS -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous">

		<!-- Optional theme -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap-theme.min.css" integrity="sha384-fLW2N01lMqjakBkx3l/M9EahuwpSfeNvV63J5ezn3uZzapT0u7EYsXMjQV+0En5r" crossorigin="anonymous">

		<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>

		<!-- Latest compiled and minified JavaScript -->
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous"></script>
	</head>

	<body>

		<div class="jumbotron">
			<div align="center">	
				<h1 style="color: #e8002b; text-shadow: 2px 2px #000000;">Welcome to UTrack</h1>
				<h3>Site Statistics</h3>
			</div>
		</div>

		<%
		String searchAttribute = request.getParameter("searchAttribute");
		if( searchAttribute == null ) {
		%>

		<div class="container" style="padding-top: 50px;">
			<div class="row">
				<div class="col-sm-4"></div>
				<div class="col-sm-4 text-right">
					<form name="register_user" method=get onsubmit="return check_all_fields(this)" action="statistics.jsp">
						<input type=hidden name="searchAttribute">
						Enter number of records to return?
							<input type=text name="limit"><br/>
						Enter number of category to view:<br/>
						1: Most popular POI's<br/>
						2: Most expensive POI's<br/>
						3: Highly rated POI's<br/>
						4: Return to previous menu<br/>
							<input type=text name="choice"><br/>
						<input type=submit>
					</form>
					<a href="index.html"><button class="btn"><span>Return</span></button></a>
				</div><!--col-sm-6-->
				<div class="col-sm-4"></div>
			</div><!--row-->
		</div><!--container-->

		<%
		} else {

			int c = 0;
			int count = 1;
			String limit = request.getParameter("limit");
			String choice = request.getParameter("choice");
			ArrayList<String []> results = new ArrayList<String []> ();
			Connector con = new Connector();
			POI poi = new POI();

		 	try {
		 		c = Integer.parseInt(choice);
		 	}
		 	catch (Exception e) {
		 		out.println(e.getMessage());
		 	}
		 	
		 	switch(c) {
		 	 	case(1):
		 	 		results = poi.getPopular(limit, con.stmt);
			 	 	out.println("<div align='center'>Here are the most popular POIs, by category:</div>");
				 	// Walk the arraylist
					for(int i = 0; i < results.size(); i++) {
						String[] arr = results.get(i);
						out.println("<div align='center'>" + count + "- POI Name: " +arr[0] +" || Category: " +arr[1] + " || Total Visits: " + arr[2] + "</div>");
						// New feedback, let's increment count
						count++;
					}
		 	 		break;
		 	 	case(2):
		 	 		results = poi.getExpensive(limit, con.stmt);
			 	 	out.println("<div align='center'>Here are the most expensive POIs, by category:</div>");
				 	// Walk the arraylist
					for(int i = 0; i < results.size(); i++) {
						String[] arr = results.get(i);
						out.println("<div align='center'>" + count + "- POI Name: " +arr[0] +" || Category: " +arr[1] + " || Avg. Price: $" + arr[2] + "</div>");
						// New feedback, let's increment count
						count++;
					}
		 	 		break;
		 	 	case(3):
		 	 		results = poi.getRated(limit, con.stmt);
			 	 	out.println("<div align='center'>Here are the highest rated POIs, by category:</div>");
				 	// Walk the arraylist
					for(int i = 0; i < results.size(); i++) {
						String[] arr = results.get(i);
						out.println("<div align='center'>" + count + "- POI Name: " +arr[0] +" || Category: " +arr[1] + " || Avg. Rating: " + arr[2] + "</div>");
						// New feedback, let's increment count
						count++;
					}
		 	 		break;
		 	 	case(4):
		 	 	default:
		 	 		break;
			}
			out.println("<p align='center'><a href='user_menu.jsp'>Back to User Menu</a></p>");
			con.closeConnection();
		}
		%>

	</body>
</html>

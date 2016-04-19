<%@ page language="java" import="cs5530.*" %>
<%@ page import="java.util.ArrayList" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>Browse POI</title>
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

		<meta name="AUTHOR"      content="Ryan Welling"/>
		<meta name="keywords"    content="University of Utah, Spring 2016"/>
		<meta name="description" content="Browse POI"/>

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
				<h3>Browse POI</h3>
			</div>
		</div>

		<%
		String searchAttribute = request.getParameter("searchAttribute");
		if( searchAttribute == null ){
		   // out.println(session.getAttribute("userName").toString());
		%>
		
		<div class="container" style="padding-top: 50px;">
			<div class="row">
				<div class="col-sm-4"></div>
				<div class="col-sm-4 text-right">
					<form name="register_user" method=get onsubmit="return check_all_fields(this)" action="trusted.jsp">
						<input type=hidden name="searchAttribute">
						Choose how you want the results sorted:<br/>
						1. By price<br/>
						2. By avg feedbacks<br/>
						<input type=text name="choice"><br/>
						Please choose how to browse the POIs:
						1. POI by City / State
						2. POI by Keywords
						3. POI by Category
						4. Return to previous menu
						<input type=text name="choice" placeholder="trusted / untrusted"><br/>
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
			String sort = null;
			String choice;
			ArrayList<String> poiarr = null;
			String userName = session.getAttribute("userName").toString();
			Connector con = new Connector();
			POI poi = new POI();
			
		 	if(choice.equals("1")) {
		 		sort = "price";
		 	}
		 	else if(choice.equals("2")) {
		 		sort = "feedback";
		 	}
		 	else {
		 		out.println("<div align='center'>You didn't enter the right choice" +
		 					"<p><a href='user_menu.jsp'>Back to User Menu</a></p></div>");
		 	}

	   	 	
	   	 	browse: while(true) {
			 	c = Integer.parseInt(choice);
			 		
			 	switch(c) {
			 	case(1):
			 		String adrvar = null;
			 		String adrchoice = null;

			 		System.out.println("By City or State?:");
			 		while ((adrchoice = in.readLine()) == null && adrchoice.length() == 0);
			 		if(adrchoice.equals("city") || adrchoice.equals("City")) {
			 			System.out.println("Enter the name of the City:");
			 			while ((adrvar = in.readLine()) == null && adrvar.length() == 0);
			 		}
			 		else if(adrchoice.equals("state") || adrchoice.equals("State")) {
			 			System.out.println("Enter the two letter abreviation for the State:");
			 			while ((adrvar = in.readLine()) == null && adrvar.length() == 0);
			 		}
			 		else {
			 			System.out.println("No one likes a funny guy");
			 			System.exit(0);
			 		}
			 		poiarr = poi.getAdr(adrvar, adrchoice, sort, con.stmt);
			 		break;
			 	case(2):
			 		String keyvar = null;
			 		System.out.println("Enter the keyword to search by:");
			 		while ((keyvar = in.readLine()) == null && keyvar.length() == 0);
			 		poiarr = poi.getKeywords(keyvar, sort, con.stmt);
			 		break;
			 	case(3):
			 		ArrayList<String>categories = poi.getCategories(con.stmt);
			 		String catvar;
			 		System.out.println("Here are a list of categories:");
			 		for(String string : categories) {
			 			System.out.println(string);
			 		}
			 		System.out.println("Which category would you like to search by?");
			 		while ((catvar = in.readLine()) == null && catvar.length() == 0);
			 		poiarr = poi.getCat(catvar, sort, con.stmt);
			 		break;
			 	case(4):
			 	default:
			 		break browse;
			 	}
			 	
			 	System.out.println(" \nHere are the POI's you requested:");
			 	for(String string : poiarr) {
			 		System.out.println(string);
			 	}
			 	System.out.println("\n");
			 	break;
	   	 	}
			out.println("<p align='center'><a href='user_menu.jsp'>Back to User Menu</a></p>");
			con.closeConnection();
		}
		%>

	</body>
</html>

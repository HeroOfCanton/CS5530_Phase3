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
		%>
		
		<div class="container" style="padding-top: 50px;">
			<div class="row">
				<div class="col-sm-12">
					<p align="center">Choose how you want to browse the POI's</p>
				</div>
			</div>
			<div class="row">
				<div class="col-sm-4 text-left">
					<form name="register_user" method=get onsubmit="return check_all_fields(this)" action="browse.jsp">
						<input type=hidden name="searchAttribute">
							<p align="center" style="color: red; border-style: double;">Search by City / State</p>
							Enter EITHER City or State
							Enter the name of the City:
								<input type=text name="adrvar_city" placeholder="South Jordan"><br/>
							Enter 2 letter name of the State:
								<input type=text name="adrvar_state" placeholder="UT"><br/>
							Choose how you want the results sorted:<br/>
							1. By price<br/>
							2. By avg feedbacks<br/>
								<input type=text name="sorted_CS"><br/>
						<input type=submit>
					</form>
				</div><!--col-sm-4-->
				<div class="col-sm-4 text-center">
					<form name="register_user" method=get onsubmit="return check_all_fields(this)" action="browse.jsp">
						<input type=hidden name="searchAttribute">
							<p style="color: blue; border-style: double;">Search by Keywords</p>
							Enter the keyword to search by:
								<input type=text name="adrvar_key" placeholder=""><br/>
							Choose how you want the results sorted:<br/>
							1. By price<br/>
							2. By avg feedbacks<br/>
								<input type=text name="sorted_keys"><br/>
						<input type=submit>
					</form>
					<a href="index.html"><button class="btn"><span>Return</span></button></a>
				</div><!--col-sm-4-->
				<div class="col-sm-4 text-right">
					<form name="register_user" method=get onsubmit="return check_all_fields(this)" action="browse.jsp">
						<input type=hidden name="searchAttribute">
							<p align="center" style="color: green; border-style: double;">Search by Categories</p>
							Enter category to search by:
								<input type=text name="adrvar_cat" placeholder=""><br/>
							Choose how you want the results sorted:<br/>
							1. By price<br/>
							2. By avg feedbacks<br/>
								<input type=text name="sorted_cats"><br/>
						<input type=submit>
					</form>
				</div><!--col-sm-4-->
			</div><!--row-->
		</div><!--container-->
		
		<%
		} else {

			int c = 0;
			String sort = null;
			String sorted_CS = request.getParameter("sorted_CS");
			String sorted_keys = request.getParameter("sorted_keys");
			String sorted_cats = request.getParameter("sorted_cats");
			int choice = 0;
			ArrayList<String> poiarr = null;
			String userName = session.getAttribute("userName").toString();
			Connector con = new Connector();
			POI poi = new POI();

			// sort by city / state
			if(sorted_CS.equals("1")) {
				sort = "price";
				choice = 1;
			}
			else if(sorted_CS.equals("2")) {
				sort = "feedback";
				choice = 1;
		 	}
			
			// sort by keywords
		 	if(sorted_keys.equals("1")) {
				sort = "price";
				choice = 2;
			}
			else if(sorted_keys.equals("2")) {
				sort = "feedback";
				choice = 2;
		 	}

		 	// sort by categories
		 	if(sorted_cats.equals("1")) {
				sort = "price";
				choice = 3;
			}
			else if(sorted_cats.equals("2")) {
				sort = "feedback";
				choice = 3;
		 	}

	   	 	
	   	 	browse: while(true) {
			 	c = choice;
			 		
			 	switch(c) {
			 	case(1):
					String adrchoice = "";
					String adrvar = "";
			 		if(request.getParameter("adrvar_city") != null) {
			 			adrvar = request.getParameter("adrvar_city");
			 			adrchoice = "city";
			 		}
			 		else if (request.getParameter("adrvar_state") != null){
			 			adrvar = request.getParameter("adrvar_city");
			 			adrchoice = "state";
			 		}

			 		poiarr = poi.getAdr(adrvar, adrchoice, sort, con.stmt);
			 		break;
			 	case(2):
			 		String keyvar = request.getParameter("adrvar_key");
			 		
			 		poiarr = poi.getKeywords(keyvar, sort, con.stmt);
			 		break;
			 	case(3):
			 		String catvar = request.getParameter("adrvar_cat");
			 		poiarr = poi.getCat(catvar, sort, con.stmt);
			 		break;
			 	case(4):
			 	default:
			 		break browse;
			 	}
			 	
			 	out.println("<p align='center'>Here are the POI's you requested:</p>");
			 	for(String string : poiarr) {
			 		out.println("<p align='center'>" + string + "</p>");
			 	}
			 	break;
	   	 	}
			out.println("<p align='center'><a href='user_menu.jsp'>Back to User Menu</a></p>");
			con.closeConnection();
		}
		%>

	</body>
</html>

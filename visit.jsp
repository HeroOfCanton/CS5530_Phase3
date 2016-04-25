<%@ page language="java" import="cs5530.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>Record a Visit</title>
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

		<meta name="AUTHOR"      content="Ryan Welling"/>
		<meta name="keywords"    content="University of Utah, Spring 2016"/>
		<meta name="description" content="Record a Visit"/>

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
				<h3>Record a Visit</h3>
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
					<form name="register_user" method=get onsubmit="return check_all_fields(this)" action="visit.jsp">
						<input type=hidden name="searchAttribute">
						Enter the name of the POI to record a visit:
							<input type=text name="poiName"><br/>
						What was the total amount spent in this visit?
							<input type=text name="cost"><br/>
						How many people were in the party?
							<input type=text name="numofheads"><br/>
						If you visited today, type Y for yes
							<input type=text name="visitToday"><br/>
						If you didn't visit today, enter date here as mm/dd/yyyy
							<input type=text name="visitdate"><br/>
						Please check information before submitting.<br/> 
						Change if necessary.<br/> 
						<input type=submit>
					</form>
					<a href="user_menu.jsp"><button class="btn"><span>Return</span></button></a>
				</div><!--col-sm-6-->
				<div class="col-sm-4"></div>
			</div><!--row-->
		</div><!--container-->

		<%
		} else {

			Visit visit = new Visit();
			POI poi = new POI();
			String poiName = request.getParameter("poiName");
			String cost = request.getParameter("cost");
			String numofheads = request.getParameter("numofheads");
			String visitToday = request.getParameter("visitToday");
			String visitdate = request.getParameter("visitdate");
			Connector con = new Connector();
			String userName = session.getAttribute("userName").toString();
			ArrayList<String []> suggestions = new ArrayList<String []>();
			
			String pid = poi.getPid(poiName, con.stmt);
			if(pid.equals("")) {
				out.println("<p align='center'>That POI does not exist</p>");
				out.println("<p align='center'><a href='user_menu.jsp'>Back to User Menu</a></p>");
				return;
			}
			
			if(visitToday.equals("Y") || visitToday.equals("y")) {
				DateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy");
				Date date = new Date();
				visitdate = dateFormat.format(date);
			}
			
			if(visit.addtoDB(userName, pid, cost, numofheads, visitdate, con.stmt)) {
				out.println("<p align='center'>Your visit has been recorded</p>");
				out.println("<p align='center'>Here are some other Points of Interest you might like:</p>");
				suggestions = visit.getVisitSuggestions(pid, con.stmt);
				// Count should start at 1, and only increment when they get a new suggestion
				// which should correspond to a new array in this arraylist
				int count = 1;
				
				// Walk the arraylist
				for(int i = 0; i < suggestions.size(); i++) {
					String arr[] = suggestions.get(i);
					out.println("<p align='center'>" + count + "- POI Name: " +arr[0] +" || Number of Times Visited: " +arr[1] + "</p>");
					// New suggestion, let's increment count
					count++;
				}
			}
			else {
				out.println("<p align='center'>Your visit has not been recorded. Try again.</p>");
			}
			out.println("<p align='center'><a href='user_menu.jsp'>Back to User Menu</a></p>");
			con.closeConnection();
		}
		%>

	</body>
</html>

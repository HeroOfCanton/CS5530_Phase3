<%@ page language="java" import="cs5530.*" %>
<%@ page import="java.util.ArrayList" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>Rate Usefulness</title>
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

		<meta name="AUTHOR"      content="Ryan Welling"/>
		<meta name="keywords"    content="University of Utah, Spring 2016"/>
		<meta name="description" content="Rate Usefulness"/>

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
				<h3>Rate Usefulness of other User's Feedbacks</h3>
			</div>
		</div>

		<%
		String searchAttribute = request.getParameter("searchAttribute");
		if( searchAttribute == null ) {
		%>

		<div class="container" style="padding-top: 50px;">
			<div class="row">
				<div class="col-sm-12 text-left">
					<form name="register_user" method=get onsubmit="return check_all_fields(this)" action="useful.jsp">
						<input type=hidden name="searchAttribute">
							<p align="center" style="color: red; border-style: double;">Rate other Feedbacks</p>
							Enter the name of the POI to see feedback:
								<input type=text name="poiName_rate"><br/>
							Enter how many you'd like to see:
								<input type=text name="numofFB"><br/>
						<input type=submit>
					</form>
					<a href="index.html"><button class="btn"><span>Return</span></button></a>
				</div><!--col-sm-6-->
			</div><!--row-->
		</div><!--container-->

		<% } else {

				Feedback feedback = new Feedback();
				POI poi = new POI();
				Connector con = new Connector();
				String userName = session.getAttribute("userName").toString();
				String poiName_see = request.getParameter("poiName_see");
				String poiName_rate = request.getParameter("poiName_rate");
					session.setAttribute("poiName_rate", poiName_rate);

				String userChoice = request.getParameter("category");
				String numofFB =request.getParameter("numofFB");
				String pid;
				String fid;
				ArrayList<String[]> feedbacks;

				if(poiName_see != null) {
					
					pid = poi.getPid(poiName_see, con.stmt);
					if(pid.equals("")) {
						out.println("<div align='center'>That POI does not exist</div>");
						return;
					}
					
					feedbacks = feedback.getPOIFeedback(pid, numofFB, userName, con.stmt);
					if(feedbacks.size() != 0) {
						out.println("<div align='center'>Here are the feedbacks for this POI</div>");
						// Count should start at 1, and only increment when they get a new feedback
						// which should correspond to a new array in this arraylist
						int count = 1;
						
						// Walk the arraylist
						for(int i = 0; i < feedbacks.size(); i++) {
							// Get the data from the array
							// [0] = fid, we don't need this yet, so don't display it
							// [1] = text of feedback
							// [2] = feedback score
							for(int j = 0; j < 1; j++) {
								String arr[] = feedbacks.get(i);
								System.out.println("<div align='center'>" + count + ": Feedback: " +arr[0] +" || Score: " +arr[1] + "</div>");
							}
							// New feedback, let's increment count
							count++;
						}
						System.out.println("\n");
					}
					else {
						System.out.println("<div align='center'>No feedbacks currently on file for that POI</div>");
					}
				}
			}
		String search2 = request.getParameter("search2");
		if(search2 == null) {
		%>

			<div class="container" style="padding-top: 50px;">
				<div class="row">
					<div class="col-sm-12 text-center">
						<form name="register_user" method=get onsubmit="return check_all_fields(this)" action="useful.jsp">
							<input type=hidden name="search2">
								<p align="center" style="color: red; border-style: double;">Rate other Feedbacks</p>
								Please choose which number to rate:
									<input type=text name="rateChoice"><br/>
								On a scale of 0 - Useless / 1 - Useful / 2 - Very Useful<br/>
								Rate this feedback:
									<input type=text name="rating"><br/>
							<input type=submit>
						</form>
					</div><!--col-sm-6-->
				</div><!--row-->
			</div><!--container-->


		<%
		} else {
			Connector con = new Connector();
			Feedback feedback = new Feedback();
			POI poi = new POI();
			String pid;
			String fid = null;
			ArrayList<String[]> feedbacks;

			String userName = session.getAttribute("userName").toString();
			String poiName_rate = session.getAttribute("poiName_rate").toString();
			String rateChoice = request.getParameter("rateChoice");
			String rating = request.getParameter("rating");	

			pid = poi.getPid(poiName_rate, con.stmt);
			feedbacks = feedback.getPOIFeedback(pid, "all", userName, con.stmt);
				if(feedbacks.size() == 0) {
					out.println("<div align='center'>No feedbacks currently on file for that POI</div>");
				}

			// Convert their choice to an int, so we can use it in the array
			int rateChoiceNum = Integer.parseInt(rateChoice);
			
			// Arrays start at 0, user's options start at 1, so -- to make them match
			rateChoiceNum--;
				
			// If all goes well, their ratechoice has been converted to an int at this point
			// and that should correspond to the arraylist position of the feedback they want to rate
			// and hopefully this janky looking syntax works
			fid = feedbacks.get(rateChoiceNum)[0];
				
			// Now that we have it all, let's try adding it to the Rates table
			if(feedback.rateFeedback(userName, fid, rating, con.stmt)) {
				out.println("<div align='center'>Your rating has been saved successfully</div>");
			}
			else {
				out.println("<div align='center'>Your rating has not been saved</div>");
			}
			out.println("<p align='center'><a href='user_menu.jsp'>Back to User Menu</a></p>");
			con.closeConnection();
		}
		%>

	</body>
</html>

<%@ page language="java" import="cs5530.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>POI Feedback</title>
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

		<meta name="AUTHOR"      content="Ryan Welling"/>
		<meta name="keywords"    content="University of Utah, Spring 2016"/>
		<meta name="description" content="POI Feedback"/>

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
				<h3>Leave Feedback for a POI</h3>
			</div>
		</div>

		<%
		String searchAttribute = request.getParameter("searchAttribute");
		if( searchAttribute == null ){
		%>

		<div class="container" style="padding-top: 50px;">
			<div class="row">
				<div class="col-sm-4"></div>
				<div class="col-sm-4 text-right">
					<form name="register_user" method=get onsubmit="return check_all_fields(this)" action="separation.jsp">
						<input type=hidden name="searchAttribute">
						Enter name of POI to leave feedback for:
						<input type=text name="poiName"><br/>
						Enter a score for POI, between 0-10:
						<input type=text name="feedbackScore"><br/>
						If you'd like to leave a short review, enter Y
						<input type=text name="feedbackChoice"><br/>
						Please enter a short textual review:
						<input type=text name="feedbackReview"><br/>
						<input type=submit>
					</form>
					<a href="index.html"><button class="btn"><span>Return</span></button></a>
				</div><!--col-sm-6-->
				<div class="col-sm-4"></div>
			</div><!--row-->
		</div><!--container-->

		<%
		} else {

			Feedback feedback = new Feedback();
			POI poi = new POI();
			Connector con = new Connector();
			String poiName = request.getParameter("poiName");
			String feedbackScore = request.getParameter("feedbackScore");
			String feedbackReview = request.getParameter("feedbackReview");
			String feedbackChoice = request.getParameter("feedbackChoice");
			String fbdate;

			String pid = poi.getPid(poiName, con.stmt);
			if(pid.equals("")) {
				out.println("<div align='center'>That POI does not exist</div>");
				return;
			}

			if(feedback.canGiveFeedback(pid, userName, con.stmt)) {
				DateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy");
				Date date = new Date();
				fbdate = dateFormat.format(date);

				if(feedbackChoice.equals("Y") || feedbackChoice.equals("y")) {
					out.println("<div align='center'>");
					if(feedback.addFeedback(pid, userName, feedbackReview, feedbackScore, fbdate, con.stmt)) {
						out.println("Your feedback has been saved");
					}
					else {
						out.println("Your feedback has NOT been saved. Try again");
						out.println("<p><a href='user_menu.jsp'>Back to User Menu</a></p>");
					}
					out.println("</div>");
				}
				else {
					out.println("<div align='center'>");
					if(feedback.addFeedback(pid, userName, feedbackReview, feedbackScore, fbdate, con.stmt)) {
						out.println("Your feedback has been saved");
					}
					else {
						out.println("Your feedback has NOT been saved. Try again");
						out.println("<p><a href='user_menu.jsp'>Back to User Menu</a></p>");
					}
					out.println("</div>");
				}
			}
			else {
				System.out.println("You've already given feedback for that POI. No changes allowed\n");
			}
			out.println("<p align='center'><a href='user_menu.jsp'>Back to User Menu</a></p>");
			con.closeConnection();
		}
		%>

	</body>
</html>

<%@ page language="java" import="cs5530.*" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>Degrees of Separation</title>
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

		<meta name="AUTHOR"      content="Ryan Welling"/>
		<meta name="keywords"    content="University of Utah, Spring 2016"/>
		<meta name="description" content="Degrees of Separation"/>

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
				<h3>Degrees of separation</h3>
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
						What is the real name of the first user?
						<input type=text name="userOne"><br/>
						What is the real name of the second user?
						<input type=text name="userTwo"><br/>
						Would you like to show 1 or 2 degrees of separation?
						<input type=text name="degrees"><br/>
						<input type=submit>
					</form>
					<a href="admin_menu.jsp"><button class="btn"><span>Return</span></button></a>
				</div><!--col-sm-6-->
				<div class="col-sm-4"></div>
			</div><!--row-->
		</div><!--container-->

		<%
		} else {

			String degrees = request.getParameter("degrees");
			String userOne = request.getParameter("userOne");
			String userTwo = request.getParameter("userTwo");
			ArrayList<String> userList = new ArrayList<String> ();
			Connector con = new Connector();
			User user = new User();

			if(degrees.equals("1")) {
				ArrayList<String> userList2 = new ArrayList<String> ();
				userList = user.separationOne(userOne, con.stmt);
				userList2 = user.separationOne(userTwo, con.stmt);
				out.println("<div align='center'>Users with 1 degree of separation from "+userOne+" and "+userTwo);
				for(String string : userList) {
					out.println("<p>"+string+"</p>");
				}
				for(String string : userList2) {
					out.println("<p>"+string+"</p>");
				}
				out.println("</div>");
			}
			else if(degrees.equals("2")) {
				userList = user.separationTwo(userOne, userTwo,  con.stmt);
				out.println("<div align='center'>Users with 2 degrees of separation from "+userOne+ " and " +userTwo);
				for(String string : userList) {
					out.println("<p>"+string+"</p>");
				}
				out.println("</div>");
			}
			else {
				out.println("<div align='center'>No one likes a comedian" +
							"<p><a href='admin_menu.jsp'>Back to Admin Menu</a></p></div>");
			}
			out.println("<p align='center'><a href='admin_menu.jsp'>Back to Admin Menu</a></p>");
			con.closeConnection();
		}
		%>

	</body>
</html>

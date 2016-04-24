<%@ page language="java" import="cs5530.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>Favorite</title>
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

		<meta name="AUTHOR"      content="Ryan Welling"/>
		<meta name="keywords"    content="University of Utah, Spring 2016"/>
		<meta name="description" content="Favorite"/>

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
				<h3>Choose / Change your Favorite POI</h3>
			</div>
		</div>

		<%
		String searchAttribute = request.getParameter("searchAttribute");
		if( searchAttribute == null ) {
		
		Connector con = new Connector();
		Favorite favorite = new Favorite();
		String userName = session.getAttribute("userName").toString();
		// Function to check to see if user has favorite
		String existingFavorite = favorite.hasFavorite(userName, con.stmt);
			
		%>

		<div class="container" style="padding-top: 50px;">
			<div class="row">
				<div class="col-sm-4"></div>
				<div class="col-sm-4 text-right">
					<form name="register_user" method=get onsubmit="return check_all_fields(this)" action="favorites.jsp">
						<input type=hidden name="searchAttribute">
						If you have an existing favorite, it will be displayed here<br/>
						<input type=text name="favvar" value="<%=existingFavorite%>"><br/>
						If the field is blank, or if you'd like to change it,<br/>
						please enter the name of your favorite POI<br/>
						then type 'Y' into the field below that corresponds<br/>
						with a new POI or a changed POI.<br/>
						Leave both blank to do nothing.<br/>
						<br/>
						Change Favorite
						<input type=text name="changechoice"><br/>
						New Favorite
						<input type=text name="newchoice"><br/>
						<input type=submit>
					</form>
					<a href="index.html"><button class="btn"><span>Return</span></button></a>
				</div><!--col-sm-6-->
				<div class="col-sm-4"></div>
			</div><!--row-->
		</div><!--container-->

		<%
		} else {
			
			Connector con =	new Connector();
                	Favorite favorite = new Favorite();
			String userName = session.getAttribute("userName").toString();
			String favvar = request.getParameter("favvar");
			String changechoice = request.getParameter("changechoice");	
			String newchoice = request.getParameter("newchoice");
			String changeVar = null;
			String newVar = null;		
			
			if(changechoice.equals("Y") || changechoice.equals("y")) {
				changeVar = favvar;
				if(favorite.changeFavorite(userName, changeVar, con.stmt)) {
						out.println("<p align='center'>Your favorite has been changed</p>");
				} else {
						out.println("<p align='center'>Your favorite has not been changed. Try again.</p>");
				}
			}

			if(newchoice.equals("Y") || newchoice.equals("y")) {
				newVar = favvar;
				if(favorite.saveFavorite(userName, newVar, con.stmt)) {
					out.println("<p align='center'>Your Favorite has been recorded</p>");
				}
				else {
					out.println("<p align='center'>Favorite not saved. Try again</p>");
				}
			}
			out.println("<p align='center'><a href='user_menu.jsp'>Back to User Menu</a></p>");
			con.closeConnection();
		}
		%>

	</body>
</html>

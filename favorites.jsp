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
			
		%>

		<div class="container" style="padding-top: 50px;">
			<div class="row">
				<div class="col-sm-4"></div>
				<div class="col-sm-4 text-right">
					<form name="register_user" method=get onsubmit="return check_all_fields(this)" action="favorites.jsp">
						<input type=hidden name="searchAttribute">
						You don't have a favorite already selected.
						Please enter the name of your favorite POI
						<input type=text name="newVar"><br/>
						<input type=submit>
					</form>
					<a href="index.html"><button class="btn"><span>Return</span></button></a>
				</div><!--col-sm-6-->
				<div class="col-sm-4"></div>
			</div><!--row-->
		</div><!--container-->

		<%
		} else {

			Favorite favorite = new Favorite();
			
			// Function to check to see if user has favorite
			String existingFavorite = favorite.hasFavorite(userName, con.stmt);
			
			String newVar = null;			// User's new favorite name
			String changeFavorite = null;	// User's decision to change favorite
			String changeVar = null;		// User's change favorite name
			
			// User has no favorite, so ask them for it, and save it
			if(existingFavorite.equals("")) {
				System.out.println("You don't have a favorite already selected.");
				System.out.println("Please enter the name of your favorite POI");
				while ((newVar = in.readLine()) == null && newVar.length() == 0);
				if(favorite.saveFavorite(userName, newVar, con.stmt)) {
					System.out.println("Your Favorite has been recorded\n");
				}
				else {
					System.out.println("Favorite not saved. Try again\n");
				}
			}
			// User has a favorite, so display it, then ask if they want to change it
			else {
				System.out.println("Your current favorite is: " +existingFavorite);
				System.out.println("Would you like to change it? Y/N");
				while ((changeFavorite = in.readLine()) == null && changeFavorite.length() == 0);
				// They want to change it
				if(changeFavorite.equals("Y") || changeFavorite.equals("y")) {
					System.out.println("What would you like to change it to?");
					while ((changeVar = in.readLine()) == null && changeVar.length() == 0);
					if(favorite.changeFavorite(userName, changeVar, con.stmt)) {
						out.println("<p align='center'>Your favorite has been changed</p>");
					}
					else {
						out.println("<p align='center'>Your favorite has not been changed. Try again.</p>");
					}
				}
				// They don't want to change it
				else if(changeFavorite.equals("N") || changeFavorite.equals("n")) {
					out.println("<p align='center'>Then why are you here?</p>");
					return;
				}
			}
			con.closeConnection();
		}
		%>

	</body>
</html>

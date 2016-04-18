<%@ page language="java" import="cs5530.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>Modify POI</title>
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

		<meta name="AUTHOR"      content="Ryan Welling"/>
		<meta name="keywords"    content="University of Utah, Spring 2016"/>
		<meta name="description" content="Modify POI"/>

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
				<h3>Modify POI</h3>
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
					<form name="register_user" method=get onsubmit="return check_all_fields(this)" action="awards.jsp">
						<input type=hidden name="searchAttribute">
						Enter POI Name to modify:
						<input type=text name="poiname"><br/>
						Choose field to modify:<br/>
				   	 	1. POI City<br/>
				   	 	2. POI State<br/>
				   	 	3. POI URL<br/>
				   	 	4. POI Telephone<br/>
				   	 	5. POI Year Established<br/>
				   	 	6. POI Hours of Operation<br/>
				   	 	7. POI Avg. Price<br/>
				   	 	8. POI Category<br/>
	   	 				9. Return to Previous Menu<br/>
						<input type=text name="choice"><br/>
						Enter new information:
						<input type=text name="updateVar"><br/>
						<input type=submit>
					</form>
				</div><!--col-sm-6-->
				<div class="col-sm-4"></div>
			</div><!--row-->
		</div><!--container-->

		<%
		} else {

			String updateField = null; 
			String name = request.getParameter("poiname");
			String choice = request.getParameter("choice");
			String updateVar = request.getParameter("updateVar");
			int c = 0;
			
			mod: while(true) {

			 	c = Integer.parseInt(choice);

			 	switch(c) {
		 	 	case(1):
		 	 		updateField = "city";
		 	 		break;
		 	 	case(2):
		 	 		updateField = "state";
		 	 		break;
		 	 	case(3):
		 	 		updateField = "url";
		 	 		break;
		 	 	case(4):
		 	 		updateField = "telephone";
		 	 		break;
		 	 	case(5):
		 	 		updateField = "yearest";
		 	 		break;
		 	 	case(6):
		 	 		updateField = "hours";
		 	 		break;
		 	 	case(7):
		 	 		updateField = "price";
		 	 		break;
		 	 	case(8):
		 	 		updateField = "category";
		 	 		break;
		 	 	case(9):
		 	 	default:
		 	 		break mod;
		 	 	}
				
			 	POI poi = new POI();
				if(poi.updatePOI(name, updateField, updateVar, con.stmt)) {
					out.println("<div align='center'>POI updated successfully</div>" +
								"<p align='center'><a href='admin_menu.jsp'>Back to Admin Menu</a></p>");
					break;
				}
				else {
					out.println("<div align='center'>POI NOT CHANGED. Please try again</div>" +
								"<p align='center'><a href='admin_menu.jsp'>Back to Admin Menu</a></p>");
					break;
				}
			 	
			}
			out.println("<p align='center'><a href='admin_menu.jsp'>Back to Admin Menu</a></p>");
			con.closeConnection();
		}
		%>

	</body>
</html>

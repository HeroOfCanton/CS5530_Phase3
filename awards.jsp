<%@ page language="java" import="cs5530.*" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>User Awards</title>
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

		<meta name="AUTHOR"      content="Ryan Welling"/>
		<meta name="keywords"    content="University of Utah, Spring 2016"/>
		<meta name="description" content="User Awards"/>

		<!-- ALL CSS FILES -->
		<!-- Latest compiled and minified CSS -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous">

		<!-- Optional theme -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap-theme.min.css" integrity="sha384-fLW2N01lMqjakBkx3l/M9EahuwpSfeNvV63J5ezn3uZzapT0u7EYsXMjQV+0En5r" crossorigin="anonymous">

		<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>

		<!-- Latest compiled and minified JavaScript -->
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous"></script>

		<script type="text/javascript">

			function check_all_fields(form_obj){
				alert(form_obj.searchAttribute.value+"='"+form_obj.attributeValue.value+"'");
				if( form_obj.attributeValue.value == ""){
				    alert("Search field should be nonempty");
				 	return false;
				}
				return true;
			}
		</script>
	</head>

	<body>

		<div class="jumbotron">
			<div align="center">	
				<h1 style="color: #e8002b; text-shadow: 2px 2px #000000;">Welcome to UTrack</h1>
				<h3>User Awards</h3>
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
						How many records would you like to return?
						<input type=text name="number"><br/>
						Please choose the type of users to display, for awards:</br>
						1: Most trusted users</br>
						2: Most useful users</br>
						3: Return to previous menu</br>
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
			String number = request.getParameter("number");
			String choice = request.getParameter("choice");
			ArrayList<String[]> most = null;
			Connector con = new Connector();
			Awards award = new Awards();
			
		 	int numOfRecords = Integer.parseInt(number);
		 	c = Integer.parseInt(choice);

		 	switch(c) {
	 	 	case(1):
	 	 		most = award.getTrusted(numOfRecords, con.stmt);
		 	 	out.println("<div align='center'>Here is your list of trusted users:");
			 	// Walk the arraylist
				for(int i = 0; i < most.size(); i++) {
					// Get the data from the array
					// [0] = pid name
					// [1] = num of visits
					String arr[] = most.get(i);
					out.println("<p>" +count + "- User Name: " +arr[0] +" || Total Trust Score: " +arr[1] +"</p>");
					// New feedback, let's increment count
					count++;
				}
				out.println("</div>");
	 	 		break;
	 	 	case(2):
	 	 		most = award.getUseful(numOfRecords, con.stmt);
		 	 	out.println("<div align='center'>Here is your list of useful users:");
			 	// Walk the arraylist
				for(int i = 0; i < most.size(); i++) {
					// Get the data from the array
					// [0] = pid name
					// [1] = num of visits
					String arr[] = most.get(i);
					out.println("<p>" + count + "- User Name: " +arr[0] +" || Avg Useful Score: " +arr[1] +"<p/>");
					// New feedback, let's increment count
					count++;
				}
				out.println("</div>");
	 	 		break;
		 	case(3):
		 	default:
		 		break;
		 	}
		 	out.println("<p align='center'><a href='admin_menu.jsp'>Back to Admin Menu</a></p>");
		 	con.closeConnection();
		}
		%>

	</body>
</html>

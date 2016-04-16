<%@ page language="java" import="cs5530.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>UTrack - Phase 3</title>
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

		<meta name="AUTHOR"      content="Ryan Welling"/>
		<meta name="keywords"    content="University of Utah, Spring 2016"/>
		<meta name="description" content="Utrack - Phase 3"/>

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
			</div>
		</div>

		<div class="container">
			<div class="row">
				<div class="col-sm-12 text-center">
					<a href="index.html"><button class="btn"><span>Return</span></button></a>
				</div><!--col-sm-12-->
			</div><!--row-->
		</div><!--container-->

		<%
		String searchAttribute = request.getParameter("searchAttribute");
		if( searchAttribute == null ){
		%>

		<div class="container" style="padding-top: 50px;">
			<div class="row">
				<div class="col-sm-12 text-center">
					<form name="user_search" method=get onsubmit="return check_all_fields(this)" action="login.jsp">
					<input type=hidden name="searchAttribute">
					<input type=text name="login" placeholder="login">
					<input type=password name="password" placeholder="password">
					<input type=submit>
					</form>
				</div><!--col-sm-12-->
			</div><!--row-->
		</div><!--container-->

		<%
		} else {

			Connector con = new Connector();
			String userName = request.getParameter("login").toLowerCase();
			String userPassword = request.getParameter("password");
			Login login = new Login();
			String type = login.verifyLogin(userName, userPassword, con.stmt);

			//if(userType.equals("false")) { 
			//%>
    		//	Passwords do not match, please try again
    		//<%	
    		//}
    		//else if(userType.equals("mismatch")) { %>

    		//	<p>Login does not exist. Please register as a new user</p>
			//<%    	
    		//}
    		if(type.equals("admin")) {
    			response.sendRedirect("admin_menu.jsp");
    		}
    		else {
    			response.sendRedirect("user_menu.jsp?name=" + userName);
    		}

		}
		%>

	</body>
</html>

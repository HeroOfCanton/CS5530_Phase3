<%@ page language="java" import="cs5530.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>New User Registration</title>
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

		<meta name="AUTHOR"      content="Ryan Welling"/>
		<meta name="keywords"    content="University of Utah, Spring 2016"/>
		<meta name="description" content="New User Registration"/>

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
				<h3>New User Registration</h3>
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
				<div class="col-sm-4"></div>
				<div class="col-sm-4 text-right">
					<form name="register_user" method=get onsubmit="return check_all_fields(this)" action="register.jsp">
						<input type=hidden name="searchAttribute">
						Enter desired login
						<input type=text name="login" placeholder="jsmith123"><br/>
						Enter First and Last name
						<input type=text name="realName" placeholder="John Smith"><br/>
						Enter desired password
						<input type=password name="password1"><br/>
						Verify your password
						<input type=password name="password2"><br/>
						Enter your city
						<input type=text name="city" placeholder="South Jordan"><br/>
						Enter your state as a 2-letter abreviation
						<input type=text name="state" placeholder="UT"><br/>
						Enter your telephone with no spaces or characters
						<input type=text name="telephone" placeholder="8015551234"><br/>
						<input type=submit>
					</form>
				</div><!--col-sm-6-->
				<div class="col-sm-4"></div>
			</div><!--row-->
		</div><!--container-->

		<%
		} else {

			String password1 = request.getParameter("password1");
			String password2 = request.getParameter("password1");
			String login = request.getParameter("login");
			String realName = request.getParameter("realName");
			String city = request.getParameter("city");
			String state = request.getParameter("state");
			String telephone = request.getParameter("telephone");
			Connector con = new Connector();

			if(!(password1.equals(password2))) {
				out.println("Passwords to not match");
			}
			else {
				Register register = new Register();
				if(register.registerUser(login, realName, password1, city, state, telephone, con.stmt)) {
					out.println("<div align='center'>Thank you for registering</div>" +
								"<p align='center'><a href='index.html'>Back to Main Menu</a></p>");
				}
				else {
					out.println("<div align='center'>Registration failed. You failed. You're a failure.<div>" +
								"<p align='center'><a href='index.html'>Back to Main Menu</a></p>");
				}
			}
 			con.closeConnection();
		}
		%>
		
	</body>
</html>

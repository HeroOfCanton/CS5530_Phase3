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

			int c = 0;
			int count = 1;
			String number;
			String choice;
			ArrayList<String[]> most = new ArrayList<String[]>();
			Connector con = new Connector();
			BufferedReader in = new BufferedReader(new InputStreamReader(System.in));
			Awards award = new Awards();
			
			System.out.println("How many records would you like to return?");
		 	while ((number = in.readLine()) == null && number.length() == 0);
		 	int numOfRecords = Integer.parseInt(number);
			
			System.out.println("Please choose the type of users to display, for awards:");
			System.out.println("1: Most trusted users");
			System.out.println("2: Most useful users");
			System.out.println("3: Return to previous menu");

			while ((choice = in.readLine()) == null && choice.length() == 0);
		 	try {
		 		c = Integer.parseInt(choice);
		 	}
		 	catch (Exception e) {
		 		System.out.println(e.getMessage());
		 	}
		 	
		 	switch(c) {
	 	 	case(1):
	 	 		most = award.getTrusted(numOfRecords, con.stmt);
		 	 	out.println("Here is your list of trusted users:");
			 	// Walk the arraylist
				for(int i = 0; i < most.size(); i++) {
					// Get the data from the array
					// [0] = pid name
					// [1] = num of visits
					String arr[] = most.get(i);
					out.println(count + "- User Name: " +arr[0] +" || Total Trust Score: " +arr[1]);
					// New feedback, let's increment count
					count++;
				}
				out.println("\n");
	 	 		break;
	 	 	case(2):
	 	 		most = award.getUseful(numOfRecords, con.stmt);
		 	 	out.println("Here is your list of useful users:");
			 	// Walk the arraylist
				for(int i = 0; i < most.size(); i++) {
					// Get the data from the array
					// [0] = pid name
					// [1] = num of visits
					String arr[] = most.get(i);
					out.println(count + "- User Name: " +arr[0] +" || Avg Useful Score: " +arr[1]);
					// New feedback, let's increment count
					count++;
				}
				out.println("\n");
	 	 		break;
		 	case(3):
		 	default:
		 		break;
		 	}
		 	con.closeConnection();
		}
		%>

	</body>
</html>

<%@ page language="java" import="cs5530.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>New POI</title>
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

		<meta name="AUTHOR"      content="Ryan Welling"/>
		<meta name="keywords"    content="University of Utah, Spring 2016"/>
		<meta name="description" content="New POI"/>

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
				<h3>New POI</h3>
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
					<form name="register_user" method=get onsubmit="return check_all_fields(this)" action="new_poi.jsp">
						<input type=hidden name="searchAttribute">
						Enter POI name
						<input type=text name="name"><br/>
						Enter POI city
						<input type=text name="city" placeholder="South Jordan"><br/>
						Enter POI state as a 2-letter abreviation
						<input type=text name="state" placeholder="UT"><br/>
						Enter POI URL
						<input type=text name="url" placeholder="www.somedomain.com"><br/>
						Enter POI telephone with no spaces or characters
						<input type=text name="telephone" placeholder="8015551234"><br/>
						Enter 4 digit year established
						<input type=text name="yearest" placeholder="2015"><br/>
						Enter hours of operation, separated by a dash
						<input type=text name="hours" placeholder="8-5, 9-6 etc."><br/>
						Enter avg price of a transaction
						<input type=text name="price" placeholder="100"><br/>
						Enter single word POI category
						<input type=text name="category" placeholder="Grocery, Service etc."><br/>
						<input type=submit>
					</form>
					<a href="index.html"><button class="btn"><span>Return</span></button></a>
				</div><!--col-sm-6-->
				<div class="col-sm-4"></div>
			</div><!--row-->
		</div><!--container-->

		<%
		} else {

			String name = request.getParameter("name");
			String city = request.getParameter("city");
			String state = request.getParameter("state");
			String url = request.getParameter("url");
			String telephone = request.getParameter("telephone");
			String yearest = request.getParameter("yearest");
			String hours = request.getParameter("hours");
			String price = request.getParameter("price");
			String category = request.getParameter("category");
			Connector con = new Connector();
			POI poi = new POI();
			
			if(poi.newPOI(name, city, state, url, telephone, yearest, hours, price, category, con.stmt)) {
				out.println("<div align='center'>New POI added successfully</div>\n" +
							"<p align='center'><a href='admin_menu.jsp'>Back to Admin Menu</a></p>");
			}
			else {
				out.println("New POI NOT ADDED. Please try again\n" +
							"<p align='center'><a href='admin_menu.jsp'>Back to Admin Menu</a></p>");
			}
			con.closeConnection();
		}
		%>

	</body>
</html>

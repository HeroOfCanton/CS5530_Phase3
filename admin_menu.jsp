<%@ page language="java" import="cs5530.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>UTrack - Admin Menu</title>
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

		<meta name="AUTHOR"      content="Ryan Welling"/>
		<meta name="keywords"    content="University of Utah, Spring 2016"/>
		<meta name="description" content="Utrack - Admin Menu"/>

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
				<h3>Admin Menu</h3>
			</div>
		</div>

		<div class="container">
			<div class="row">
				<div class="col-sm-12 text-center">
					<a href="new_poi.jsp"><button class="btn"><span>New Poi</span></button></a>
					<a href="modify_poi.jsp"><button class="btn"><span>Modify Existing POI</span></button></a>
					<a href="awards.jsp"><button class="btn"><span>Awards</span></button></a>
					<a href="separation.jsp"><button class="btn"><span>Degrees of Separation</span></button></a>
					<a href="index.html"><button class="btn"><span>Return</span></button></a>
				</div><!--col-sm-12-->
			</div><!--row-->
		</div><!--container-->
	</body>	
</html>

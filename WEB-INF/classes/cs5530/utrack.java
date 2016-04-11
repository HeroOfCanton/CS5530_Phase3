package cs5530;

import java.io.*;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

public class utrack {

	/**
	 * Displays the main menu after connection
	 */
	private static void mainMenu() {
		System.out.println("	Welcome to the UTrack System - Main Menu	");
   	 	System.out.println("1. Login");
   	 	System.out.println("2. New User Registration");
   	 	System.out.println("3. Exit\n");
   	 	System.out.println("Please enter your choice:");
	}
	
	/**
	 * Login Menu - Takes in userName, userPassword, and the DB Connector object
	 * Calls login.verifyLogin and returns a String [] of userName and type
	 * 
	 * @param userName
	 * @param userPassword
	 * @param con
	 * @return String []
	 * @throws Exception
	 */
	private static String[] loginMenu(String userName, String userPassword, Connector con) throws Exception {
		BufferedReader in = new BufferedReader(new InputStreamReader(System.in));
		
		System.out.println("	Login Menu	");
		System.out.println("Please enter your username:");
		while ((userName = in.readLine()) == null && userName.length() == 0);
		userName = userName.toLowerCase();
		
		System.out.println("Please enter your password:");
		while ((userPassword = in.readLine()) == null && userPassword.length() == 0);
		
		Login login = new Login();
		String type = login.verifyLogin(userName, userPassword, con.stmt);
		
		String[] userArr = {userName, type};
		return userArr;
	}
	
	/**
	 * Registration Menu - takes in DB Connector object, collects users
	 * registration input, calls register.registerUser and passes in 
	 * login, realName, password, city, state, and telephone to be saved in database
	 * Returns true if user was saved in DB
	 * 
	 * @param con
	 * @return boolean
	 * @throws Exception
	 */
	private static boolean registerMenu(Connector con) throws Exception {
		BufferedReader in = new BufferedReader(new InputStreamReader(System.in));
		
		String login, realName, password1, password2, city, state, telephone;		
		while(true) {
			System.out.println("	Registration Menu	");
			System.out.println("Please enter your desired login:");
			while ((login = in.readLine()) == null && login.length() == 0);			
			System.out.println("Please enter your First and Last Name, eg. John Smith:");
			while ((realName = in.readLine()) == null && realName.length() == 0);
			System.out.println("Please enter your desired password:");
			while ((password1 = in.readLine()) == null && password1.length() == 0);		
			System.out.println("Verify your password:");
			while ((password2 = in.readLine()) == null && password2.length() == 0);			
			System.out.println("Please enter your city:");
			while ((city = in.readLine()) == null && city.length() == 0);			
			System.out.println("Please enter your state as a 2-letter abreviation eg. UT:");
			while ((state = in.readLine()) == null && state.length() == 0);			
			System.out.println("Please enter your telephone with no spaces, or characters eg. 8015551234:");
			while ((telephone = in.readLine()) == null && telephone.length() == 0);

			if(!(password1.equals(password2))) {
				System.out.println("Passwords to not match");
			}
			else {
				Register register = new Register();
				if(register.registerUser(login, realName, password1, city, state, telephone, con.stmt)) {
					return true;
				}
				else {
					return false;
				}
			}
		}
	}
	/**
	 * Admin Menu - takes in DB Connector object, let's user choose an option
	 * and then calls those submenu / option functions
	 * 
	 * @param con
	 * @throws Exception
	 */
	private static void adminMenu(Connector con) throws Exception {
		int c;
		String choice;
		BufferedReader in = new BufferedReader(new InputStreamReader(System.in));
		
		admin: while(true) {
			System.out.println("	Admin Menu	");
			System.out.println("1. New POI");
	   	 	System.out.println("2. Modify Existing POI");
	   	 	System.out.println("3. Awards");
	   	 	System.out.println("4. Show degrees of separation");
	   	 	System.out.println("5: Return to previous menu\n");
	   	 	System.out.println("Please enter your choice:");
	   	 	
		   	while ((choice = in.readLine()) == null && choice.length() == 0);
	 	 	try {
	 	 		c = Integer.parseInt(choice);
	 	 	}
	 	 	catch (Exception e) {
	 	 		continue;
	 	 	}
	 	 	
	 	 	switch(c) {
	 	 	case(1):
	 	 		newPOI(con);
	 	 		break;
	 	 	case(2):
	 	 		modPOI(con);
	 	 		break;
	 	 	case(3):
	 	 		awards(con);
	 	 		break;
	 	 	case(4):
	 	 		separation(con);
	 	 		break;
	 	 	case(5):
	 	 	default:
	 	 		break admin;
	 	 	}
		}
	}
	
	private static void separation(Connector con) throws Exception {
		String degrees;
		String userOne;
		String userTwo;
		ArrayList<String> userList = new ArrayList<String> ();
		BufferedReader in = new BufferedReader(new InputStreamReader(System.in));
		User user = new User();
		
		System.out.println("What is the real name of the first user?");
		while ((userOne = in.readLine()) == null && userOne.length() == 0);
		System.out.println("What is the real name of the second user?");
		while ((userTwo = in.readLine()) == null && userTwo.length() == 0);		
		System.out.println("Would you like to show 1 or 2 degrees of separation?");
		while ((degrees = in.readLine()) == null && degrees.length() == 0);
		if(degrees.equals("1")) {
			ArrayList<String> userList2 = new ArrayList<String> ();
			userList = user.separationOne(userOne, con.stmt);
			userList2 = user.separationOne(userTwo, con.stmt);
			System.out.println("Users with 1 degree of separation from "+userOne+" and "+userTwo);
			for(String string : userList) {
				System.out.println(string);
			}
			for(String string : userList2) {
				System.out.println(string);
			}
			System.out.println("\n");
		}
		else if(degrees.equals("2")) {
			userList = user.separationTwo(userOne, userTwo,  con.stmt);
			System.out.println("Users with 2 degrees of separation from "+userOne+ " and " +userTwo);
			for(String string : userList) {
				System.out.println(string);
			}
			System.out.println("\n");
		}
		else {
			System.out.println("No one likes a comedian");
			System.exit(0);
		}
	}

	/**
	 * 
	 * @param con
	 * @throws Exception
	 */
	private static void newPOI(Connector con) throws Exception {
		BufferedReader in = new BufferedReader(new InputStreamReader(System.in));
		
		String name, city, state, url, telephone, yearest, hours, price, category;
		while(true) {
			System.out.println("	Add New POI	");
			System.out.println("Enter POI Name:");
			while ((name = in.readLine()) == null && name.length() == 0);
			System.out.println("Enter POI City:");
			while ((city = in.readLine()) == null && city.length() == 0);			
			System.out.println("Enter POI state as a 2-letter abreviation eg. UT:");
			while ((state = in.readLine()) == null && state.length() == 0);			
			System.out.println("Enter POI URL eg. www.somedomain.com:");
			while ((url = in.readLine()) == null && url.length() == 0);			
			System.out.println("Enter POI telephone with no spaces, or characters eg. 8015551234:");
			while ((telephone = in.readLine()) == null && telephone.length() == 0);			
			System.out.println("Enter 4 digit year established eg. 2015:");
			while ((yearest = in.readLine()) == null && yearest.length() == 0);			
			System.out.println("Enter hours of operation, separated by a dash, eg. 8-5, 9-6:");
			while ((hours = in.readLine()) == null && hours.length() == 0);			
			System.out.println("Enter avg price of a transaction:");
			while ((price = in.readLine()) == null && price.length() == 0);			
			System.out.println("Enter single word POI category, eg. Grocery, Services, Restaurant:");
			while ((category = in.readLine()) == null && category.length() == 0);

			POI poi = new POI();
			if(poi.newPOI(name, city, state, url, telephone, yearest, hours, price, category, con.stmt)) {
				System.out.println("New POI added successfully\n");
				break;
			}
			else {
				System.out.println("New POI NOT ADDED. Please try again\n");
			}
		}
	}
	
	/**
	 * 
	 * @param con
	 * @throws Exception
	 */
	private static void modPOI(Connector con) throws Exception {
		BufferedReader in = new BufferedReader(new InputStreamReader(System.in));
		
		String updateField = null; 
		String name = null;
		String choice = null;
		String updateVar = null;
		int c = 0;
		
		mod: while(true) {
			System.out.println("	Add New POI	");
			System.out.println("Enter POI Name to modify:");
			while ((name = in.readLine()) == null && name.length() == 0);
			
			System.out.println("Choose field to modify:");
	   	 	System.out.println("1. POI City");
	   	 	System.out.println("2. POI State");
	   	 	System.out.println("3. POI URL");
	   	 	System.out.println("4. POI Telephone");
	   	 	System.out.println("5. POI Year Established");
	   	 	System.out.println("6. POI Hours of Operation");
	   	 	System.out.println("7. POI Avg. Price");
	   	 	System.out.println("8. POI Category");
	   	 	System.out.println("9. Return to Previous Menu");
	   	 	
	   	 	while ((choice = in.readLine()) == null && choice.length() == 0);
		 	try {
		 		c = Integer.parseInt(choice);
		 	}
		 	catch (Exception e) {
		 		continue;
		 	}
		 	
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
		 	
		 	System.out.println("Enter new information:");
			while ((updateVar = in.readLine()) == null && updateVar.length() == 0);
			
		 	POI poi = new POI();
			if(poi.updatePOI(name, updateField, updateVar, con.stmt)) {
				System.out.println("POI updated successfully\n");
				break;
			}
			else {
				System.out.println("POI NOT CHANGED. Please try again\n");
				break;
			}
		}		
	}
	
	/**
	 * 
	 * @param con
	 * @throws Exception
	 */
	private static void awards(Connector con) throws Exception {
		int c = 0;
		int count = 1;
		String number;
		String choice;
		ArrayList<String[]> most = null;
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
	 	 	System.out.println("Here is your list of trusted users:");
		 	// Walk the arraylist
			for(int i = 0; i < most.size(); i++) {
				// Get the data from the array
				// [0] = pid name
				// [1] = num of visits
				String arr[] = most.get(i);
				System.out.println(count + "- User Name: " +arr[0] +" || Total Trust Score: " +arr[1]);
				// New feedback, let's increment count
				count++;
			}
			System.out.println("\n");
 	 		break;
 	 	case(2):
 	 		most = award.getUseful(numOfRecords, con.stmt);
	 	 	System.out.println("Here is your list of useful users:");
		 	// Walk the arraylist
			for(int i = 0; i < most.size(); i++) {
				// Get the data from the array
				// [0] = pid name
				// [1] = num of visits
				String arr[] = most.get(i);
				System.out.println(count + "- User Name: " +arr[0] +" || Avg Useful Score: " +arr[1]);
				// New feedback, let's increment count
				count++;
			}
			System.out.println("\n");
 	 		break;
	 	case(3):
	 	default:
	 		break;
	 	}
	}
	
	/**
	 * 
	 * @param con
	 * @throws Exception
	 */
	private static void userMenu(String userName, Connector con) throws Exception {
		int c;
		String choice;
		BufferedReader in = new BufferedReader(new InputStreamReader(System.in));
		
		user: while(true) {
			System.out.println("	User Menu	");
			System.out.println("1. Browse POI");
	   	 	System.out.println("2. Give Feedback");
	   	 	System.out.println("3. Manage Favorite");
	   	 	System.out.println("4. Record Visit");
		 	System.out.println("5. Manage Trusted Users");
		 	System.out.println("6. Usefulness of other Feedbacks");
		 	System.out.println("7. Site Statistics");
		 	System.out.println("8. Return to Previous Menu\n");
	   	 	System.out.println("Please enter your choice:");
	   	 	
	   	 	while ((choice = in.readLine()) == null && choice.length() == 0);
		 	try {
		 		c = Integer.parseInt(choice);
		 	}
		 	catch (Exception e) {
		 		continue;
		 	}
		 	
		 	switch(c) {
	 	 	case(1):
	 	 		browsePOI(con);
	 	 		break;
	 	 	case(2):
	 	 		feedback(userName, con);
	 	 		break;
	 	 	case(3):
	 	 		favorites(userName, con);
	 	 		break;
	 	 	case(4):
	 	 		visit(userName, con);
	 	 		break;
	 	 	case(5):
	 	 		trusted(userName, con);
	 	 		break;
	 	 	case(6):
	 	 		useful(userName, con);
	 	 		break;
	 	 	case(7):
	 	 		statistics(con);
	 	 		break;
	 	 	case(8):
	 	 	default:
	 	 		break user;
	 	 	}
		}
	}
	
	private static void statistics(Connector con) throws Exception {
		String limit;
		int c = 0;
		int count = 1;
		String choice;
		ArrayList<String []> results = new ArrayList<String []> ();
		BufferedReader in = new BufferedReader(new InputStreamReader(System.in));
		POI poi = new POI();
		
		System.out.println("How many records would you like to return?");
		while ((limit = in.readLine()) == null && limit.length() == 0);
		
		System.out.println("Please choose a category to view:");
		System.out.println("1: Most popular POI's");
		System.out.println("2: Most expensive POI's");
		System.out.println("3: Highly rated POI's");
		System.out.println("4: Return to previous menu");
		
		while ((choice = in.readLine()) == null && choice.length() == 0);
	 	try {
	 		c = Integer.parseInt(choice);
	 	}
	 	catch (Exception e) {
	 		System.out.println(e.getMessage());
	 	}
	 	
	 	switch(c) {
 	 	case(1):
 	 		results = poi.getPopular(limit, con.stmt);
	 	 	System.out.println("Here are the most popular POIs, by category: ");
		 	// Walk the arraylist
			for(int i = 0; i < results.size(); i++) {
				String[] arr = results.get(i);
				System.out.println(count + "- POI Name: " +arr[0] +" || Category: " +arr[1] + " || Total Visits: " + arr[2]);
				// New feedback, let's increment count
				count++;
			}
			System.out.println("\n");
 	 		break;
 	 	case(2):
 	 		results = poi.getExpensive(limit, con.stmt);
	 	 	System.out.println("Here are the most expensive POIs, by category: ");
		 	// Walk the arraylist
			for(int i = 0; i < results.size(); i++) {
				String[] arr = results.get(i);
				System.out.println(count + "- POI Name: " +arr[0] +" || Category: " +arr[1] + " || Avg. Price: $" + arr[2]);
				// New feedback, let's increment count
				count++;
			}
			System.out.println("\n");
 	 		break;
 	 	case(3):
 	 		results = poi.getRated(limit, con.stmt);
	 	 	System.out.println("Here are the highest rated POIs, by category: ");
		 	// Walk the arraylist
			for(int i = 0; i < results.size(); i++) {
				String[] arr = results.get(i);
				System.out.println(count + "- POI Name: " +arr[0] +" || Category: " +arr[1] + " || Avg. Rating: " + arr[2]);
				// New feedback, let's increment count
				count++;
			}
			System.out.println("\n");
 	 		break;
 	 	case(4):
 	 	default:
 	 		break;
		}
	}

	private static void useful(String userName, Connector con) throws Exception {
		BufferedReader in = new BufferedReader(new InputStreamReader(System.in));
		Feedback feedback = new Feedback();
		POI poi = new POI();
		String poiName;
		String rateChoice;
		String rating;
		String userChoice;
		String numofFB;
		String pid;
		String fid;
		ArrayList<String[]> feedbacks;
		
		System.out.println("Would you like to rate other feedbacks or see most useful feedbacks for a POI?");
		System.out.println("1. Rate other feedbacks");
		System.out.println("2. See most useful feedbacks");
		while ((userChoice = in.readLine()) == null && userChoice.length() == 0);
		
		if(userChoice.equals("1")) {
			System.out.println("Enter the name of the POI you wish to see feedback for:");
			while ((poiName = in.readLine()) == null && poiName.length() == 0);
			pid = poi.getPid(poiName, con.stmt);
			if(pid.equals("")) {
				System.out.println("That POI does not exist\n");
				return;
			}
			// Get the arraylist of string arrays
			// each array holding an fid, text, and score for the POI
			feedbacks = feedback.getPOIFeedback(pid, "all", userName, con.stmt);
			if(feedbacks.size() != 0) {
				System.out.println("Here are the feedbacks for this POI.");
				// Count should start at 1, and only increment when they get a new feedback
				// which should correspond to a new array in this arraylist
				int count = 1;
				
				// Walk the arraylist
				for(int i = 0; i < feedbacks.size(); i++) {
					// Get the data from the array
					// [0] = fid, we don't need this yet, so don't display it
					// [1] = text of feedback
					// [2] = feedback score
					for(int j = 0; j < 1; j++) {
						String arr[] = feedbacks.get(i);
						System.out.println(count + ": Feedback: " +arr[1] +" || Score: " +arr[2]);
					}
					// New feedback, let's increment count
					count++;
				}
				
				System.out.println("Please choose which one to rate:");
				while ((rateChoice = in.readLine()) == null && rateChoice.length() == 0);
				
				// Convert their choice to an int, so we can use it in the array
				int rateChoiceNum = Integer.parseInt(rateChoice);
				
				// Arrays start at 0, user's options start at 1, so -- to make them match
				rateChoiceNum--;
				
				System.out.println("On a scale of 0 - Useless / 1 - Useful / 2 - Very Useful");
				System.out.println("Rate this feedback:");
				while ((rating = in.readLine()) == null && rating.length() == 0);
				
				// If all goes well, their ratechoice has been converted to an int at this point
				// and that should correspond to the arraylist position of the feedback they want to rate
				// and hopefully this janky looking syntax works
				fid = feedbacks.get(rateChoiceNum)[0];
				
				// Now that we have it all, let's try adding it to the Rates table
				if(feedback.rateFeedback(userName, fid, rating, con.stmt)) {
					System.out.println("Your rating has been saved successfully");
				}
				else {
					System.out.println("Your rating has not been saved");
				}
			}
			else {
				System.out.println("No feedbacks currently on file for that POI");
			}
		}
		else {
			System.out.println("Enter the name of the POI you wish to see feedback for:");
			while ((poiName = in.readLine()) == null && poiName.length() == 0);
			pid = poi.getPid(poiName, con.stmt);
			if(pid.equals("")) {
				System.out.println("That POI does not exist\n");
				return;
			}
			System.out.println("How many would you like to see?");
			while ((numofFB = in.readLine()) == null && numofFB.length() == 0);
			feedbacks = feedback.getPOIFeedback(pid, numofFB, userName, con.stmt);
			if(feedbacks.size() != 0) {
				System.out.println("Here are the feedbacks for this POI.");
				// Count should start at 1, and only increment when they get a new feedback
				// which should correspond to a new array in this arraylist
				int count = 1;
				
				// Walk the arraylist
				for(int i = 0; i < feedbacks.size(); i++) {
					// Get the data from the array
					// [0] = fid, we don't need this yet, so don't display it
					// [1] = text of feedback
					// [2] = feedback score
					for(int j = 0; j < 1; j++) {
						String arr[] = feedbacks.get(i);
						System.out.println(count + ": Feedback: " +arr[0] +" || Score: " +arr[1]);
					}
					// New feedback, let's increment count
					count++;
				}
				System.out.println("\n");
			}
			else {
				System.out.println("No feedbacks currently on file for that POI");
			}
		}
	}

	private static void browsePOI(Connector con) throws Exception {
		int c = 0;
		String sort = null;
		String choice;
		ArrayList<String> poiarr = null;
		BufferedReader in = new BufferedReader(new InputStreamReader(System.in));
		POI poi = new POI();
		
		System.out.println("Choose how you want the results sorted:");
	 	System.out.println("1. By price");
   	 	System.out.println("2. By avg feedbacks");
   	 	while ((choice = in.readLine()) == null && choice.length() == 0);
	 	if(choice.equals("1"))
	 		sort = "price";
	 	else if(choice.equals("2"))
	 		sort = "feedback";
	 	else {
	 		System.out.println("You didn't enter the right choice");
	 		System.exit(0);
	 	}
		
		System.out.println("Please choose how to browse the POIs:");
		System.out.println("1. POI by City / State");
   	 	System.out.println("2. POI by Keywords");
   	 	System.out.println("3. POI by Category");
   	 	System.out.println("4. Return to previous menu");
   	 	
   	 	browse: while(true) {
   	 		while ((choice = in.readLine()) == null && choice.length() == 0);
		 	try {
		 		c = Integer.parseInt(choice);
		 	}
		 	catch (Exception e) {
		 		System.out.println(e.getMessage());
		 	}
		 		
		 	switch(c) {
		 	case(1):
		 		String adrvar = null;
		 		String adrchoice = null;
		 		System.out.println("By City or State?:");
		 		while ((adrchoice = in.readLine()) == null && adrchoice.length() == 0);
		 		if(adrchoice.equals("city") || adrchoice.equals("City")) {
		 			System.out.println("Enter the name of the City:");
		 			while ((adrvar = in.readLine()) == null && adrvar.length() == 0);
		 		}
		 		else if(adrchoice.equals("state") || adrchoice.equals("State")) {
		 			System.out.println("Enter the two letter abreviation for the State:");
		 			while ((adrvar = in.readLine()) == null && adrvar.length() == 0);
		 		}
		 		else {
		 			System.out.println("No one likes a funny guy");
		 			System.exit(0);
		 		}
		 		poiarr = poi.getAdr(adrvar, adrchoice, sort, con.stmt);
		 		break;
		 	case(2):
		 		String keyvar = null;
		 		System.out.println("Enter the keyword to search by:");
		 		while ((keyvar = in.readLine()) == null && keyvar.length() == 0);
		 		poiarr = poi.getKeywords(keyvar, sort, con.stmt);
		 		break;
		 	case(3):
		 		ArrayList<String>categories = poi.getCategories(con.stmt);
		 		String catvar;
		 		System.out.println("Here are a list of categories:");
		 		for(String string : categories) {
		 			System.out.println(string);
		 		}
		 		System.out.println("Which category would you like to search by?");
		 		while ((catvar = in.readLine()) == null && catvar.length() == 0);
		 		poiarr = poi.getCat(catvar, sort, con.stmt);
		 		break;
		 	case(4):
		 	default:
		 		break browse;
		 	}
		 	
		 	System.out.println(" \nHere are the POI's you requested:");
		 	for(String string : poiarr) {
		 		System.out.println(string);
		 	}
		 	System.out.println("\n");
		 	break;
   	 	}
	}
	
	/**
	 * 
	 * @param userName
	 * @param con
	 * @throws Exception
	 */
	private static void feedback(String userName, Connector con) throws Exception {
		BufferedReader in = new BufferedReader(new InputStreamReader(System.in));
		Feedback feedback = new Feedback();
		POI poi = new POI();
		String poiName;
		String fbdate;
		String feedbackScore;
		String feedbackReview = "";
		String feedbackChoice;
		
		System.out.println("Enter the name of the POI you wish to leave feedback for:");
		while ((poiName = in.readLine()) == null && poiName.length() == 0);
		String pid = poi.getPid(poiName, con.stmt);
		if(pid.equals("")) {
			System.out.println("That POI does not exist\n");
			return;
		}
		if(feedback.canGiveFeedback(pid, userName, con.stmt)) {
			DateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy");
			Date date = new Date();
			fbdate = dateFormat.format(date);
			System.out.println("Please enter a score for this POI, between 0-10:");
			while ((feedbackScore = in.readLine()) == null && feedbackScore.length() == 0);
			System.out.println("Would you like to leave a short review?");
			while ((feedbackChoice = in.readLine()) == null && feedbackChoice.length() == 0);
			if(feedbackChoice.equals("Y") || feedbackChoice.equals("y")) {
				System.out.println("Please enter a short textual review:");
				while ((feedbackReview = in.readLine()) == null && feedbackReview.length() == 0);
				if(feedback.addFeedback(pid, userName, feedbackReview, feedbackScore, fbdate, con.stmt)) {
					System.out.println("Your feedback has been saved\n");
				}
				else {
					System.out.println("Your feedback has NOT been saved. Try again\n");
				}
			}
			else {
				if(feedback.addFeedback(pid, userName, feedbackReview, feedbackScore, fbdate, con.stmt)) {
					System.out.println("Your feedback has been saved\n");
				}
				else {
					System.out.println("Your feedback has NOT been saved. Try again\n");
				}
			}
		}
		else {
			System.out.println("You've already given feedback for that POI. No changes allowed\n");
		}
	}
	
	/**
	 * 
	 * @param userName
	 * @param con
	 * @throws Exception 
	 */
	private static void favorites(String userName, Connector con) throws Exception {
		BufferedReader in = new BufferedReader(new InputStreamReader(System.in));
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
					System.out.println("Your favorite has been changed\n");
				}
				else {
					System.out.println("Your favorite has not been changed. Try again.\n");
				}
			}
			// They don't want to change it
			else if(changeFavorite.equals("N") || changeFavorite.equals("n")) {
				System.out.println("Then why are you here?");
				return;
			}
			// They're being cheeky
			else {
				System.out.println("You didn't answer Y or N. Goodbye.");
				System.exit(0);
			}
		}
	}
	
	private static void visit(String userName, Connector con) throws Exception {
		BufferedReader in = new BufferedReader(new InputStreamReader(System.in));
		Visit visit = new Visit();
		POI poi = new POI();
		String poiName;
		String changeText;
		String cost;
		String numofheads;
		String visitToday;
		String visitdate = null;
		boolean change = true;
		ArrayList<String []> suggestions = new ArrayList<String []>();
		
		// Visits have to be done in several stages, because of how the DB is setup
		// Get the pid of the POI and save it for later
		System.out.println("Enter the name of the POI to record a visit:");
		while ((poiName = in.readLine()) == null && poiName.length() == 0);
		String pid = poi.getPid(poiName, con.stmt);
		if(pid.equals("")) {
			System.out.println("That POI does not exist\n");
			return;
		}
		
		// Now to get the information for the VisEvent table
		System.out.println("What was the total amount spent in this visit?");
		while ((cost = in.readLine()) == null && cost.length() == 0);
		System.out.println("How many people were in the party?");
		while ((numofheads = in.readLine()) == null && numofheads.length() == 0);
		
		// Get date for Visit table
		System.out.println("Did you visit today?");
		while ((visitToday = in.readLine()) == null && visitToday.length() == 0);
		if(visitToday.equals("Y") || visitToday.equals("y")) {
			DateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy");
			Date date = new Date();
			visitdate = dateFormat.format(date);
		}
		else if(visitToday.equals("N") || visitToday.equals("n")) {
			System.out.println("Please enter date you visited as mm/dd/yyyy");
			while ((visitdate = in.readLine()) == null && visitdate.length() == 0);
		}
		else {
			System.out.println("You didn't answer Y or N. Goodbye.");
			System.exit(0);
		}
		
		// Gotta loop in case they want to change
		while(change) {
			System.out.println("Here's what you said about "+poiName);
			System.out.println("Cost: " +cost);
			System.out.println("Number of people in party: " +numofheads);
			System.out.println("Date Visited: " + visitdate);
			System.out.println("Do you want to change it before saving?");
			while ((changeText = in.readLine()) == null && changeText.length() == 0);
			if(changeText.equals("Y") || changeText.equals("y")) {
				System.out.println("Enter the name of the POI to record a visit:");
				while ((poiName = in.readLine()) == null && poiName.length() == 0);
				pid = poi.getPid(poiName, con.stmt);
				
				// Now to get the information for the VisEvent table
				System.out.println("What was the total amount spent in this visit?");
				while ((cost = in.readLine()) == null && cost.length() == 0);
				System.out.println("How many people were in the party?");
				while ((numofheads = in.readLine()) == null && numofheads.length() == 0);
				
				// Get date for Visit table
				System.out.println("Did you visit today?");
				while ((visitToday = in.readLine()) == null && visitToday.length() == 0);
				if(visitToday.equals("Y") || visitToday.equals("y")) {
					DateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy");
					Date date = new Date();
					visitdate = dateFormat.format(date);
				}
				else if(visitToday.equals("N") || visitToday.equals("n")) {
					System.out.println("Please enter date you visited as mm/dd/yyyy");
					while ((visitdate = in.readLine()) == null && visitdate.length() == 0);
				}
				else {
					System.out.println("You didn't answer Y or N. Goodbye.");
					System.exit(0);
				}
			}
			else if(changeText.equals("N") || changeText.equals("n")) {
				if(visit.addtoDB(userName, pid, cost, numofheads, visitdate, con.stmt)) {
					change = false;
					System.out.println("Your visit has been recorded\n");
					System.out.println("Here are some other Points of Interest you might like:");
					suggestions = visit.getVisitSuggestions(pid, con.stmt);
					// Count should start at 1, and only increment when they get a new feedback
					// which should correspond to a new array in this arraylist
					int count = 1;
					
					// Walk the arraylist
					for(int i = 0; i < suggestions.size(); i++) {
						String arr[] = suggestions.get(i);
						System.out.println(count + "- POI Name: " +arr[0] +" || Number of Times Visited: " +arr[1]);
						// New feedback, let's increment count
						count++;
					}
					System.out.println("\n");
				}
				else {
					System.out.println("Your visit has not been recorded. Try again.\n");
				}
			}
			else {
				System.out.println("You didn't answer Y or N. Goodbye.");
				System.exit(0);
			}
		}		
	}
	
	private static void trusted(String userName, Connector con) throws Exception {
		BufferedReader in = new BufferedReader(new InputStreamReader(System.in));
		User user = new User();
		String otherUser;
		String otherLogin;
		String trustVar;
		
		System.out.println("Enter the first and last name of the user you'd like to mark trusted / untrusted");
		while ((otherUser = in.readLine()) == null && otherUser.length() == 0);
		otherLogin = user.getLogin(otherUser, con.stmt);
		
		if(otherLogin.equals("")) {
			System.out.println("No user found with that name. Try again.\n");
		}
		else {
			System.out.println("Mark user as 'trusted' or 'untrusted'?");
			while ((trustVar = in.readLine()) == null && trustVar.length() == 0);
			if(user.setTrust(userName, otherLogin, trustVar, con.stmt)) {
				System.out.println("User has been marked as " +trustVar + "\n");
			}
			else {
				System.out.println("User has not been marked. Try again.\n");
			}
		}
	}
	
	/**
	 * 
	 * @param args
	 */
	public static void main(String[] args) {
		Connector con = null;
		String choice;
        String userName = null;
        String userPassword = null;
        String userType = null;
        int c = 0;

		try {
			//remember to replace the password
		 	con= new Connector();
		    System.out.println ("Database connection established");
		 
		    BufferedReader in = new BufferedReader(new InputStreamReader(System.in));
		    
		    while(true) {
		    	mainMenu();
		    	// get the users input
		    	while ((choice = in.readLine()) == null && choice.length() == 0);
	    	 	try {
	    	 		c = Integer.parseInt(choice);
	    	 	}
	    	 	catch (Exception e) {
	    	 		continue;
	    	 	}
		    	 	
		    	if (c < 1 || c > 3) {
		    		 continue;
		    	}
		    	if (c == 1) {
		    		String[] userInfo = loginMenu(userName, userPassword, con);
		    		userName = userInfo[0];
		    		userType = userInfo[1];
		    		
		    		if(userType.equals("false")) {
		    			System.out.println("Passwords do not match, please try again");
		    		}
		    		else if(userType.equals("mismatch")) {
		    			System.out.println("Login does not exist. Please register as a new user\n");
		    			continue;
		    		}
		    		else if(userType.equals("admin")) {
		    			adminMenu(con);
		    		}
		    		else {
		    			userMenu(userName, con);
		    		}
		    	}
		    	else if (c==2) {	 
		    		if(registerMenu(con)) {
		    			System.out.println("Thank you for registering. You may now login");
		    		}
		    		else {
		    			System.out.println("Registration failed. Please try again\n");
		    		}
		    	}
		    	else {   
		    		System.out.println("Thank you for using UTrack");
		        	con.stmt.close(); 
		        	break;
		        }
		    }
		}
		catch (Exception e) {
			e.printStackTrace();
			System.err.println ("Either connection error or query execution error!");
		}
		finally {
			if (con != null) {
				try {
					con.closeConnection();
					System.out.println ("Database connection terminated");
				}
				catch (Exception e) { /* ignore close errors */ }
			}	 
		}
	}
}

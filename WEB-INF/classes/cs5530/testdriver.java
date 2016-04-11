package cs5530;

import java.util.*;

public class testdriver {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		try{
			Connector con= new Connector();
			Order order= new Order();
			
			String result=order.getUsers("login", "rwelling", con.stmt);
			System.out.println(result);
			con.closeConnection();
		}
		catch (Exception e)
		{
			e.printStackTrace();
			
		}
	}

}

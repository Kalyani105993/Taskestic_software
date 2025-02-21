package com.dakshabhi.common.utility;

public class Validate 
{
	
	public boolean isValidEmailAddress(String email)
    {
        String regex = "^[_A-Za-z0-9-]+(\\.[_A-Za-z0-9-]+)*@[A-Za-z0-9-]+(\\.[A-Za-z0-9-]+)+$";
      	  return email.matches(regex);
    }
	
	 public  boolean isNumber(String num)
		{
			String regx="^?([0-9])*$";
			return num.matches(regx);
		
			
		}
	public  boolean isDouble(String num)
	{
		String regx="^([0-9]\\d*)?\\d(\\.\\d{1,6})?$";
		return num.matches(regx);
			
		
	}
	public  boolean isString(String num)
	{
		String regx="^?([A-Za-z])*$";
		return num.matches(regx);
			
		
	}
	public int convertIntoNumber(String num)
	{
		return Integer.parseInt(num);
		
	}
	public double convertIntoDouble(String num)
	{
		return Double.parseDouble(num);
	}
	
	// code for validation of password
/*	public boolean isvalidPassword(String password)
	{
		String regx="^([a-z]?[A-Z]?[0-9]?)*";
		return password.matches(regx);
	}*/
	

}

package com.dakshabhi.common.utility;

import java.sql.ResultSet;

import com.dakshabhi.common.db.QueryHelper;
import com.dakshabhi.common.formatter.Formatter;
 
public class Activity {
/***
 * Method to store the activity events value
 * @param event
 * @param value
 */
	
	public void updateActivity(String event, String value){
		QueryHelper qh = new QueryHelper();
		try {
			java.util.GregorianCalendar calendar = new java.util.GregorianCalendar();
			//calendar.add(calendar.DATE, 0); //Current date
			java.util.Date currentDay = calendar.getTime();
			String currentDate = Formatter.dateFormat("MM-dd-yyyy",
					currentDay);
			java.sql.Date currentSqlDate = Formatter.parseSQLDate(
					currentDate, "MM-dd-yyyy");
			
			boolean isAvil= false; 
			//To check for current date records
			String sql= "select * from ACTIVITY where CURRENTDATE = ?";
			String subsql="";
			qh.addParam(currentSqlDate);
			ResultSet rs= qh.runQueryStreamResults(sql);
			if (rs.next())
				isAvil=true;
			
			rs.close();
			
			if(isAvil){
				sql="update ACTIVITY set ";
				
				if (event.equals("NEWTRANSACTION")){
					subsql=" NEWTRANSACTION = ( NEWTRANSACTION + "+ Integer.parseInt(value) +")"; // Increase  New Transaction count
				}else if(event.equals("AMOUTRECIVED")){
					subsql=" AMOUTRECIVED = ( AMOUTRECIVED + "+ Double.parseDouble(value) +")";
				}else if(event.equals("USPS")){
					subsql=" USPS= ( USPS+"+ Integer.parseInt(value) +")";
				}else if(event.equals("ADDRESSCHANGE")){
					subsql=" ADDRESSCHANGE = ( ADDRESSCHANGE +" + Integer.parseInt(value) +")";
				}else if(event.equals("SIGNUP")){
					subsql=" SIGNUP = ( SIGNUP +" + Integer.parseInt(value) +")";
				}else if(event.equals("DISCONNECT")){
					subsql=" DISCONNECT = ( DISCONNECT +" + Integer.parseInt(value) +")";
				}else if(event.equals("SPECIALOFFER")){
					subsql=" SPECIALOFFER = ( SPECIALOFFER +" + Integer.parseInt(value) +")";
				}else if(event.equals("JUNKMAIL")){
					subsql=" JUNKMAIL = ( JUNKMAIL +" + Integer.parseInt(value) +")";
				}else if(event.equals("JUNKMAILFAIL")){
					subsql=" JUNKMAILFAIL = ( JUNKMAILFAIL +" + Integer.parseInt(value) +")";
				}
				
				// If not event found, than only store the value 
				if(!subsql.equals("")){
					sql= sql + " " + subsql +" where CURRENTDATE = ?";
					qh.addParam(currentSqlDate);
					qh.runQuery(sql);
				}				
			}else{				
				sql="insert into ACTIVITY (" + event + ",CURRENTDATE) values (?,?)";
				qh.addParam(value);
				qh.addParam(currentSqlDate);
				qh.runQuery(sql);				
			}			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally{
			qh.releaseConnection();
		}
		
	}
}

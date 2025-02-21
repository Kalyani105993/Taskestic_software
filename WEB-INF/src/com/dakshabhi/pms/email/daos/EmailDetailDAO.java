package com.dakshabhi.pms.email.daos;

import java.sql.ResultSet;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.mail.Folder;

import com.dakshabhi.common.db.QueryHelper;
import com.dakshabhi.common.utility.StringUtility;
import com.dakshabhi.pms.companies.dtos.CCompanyDTO;
import com.dakshabhi.pms.email.dtos.ReadMailDetailDTO;

public class EmailDetailDAO {
	/***
	 * Method for Insert email details 
	 *
	 */
	public boolean saveEmailDetails(ReadMailDetailDTO mailDetailDTO) {
		QueryHelper qh = new QueryHelper();
		
		try {
			
			String query = ("INSERT INTO  pms_dakshabhi_mail_details(from_Email,to_Email,email_Subject,email_body,from_name,to_name,send_date)"+"values (?, ?, ?, ?, ?, ?, ?)");
			qh.addParam(StringUtility.removeNull(mailDetailDTO.getFromEmail()));
			qh.addParam(StringUtility.removeNull(mailDetailDTO.getToEmail()));
			qh.addParam(StringUtility.removeNull(mailDetailDTO.getEmailSubject()));
			qh.addParam(StringUtility.removeNull(mailDetailDTO.getEmailBody()));
			qh.addParam(StringUtility.removeNull(mailDetailDTO.getFromName()));
			qh.addParam(StringUtility.removeNull(mailDetailDTO.getToName()));
			qh.addParam(StringUtility.removeNull(mailDetailDTO.getSend_date()));
			qh.runQuery(query);
			qh.clearParams();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}
		return false;
		
	}

	/*  
	 * create new folder in gmail account 
	 */  
	public boolean createFolder(Folder parent, String folderName)   
	{   
	    boolean isCreated = true;   

	    try  
	    {   
	        Folder newFolder = parent.getFolder(folderName);   
	        isCreated = newFolder.create(Folder.HOLDS_MESSAGES);   
	        System.out.println("created: " + isCreated);   

	    } catch (Exception e)   
	    {   
	        System.out.println("Error creating folder: " + e.getMessage());   
	        e.printStackTrace();   
	        isCreated = false;   
	    }   
	    return isCreated;   
	}
	
	// Function to extract email address from a string
	public String extractEmailAddress(String input) {
	    String emailAddress = "";
	    Matcher matcher = Pattern.compile("<([^>]+)>").matcher(input);
	    while (matcher.find()) {
	        emailAddress = matcher.group(1);
	    }
	    return emailAddress;
	}
	
	
	// Function to extract name from a string
	public String extractName(String input) { 
	String name = input;
	Matcher matcher =Pattern.compile("(.+) <([^>]+)>").matcher(input); while (matcher.find()) {
	  name = matcher.group(1);
	  
	} 
	
	return name;
	  
	}
	
	

}

package com.dakshabhi.pms.users.services;

import java.io.IOException;
import java.time.LocalTime;
import java.time.OffsetTime;
import java.time.ZoneOffset;
import java.time.format.DateTimeFormatter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.util.StringUtil;

import com.dakshabhi.common.constants.ConfigConstants;
import com.dakshabhi.common.utility.StringUtility;
import com.dakshabhi.pms.Security.dto.CAllowAccessDTO;
import com.dakshabhi.pms.companies.daos.CCompanyDAO;
import com.dakshabhi.pms.companies.dtos.CCompanyDTO;
import com.dakshabhi.pms.users.daos.CUserLoginDAO;
import com.dakshabhi.pms.users.dtos.CUserLoginDTO;

@WebServlet(value = "/userlogin")
public class CUserLoginService extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	    String username = req.getParameter("username") == null ? "" : req.getParameter("username");
	    String password = req.getParameter("password") == null ? "" : req.getParameter("password");
	    String rememberme = req.getParameter("rememberme") == null ? "" : req.getParameter("rememberme");
	    String deviceToken = req.getParameter("deviceTokenName") == null ? "" : req.getParameter("deviceTokenName");
	    String company_id = ConfigConstants.getCompanyID(req.getSession());

	    CCompanyDTO companyDetailsdto = CCompanyDAO.getCompanyName(company_id);
	    String from_login = companyDetailsdto.getFrom_login();
	    String to_login = companyDetailsdto.getTo_login();
	    String time_zone = companyDetailsdto.getTimezone();
	    String toggelswitchisOn = StringUtility.removeNull(companyDetailsdto.getIsToggelSwitchOn());
	    
	    boolean toggleswitchOn = toggelswitchisOn.equals("yes");

		 //If toggelSwitch is on then check condition for login time restriction.
	    if (toggleswitchOn && isLoginAllowed(from_login, to_login, time_zone) && !from_login.isEmpty() && !to_login.isEmpty() && !username.isEmpty() && !password.isEmpty()) {
	   
	    	CUserLoginDTO cUserLoginDTO = CUserLoginDAO.getUserloginDetails(company_id, username, password, deviceToken);
	    	
	    	if(cUserLoginDTO != null) {
		    	String isActive = cUserLoginDTO.getIs_active();
		    	
		    	if ("1".equals(isActive)) { //check if the user active 
		            CAllowAccessDTO allowAccessDTO = new CAllowAccessDTO();
		            String forward = "workspace.jsp";
	
		            if (cUserLoginDTO.getUser_role_type() == 1 || cUserLoginDTO.getUser_role_type() == 2) {
		                allowAccessDTO.setWorkspaceSectionAllowed(true);
		                allowAccessDTO.setCustomerSectionAllowed(true);
		                allowAccessDTO.setProjectSectionAllowed(true);
		                allowAccessDTO.setEmployeeSectionAllowed(true);
		                allowAccessDTO.setWorkpackSectionAllowed(true);
		                allowAccessDTO.setProjectContactSectionAllowed(true);
		                allowAccessDTO.setProjectWorkpackSectionAllowed(true);
		                allowAccessDTO.setProjectEmployeeSectionAllowed(true);
		                allowAccessDTO.setEmployeeDailyWorkSectionAllowed(true);
		                allowAccessDTO.setEmployeeWorkApprovalSectionAllowed(true);
		            } else if (cUserLoginDTO.getUser_role_type() == 0 || cUserLoginDTO.getUser_role() == 3) {
		                allowAccessDTO.setEmployeeDailyWorkSectionAllowed(true);
		                allowAccessDTO.setWorkspaceSectionAllowed(true);
		            }
		            if ("Rememberme".equals(rememberme) || rememberme.isEmpty()) {
		                setRememberMeCookies(resp, username, password, rememberme);
		            }
		            req.getSession().setAttribute("userLogin", cUserLoginDTO);
		            req.getSession().setAttribute("allowAccess", allowAccessDTO);
		            resp.sendRedirect(forward);
		            return;
		        } 
		    	 String  errormsg= "User dose not exist!";
				 req.getSession().setAttribute("errorMessage", errormsg);
	    	}else {
	            req.getSession().setAttribute("errorMessage", "Invalid login details!");
	        }
	    } else if (!toggleswitchOn && !username.isEmpty() && !password.isEmpty()) { //if toggelSwitch is off then do not need to check condition for login time restriction. 
	        CUserLoginDTO cUserLoginDTO = CUserLoginDAO.getUserloginDetails(company_id, username, password, deviceToken);
	        
	        if(cUserLoginDTO != null) {
	        	String isActive = cUserLoginDTO.getIs_active();
	        	
		        if ("1".equals(isActive)) { //check if the user active 
		            CAllowAccessDTO allowAccessDTO = new CAllowAccessDTO();
		            String forward = "workspace.jsp";
	
		            if (cUserLoginDTO.getUser_role_type() == 1 || cUserLoginDTO.getUser_role_type() == 2) {
		                allowAccessDTO.setWorkspaceSectionAllowed(true);
		                allowAccessDTO.setCustomerSectionAllowed(true);
		                allowAccessDTO.setProjectSectionAllowed(true);
		                allowAccessDTO.setEmployeeSectionAllowed(true);
		                allowAccessDTO.setWorkpackSectionAllowed(true);
		                allowAccessDTO.setProjectContactSectionAllowed(true);
		                allowAccessDTO.setProjectWorkpackSectionAllowed(true);
		                allowAccessDTO.setProjectEmployeeSectionAllowed(true);
		                allowAccessDTO.setEmployeeDailyWorkSectionAllowed(true);
		                allowAccessDTO.setEmployeeWorkApprovalSectionAllowed(true);
		            } else if (cUserLoginDTO.getUser_role_type() == 0 || cUserLoginDTO.getUser_role() == 3) {
		                allowAccessDTO.setEmployeeDailyWorkSectionAllowed(true);
		                allowAccessDTO.setWorkspaceSectionAllowed(true);
		            }
		            if ("Rememberme".equals(rememberme) || rememberme.isEmpty()) {
		                setRememberMeCookies(resp, username, password, rememberme);
		            }
	
		            req.getSession().setAttribute("userLogin", cUserLoginDTO);
		            req.getSession().setAttribute("allowAccess", allowAccessDTO);
		            resp.sendRedirect(forward);
		            return;
		        }
		        String  errormsg= "User dose not exist!";
				req.getSession().setAttribute("errorMessage", errormsg);
	        }
	        String  errormsg= "Invalid login details!";
		    req.getSession().setAttribute("errorMessage", errormsg);
	    }
		  String loginerrorMsg = "You can login between " + from_login + " to " +to_login + "."; //if toggelSwitch is on but current time is outside the interval it will show error message
		  req.getSession().setAttribute("loginerrorMessage", loginerrorMsg);
		  resp.sendRedirect("signin.jsp");
	}

	/* method to set RememberMe cookies */
	private void setRememberMeCookies(HttpServletResponse resp, String username, String password, String rememberme) {
	    Cookie cUsername = new Cookie("cookusername", username.trim());
	    Cookie cPassword = new Cookie("cookpass", password.trim());
	    Cookie cRemember = new Cookie("cookrem", rememberme.trim());

	    if ("Rememberme".equals(rememberme)) {
	        cUsername.setMaxAge(60 * 60 * 24 * 15); // 15 days
	        cPassword.setMaxAge(60 * 60 * 24 * 15);
	        cRemember.setMaxAge(60 * 60 * 24 * 15);
	    } else {
	        cUsername.setMaxAge(0); // Expire cookies
	        cPassword.setMaxAge(0);
	        cRemember.setMaxAge(0);
	    }

	    resp.addCookie(cUsername);
	    resp.addCookie(cPassword);
	    resp.addCookie(cRemember);
	}
	/*
	 * Method for checkLoginTime 
	 * Input: fromTime, toTime ,time_zone.
	 */
	private boolean isLoginAllowed(String fromTime, String toTime, String time_zone) {

		ZoneOffset zoneOffset = ZoneOffset.of(time_zone);
		OffsetTime offsetTime = OffsetTime.now(zoneOffset);// Get the current time for the specified time zone offset
		
		LocalTime currentTime = offsetTime.toLocalTime();	// Convert OffsetTime to LocalTime
		System.out.println("LocalTime for " + time_zone + " : " + currentTime);

		// LocalTime currentTime = LocalTime.now();
		System.out.println("Current Time   " + currentTime);
		LocalTime loginStartTime = parseTimeWithAMPM(fromTime);
		LocalTime loginEndTime = parseTimeWithAMPM(toTime);

		if (loginStartTime.isBefore(loginEndTime)) { // Normal time interval (fromTime < toTime)

			return !currentTime.isBefore(loginStartTime) && !currentTime.isAfter(loginEndTime); // Current time is within the interval

		} else { // Time interval crosses midnight (fromTime > toTime)

			return !currentTime.isBefore(loginStartTime) || !currentTime.isAfter(loginEndTime); // Current time is within the interval
		}
	}
	/*
	 * Method for parseTimrWith AM/PM fromTime,toTime
	 */
	private LocalTime parseTimeWithAMPM(String timeString) {

		String format = "hh:mm a";
		timeString = timeString.toUpperCase(); // Convert to uppercase
		return LocalTime.parse(timeString, DateTimeFormatter.ofPattern(format));

	}


}

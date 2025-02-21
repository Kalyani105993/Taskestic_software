package com.dakshabhi.pms.companies.services;

import java.io.IOException;

import java.io.PrintWriter;
import java.util.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.TimeZone;
import java.util.concurrent.TimeUnit;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dakshabhi.common.constants.ConfigConstants;
import com.dakshabhi.pms.companies.daos.CCompanyDAO;
import com.dakshabhi.pms.companies.dtos.CCompanyDTO;
import com.dakshabhi.pms.users.dtos.CUserLoginDTO;
import com.google.gson.Gson;
import com.mysql.cj.Session;

/**
 * Class for manage all services related to company
 * 
 * @author Deepak Patil
 *
 */

@WebServlet(value = "/company")
public class CCompnyService extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		String action_type = req.getParameter("action_type") == null ? "" : req.getParameter("action_type");
		String company_id = ConfigConstants.getCompanyID(req.getSession());
		
		CCompanyDAO cCompanyDAO = new CCompanyDAO();
		
		if (action_type.equalsIgnoreCase("getCompanyData")) {
			CCompanyDTO companyDetails = CCompanyDAO.getCompanyName(company_id);
			req.getSession().setAttribute("companyDetails", companyDetails);
			resp.setContentType("application/json");
			String json = new Gson().toJson(companyDetails);
			resp.getWriter().write(json);
			return;
			
		} else if (action_type.equalsIgnoreCase("updateCompanyDetails")) {
			CCompanyDTO cCompanyDTO = new CCompanyDTO();
		
			String companyname = req.getParameter("companyname");
			String companyaddress = req.getParameter("companyaddress");
			String companyphone = req.getParameter("companyphone");
			String companyemail = req.getParameter("companyemail");
			String from_login =  req.getParameter("from_login");
			String to_login = req.getParameter("to_login");
			String time_zone = req.getParameter("time_zone");
			String toggel_switch = req.getParameter("toggel_switch");

			System.out.println("Time Zone : "+time_zone);
			
			SimpleDateFormat sdf = new SimpleDateFormat("Z");
			TimeZone istTimeZone = TimeZone.getTimeZone(time_zone);
			Date date = new Date();
			sdf.setTimeZone(istTimeZone);
			String timezone = sdf.format(date);
			System.out.println("GMT Offset for time zone : "+timezone);
			
			cCompanyDTO.setCompany_address(companyaddress);
			cCompanyDTO.setCompany_email(companyemail);
			cCompanyDTO.setCompany_name(companyname);
			cCompanyDTO.setCompany_phone(companyphone);
			cCompanyDTO.setFrom_login(from_login);
			cCompanyDTO.setTo_login(to_login);
			cCompanyDTO.setTimezone(timezone);
			cCompanyDTO.setIsToggelSwitchOn(toggel_switch);
	
			CCompanyDTO updatecompanyDetails = cCompanyDAO.updateCompanyDetails(cCompanyDTO, company_id);
			req.setAttribute("updatecompanyDetails", updatecompanyDetails);
			resp.setContentType("application/json");
			String json = new Gson().toJson(updatecompanyDetails);
			resp.getWriter().write(json);
			return;
			
		} else if (action_type.equalsIgnoreCase("getothercompanylist")) {
			
			ArrayList<CCompanyDTO> otherCompanyList = cCompanyDAO.getOtherCompanyList();
			resp.setContentType("application/json");
			String json = new Gson().toJson(otherCompanyList);
			resp.getWriter().write(json);
			return;
			
		}else if (action_type.equalsIgnoreCase("checkalreadyexists")) {//block for check company email and phone is already exists
				String isexistvalue = req.getParameter("isexistvalue")==null ? "" : req.getParameter("isexistvalue");
				String checkfor = req.getParameter("checkfor")==null ? "" : req.getParameter("checkfor");
				boolean is_exits = cCompanyDAO.isalreadyexists(company_id,isexistvalue,checkfor);
				resp.setContentType("application/json");
				PrintWriter out = resp.getWriter();
				Gson gson = new Gson();
				out.println(gson.toJson(is_exits));
				return;
		}   
	}

}

package com.dakshabhi.pms.companies.services;

/***
 * Class for Company Registration Service
 */

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dakshabhi.pms.companies.daos.CCompanyDAO;
import com.dakshabhi.pms.companies.dtos.CompanyRegistrationDTO;
import com.google.gson.Gson;

@WebServlet("/cregistration")
public class CCompanyRegistrationService extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String actionType = req.getParameter("actionType") == null ? "" : req.getParameter("actionType");
		String companyName = req.getParameter("companyName") == null ? "" : req.getParameter("companyName");
		String companyUrl = req.getParameter("companyUrl") == null ? "" : req.getParameter("companyUrl");
		String email = req.getParameter("email") == null ? "" : req.getParameter("email");
		String phone = req.getParameter("phone") == null ? "" : req.getParameter("phone");
		
		if(actionType.equalsIgnoreCase("checkCompanyURL")) {
			if(!"".equals(companyUrl)) {
				String companyID = CCompanyDAO.getCompanyIDByURL(companyUrl+".taskistic.com");
				if(!"".equals(companyID)) {
					resp.setContentType("application/plain");
					String json = new Gson().toJson(true);
					resp.getWriter().write(json);
					return;
				}else {
					resp.setContentType("application/plain");
					String json = new Gson().toJson(false);
					resp.getWriter().write(json);
					return;
				}
				
			}
		} else if (actionType.equalsIgnoreCase("register")) {

			CompanyRegistrationDTO registrationDTO = new CompanyRegistrationDTO();
			registrationDTO.setCompanyURL(companyUrl + ".taskistic.com");
			registrationDTO.setCompanyName(companyName);
			registrationDTO.setCompanyEmail(email);
			registrationDTO.setCompanyPhone(phone); 
//			registrationDTO = CCompanyDAO.registerCompany(registrationDTO);
//			if(!registrationDTO.getCompanyID().equals("")) {
//				req.getSession().setAttribute("registrationDTO", registrationDTO);
//				resp.sendRedirect("cregsuccess.jsp");
//			}else {
//				req.getSession().setAttribute("regError", "Error in company registration. Please contact administrator.");
//				resp.sendRedirect("cregistration.jsp");
//			}
			
		}

	}
}

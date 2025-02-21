package com.dakshabhi.pms.users.services;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.Format;
import java.text.MessageFormat;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dakshabhi.common.security.EncryptionManager;
import com.dakshabhi.common.utility.Utility;
import com.dakshabhi.pms.email.dtos.CEmailDetailsDTO;
import com.dakshabhi.pms.email.services.CSendUserRegistrationEmail;
import com.dakshabhi.pms.users.daos.CUserLoginDAO;
import com.google.gson.Gson;
@WebServlet("/forgotpassowrd")
public class CForgotPasswordService extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private static String msgtxtForgotPassord = null;

	static {
		try {
			msgtxtForgotPassord = Utility.getResourceFileAsString(CForgotPasswordService.class,
					"userForgotpassword.txt");

		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String companyId = req.getParameter("companyid") == null ? "" : req.getParameter("companyid");
		String email = req.getParameter("email") == null ? "" : req.getParameter("email");
		boolean ismailSent = false;
		if (!"".equals(email) && !"".equals(companyId)) {
			CUserLoginDAO userLoginDAO = new CUserLoginDAO();
			String userPassword = userLoginDAO.getuserPassword(email,companyId);
			if (!"".endsWith(userPassword)) { 
				Format forgotEmailFormat = new MessageFormat(msgtxtForgotPassord);
				String[] args = { "", email, EncryptionManager.decryptBlowfish(userPassword) };
  	
				String forgotEmailBody = forgotEmailFormat.format(args); 

				CEmailDetailsDTO emailDetailsDTO = new CEmailDetailsDTO();
				emailDetailsDTO.setFromEmail("Taskistic <support@taskistic.com>");
				emailDetailsDTO.setToEmail(email);
				emailDetailsDTO.setEmailSubject("Taskistic account login details");
				emailDetailsDTO.setEmailBody(forgotEmailBody);
				emailDetailsDTO.setContentType("text/html");
				ismailSent = CSendUserRegistrationEmail.sendEmail(emailDetailsDTO);
			}
		}
		if (ismailSent) {
			resp.setContentType("application/json");
			PrintWriter out = resp.getWriter();
			Gson gson = new Gson();
			out.println(gson.toJson("Success"));
			return;
		} else {
			resp.setContentType("application/json");
			PrintWriter out = resp.getWriter();
			Gson gson = new Gson();
			out.println(gson.toJson("Failure"));
			return;
		}

	}
}

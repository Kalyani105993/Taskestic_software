package com.dakshabhi.pms.api.services;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dakshabhi.pms.api.dtos.APIResponseDTO;
import com.dakshabhi.pms.companies.daos.CCompanyDAO;
import com.dakshabhi.pms.users.daos.CUserLoginDAO;
import com.dakshabhi.pms.users.dtos.CUserLoginDTO;
import com.google.gson.Gson;

@WebServlet("/api/login")
public class LoginAPI extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		APIResponseDTO responseDTO = new APIResponseDTO();
		responseDTO.setResponse(0);
		responseDTO.setReposneText("Declined. Method not allowed.");
		responseDTO.setResponseType("plain");
		resp.setContentType("application/json");
		String json = new Gson().toJson(responseDTO);
		resp.getWriter().write(json);
		return;
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String userEmail = req.getParameter("email") == null ? "" :  req.getParameter("email");
		String userpassword = req.getParameter("password") == null ? "" :  req.getParameter("password");
		String companyURL = req.getParameter("companyurl") == null ? "" :  req.getParameter("companyurl");
		String deviceToken = req.getParameter("deviceTokenName") == null ? "" : req.getParameter("deviceTokenName");
		String apikey = req.getParameter("key") == null ? "" :   req.getParameter("key"); 
		if (!apikey.equals("")) {
			boolean isLogginSuccessfull = false;
			String companyId = CCompanyDAO.getCompanyIDByURL(companyURL);
			APIResponseDTO responseDTO = new APIResponseDTO();
			if(!"".equals(companyId)) {
				CUserLoginDTO cUserLoginDTO = CUserLoginDAO.getUserloginDetails(companyId, userEmail, userpassword,deviceToken);
				if (cUserLoginDTO != null) {
					isLogginSuccessfull = true;
					responseDTO.setResponse(1);
					responseDTO.setReposneText("Success");
					responseDTO.setResponseType("Object");
					responseDTO.setResponseData(cUserLoginDTO);
					resp.setContentType("application/json");
					String json = new Gson().toJson(responseDTO);
					resp.getWriter().write(json);
					return;
				}
			} 
			
			if(!isLogginSuccessfull) {
				responseDTO.setResponse(0);
				responseDTO.setReposneText("Failed. Invalid login details.");
				responseDTO.setResponseType("plain");
				resp.setContentType("application/json");
				String json = new Gson().toJson(responseDTO);
				resp.getWriter().write(json);
				return;
			} 
		}else {
			APIResponseDTO responseDTO = new APIResponseDTO();
			responseDTO.setResponse(0);
			responseDTO.setReposneText("Declined. Invalid Request.");
			responseDTO.setResponseType("plain");
			resp.setContentType("application/json");
			String json = new Gson().toJson(responseDTO);
			resp.getWriter().write(json);
			return;
		} 
	}
}

package com.dakshabhi.pms.api.services;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dakshabhi.pms.api.daos.CompanyDAO;
import com.dakshabhi.pms.api.dtos.APIResponseDTO;
import com.dakshabhi.pms.api.dtos.CompanyDTO;
import com.google.gson.Gson;
@WebServlet("/api/company")
public class CompanyInfoAPI extends HttpServlet{

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
		String appkey = req.getParameter("appkey") == null ? "" : req.getParameter("appkey");
		String apikey = req.getParameter("key") == null ? "" : req.getParameter("key");
		if (!apikey.equals("") && !appkey.equals("")) {
			CompanyDAO companyDAO = new CompanyDAO();
			CompanyDTO companyDTO = companyDAO.getCompanyInfoByKey(appkey);
			APIResponseDTO responseDTO = new APIResponseDTO();
			if(companyDTO == null) { 
				responseDTO.setResponse(0);
				responseDTO.setReposneText("Error: Invalid app key."); 
				responseDTO.setResponseType("plain");
				resp.setContentType("application/json");
				String json = new Gson().toJson(responseDTO);
				resp.getWriter().write(json);
			}else {
			
			responseDTO.setResponse(1);
			responseDTO.setReposneText("Success");
			responseDTO.setResponseType("Object"); 
			responseDTO.setResponseData(companyDTO);
			resp.setContentType("application/json");
			String json = new Gson().toJson(responseDTO);
			resp.getWriter().write(json);
			
			}
			return;
		} else {
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

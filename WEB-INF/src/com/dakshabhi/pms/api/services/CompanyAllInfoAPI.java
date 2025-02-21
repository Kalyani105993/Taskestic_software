package com.dakshabhi.pms.api.services;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.TimeZone;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dakshabhi.pms.api.dtos.APIResponseDTO;
import com.dakshabhi.pms.companies.daos.CCompanyDAO;
import com.dakshabhi.pms.companies.dtos.CCompanyDTO;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

@WebServlet("/api/companyDetails")
public class CompanyAllInfoAPI extends HttpServlet {

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
		String action_type = req.getParameter("action_type") == null ? "" : req.getParameter("action_type");
		String company_id = req.getParameter("company_id");
		if (action_type.equalsIgnoreCase("companyInfo")) {
			CCompanyDTO companyDetails = CCompanyDAO.getCompanyName(company_id);
			APIResponseDTO responseDTO = new APIResponseDTO();
			responseDTO.setResponse(1);
			responseDTO.setReposneText("Success");
			responseDTO.setResponseType("List");
			responseDTO.setResponseData(companyDetails);
			resp.setContentType("application/json");
			String json = new Gson().toJson(responseDTO);
			resp.getWriter().write(json);
			return;
		} else if (action_type.equalsIgnoreCase("companyInfoUpdate")) {
			CCompanyDTO cCompanyDTO = new CCompanyDTO();
			String jsonData = req.getReader().lines().reduce("", (accumulator, actual) -> accumulator + actual);
			JsonObject jsonObject = new JsonParser().parse(jsonData).getAsJsonObject();

			cCompanyDTO.setCompany_name(jsonObject.get("company_name").getAsString());
			cCompanyDTO.setCompany_address(jsonObject.get("company_address").getAsString());
			cCompanyDTO.setCompany_phone(jsonObject.get("company_phone").getAsString());
			cCompanyDTO.setCompany_email(jsonObject.get("company_email").getAsString());
			cCompanyDTO.setFrom_login(jsonObject.get("from_login").getAsString());
			cCompanyDTO.setTo_login(jsonObject.get("to_login").getAsString());
			cCompanyDTO.setTimezone(jsonObject.get("timezone").getAsString());
			cCompanyDTO.setIsToggelSwitchOn(jsonObject.get("isToggelSwitchOn").getAsString());

			CCompanyDAO cCompanyDAO = new CCompanyDAO();
			CCompanyDTO updatecompanyDetails = cCompanyDAO.updateCompanyDetails(cCompanyDTO, company_id);
			req.setAttribute("updatecompanyDetails", updatecompanyDetails);
			resp.setContentType("application/json");
			String json = new Gson().toJson(updatecompanyDetails);
			resp.getWriter().write(json);
			return;

		}
	}
}

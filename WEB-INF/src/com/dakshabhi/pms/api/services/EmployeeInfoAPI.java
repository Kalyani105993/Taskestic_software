package com.dakshabhi.pms.api.services;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dakshabhi.pms.profile.daos.CProfileDAO;
import com.dakshabhi.pms.profile.dtos.CProfileDTO;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

@WebServlet("/api/employee")
public class EmployeeInfoAPI extends HttpServlet {

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
		if (action_type.equalsIgnoreCase("updateEmpInfo")) {
			CProfileDAO cProfileDAO = new CProfileDAO();
			CProfileDTO cProfileDTO = new CProfileDTO();
			
			String jsonData = req.getReader().lines().reduce("", (accumulator, actual) -> accumulator + actual);
			JsonObject jsonObject = new JsonParser().parse(jsonData).getAsJsonObject();
			System.out.println("jsonData" + jsonData);

			cProfileDTO.setEmployee_name(jsonObject.get("employee_name").getAsString());
			cProfileDTO.setEmployee_email(jsonObject.get("employee_email").getAsString());
			cProfileDTO.setEmployee_phone(jsonObject.get("employee_phone").getAsString());
			cProfileDTO.setAadhaar_card_no(jsonObject.get("aadhar_card_no").getAsString());
			cProfileDTO.setPan_no(jsonObject.get("pan_no").getAsString());
			cProfileDTO.setPassport_no(jsonObject.get("passport_no").getAsString());
			cProfileDTO.setPermanent_address(jsonObject.get("permanant_address").getAsString());
			
			cProfileDTO.setCurrent_address(jsonObject.get("current_address").getAsString());
			cProfileDTO.setDOB(jsonObject.get("date_of_birth").getAsString());
			cProfileDTO.setGender(jsonObject.get("gender").getAsString());
			cProfileDTO.setEmployee_id(jsonObject.get("employee_id").getAsInt());

			boolean updateEmployeeDetails = cProfileDAO.updateData(cProfileDTO);
			req.setAttribute("updateEmployeeDetails", updateEmployeeDetails);
			resp.setContentType("application/json");
			String json = new Gson().toJson(updateEmployeeDetails);
			resp.getWriter().write(json);
			return;

		}else if (action_type.equalsIgnoreCase("updatepassword")) {
			CProfileDAO cProfileDAO = new CProfileDAO();
			String userId = req.getParameter("userid") == null ? "" : req.getParameter("userid");
			String newPassword = req.getParameter("newPassword") == null ? "" : req.getParameter("newPassword");
			boolean updatepassword = cProfileDAO.updatePassword(userId, newPassword);
			req.setAttribute("updatepassword", updatepassword);
			resp.setContentType("application/json");
			String json = new Gson().toJson(updatepassword);
			resp.getWriter().write(json);
			return;

		}

	}
}

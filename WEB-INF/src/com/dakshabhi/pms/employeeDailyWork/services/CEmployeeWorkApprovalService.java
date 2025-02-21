package com.dakshabhi.pms.employeeDailyWork.services;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dakshabhi.common.constants.ConfigConstants;
import com.dakshabhi.pms.employeeDailyWork.daos.CEmployeeDailyWorkDAO;
import com.dakshabhi.pms.employeeDailyWork.dtos.CEmployeeDailyWorkDTO;
import com.dakshabhi.pms.employeeDailyWork.dtos.CEmployeeDailyWorkInfoDTO;
import com.dakshabhi.pms.employees.daos.CEmployeeDAO;
import com.dakshabhi.pms.employees.dtos.CEmployeeDTO;
import com.dakshabhi.pms.users.dtos.CUserLoginDTO;
import com.google.gson.Gson;

@WebServlet(value = "/employeeworkapproval")
public class CEmployeeWorkApprovalService extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		CEmployeeDAO cEmployeeDAO = new CEmployeeDAO();

		CEmployeeDailyWorkDAO cEmployeeDailyWorkDAO = new CEmployeeDailyWorkDAO();
		String action_type = req.getParameter("action_type") == null ? "" : req.getParameter("action_type");
		String companyId = ConfigConstants.getCompanyID(req.getSession());
		if (action_type.equalsIgnoreCase("infoforapprovaledit")) {
			String employeeId = req.getParameter("employee_id") == null ? "" : req.getParameter("employee_id");
			String fromDate = req.getParameter("from_date") == null ? "" : req.getParameter("from_date");
			String toDate = req.getParameter("to_date") == null ? "" : req.getParameter("to_date");
			ArrayList<CEmployeeDailyWorkInfoDTO> employeeDailyWorkInfoViewDTO = cEmployeeDailyWorkDAO
					.getCustomerDetailsForEdit(employeeId, fromDate, toDate);
			if (employeeDailyWorkInfoViewDTO != null) {
				resp.setContentType("application/json");
				PrintWriter out = resp.getWriter();
				Gson gson = new Gson();
				out.println(gson.toJson(employeeDailyWorkInfoViewDTO));
				return;
			}
		} else if (action_type.equalsIgnoreCase("updateEmployeeWorkApproval")) {
			CUserLoginDTO cUserLoginDTO = (CUserLoginDTO) req.getSession().getAttribute("userLogin");
			String daily_work_id = req.getParameter("daily_work_id");
			int approvedby_id = cUserLoginDTO.getUser_login_id();

			String approved_hours = req.getParameter("approved_hours");
			String approved_remark = req.getParameter("approved_remark");
			String rejected_hours = req.getParameter("rejected_hours");
			float existingApprovedHours = cEmployeeDailyWorkDAO.getExitingApprovedHours(daily_work_id);
			if (cEmployeeDailyWorkDAO.updateProjectWorkpackDetails(daily_work_id, approved_hours, rejected_hours,
					approved_remark, approvedby_id)) {
				System.out.println("employee work approval update successfully");
				if (cEmployeeDailyWorkDAO.updateBookedHoursInProjectWorkpack(daily_work_id, approved_hours,
						existingApprovedHours)) {
					System.out.println("Booked Hours updated successfully");
				}

			} else {
				System.out.println("employee work approval updation failed!!!");
			}
		} else if (action_type.equalsIgnoreCase("getEmployeeList")) {
			try {
				CUserLoginDTO cUserLoginDTO = (CUserLoginDTO) req.getSession().getAttribute("userLogin");
				ArrayList<CEmployeeDTO> cEmployeeDTOList = null;
				if (cUserLoginDTO.getUser_role() == 1) {
					cEmployeeDTOList = cEmployeeDailyWorkDAO.getEmployeeNameList();
				} else if (cUserLoginDTO.getUser_role() == 2) {
					cEmployeeDTOList = cEmployeeDailyWorkDAO.getEmployeeUnderReportingTo(cUserLoginDTO,companyId);
				} else {
					cEmployeeDTOList = new ArrayList<CEmployeeDTO>();
					CEmployeeDTO cEmployeeDTO = new CEmployeeDTO();
					cEmployeeDTO.setEmployee_id(cUserLoginDTO.getUser_employee_id());
					cEmployeeDTO.setEmployee_name(cUserLoginDTO.getUser_full_name());
					cEmployeeDTOList.add(cEmployeeDTO);
				}

				resp.setContentType("application/json");
				PrintWriter out = resp.getWriter();
				Gson gson = new Gson();
				out.println(gson.toJson(cEmployeeDTOList));
				return;
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (action_type.equalsIgnoreCase("getApprovedHours")) {
			try {

				CEmployeeDailyWorkDTO cEmployeeDailyWorkDTO = new CEmployeeDailyWorkDTO();

				String employee_id = req.getParameter("employee_id");

				String project_id = req.getParameter("project_id");
				String workpack_id = req.getParameter("workpack_id");

				ArrayList<CEmployeeDailyWorkDTO> employeeDailyWorkDTO = cEmployeeDailyWorkDAO
						.getAllApprovedHours(project_id, workpack_id, employee_id);

				resp.setContentType("application/json");
				PrintWriter out = resp.getWriter();
				Gson gson = new Gson();
				out.println(gson.toJson(employeeDailyWorkDTO));
				return;

			} catch (Exception e) {
				e.printStackTrace();
			}

		}
		resp.sendRedirect("employeeworkapproval.jsp");
	}

}

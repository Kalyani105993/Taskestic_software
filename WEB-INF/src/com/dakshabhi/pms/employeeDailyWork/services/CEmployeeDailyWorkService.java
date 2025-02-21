package com.dakshabhi.pms.employeeDailyWork.services;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dakshabhi.pms.employees.dtos.CEmployeeDTO;
import com.dakshabhi.pms.projects.daos.CProjectDAO;
import com.dakshabhi.pms.projects.dtos.CProjectInfoDTO;
import com.dakshabhi.common.constants.ConfigConstants;
import com.dakshabhi.pms.employeeDailyWork.daos.CEmployeeDailyWorkDAO;
import com.dakshabhi.pms.employeeDailyWork.dtos.CEmployeeDailyWorkDTO;
import com.dakshabhi.pms.projectsemployee.dtos.CProjectEmployeeInfoDTO;
import com.dakshabhi.pms.projectworkpacks.dtos.CProjectworkpacksInfoDTO;
import com.dakshabhi.pms.users.dtos.CUserLoginDTO;
import com.google.gson.Gson;

@WebServlet(value = "/employeedailywork")
public class CEmployeeDailyWorkService extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		doPost(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		CEmployeeDailyWorkDAO cEmployeeDailyWorkDAO = new CEmployeeDailyWorkDAO();

		String actionType = req.getParameter("actionType") == null ? "" : req.getParameter("actionType");
		String companyId = ConfigConstants.getCompanyID(req.getSession());
		if (actionType.equalsIgnoreCase("getProjectName")) {
			try {
				String employeeId = req.getParameter("employeeId");

				ArrayList<CProjectEmployeeInfoDTO> cProjectDTO = cEmployeeDailyWorkDAO
						.getProjectNameListByEmployeeId(employeeId);
				resp.setContentType("application/json");

				PrintWriter out = resp.getWriter();
				Gson gson = new Gson();
				out.println(gson.toJson(cProjectDTO));
				return;
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (actionType.equalsIgnoreCase("getWorkpackName")) {
			try {
				String projectId = req.getParameter("projectId");
				ArrayList<CProjectworkpacksInfoDTO> cProjectsWorkpackInfoDTO = cEmployeeDailyWorkDAO
						.getWorkpackNameListByProjectId(projectId);
				resp.setContentType("application/json");

				PrintWriter out = resp.getWriter();
				Gson gson = new Gson();
				out.println(gson.toJson(cProjectsWorkpackInfoDTO));
				return;
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (actionType.equalsIgnoreCase("getEmployeeList")) {
			try {
				CUserLoginDTO cUserLoginDTO = (CUserLoginDTO) req.getSession().getAttribute("userLogin");
				ArrayList<CEmployeeDTO> cEmployeeDTOList = null;
				if (cUserLoginDTO.getUser_role() == 1) {
					cEmployeeDTOList = cEmployeeDailyWorkDAO.getAllEmployee();
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
		} else if (actionType.equalsIgnoreCase("saveEmployeeWork")) {
			CEmployeeDailyWorkDTO objEmployeeDailyworkDTO = new CEmployeeDailyWorkDTO();
			objEmployeeDailyworkDTO.setCompany_id(1);
			objEmployeeDailyworkDTO.setEmployee_id(Integer.parseInt(req.getParameter("employee_id")));
			objEmployeeDailyworkDTO.setProject_id(Integer.parseInt(req.getParameter("project_id")));
			objEmployeeDailyworkDTO.setWorkpack_id(Integer.parseInt(req.getParameter("workpack_id")));
			objEmployeeDailyworkDTO.setWork_date(req.getParameter("dateName"));
			objEmployeeDailyworkDTO.setWork_hours(Float.parseFloat(req.getParameter("work_hours")));

			objEmployeeDailyworkDTO.setWork_added_date(req.getParameter("work_added_date"));

			if (cEmployeeDailyWorkDAO.saveEmployeeDailyWorkInfo(objEmployeeDailyworkDTO)) {
				System.out.println("Employee Daily Work created successfully");

				resp.setContentType("application/json");
				PrintWriter out = resp.getWriter();
				Gson gson = new Gson();
				out.println(gson.toJson(objEmployeeDailyworkDTO));
				return;
			} else {
				System.out.println("Employee Daily Work creation failed!!!");
			}
		} else if (actionType.equalsIgnoreCase("checkDateandWorkHours")) {
			try {
				String project_id = req.getParameter("projectId");
				String workpackId = req.getParameter("workpackId");
				String employee_id = req.getParameter("employee_id");
				String cDate = req.getParameter("cDate");
				ArrayList<CEmployeeDailyWorkDTO> cEmployeeDailyWorkDTOs = cEmployeeDailyWorkDAO
						.getDailyWorkDetails(employee_id, project_id, workpackId, cDate);
				resp.setContentType("application/json");
				PrintWriter out = resp.getWriter();
				Gson gson = new Gson();
				out.println(gson.toJson(cEmployeeDailyWorkDTOs));
				return;
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (actionType.equalsIgnoreCase("infoForUpdate")) {
			try {
				String employee_id = req.getParameter("employee_id");
				String project_id = req.getParameter("project_id");
				String workpack_id = req.getParameter("workpack_id");
				String work_date = req.getParameter("work_date");

				ArrayList<CEmployeeDailyWorkDTO> cEmployeeDailyWorkDTO = cEmployeeDailyWorkDAO
						.getInfoForEdit(employee_id, project_id, workpack_id, work_date);
				resp.setContentType("application/json");
				PrintWriter out = resp.getWriter();
				Gson gson = new Gson();
				out.println(gson.toJson(cEmployeeDailyWorkDTO));
				return;
			} catch (Exception e) {
				e.printStackTrace();
			}

		} else if (actionType.equalsIgnoreCase("update")) {
			try {
				String employee_daily_work_id = req.getParameter("employee_daily_work_id");

				String work_date = req.getParameter("work_date");
				String work_hours = req.getParameter("work_hours");

				if (cEmployeeDailyWorkDAO.updateHours(employee_daily_work_id, work_date, work_hours)) {
					System.out.println("Update hours successfully");
				} else {
					System.out.println("Update hours failed!!!");
				} 
				return;
			} catch (Exception e) {
				e.printStackTrace();
			}

		}
		resp.sendRedirect("employeedailywork.jsp");
	}

}

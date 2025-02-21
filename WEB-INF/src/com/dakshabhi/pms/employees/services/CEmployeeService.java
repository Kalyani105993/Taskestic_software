package com.dakshabhi.pms.employees.services;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dakshabhi.common.constants.ConfigConstants;
import com.dakshabhi.pms.employees.daos.CEmployeeDAO;
import com.dakshabhi.pms.employees.dtos.CEmployeeDTO;
import com.dakshabhi.pms.employees.dtos.CEmployeeInfoDTO;
import com.dakshabhi.pms.fcm.dtos.PushNotificationRequest;
import com.dakshabhi.pms.fcm.services.Notification;
import com.dakshabhi.pms.masters.dtos.CDepartmentDTO;
import com.dakshabhi.pms.projects.daos.CProjectContactsDAO;
import com.dakshabhi.pms.projects.daos.CProjectDAO;
import com.dakshabhi.pms.projects.dtos.CProjectContactsDTO;
import com.dakshabhi.pms.projects.dtos.CProjectDTO;
import com.dakshabhi.pms.projects.dtos.CProjectInfoDTO;
import com.dakshabhi.pms.users.dtos.CUserLoginDTO;
import com.google.gson.Gson;

@WebServlet(value = "/employee")
public class CEmployeeService extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		CEmployeeDTO cEmployeeDTO = new CEmployeeDTO();
		CEmployeeDAO cEmployeeDAO = new CEmployeeDAO();
		String actionType = req.getParameter("actionType") == null ? "" : req.getParameter("actionType");
		String companyId = ConfigConstants.getCompanyID(req.getSession());
		CUserLoginDTO cUserLoginDTO = (CUserLoginDTO) req.getSession().getAttribute("userLogin");
		if (actionType.equalsIgnoreCase("save")) { // block for save new employee
			try {

				cEmployeeDTO.setCompany_id(Integer.parseInt(companyId));
				cEmployeeDTO.setEmployee_code(req.getParameter("employee_code"));
				cEmployeeDTO.setEmployee_name(req.getParameter("employee_name"));
				cEmployeeDTO.setDepartment_id(Integer.parseInt(req.getParameter("department_id")== null ? "0" : req.getParameter("department_id")));
				cEmployeeDTO.setRemporting_to(Integer.parseInt(req.getParameter("remporting_to")== null ? "0" : req.getParameter("remporting_to")));
				cEmployeeDTO.setEmployee_role(Integer.parseInt(req.getParameter("employee_role")== null ? "0" : req.getParameter("employee_role")));
				cEmployeeDTO.setEmployee_email(req.getParameter("employee_email"));
				cEmployeeDTO.setEmployee_phone(req.getParameter("employee_phone"));
				cEmployeeDTO.setEmployee_status(Integer.parseInt(req.getParameter("employee_status")== null ? "0" : req.getParameter("employee_status")));
				cEmployeeDTO.setEmployee_type(Integer.parseInt(req.getParameter("employee_type")== null ? "0" : req.getParameter("employee_type")));
				cEmployeeDTO.setDate_joining(req.getParameter("date_joining"));
				cEmployeeDTO.setAadhar_card_no(req.getParameter("aadhar_card_no"));
				cEmployeeDTO.setPassport_no(req.getParameter("passport_no"));
				cEmployeeDTO.setPan_no(req.getParameter("pan_no"));
				cEmployeeDTO.setCurrent_address(req.getParameter("current_address"));
				cEmployeeDTO.setPermanant_address(req.getParameter("permanant_address"));
				cEmployeeDTO.setDate_of_birth(
						req.getParameter("date_of_birth") == "" ? "0000-00-00" : req.getParameter("date_of_birth"));
				cEmployeeDTO.setGender(req.getParameter("gender"));
				cEmployeeDTO.setCreated_by(cUserLoginDTO.getUser_full_name());
				int stutus = 0;

				if (cEmployeeDAO.saveEmployee(cEmployeeDTO, companyId)) {
					stutus = 1;
				}
				resp.setContentType("application/json");
				PrintWriter out = resp.getWriter();
				Gson gson = new Gson();
				out.println(gson.toJson(stutus));
				return;

			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (actionType.equalsIgnoreCase("deleteEmployeeById")) {
			String employeeId = req.getParameter("id");
			cEmployeeDAO.deleteEmployee(employeeId);

		} else if (actionType.equalsIgnoreCase("infoforedit")) {
			String employeeId = req.getParameter("employee_id") == null ? "" : req.getParameter("employee_id");
			CEmployeeDTO objCEmployeeInfoDTO = cEmployeeDAO.getEmployeeDetailsForEdit(employeeId);
			if (objCEmployeeInfoDTO != null) {
				resp.setContentType("application/json");
				PrintWriter out = resp.getWriter();
				Gson gson = new Gson();
				out.println(gson.toJson(objCEmployeeInfoDTO));
				return;
			}
		} else if (actionType.equalsIgnoreCase("update")) {
			CEmployeeDTO objEmployeeDTO = new CEmployeeDTO();

			objEmployeeDTO.setEmployee_id(Integer.parseInt(req.getParameter("employeeId")));
			objEmployeeDTO.setEmployee_code(req.getParameter("employee_code"));
			objEmployeeDTO.setEmployee_name(req.getParameter("employee_name"));
			objEmployeeDTO.setDepartment_id(Integer.parseInt(req.getParameter("department_id")));
			objEmployeeDTO.setEmployee_role(Integer.parseInt(req.getParameter("employee_role")));
			objEmployeeDTO.setEmployee_email(req.getParameter("employee_email"));
			objEmployeeDTO.setEmployee_phone(req.getParameter("employee_phone"));
			objEmployeeDTO.setEmployee_status(Integer.parseInt(req.getParameter("employee_status")));
			objEmployeeDTO.setEmployee_type(Integer.parseInt(req.getParameter("employee_type")));
			objEmployeeDTO.setDate_joining(req.getParameter("date_joining"));
			objEmployeeDTO.setAadhar_card_no(req.getParameter("aadhar_card_no"));
			objEmployeeDTO.setPassport_no(req.getParameter("passport_no"));
			objEmployeeDTO.setPan_no(req.getParameter("pan_no"));
			objEmployeeDTO.setRemporting_to(Integer.parseInt(req.getParameter("remporting_to")));
			objEmployeeDTO.setCurrent_address(req.getParameter("current_address"));
			objEmployeeDTO.setPermanant_address(req.getParameter("permanant_address"));
			objEmployeeDTO.setDate_of_birth(
					req.getParameter("date_of_birth") == "" ? "0000-00-00" : req.getParameter("date_of_birth"));
			objEmployeeDTO.setGender(req.getParameter("gender"));
			System.out.println(objEmployeeDTO.getEmployee_status());
			int status = 0; 
			if (cEmployeeDAO.updateEmployeeDetails(objEmployeeDTO)) {
				 status = 1; 
				System.out.println("Employee update successfully");
			} else {
				System.out.println("Employee updation failed!!!");
			}
			resp.setContentType("application/json");
			PrintWriter out = resp.getWriter();
			Gson gson = new Gson();
			 out.println(gson.toJson(status));
			return;
		} else if (actionType.equalsIgnoreCase("getAllEmployeeName")) {
			CEmployeeDAO cAllEmployeeNameById = new CEmployeeDAO();
			try {
				int employee_id = Integer.parseInt(req.getParameter("id"));
				ArrayList<CEmployeeDTO> cEmployeeName = cAllEmployeeNameById.getAllEmployeeNameByID(employee_id);
				resp.setContentType("application/json");
				PrintWriter out = resp.getWriter();
				Gson gson = new Gson();
				out.println(gson.toJson(cEmployeeName));
				return;
			} catch (Exception e) {
				e.printStackTrace();
			}

		} else if (actionType.equalsIgnoreCase("searchData")) {
			try {
				int startIndex = Integer.parseInt(req.getParameter("startIndex"));
				int endIndex = Integer.parseInt(req.getParameter("endIndex"));
				String pageNo = req.getParameter("pageNo")== null ? "1" : req.getParameter("pageNo");
				System.out.println("current page: "+pageNo);
				String employee_code = req.getParameter("searchEmployee_code_id") == null ? ""
						: req.getParameter("searchEmployee_code_id");
				String employee_name = req.getParameter("searchEmployee_name_id") == null ? ""
						: req.getParameter("searchEmployee_name_id");

				String employee_email = req.getParameter("searchEmployee_email_id") == null ? ""
						: req.getParameter("searchEmployee_email_id");
				String employee_phone = req.getParameter("searchEmployee_phone_id") == null ? ""
						: req.getParameter("searchEmployee_phone_id");

				int department_id = Integer.parseInt(req.getParameter("searchDepartment_id"));
				String department_Id = Integer.toString(department_id);
				if (department_id == 0) {
					department_Id = "";
				}

				int employee_role = Integer.parseInt(req.getParameter("searchEmployee_role_id"));
				String employeeRole = Integer.toString(employee_role);
				if (employee_role == 0) {
					employeeRole = "";
				}

				int searchStatusList = Integer.parseInt(req.getParameter("searchStatus"));
				String searchStatusListData = Integer.toString(searchStatusList);
				if (searchStatusList == 0) {
					searchStatusListData = "";
				}

				Object[] employeeInfoListObj = cEmployeeDAO.getSearchData(employee_code, employee_name, employee_email,
						employee_phone, department_Id, searchStatusListData, employeeRole, startIndex, endIndex, companyId, pageNo);

				resp.setContentType("application/json");
				PrintWriter out = resp.getWriter();
				Gson gson = new Gson();
				out.println(gson.toJson(employeeInfoListObj));
				return;

			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (actionType.equalsIgnoreCase("getAllEmployees")) {
			try {
				int startIndex = Integer.parseInt(req.getParameter("startIndex"));
				int endIndex = Integer.parseInt(req.getParameter("endIndex"));
				String pageNo = req.getParameter("pageNo")== null ? "1" : req.getParameter("pageNo");
				System.out.println("page no is: "+pageNo);
				Object[] cEmployeeDTOs = cEmployeeDAO.getAllEmployeeDetails(startIndex, endIndex, companyId, pageNo);
				resp.setContentType("application/json");
				PrintWriter out = resp.getWriter();
				Gson gson = new Gson();
				out.println(gson.toJson(cEmployeeDTOs));
				return;
			} catch (Exception e) {
				e.printStackTrace();
			}

		} else if (actionType.equalsIgnoreCase("checkalreadyexists")) {
			try {
				String isexistvalue = req.getParameter("isexistvalue")==null ? "" : req.getParameter("isexistvalue");
				String checkfor = req.getParameter("checkfor")==null ? "" : req.getParameter("checkfor");
				boolean is_exits = cEmployeeDAO.isalreadyexists(companyId,isexistvalue,checkfor);
				resp.setContentType("application/json");
				PrintWriter out = resp.getWriter();
				Gson gson = new Gson();
				out.println(gson.toJson(is_exits));
				return;
			} catch (Exception e) {
				e.printStackTrace();
			}

		}
	}
}

package com.dakshabhi.pms.masters.services;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dakshabhi.common.constants.ConfigConstants;
import com.dakshabhi.pms.employees.daos.CEmployeeDAO;
import com.dakshabhi.pms.employees.dtos.CEmployeeDTO;
import com.dakshabhi.pms.masters.daos.CCustomerTypeDAO;
import com.dakshabhi.pms.masters.daos.CDepartmentDAO;
import com.dakshabhi.pms.masters.daos.CEmployeeRoleDAO;
import com.dakshabhi.pms.masters.daos.CEmployeeStatusDAO;
import com.dakshabhi.pms.masters.daos.CEmployeeTypeDAO;
import com.dakshabhi.pms.masters.daos.CProjectGroupDAO;
import com.dakshabhi.pms.masters.daos.CProjectStatusDAO;
import com.dakshabhi.pms.masters.daos.CProjectSubGroupDAO;
import com.dakshabhi.pms.masters.daos.CProjectTypeDAO;
import com.dakshabhi.pms.masters.daos.CTaskActivityDAO;
import com.dakshabhi.pms.masters.daos.CTaskPriorityDAO;
import com.dakshabhi.pms.masters.daos.CTaskStatusDAO;
import com.dakshabhi.pms.masters.daos.CTaskTypeDAO;
import com.dakshabhi.pms.masters.dtos.CCustomerTypeDTO;
import com.dakshabhi.pms.masters.dtos.CDepartmentDTO;
import com.dakshabhi.pms.masters.dtos.CEmployeeRoleDTO;
import com.dakshabhi.pms.masters.dtos.CEmployeeStatusDTO;
import com.dakshabhi.pms.masters.dtos.CEmployeeTypeDTO;
import com.dakshabhi.pms.masters.dtos.CProjectGroupDTO;
import com.dakshabhi.pms.masters.dtos.CProjectStatusDTO;
import com.dakshabhi.pms.masters.dtos.CProjectSubGroupDTO;
import com.dakshabhi.pms.masters.dtos.CProjectTypeDTO;
import com.dakshabhi.pms.masters.dtos.CTaskAcitvityDTO;
import com.dakshabhi.pms.masters.dtos.CTaskPriorityDTO;
import com.dakshabhi.pms.masters.dtos.CTaskStatusDTO;
import com.dakshabhi.pms.masters.dtos.CTaskTypeDTO;
import com.google.gson.Gson;

/***
 * Class for Fetch All Master Details
 * 
 * @author dakshabhi
 *
 */
@WebServlet(value = "/masterDetails")
public class CMasterDetailsService extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		String actionType = req.getParameter("actionType") == null ? "" : req.getParameter("actionType");
		String companyId = ConfigConstants.getCompanyID(req.getSession());
		if (actionType.equalsIgnoreCase("departmentList")) {
			try {
				ArrayList<CDepartmentDTO> departmentList = null;
				departmentList = CDepartmentDAO.getDepartmentList(companyId);
				resp.setContentType("application/json");
				PrintWriter out = resp.getWriter();
				Gson gson = new Gson();
				out.println(gson.toJson(departmentList));
				return;

			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (actionType.equalsIgnoreCase("employeeRoleList")) {
			try {
				ArrayList<CEmployeeRoleDTO> employeeRoleList = null;

				employeeRoleList = CEmployeeRoleDAO.getEmployeeRoleList(companyId);

				resp.setContentType("application/json");
				PrintWriter out = resp.getWriter();
				Gson gson = new Gson();
				out.println(gson.toJson(employeeRoleList));
				return;

			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (actionType.equalsIgnoreCase("reportingToList")) {
			try {
//				int company_id = Integer.parseInt(req.getParameter("company_id"));
				ArrayList<CEmployeeDTO> cEmployeeDTOs = null;

				cEmployeeDTOs = CEmployeeDAO.getReportingListByEmployeeId(companyId);
//				req.getSession().setAttribute("employeeRoleList", cEmployeeDTOs);

				resp.setContentType("application/json");
				PrintWriter out = resp.getWriter();
				Gson gson = new Gson();
				out.println(gson.toJson(cEmployeeDTOs));
				return;

			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (actionType.equalsIgnoreCase("getEmployeeTypeList")) {
			try {
				ArrayList<CEmployeeTypeDTO> cEmployeeTypeDTOsList = null;

				cEmployeeTypeDTOsList = CEmployeeTypeDAO.getEmployeeTypeList(companyId);

				resp.setContentType("application/json");
				PrintWriter out = resp.getWriter();
				Gson gson = new Gson();
				out.println(gson.toJson(cEmployeeTypeDTOsList));
				return;

			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (actionType.equalsIgnoreCase("getEmployeeStatusList")) {
			try {
				ArrayList<CEmployeeStatusDTO> cEmployeeStatusList = null;

				cEmployeeStatusList = CEmployeeStatusDAO.getEmployeeStatusList(companyId);

				resp.setContentType("application/json");
				PrintWriter out = resp.getWriter();
				Gson gson = new Gson();
				out.println(gson.toJson(cEmployeeStatusList));
				return;

			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (actionType.equalsIgnoreCase("projectStatusList")) {
			try {
				ArrayList<CProjectStatusDTO> projectStatusList = null;

				projectStatusList = CProjectStatusDAO.getProjectStatusList(companyId);

				resp.setContentType("application/json");
				PrintWriter out = resp.getWriter();
				Gson gson = new Gson();
				out.println(gson.toJson(projectStatusList));
				return;

			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (actionType.equalsIgnoreCase("projectGroupList")) {
			try {
				ArrayList<CProjectGroupDTO> projectGroupList = null;

				projectGroupList = CProjectGroupDAO.getProjectGroupList(companyId);

				resp.setContentType("application/json");
				PrintWriter out = resp.getWriter();
				Gson gson = new Gson();
				out.println(gson.toJson(projectGroupList));
				return;

			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (actionType.equalsIgnoreCase("projectSubGroupList")) {
			try {
				ArrayList<CProjectSubGroupDTO> projectSubGroupList = null;

				projectSubGroupList = CProjectSubGroupDAO.getProjectSubGroupList(companyId);

				resp.setContentType("application/json");
				PrintWriter out = resp.getWriter();
				Gson gson = new Gson();
				out.println(gson.toJson(projectSubGroupList));
				return;

			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (actionType.equalsIgnoreCase("projectType")) {
			try {
				ArrayList<CProjectTypeDTO> projectType = null;

				projectType = CProjectTypeDAO.getProjectType(companyId);

				resp.setContentType("application/json");
				PrintWriter out = resp.getWriter();
				Gson gson = new Gson();
				out.println(gson.toJson(projectType));
				return;

			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (actionType.equalsIgnoreCase("taskTypeList")) {
			ArrayList<CTaskTypeDTO> taskTyleList = CTaskTypeDAO.getTasktypeList(companyId);
			resp.setContentType("application/json");
			PrintWriter out = resp.getWriter();
			Gson gson = new Gson();
			out.println(gson.toJson(taskTyleList));
			return;
		} else if (actionType.equalsIgnoreCase("taskPriorityList")) {
			ArrayList<CTaskPriorityDTO> taskPriorityList = CTaskPriorityDAO.getTaskPriorityList(companyId);
			resp.setContentType("application/json");
			PrintWriter out = resp.getWriter();
			Gson gson = new Gson();
			out.println(gson.toJson(taskPriorityList));
			return;
		} else if (actionType.equalsIgnoreCase("taskStatusList")) {
			ArrayList<CTaskStatusDTO> taskStatusList = CTaskStatusDAO.getTaskStatusLit(companyId);
			resp.setContentType("application/json");
			PrintWriter out = resp.getWriter();
			Gson gson = new Gson();
			out.println(gson.toJson(taskStatusList));
			return;
		} else if (actionType.equalsIgnoreCase("taskActivityList")) {
			ArrayList<CTaskAcitvityDTO> taskActivityList = CTaskActivityDAO.getTaskActivityList(companyId);
			resp.setContentType("application/json");
			PrintWriter out = resp.getWriter();
			Gson gson = new Gson();
			out.println(gson.toJson(taskActivityList));
			return;
		} else if (actionType.equalsIgnoreCase("customertypelist")) {
			ArrayList<CCustomerTypeDTO> customerTypeList = CCustomerTypeDAO.getCustomerTypeList(companyId);
			resp.setContentType("application/json");
			PrintWriter out = resp.getWriter();
			Gson gson = new Gson();
			out.println(gson.toJson(customerTypeList));
			return;
		} else if (actionType.equalsIgnoreCase("delete")) {
			int pkid = Integer.parseInt(req.getParameter("id"));
			String masterTypeValue = req.getParameter("masterType");

			if (masterTypeValue.equalsIgnoreCase("customertype")) {
				
				CCustomerTypeDAO.deleteCustomerType(pkid);
			} else if (masterTypeValue.equalsIgnoreCase("department")) {

				CDepartmentDAO.deleteDepartmentType(pkid);
			} else if (masterTypeValue.equalsIgnoreCase("employeerole")) {

				CEmployeeRoleDAO.deleteEmployeeRole(pkid);
			} else if (masterTypeValue.equalsIgnoreCase("employeestatus")) {

				CEmployeeStatusDAO.deleteEmployeeStatus(pkid);
			} else if (masterTypeValue.equalsIgnoreCase("employeetype")) {

				CEmployeeTypeDAO.deleteEmployeeType(pkid);
			} else if (masterTypeValue.equalsIgnoreCase("projectgroup")) {

				CProjectGroupDAO.deleteProjectGroup(pkid);
			} else if (masterTypeValue.equalsIgnoreCase("projectstatus")) {

				CProjectStatusDAO.deleteProjectStatus(pkid);
			} else if (masterTypeValue.equalsIgnoreCase("projectsubgroup")) {

				CProjectSubGroupDAO.deleteProjectSubGroup(pkid);
			} else if (masterTypeValue.equalsIgnoreCase("projecttype")) {

				CProjectTypeDAO.deleteProjectType(pkid);
			} else if (masterTypeValue.equalsIgnoreCase("taskactivity")) {

				CTaskActivityDAO.deleteTaskActivity(pkid);
			} else if (masterTypeValue.equalsIgnoreCase("taskpriority")) {

				CTaskPriorityDAO.deleteTaskPriority(pkid);
			} else if (masterTypeValue.equalsIgnoreCase("taskstatus")) {

				CTaskStatusDAO.deleteTaskStatus(pkid);
			} else if (masterTypeValue.equalsIgnoreCase("tasktype")) {

				CTaskTypeDAO.deleteTaskType(pkid);
			}

		} 
		else if (actionType.equalsIgnoreCase("createnew")) {

			String masterTypeValue = req.getParameter("masterType");
			int companyid = Integer.parseInt(req.getParameter("company_id"));
			if (masterTypeValue.equalsIgnoreCase("customertype")) {
				
				String cxType = req.getParameter("cxType");
				
				CCustomerTypeDAO.createCustomerType(companyid, cxType);
			} else if (masterTypeValue.equalsIgnoreCase("department")) {
				
				String department = req.getParameter("department");
				
				CDepartmentDAO.createDepartmentType(companyid, department);
			} else if (masterTypeValue.equalsIgnoreCase("employeerole")) {
				
				String empRole = req.getParameter("empRole");
				
				CEmployeeRoleDAO.createEmployeeRole(companyid, empRole);
			} else if (masterTypeValue.equalsIgnoreCase("employeestatus")) {
				
				String empStatus = req.getParameter("empStatus");
				
				CEmployeeStatusDAO.createEmployeeStatus(companyid, empStatus);
			}  else if (masterTypeValue.equalsIgnoreCase("employeetype")) {

				String empType = req.getParameter("empType");
				
				CEmployeeTypeDAO.createEmployeeType(companyid, empType);
			} else if (masterTypeValue.equalsIgnoreCase("projectgroup")) {
				
				String projectGroup = req.getParameter("projectGroup");
				
				CProjectGroupDAO.createProjectGroup(companyid, projectGroup);
			} else if (masterTypeValue.equalsIgnoreCase("projectstatus")) {

				String projectStatus = req.getParameter("projectStatus");
				
				CProjectStatusDAO.createProjectStatus(companyid, projectStatus);
			} else if (masterTypeValue.equalsIgnoreCase("projectsubgroup")) {

				String projectSubGroup = req.getParameter("projectSubGroup");
				int projectGroupId = Integer.parseInt(req.getParameter("groupid"));
				
				CProjectSubGroupDAO.createProjectSubGroup(companyid, projectSubGroup, projectGroupId);
			} 
			else if (masterTypeValue.equalsIgnoreCase("projecttype")) {
				
				String projectType = req.getParameter("projectType");
				
				CProjectTypeDAO.createProjectType(companyid, projectType);
			} else if (masterTypeValue.equalsIgnoreCase("taskactivity")) {

				String taskActivity = req.getParameter("taskActivity");
				
				CTaskActivityDAO.createTaskActivity(companyid, taskActivity);
			} else if (masterTypeValue.equalsIgnoreCase("taskpriority")) {

				String taskPriority = req.getParameter("taskPriority");
				
				CTaskPriorityDAO.createTaskPriority(companyid, taskPriority);
			} else if (masterTypeValue.equalsIgnoreCase("taskstatus")) {

				String taskStatus = req.getParameter("taskStatus");
				
				CTaskStatusDAO.createTaskStatus(companyid, taskStatus);
			} else if (masterTypeValue.equalsIgnoreCase("tasktype")) {

				String taskType = req.getParameter("taskType");
				
				CTaskTypeDAO.createTaskType(companyid, taskType);
			}

		} else if (actionType.equalsIgnoreCase("projectGroupID")) {
			try {
				ArrayList<CProjectGroupDTO> projectGroupID = null;

				projectGroupID = CProjectGroupDAO.getprojectGroupID(companyId);

				resp.setContentType("application/json");
				PrintWriter out = resp.getWriter();
				Gson gson = new Gson();
				out.println(gson.toJson(projectGroupID));
				return;

			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if(actionType.equalsIgnoreCase("populateData")) {
			String masterTypeValue = req.getParameter("masterType");
			int company_id = Integer.parseInt(req.getParameter("company_id"));
			
			if (masterTypeValue.equalsIgnoreCase("customertype")) {
				
				int id = Integer.parseInt(req.getParameter("pkid"));
				
				ArrayList<CCustomerTypeDTO> CustomerTypeList = CCustomerTypeDAO.populateData(id);
				resp.setContentType("application/json");
				Gson gson = new Gson();
				resp.getWriter().write(gson.toJson(CustomerTypeList));
				
			} else if (masterTypeValue.equalsIgnoreCase("department")) {
				
				int id = Integer.parseInt(req.getParameter("pkid"));
				
				ArrayList<CDepartmentDTO> DepartmentList = CDepartmentDAO.populateData(id);
				resp.setContentType("application/json");
				Gson gson = new Gson();
				resp.getWriter().write(gson.toJson(DepartmentList));
				
			} else if (masterTypeValue.equalsIgnoreCase("employeerole")) {
				
				int id = Integer.parseInt(req.getParameter("pkid"));
				
				ArrayList<CEmployeeRoleDTO> EmployeeRoleList = CEmployeeRoleDAO.populateData(id);
				resp.setContentType("application/json");
				Gson gson = new Gson();
				resp.getWriter().write(gson.toJson(EmployeeRoleList));
				
			} else if (masterTypeValue.equalsIgnoreCase("employeestatus")) {
				
				int id = Integer.parseInt(req.getParameter("pkid"));
				
				ArrayList<CEmployeeStatusDTO> EmployeeStatusList = CEmployeeStatusDAO.populateData(id);
				resp.setContentType("application/json");
				Gson gson = new Gson();
				resp.getWriter().write(gson.toJson(EmployeeStatusList));
				
			} else if (masterTypeValue.equalsIgnoreCase("employeetype")) {

				int id = Integer.parseInt(req.getParameter("pkid"));
				
				ArrayList<CEmployeeTypeDTO> EmployeeTypeList = CEmployeeTypeDAO.populateData(id);
				resp.setContentType("application/json");
				Gson gson = new Gson();
				resp.getWriter().write(gson.toJson(EmployeeTypeList));
				
			} else if (masterTypeValue.equalsIgnoreCase("projectgroup")) {
				
				int id = Integer.parseInt(req.getParameter("pkid"));
				
				ArrayList<CProjectGroupDTO> ProjectGroupList = CProjectGroupDAO.populateData(id);
				resp.setContentType("application/json");
				Gson gson = new Gson();
				resp.getWriter().write(gson.toJson(ProjectGroupList));
				
			} else if (masterTypeValue.equalsIgnoreCase("projectstatus")) {

				int id = Integer.parseInt(req.getParameter("pkid"));
				
				ArrayList<CProjectStatusDTO> ProjectStatusList = CProjectStatusDTO.populateData(id);
				resp.setContentType("application/json");
				Gson gson = new Gson();
				resp.getWriter().write(gson.toJson(ProjectStatusList));
				
			} else if (masterTypeValue.equalsIgnoreCase("projectsubgroup")) {

				int id = Integer.parseInt(req.getParameter("pkid"));
				
				ArrayList<CProjectSubGroupDTO> ProjectSubGroupList = CProjectSubGroupDAO.populateData(id);
				resp.setContentType("application/json");
				Gson gson = new Gson();
				resp.getWriter().write(gson.toJson(ProjectSubGroupList));
				
			}
			else if (masterTypeValue.equalsIgnoreCase("projecttype")) {
				
				int id = Integer.parseInt(req.getParameter("pkid"));
				
				ArrayList<CProjectTypeDTO> ProjectTypeList = CProjectTypeDAO.populateData(id);
				resp.setContentType("application/json");
				Gson gson = new Gson();
				resp.getWriter().write(gson.toJson(ProjectTypeList));
				
			} else if (masterTypeValue.equalsIgnoreCase("taskactivity")) {

				int id = Integer.parseInt(req.getParameter("pkid"));
				
				ArrayList<CTaskAcitvityDTO> TaskActivityList = CTaskActivityDAO.populateData(id);
				resp.setContentType("application/json");
				Gson gson = new Gson();
				resp.getWriter().write(gson.toJson(TaskActivityList));
				
			} else if (masterTypeValue.equalsIgnoreCase("taskpriority")) {

				int id = Integer.parseInt(req.getParameter("pkid"));
				
				ArrayList<CTaskPriorityDTO> TaskPriorityList = CTaskPriorityDAO.populateData(id);
				resp.setContentType("application/json");
				Gson gson = new Gson();
				resp.getWriter().write(gson.toJson(TaskPriorityList));
				
			} else if (masterTypeValue.equalsIgnoreCase("taskstatus")) {

				int id = Integer.parseInt(req.getParameter("pkid"));
				
				ArrayList<CTaskStatusDTO> TaskStatusList = CTaskStatusDAO.populateData(id);
				resp.setContentType("application/json");
				Gson gson = new Gson();
				resp.getWriter().write(gson.toJson(TaskStatusList));
				
			} else if (masterTypeValue.equalsIgnoreCase("tasktype")) {

				int id = Integer.parseInt(req.getParameter("pkid"));
				
				ArrayList<CTaskTypeDTO> TaskTypeList = CTaskTypeDAO.populateData(id);
				resp.setContentType("application/json");
				Gson gson = new Gson();
				resp.getWriter().write(gson.toJson(TaskTypeList));
				
			}
			
		} else if(actionType.equalsIgnoreCase("update")) {
			
			String masterTypeValue = req.getParameter("masterType");
			int company_id = Integer.parseInt(req.getParameter("company_id"));
			
			if (masterTypeValue.equalsIgnoreCase("customertype")) {
				
				String cxType = req.getParameter("cxType");
				int id = Integer.parseInt(req.getParameter("id"));
				
				CCustomerTypeDAO.updateCustomerType(cxType, id);
				
			} else if (masterTypeValue.equalsIgnoreCase("department")) {
				
				String department = req.getParameter("department");
				int id = Integer.parseInt(req.getParameter("id"));
				
				CDepartmentDAO.updateDepartmentType(id, department);
				
			} else if (masterTypeValue.equalsIgnoreCase("employeerole")) {
				
				String empRole = req.getParameter("empRole");
				int id = Integer.parseInt(req.getParameter("id"));
				
				CEmployeeRoleDAO.updateEmployeeRole(id, empRole);
				
			} else if (masterTypeValue.equalsIgnoreCase("employeestatus")) {
				
				String empStatus = req.getParameter("empStatus");
				int id = Integer.parseInt(req.getParameter("id"));
				
				CEmployeeStatusDAO.updateEmployeeStatus(id, empStatus);
				
			}  else if (masterTypeValue.equalsIgnoreCase("employeetype")) {

				String empType = req.getParameter("empType");
				int id = Integer.parseInt(req.getParameter("id"));
				
				CEmployeeTypeDAO.updateEmployeeType(id, empType);
				
			} else if (masterTypeValue.equalsIgnoreCase("projectgroup")) {
				
				String projectGroup = req.getParameter("projectGroup");
				int id = Integer.parseInt(req.getParameter("id"));
				
				CProjectGroupDAO.updateProjectGroup(id, projectGroup);
				
			} else if (masterTypeValue.equalsIgnoreCase("projectstatus")) {

				String projectStatus = req.getParameter("projectStatus");
				int id = Integer.parseInt(req.getParameter("id"));
				
				CProjectStatusDAO.updateProjectStatus(id, projectStatus);
				
			} else if (masterTypeValue.equalsIgnoreCase("projectsubgroup")) {

				String projectSubGroup = req.getParameter("projectSubGroup");
				int id = Integer.parseInt(req.getParameter("id"));
				int projectGroupId = Integer.parseInt(req.getParameter("groupid"));
				
				CProjectSubGroupDAO.updateProjectSubGroup(id, projectSubGroup, projectGroupId);
				
			} else if (masterTypeValue.equalsIgnoreCase("projecttype")) {
				
				String projectType = req.getParameter("projectType");
				int id = Integer.parseInt(req.getParameter("id"));
				
				CProjectTypeDAO.updateProjectType(id, projectType);
				
			} else if (masterTypeValue.equalsIgnoreCase("taskactivity")) {

				String taskActivity = req.getParameter("taskActivity");
				int id = Integer.parseInt(req.getParameter("id"));
				
				CTaskActivityDAO.updateTaskActivity(id, taskActivity);
				
			} else if (masterTypeValue.equalsIgnoreCase("taskpriority")) {

				String taskPriority = req.getParameter("taskPriority");
				int id = Integer.parseInt(req.getParameter("id"));
				
				CTaskPriorityDAO.updateTaskPriority(id, taskPriority);
				
			} else if (masterTypeValue.equalsIgnoreCase("taskstatus")) {

				String taskStatus = req.getParameter("taskStatus");
				int id = Integer.parseInt(req.getParameter("id"));
				
				CTaskStatusDAO.updateTaskStatus(id, taskStatus);
				
			} else if (masterTypeValue.equalsIgnoreCase("tasktype")) {

				String taskType = req.getParameter("taskType");
				int id = Integer.parseInt(req.getParameter("id"));
				
				CTaskTypeDAO.updateTaskType(id, taskType);
			}
		}

	}
}

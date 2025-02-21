package com.dakshabhi.pms.api.services;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dakshabhi.pms.api.daos.ProjectsDAO;
import com.dakshabhi.pms.companies.daos.CCompanyDAO;
import com.dakshabhi.pms.companies.dtos.CCompanyDTO;
import com.dakshabhi.pms.customers.dtos.CCustomerDTO;
import com.dakshabhi.pms.masters.daos.CProjectStatusDAO;
import com.dakshabhi.pms.masters.daos.CProjectTypeDAO;
import com.dakshabhi.pms.masters.dtos.CProjectStatusDTO;
import com.dakshabhi.pms.masters.dtos.CProjectTypeDTO;
import com.dakshabhi.pms.projects.daos.CProjectDAO;
import com.dakshabhi.pms.projects.dtos.CProjectDTO;
import com.dakshabhi.pms.projects.dtos.CProjectInfoDTO;
import com.dakshabhi.pms.projectsemployee.daos.CProjectEmployeeDAO;
import com.dakshabhi.pms.projectsemployee.dtos.CProjectEmployeeInfoDTO;
import com.dakshabhi.pms.tasks.daos.CTaskDAO;
import com.dakshabhi.pms.tasks.dtos.CTaskDTO;
import com.dakshabhi.pms.users.dtos.CUserLoginDTO;
import com.dakshabhi.pms.workspace.daos.CtaskLogDAO;
import com.dakshabhi.pms.workspace.dtos.CTaskLogInfoDTO;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

@WebServlet("/api/projects")
public class ProjectAllInfoAPI extends HttpServlet {
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

		if (action_type.equalsIgnoreCase("save")) {
			CProjectDTO objProjectDTO = new CProjectDTO();
			String jsonData = req.getReader().lines().reduce("", (accumulator, actual) -> accumulator + actual);
			JsonObject jsonObject = new JsonParser().parse(jsonData).getAsJsonObject();
			String companyID = jsonObject.get("company_id").getAsString();
			objProjectDTO.setCustomer_id(jsonObject.get("customer_id").getAsInt());
			objProjectDTO.setProject_name(jsonObject.get("project_name").getAsString());
			objProjectDTO.setProject_description(jsonObject.get("project_description").getAsString());
			objProjectDTO.setProject_start_date(jsonObject.get("start_date").getAsString());
			objProjectDTO.setProject_end_date(jsonObject.get("end_date").getAsString());
			objProjectDTO.setProject_status_id(jsonObject.get("project_status").getAsInt());
			objProjectDTO.setProject_code(jsonObject.get("project_code").getAsString());
			objProjectDTO.setProject_type_id(jsonObject.get("project_type").getAsInt());
			objProjectDTO.setCreated_by(jsonObject.get("created_by").getAsInt());
			CProjectDAO cProjectDAO = new CProjectDAO();
			boolean saveProject = cProjectDAO.createNewProject(objProjectDTO, companyID);
			req.setAttribute("updatecompanyDetails", saveProject);
			resp.setContentType("application/json");
			String json = new Gson().toJson(saveProject);
			resp.getWriter().write(json);
			return;

		} else if (action_type.equalsIgnoreCase("getCustomerNameList")) {
			try {
				String companyId = req.getParameter("companyId") == null ? "0" : req.getParameter("companyId");
				ArrayList<CCustomerDTO> cCustomerNameDTO = CProjectDAO.getCustomerNameList(companyId);
				if (cCustomerNameDTO != null) {
					resp.setContentType("application/json");
					String json = new Gson().toJson(cCustomerNameDTO);
					resp.getWriter().write(json);
					return;
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (action_type.equalsIgnoreCase("projectStatusList")) {
			try {
				try {
					ArrayList<CProjectStatusDTO> projectStatusList = null;
					String companyId = req.getParameter("companyId") == null ? "0" : req.getParameter("companyId");
					projectStatusList = CProjectStatusDAO.getProjectStatusList(companyId);

					resp.setContentType("application/json");
					PrintWriter out = resp.getWriter();
					Gson gson = new Gson();
					out.println(gson.toJson(projectStatusList));
					return;
				} catch (Exception e) {
					e.printStackTrace();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (action_type.equalsIgnoreCase("searchData")) {
			CProjectDAO cProjectDAO = new CProjectDAO();
			try {
				CProjectDTO objProjectDTO = new CProjectDTO();
				String jsonData = req.getReader().lines().reduce("", (accumulator, actual) -> accumulator + actual);
				JsonObject jsonObject = new JsonParser().parse(jsonData).getAsJsonObject();
				String companyID = jsonObject.get("company_id").getAsString();
				String customer_id = jsonObject.get("customer_id") != null ? jsonObject.get("customer_id").getAsString()
						: "";
				String project_name = jsonObject.get("project_name") != null
						? jsonObject.get("project_name").getAsString()
						: "";
				String project_status = jsonObject.get("project_status") != null
						? jsonObject.get("project_status").getAsString()
						: "";
				int userID = jsonObject.get("userID").getAsInt();
				if (project_status == null) {
					project_status = "";
				}
				ProjectsDAO ProjectDAO = new ProjectsDAO();
				Map<String, Object> resultMap = new HashMap<>();
				resultMap.put("projectInfoList",
						ProjectDAO.getSearchData(project_name, customer_id, project_status, userID, companyID));
				resultMap.put("projectInfoListSize", ((List<CProjectInfoDTO>) resultMap.get("projectInfoList")).size());

				resp.setContentType("application/json");
				String json = new Gson().toJson(resultMap);
				resp.getWriter().write(json);
				return;

			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (action_type.equalsIgnoreCase("update")) {
			CProjectDTO objProjectDTO = new CProjectDTO();
			String jsonData = req.getReader().lines().reduce("", (accumulator, actual) -> accumulator + actual);
			JsonObject jsonObject = new JsonParser().parse(jsonData).getAsJsonObject();
			System.out.println("jsonObject" + jsonObject);
			objProjectDTO.setCustomer_id(jsonObject.get("customer_id").getAsInt());
			objProjectDTO.setProject_id(jsonObject.get("project_id").getAsInt());
			objProjectDTO.setProject_name(jsonObject.get("project_name").getAsString());
			objProjectDTO.setProject_description(jsonObject.get("project_description").getAsString());
			objProjectDTO.setProject_start_date(jsonObject.get("start_date").getAsString());
			objProjectDTO.setProject_end_date(jsonObject.get("end_date").getAsString());
			objProjectDTO.setProject_status_id(jsonObject.get("project_status").getAsInt());
			objProjectDTO.setProject_code(jsonObject.get("project_code").getAsString());
			objProjectDTO.setProject_type_id(jsonObject.get("project_type").getAsInt());
			if (CProjectDAO.updateProjectDeails(objProjectDTO)) {
				System.out.println("Project update successfully");
				resp.getWriter().write("true");
			} else {
				System.out.println("Project updation failed!!!");
				resp.getWriter().write("false");

			}
			return;

		} else if (action_type.equalsIgnoreCase("projectType")) {
			try {
				String companyId = req.getParameter("companyId") == null ? "0" : req.getParameter("companyId");
				ArrayList<CProjectTypeDTO> projectType = CProjectTypeDAO.getProjectType(companyId);
				resp.setContentType("application/json");
				PrintWriter out = resp.getWriter();
				Gson gson = new Gson();
				out.println(gson.toJson(projectType));
				return;

			} catch (Exception e) {
				e.printStackTrace();
			}

		} else if (action_type.equalsIgnoreCase("getActivityLogList")) {
			CTaskLogInfoDTO CTaskLogInfoDTO = new CTaskLogInfoDTO();
			String jsonData = req.getReader().lines().reduce("", (accumulator, actual) -> accumulator + actual);
			JsonObject jsonObject = new JsonParser().parse(jsonData).getAsJsonObject();
			String searchBy = jsonObject.has("searchBy") ? jsonObject.get("searchBy").getAsString() : "last_sevenDays";
			String start_date = jsonObject.has("filterStartDateid") ? jsonObject.get("filterStartDateid").getAsString()
					: "";
			String end_date = jsonObject.has("filterEndDate") ? jsonObject.get("filterEndDate").getAsString() : "";

			System.out.println(start_date);
			System.out.println(end_date);
			String projectid = jsonObject.has("projectid") ? jsonObject.get("projectid").getAsString() : "0";
			int startIndex = jsonObject.has("startIndex") ? jsonObject.get("startIndex").getAsInt() : 0;
			int endIndex = jsonObject.has("endIndex") ? jsonObject.get("endIndex").getAsInt() : 0;
			String pageNo = jsonObject.has("pageNo") ? jsonObject.get("pageNo").getAsString() : "1";
			CtaskLogDAO logDAO = new CtaskLogDAO();
			ArrayList<CTaskLogInfoDTO> cTaskLogInfoDTOList = logDAO.getTaskLogList(Integer.parseInt(projectid),
					searchBy, start_date, end_date, startIndex, endIndex, pageNo);
			System.out.println(cTaskLogInfoDTOList);
			resp.setContentType("application/json");
			PrintWriter out = resp.getWriter();
			Gson gson = new Gson();
			out.println(gson.toJson(cTaskLogInfoDTOList));
			return;
		} else if (action_type.equalsIgnoreCase("getTaskLogList")) {
			CTaskLogInfoDTO CTaskLogInfoDTO = new CTaskLogInfoDTO();
			String jsonData = req.getReader().lines().reduce("", (accumulator, actual) -> accumulator + actual);
			JsonObject jsonObject = new JsonParser().parse(jsonData).getAsJsonObject();
			String searchBy = jsonObject.has("searchBy") ? jsonObject.get("searchBy").getAsString() : "last_sevenDays";
			String start_date = jsonObject.has("filterStartDateid") ? jsonObject.get("filterStartDateid").getAsString()
					: "";
			String end_date = jsonObject.has("filterEndDate") ? jsonObject.get("filterEndDate").getAsString() : "";

			System.out.println(start_date);
			System.out.println(end_date);
			String projectid = jsonObject.has("projectid") ? jsonObject.get("projectid").getAsString() : "0";
			int startIndex = jsonObject.has("startIndex") ? jsonObject.get("startIndex").getAsInt() : 0;
			int endIndex = jsonObject.has("endIndex") ? jsonObject.get("endIndex").getAsInt() : 0;
			String pageNo = jsonObject.has("pageNo") ? jsonObject.get("pageNo").getAsString() : "1";
			CtaskLogDAO logDAO = new CtaskLogDAO();
			ArrayList<CTaskLogInfoDTO> cTaskLogInfoDTOList = logDAO.getTaskLogList(Integer.parseInt(projectid),
					searchBy, start_date, end_date, startIndex, endIndex, pageNo);
			System.out.println(cTaskLogInfoDTOList);
			resp.setContentType("application/json");
			PrintWriter out = resp.getWriter();
			Gson gson = new Gson();
			out.println(gson.toJson(cTaskLogInfoDTOList));
			return;
		} else if (action_type.equalsIgnoreCase("getprojectmembers")) {
			CProjectEmployeeDAO cProjectEmployeeDAO = new CProjectEmployeeDAO();
			try {
				String jsonData = req.getReader().lines().reduce("", (accumulator, actual) -> accumulator + actual);
				JsonObject jsonObject = new JsonParser().parse(jsonData).getAsJsonObject();
				System.out.println("jsonObject" + jsonObject);
				int userId = jsonObject.get("userId") != null ? Integer.parseInt(jsonObject.get("userId").getAsString())
						: 0;
				String companyId = jsonObject.has("companyId") ? jsonObject.get("companyId").getAsString() : "0";
				String projectid = jsonObject.has("projectid") ? jsonObject.get("projectid").getAsString() : "0";
				String departmentid = jsonObject.has("departmentid") ? jsonObject.get("departmentid").getAsString()
						: "0";
				String listType = jsonObject.has("listType") ? jsonObject.get("listType").getAsString() : "0";

				int startIndex = jsonObject.get("startIndex") != null
						? Integer.parseInt(jsonObject.get("startIndex").getAsString())
						: 0;
				int endIndex = jsonObject.get("endIndex") != null
						? Integer.parseInt(jsonObject.get("endIndex").getAsString())
						: 0;
				String pageNo = jsonObject.has("pageNo") ? jsonObject.get("pageNo").getAsString() : "1";

				ArrayList<CProjectEmployeeInfoDTO> cProjectEmployeeInfoDTO = cProjectEmployeeDAO
						.getProjectEmployeeDetails(projectid, companyId, departmentid, userId, listType, startIndex,
								endIndex, pageNo);
				resp.setContentType("application/json");

				PrintWriter out = resp.getWriter();
				Gson gson = new Gson();
				out.println(gson.toJson(cProjectEmployeeInfoDTO));
				return;
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (action_type.equalsIgnoreCase("tasklist")) {
			CTaskDAO taskDAO = new CTaskDAO();
			String jsonData = req.getReader().lines().reduce("", (accumulator, actual) -> accumulator + actual);
			JsonObject jsonObject = new JsonParser().parse(jsonData).getAsJsonObject();
			System.out.println("jsonObject" + jsonObject);
			String companyId = jsonObject.has("companyId") ? jsonObject.get("companyId").getAsString() : "0";
			String projectId = jsonObject.has("projectId") ? jsonObject.get("projectId").getAsString() : "0";
			String filterTask = jsonObject.has("filterTask") ? jsonObject.get("filterTask").getAsString() : "0";
			String filterStatus = jsonObject.has("filterStatus") ? jsonObject.get("filterStatus").getAsString() : "0";
			String filterAssignee = req.getParameter("filterAssignee") == null ? "0"
					: req.getParameter("filterAssignee");
			int startIndex = jsonObject.get("startIndex") != null
					? Integer.parseInt(jsonObject.get("startIndex").getAsString())
					: 0;
			int endIndex = jsonObject.get("endIndex") != null
					? Integer.parseInt(jsonObject.get("endIndex").getAsString())
					: 0;
			String pageNo = req.getParameter("pageNo") == null ? "1" : req.getParameter("pageNo");
			ArrayList<CTaskDTO> taskList = taskDAO.getTaskListByProject(projectId, filterTask, filterStatus,
					filterAssignee, companyId, startIndex, endIndex, pageNo);
			resp.setContentType("application/json");
			PrintWriter out = resp.getWriter();
			Gson gson = new Gson();
			out.println(gson.toJson(taskList));
			return;

		}
	}
}

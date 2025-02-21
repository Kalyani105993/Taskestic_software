package com.dakshabhi.pms.api.services;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dakshabhi.pms.masters.daos.CTaskPriorityDAO;
import com.dakshabhi.pms.masters.daos.CTaskStatusDAO;
import com.dakshabhi.pms.masters.dtos.CTaskPriorityDTO;
import com.dakshabhi.pms.masters.dtos.CTaskStatusDTO;
import com.dakshabhi.pms.tasks.daos.CTaskDAO;
import com.dakshabhi.pms.tasks.dtos.CTaskDTO;
import com.dakshabhi.pms.users.dtos.CUserLoginDTO;
import com.dakshabhi.pms.workspace.dtos.CTaskLogInfoDTO;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

@WebServlet("/api/workspace")
public class WorkspaceAllAPI extends HttpServlet {
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
		CTaskDAO taskDAO = new CTaskDAO();
		if (action_type.equalsIgnoreCase("mytasklist")) {
			String jsonData = req.getReader().lines().reduce("", (accumulator, actual) -> accumulator + actual);
			JsonObject jsonObject = new JsonParser().parse(jsonData).getAsJsonObject();
			String searchBy = jsonObject.has("searchBy") ? jsonObject.get("searchBy").getAsString() : "last_sevenDays";
			String filterStartDate = jsonObject.has("filterStartDate") ? jsonObject.get("filterStartDate").getAsString()
					: "";
			String filterEndDate = jsonObject.has("filterEndDate") ? jsonObject.get("filterEndDate").getAsString() : "";
			String statusid = jsonObject.has("statusid") ? jsonObject.get("statusid").getAsString() : "";
			String priorityid = jsonObject.has("priorityid") ? jsonObject.get("priorityid").getAsString() : "";
			String projectid = jsonObject.has("projectid") ? jsonObject.get("projectid").getAsString() : "";
			String pageNo = jsonObject.has("pageNo") ? jsonObject.get("pageNo").getAsString() : "1";
			int startIndex = jsonObject.has("startIndex") ? jsonObject.get("startIndex").getAsInt() : 0;
			int endIndex = jsonObject.has("endIndex") ? jsonObject.get("endIndex").getAsInt() : 0;

			String companyId = jsonObject.has("companyId") ? jsonObject.get("companyId").getAsString() : "";
			int user_login_id = jsonObject.has("user_login_id") ? jsonObject.get("user_login_id").getAsInt() : 0;

			boolean isupdated = taskDAO.updateoverduedate(companyId);
			if (isupdated)
				System.out.println("Task Overdue status updated");
			else
				System.out.println("Task Overdue status not updated");
			ArrayList<CTaskDTO> myTaskList = taskDAO.getMyTaskList(user_login_id, statusid, priorityid, projectid,
					companyId, startIndex, endIndex, pageNo, searchBy, filterStartDate, filterEndDate);
			resp.setContentType("application/json");
			PrintWriter out = resp.getWriter();
			Gson gson = new Gson();
			out.println(gson.toJson(myTaskList));
			return;

		} else if (action_type.equalsIgnoreCase("getTaskLog")) {
			String jsonData = req.getReader().lines().reduce("", (accumulator, actual) -> accumulator + actual);
			JsonObject jsonObject = new JsonParser().parse(jsonData).getAsJsonObject();
			String taskid = jsonObject.has("taskId") ? jsonObject.get("taskId").getAsString() : "0";
			String companyId = jsonObject.has("companyId") ? jsonObject.get("companyId").getAsString() : "";
			int startIndex = jsonObject.has("startIndex") ? jsonObject.get("startIndex").getAsInt() : 0;
			int endIndex = jsonObject.has("endIndex") ? jsonObject.get("endIndex").getAsInt() : 0;
			String pageNo = jsonObject.has("pageNo") ? jsonObject.get("pageNo").getAsString() : "1";
			ArrayList<CTaskLogInfoDTO> Taskloglist = taskDAO.gettasklog(companyId, taskid, startIndex, endIndex,
					pageNo);

			resp.setContentType("application/json");
			PrintWriter out = resp.getWriter();
			Gson gson = new Gson();
			out.println(gson.toJson(Taskloglist));
			return;
		} else if (action_type.equalsIgnoreCase("updatestatus")) {

			String jsonData = req.getReader().lines().reduce("", (accumulator, actual) -> accumulator + actual);
			JsonObject jsonObject = new JsonParser().parse(jsonData).getAsJsonObject();
			String statusid = jsonObject.has("statusid") ? jsonObject.get("statusid").getAsString() : "0";
			String taskId = jsonObject.has("taskId") ? jsonObject.get("taskId").getAsString() : "0";
			int userId = jsonObject.has("userId") ? jsonObject.get("userId").getAsInt() : 0;

			boolean isTaskMessageSaved = taskDAO.updateTaskStatus(taskId, statusid, userId);
			resp.setContentType("application/json");
			PrintWriter out = resp.getWriter();
			Gson gson = new Gson();
			if (isTaskMessageSaved)
				out.println(gson.toJson("Success"));
			else
				out.println(gson.toJson("Failure"));
			return;
		} else if (action_type.equalsIgnoreCase("updatepercentage")) {

			String jsonData = req.getReader().lines().reduce("", (accumulator, actual) -> accumulator + actual);
			JsonObject jsonObject = new JsonParser().parse(jsonData).getAsJsonObject();
			String taskcompletionvalue = jsonObject.has("taskcompletionvalue")
					? jsonObject.get("taskcompletionvalue").getAsString()
					: "0";
			String taskId = jsonObject.has("taskId") ? jsonObject.get("taskId").getAsString() : "0";
			int userId = jsonObject.has("userId") ? jsonObject.get("userId").getAsInt() : 0;
			boolean isTaskMessageSaved = taskDAO.updateTaskCompletion(taskcompletionvalue, taskId, userId);
			resp.setContentType("application/json");
			PrintWriter out = resp.getWriter();
			Gson gson = new Gson();
			if (isTaskMessageSaved)
				out.println(gson.toJson("Success"));
			else
				out.println(gson.toJson("Failure"));
			return;
		} else if (action_type.equalsIgnoreCase("taskStatusList")) {
			String companyId = req.getParameter("companyId") == null ? "0" : req.getParameter("companyId");
			ArrayList<CTaskStatusDTO> taskStatusList = CTaskStatusDAO.getTaskStatusLit(companyId);
			resp.setContentType("application/json");
			PrintWriter out = resp.getWriter();
			Gson gson = new Gson();
			out.println(gson.toJson(taskStatusList));
			return;
		} else if (action_type.equalsIgnoreCase("tasksummarybypriority")) {

			String jsonData = req.getReader().lines().reduce("", (accumulator, actual) -> accumulator + actual);
			JsonObject jsonObject = new JsonParser().parse(jsonData).getAsJsonObject();

			String search_by = jsonObject.has("search_by") ? jsonObject.get("search_by").getAsString()
					: "last_3_months";
			String filterStartDateid = jsonObject.has("filterStartDateid")
					? jsonObject.get("filterStartDateid").getAsString()
					: "";
			String filterEndDate = jsonObject.has("filterEndDate") ? jsonObject.get("filterEndDate").getAsString() : "";

			String projectfiler_id = jsonObject.has("projectfiler_id") ? jsonObject.get("projectfiler_id").getAsString()
					: "allproject";

			String companyId = jsonObject.has("companyId") ? jsonObject.get("companyId").getAsString() : "";
			int user_login_id = jsonObject.has("user_login_id") ? jsonObject.get("user_login_id").getAsInt() : 0;

			ArrayList<CTaskPriorityDTO> myTaskSummary = taskDAO.getMyTaskSummaryByPriority(user_login_id, companyId,
					projectfiler_id, search_by, filterStartDateid, filterEndDate);

			resp.setContentType("application/json");
			PrintWriter out = resp.getWriter();
			Gson gson = new Gson();
			out.println(gson.toJson(myTaskSummary));
			return;
		} else if (action_type.equalsIgnoreCase("tasksummarybypriorityonready")) {

			String jsonData = req.getReader().lines().reduce("", (accumulator, actual) -> accumulator + actual);
			JsonObject jsonObject = new JsonParser().parse(jsonData).getAsJsonObject();

			String search_by = jsonObject.has("search_by") ? jsonObject.get("search_by").getAsString()
					: "last_3_months";
			String filterStartDateid = jsonObject.has("filterStartDateid")
					? jsonObject.get("filterStartDateid").getAsString()
					: "";
			String filterEndDate = jsonObject.has("filterEndDate") ? jsonObject.get("filterEndDate").getAsString() : "";

			String projectfiler_id = jsonObject.has("projectfiler_id") ? jsonObject.get("projectfiler_id").getAsString()
					: "allproject";

			String companyId = jsonObject.has("companyId") ? jsonObject.get("companyId").getAsString() : "";
			int user_login_id = jsonObject.has("user_login_id") ? jsonObject.get("user_login_id").getAsInt() : 0;

			ArrayList<CTaskPriorityDTO> myTaskSummary = taskDAO.getMyTaskSummaryByPriorityOnReady(user_login_id,
					companyId, projectfiler_id, search_by, filterStartDateid, filterEndDate);

			resp.setContentType("application/json");
			PrintWriter out = resp.getWriter();
			Gson gson = new Gson();
			out.println(gson.toJson(myTaskSummary));
			return;
		} else if (action_type.equalsIgnoreCase("tasksummaryonready")) {
			String jsonData = req.getReader().lines().reduce("", (accumulator, actual) -> accumulator + actual);
			JsonObject jsonObject = new JsonParser().parse(jsonData).getAsJsonObject();

			String search_by = jsonObject.has("search_by") ? jsonObject.get("search_by").getAsString()
					: "last_3_months";
			String filterStartDateid = jsonObject.has("filterStartDateid")
					? jsonObject.get("filterStartDateid").getAsString()
					: "";
			String filterEndDate = jsonObject.has("filterEndDate") ? jsonObject.get("filterEndDate").getAsString() : "";

			String projectfiler_id = jsonObject.has("projectfiler_id") ? jsonObject.get("projectfiler_id").getAsString()
					: "allproject";

			String companyId = jsonObject.has("companyId") ? jsonObject.get("companyId").getAsString() : "";
			int user_login_id = jsonObject.has("user_login_id") ? jsonObject.get("user_login_id").getAsInt() : 0;

			
		    
			ArrayList<CTaskStatusDTO> myTaskSummary = taskDAO.getMyTaskSummaryOnReadyNew(user_login_id,
					companyId,projectfiler_id,search_by,filterStartDateid, filterEndDate);
			resp.setContentType("application/json");
			PrintWriter out = resp.getWriter();
			Gson gson = new Gson();
			out.println(gson.toJson(myTaskSummary));
			return;
		} else if (action_type.equalsIgnoreCase("tasksummary")) {
			String jsonData = req.getReader().lines().reduce("", (accumulator, actual) -> accumulator + actual);
			JsonObject jsonObject = new JsonParser().parse(jsonData).getAsJsonObject();

			String search_by = jsonObject.has("search_by") ? jsonObject.get("search_by").getAsString()
					: "last_3_months";
			String filterStartDateid = jsonObject.has("filterStartDateid")
					? jsonObject.get("filterStartDateid").getAsString()
					: "";
			String filterEndDate = jsonObject.has("filterEndDate") ? jsonObject.get("filterEndDate").getAsString() : "";

			String projectfiler_id = jsonObject.has("projectfiler_id") ? jsonObject.get("projectfiler_id").getAsString()
					: "allproject";

			String companyId = jsonObject.has("companyId") ? jsonObject.get("companyId").getAsString() : "";
			int user_login_id = jsonObject.has("user_login_id") ? jsonObject.get("user_login_id").getAsInt() : 0;
		    
			ArrayList<CTaskStatusDTO> myTaskSummary = taskDAO.getMyTaskSummary(user_login_id,
					companyId,projectfiler_id,search_by,filterStartDateid, filterEndDate);
			resp.setContentType("application/json");
			PrintWriter out = resp.getWriter();
			Gson gson = new Gson();
			out.println(gson.toJson(myTaskSummary));
			return;
		}
	}
}

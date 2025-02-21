package com.dakshabhi.pms.api.services;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.nio.file.Paths;
import java.util.ArrayList;

import javax.naming.InitialContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import org.json.JSONObject;

import com.dakshabhi.pms.api.daos.ProjectsDAO;
import com.dakshabhi.pms.masters.daos.CTaskActivityDAO;
import com.dakshabhi.pms.masters.daos.CTaskPriorityDAO;
import com.dakshabhi.pms.masters.daos.CTaskStatusDAO;
import com.dakshabhi.pms.masters.dtos.CTaskAcitvityDTO;
import com.dakshabhi.pms.masters.dtos.CTaskPriorityDTO;
import com.dakshabhi.pms.masters.dtos.CTaskStatusDTO;
import com.dakshabhi.pms.tasks.daos.CTaskDAO;
import com.dakshabhi.pms.tasks.dtos.CTaskDTO;
import com.dakshabhi.pms.tasks.dtos.TaskDocumentsDTO;
import com.dakshabhi.pms.users.dtos.CUserLoginDTO;
import com.dakshabhi.pms.workspace.daos.CtaskLogDAO;
import com.dakshabhi.pms.workspace.dtos.CTaskLogDTO;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

@WebServlet("/api/tasks")
public class TaskAllInfoAPI extends HttpServlet {
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
		if (action_type.equalsIgnoreCase("taskPriorityList")) {
			String companyId = req.getParameter("companyId") == null ? "0" : req.getParameter("companyId");
			ArrayList<CTaskPriorityDTO> taskPriorityList = CTaskPriorityDAO.getTaskPriorityList(companyId);
			resp.setContentType("application/json");
			PrintWriter out = resp.getWriter();
			Gson gson = new Gson();
			out.println(gson.toJson(taskPriorityList));
			return;

		} else if (action_type.equalsIgnoreCase("taskStatusList")) {
			String companyId = req.getParameter("companyId") == null ? "0" : req.getParameter("companyId");
			ArrayList<CTaskStatusDTO> taskStatusList = CTaskStatusDAO.getTaskStatusLit(companyId);
			resp.setContentType("application/json");
			PrintWriter out = resp.getWriter();
			Gson gson = new Gson();
			out.println(gson.toJson(taskStatusList));
			return;
		} else if (action_type.equalsIgnoreCase("mytasklist")) {
			String jsonData = req.getReader().lines().reduce("", (accumulator, actual) -> accumulator + actual);
			JsonObject jsonObject = new JsonParser().parse(jsonData).getAsJsonObject();
			String searchBy = jsonObject.has("searchBy") ? jsonObject.get("searchBy").getAsString() : "last_sevenDays";
			String filterStartDate = jsonObject.has("filterStartDateid")
					? jsonObject.get("filterStartDateid").getAsString()
					: "";
			String filterEndDate = jsonObject.has("filterEndDate") ? jsonObject.get("filterEndDate").getAsString() : "";
			String projectid = jsonObject.has("projectid") ? jsonObject.get("projectid").getAsString() : "";
			String priorityid = jsonObject.has("priorityid") ? jsonObject.get("priorityid").getAsString() : "";
			int startIndex = jsonObject.has("startIndex") ? jsonObject.get("startIndex").getAsInt() : 0;
			int endIndex = jsonObject.has("endIndex") ? jsonObject.get("endIndex").getAsInt() : 0;
			String pageNo = jsonObject.has("pageNo") ? jsonObject.get("pageNo").getAsString() : "1";
			String companyId = jsonObject.has("companyId") ? jsonObject.get("companyId").getAsString() : "";
			int user_login_id = jsonObject.has("user_login_id") ? jsonObject.get("user_login_id").getAsInt() : 0;
			String statusid = jsonObject.has("statusid") ? jsonObject.get("statusid").getAsString() : "";

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
		} else if (action_type.equalsIgnoreCase("tasksummaryonready")) {
			String jsonData = req.getReader().lines().reduce("", (accumulator, actual) -> accumulator + actual);
			JsonObject jsonObject = new JsonParser().parse(jsonData).getAsJsonObject();
			String search_by = jsonObject.has("search_by") ? jsonObject.get("search_by").getAsString()
					: "last_sevenDays";
			String filterStartDateid = jsonObject.has("filterStartDateid")
					? jsonObject.get("filterStartDateid").getAsString()
					: "";
			String filterEndDate = jsonObject.has("filterEndDate") ? jsonObject.get("filterEndDate").getAsString() : "";
			String projectfiler_id = jsonObject.has("projectfiler_id") ? jsonObject.get("projectfiler_id").getAsString()
					: "allproject";
			String companyId = jsonObject.has("companyId") ? jsonObject.get("companyId").getAsString() : "";
			int user_login_id = jsonObject.has("user_login_id") ? jsonObject.get("user_login_id").getAsInt() : 0;

			ArrayList<CTaskStatusDTO> myTaskSummary = taskDAO.getMyTaskSummaryOnReadyNew(user_login_id, companyId,
					projectfiler_id, search_by, filterStartDateid, filterEndDate);
			resp.setContentType("application/json");
			PrintWriter out = resp.getWriter();
			Gson gson = new Gson();
			out.println(gson.toJson(myTaskSummary));
			return;
		} else if (action_type.equalsIgnoreCase("sendtaskmessage")) {
			String jsonData = req.getReader().lines().reduce("", (accumulator, actual) -> accumulator + actual);
			JsonObject jsonObject = new JsonParser().parse(jsonData).getAsJsonObject();

			String taskMessage = jsonObject.has("taskMessage") ? jsonObject.get("taskMessage").getAsString() : "";
			String taskId = jsonObject.has("taskId") ? jsonObject.get("taskId").getAsString() : "0";
			int user_login_id = jsonObject.has("user_login_id") ? jsonObject.get("user_login_id").getAsInt() : 0;

			boolean isTaskMessageSaved = taskDAO.saveTaskMessage(taskId, taskMessage, user_login_id);
			resp.setContentType("application/json");
			PrintWriter out = resp.getWriter();
			Gson gson = new Gson();
			if (isTaskMessageSaved)
				out.println(gson.toJson("Success"));
			else
				out.println(gson.toJson("Failure"));
			return;
		} else if (action_type.equalsIgnoreCase("uploadAttachment")) {// block for Upload files
			// CUserLoginDTO cUserLoginDTO = (CUserLoginDTO)
			// req.getSession().getAttribute("userLogin");
			String userLoginName = req.getParameter("userLoginName") == null ? "0" : req.getParameter("userLoginName");
			String taskId = req.getParameter("taskid") == null ? "0" : req.getParameter("taskid");
			int task_id = Integer.parseInt(taskId);
			Part attachmentFile = req.getPart("firstAttachment");
			String discription = req.getParameter("description") == null ? "" : req.getParameter("description");
			TaskDocumentsDTO documentsDTO = null;
			if (attachmentFile != null) {
				String filename = attachmentFile.getSubmittedFileName();
				String uploadPath = "";

				try {
					InitialContext ic = new InitialContext();
					uploadPath = (String) ic.lookup("java:comp/env/documentpath");
					System.out.println(uploadPath);
					String uploadDirectoryPath = uploadPath + "/" + task_id;

					File attachmentFileDirectory = new File(uploadDirectoryPath);
					System.out.println(attachmentFileDirectory);

					if (!attachmentFileDirectory.exists()) {
						if (attachmentFileDirectory.mkdirs()) {
							System.out.println("Attachment Directory is created!");

							FileOutputStream fos = new FileOutputStream(uploadDirectoryPath + "/" + filename);
							InputStream is = attachmentFile.getInputStream();
							byte[] data = new byte[is.available()];
							is.read(data);
							fos.write(data);
							fos.close();
							documentsDTO = new TaskDocumentsDTO();
							documentsDTO.setTask_id(task_id);
							documentsDTO.setDocument_name(filename);
							documentsDTO.setDocumentDiscription(discription);
							documentsDTO.setCreated_by(userLoginName);
							req.getSession().setAttribute("documentsDTO", documentsDTO);
							taskDAO.savefile(documentsDTO);

						}
					} else {
						FileOutputStream fos = new FileOutputStream(uploadDirectoryPath + "/" + filename);
						InputStream is = attachmentFile.getInputStream();
						byte[] data = new byte[is.available()];
						is.read(data);
						fos.write(data);
						fos.close();
						documentsDTO = new TaskDocumentsDTO();
						documentsDTO.setTask_id(task_id);
						documentsDTO.setDocument_name(filename);
						documentsDTO.setDocumentDiscription(discription);
						documentsDTO.setCreated_by(userLoginName);
						req.getSession().setAttribute("documentsDTO", documentsDTO);
						taskDAO.savefile(documentsDTO);
					}

				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			resp.setContentType("application/json");
			PrintWriter out = resp.getWriter();
			Gson gson = new Gson();
			out.println(gson.toJson(documentsDTO));
			return;
//			resp.sendRedirect("updatetask.jsp");
//			return;
		} else if (action_type.equalsIgnoreCase("savetasklog")) {

			String jsonData = req.getReader().lines().reduce("", (accumulator, actual) -> accumulator + actual);
			JsonObject jsonObject = new JsonParser().parse(jsonData).getAsJsonObject();
			String taskId = jsonObject.has("taskId") ? jsonObject.get("taskId").getAsString() : "0";
			String logDate = jsonObject.has("logDate") ? jsonObject.get("logDate").getAsString() : "";
			String taskComment = jsonObject.has("taskComment") ? jsonObject.get("taskComment").getAsString() : "";
			String logHours = jsonObject.has("logHours") ? jsonObject.get("logHours").getAsString() : "0";
			String taskActivityId = jsonObject.has("taskActivityId") ? jsonObject.get("taskActivityId").getAsString()
					: "0";
			int userId = jsonObject.has("userId") ? jsonObject.get("userId").getAsInt() : 0;

			CTaskLogDTO taskLogDTO = new CTaskLogDTO();
			taskLogDTO.setTaskId(Integer.parseInt(taskId));
			taskLogDTO.setLogDate(logDate);
			taskLogDTO.setLogHours(Integer.parseInt(logHours));
			taskLogDTO.setTaskActivityId(Integer.parseInt(taskActivityId));
			taskLogDTO.setTaskComment(taskComment);
			taskLogDTO.setUserId(userId);
			CtaskLogDAO logDAO = new CtaskLogDAO();
			boolean isSaved = logDAO.saveTskLog(taskLogDTO);
			if (isSaved) { // If task log saved..add same entry for communication.
				String taskMessage = "Time Log: " + logHours + " Hours for " + logDate + ". " + taskComment;
				taskDAO.saveTaskMessage(taskId, taskMessage, userId);
				if (req.getSession().getAttribute("documentsDTO") != null) {
					TaskDocumentsDTO documentDTO = (TaskDocumentsDTO) req.getSession().getAttribute("documentsDTO");
					if (taskDAO.saveTaskLogfile(documentDTO, taskLogDTO.getTaskLogId())) {
						System.out.println("document details saved...!");
					} else {
						System.out.println("failed to save document details...!");
					}
					req.getSession().removeAttribute("documentsDTO");
				}
			}
			resp.setContentType("application/json");
			PrintWriter out = resp.getWriter();
			Gson gson = new Gson();
			if (isSaved)
				out.println(gson.toJson("Success"));
			else
				out.println(gson.toJson("Failure"));
			return;

		} else if (action_type.equalsIgnoreCase("createtask")) {

			String jsonData = req.getReader().lines().reduce("", (accumulator, actual) -> accumulator + actual);
			JsonObject jsonObject = new JsonParser().parse(jsonData).getAsJsonObject();
			String assigneeId = jsonObject.has("assigneeId") ? jsonObject.get("assigneeId").getAsString() : "0";
			String taskPriorityId = jsonObject.has("taskPriorityId") ? jsonObject.get("taskPriorityId").getAsString()
					: "0";
			String taskTypeId = jsonObject.has("taskTypeId") ? jsonObject.get("taskTypeId").getAsString() : "0";
			String projectId = jsonObject.has("projectId") ? jsonObject.get("projectId").getAsString() : "0";
			String taskStatusId = jsonObject.has("taskStatusId") ? jsonObject.get("taskStatusId").getAsString() : "0";
			String taskDescription = jsonObject.has("taskDescription") ? jsonObject.get("taskDescription").getAsString()
					: "";
			String companyId = jsonObject.has("companyId") ? jsonObject.get("companyId").getAsString() : "";
			int user_login_id = jsonObject.has("user_login_id") ? jsonObject.get("user_login_id").getAsInt() : 0;
			String taskName = jsonObject.has("taskName") ? jsonObject.get("taskName").getAsString() : "";
			String startDate = jsonObject.has("startDate") ? jsonObject.get("startDate").getAsString() : "0000-00-00";
			String dueDateTime = jsonObject.has("dueDateTime") ? jsonObject.get("dueDateTime").getAsString() : "0000-00-00 00:00";
			String taskEstimatedTime = jsonObject.has("taskEstimatedTime") ? jsonObject.get("taskEstimatedTime").getAsString() : "0";
			String taskCompletionValue = jsonObject.has("taskCompletionValue") ? jsonObject.get("taskCompletionValue").getAsString() : "0";
			String taskFollower_Ids = jsonObject.has("taskFollower_Ids") ? jsonObject.get("taskFollower_Ids").getAsString() : "0";

		
			System.out.println("taskFollowersList: " + taskFollower_Ids);
			String due_Date = dueDateTime;
			String[] arrStr = due_Date.split("T");
			String dueDate = arrStr[0];

			CTaskDTO taskDTO = new CTaskDTO();
			taskDTO.setProjectId(Integer.parseInt(projectId));
			taskDTO.setTaskName(taskName);
			taskDTO.setTaskDescription(taskDescription);
			taskDTO.setTaskStatusId(Integer.parseInt(taskStatusId));
			taskDTO.setTaskTypeId(Integer.parseInt(taskTypeId));
			taskDTO.setTaskPriorityId(Integer.parseInt(taskPriorityId));
			taskDTO.setAssigneeId(Integer.parseInt(assigneeId));
			taskDTO.setStartDate(startDate);
			taskDTO.setDueDate(dueDate);
			taskDTO.setDueDateTime(dueDateTime);
			taskDTO.setTaskEstimatedTime(Integer.parseInt(taskEstimatedTime));
			taskDTO.setTaskCompletionValue(Integer.parseInt(taskCompletionValue));
			taskDTO.setUserId(user_login_id);
			taskDTO.setFollowers(taskFollower_Ids);
			ProjectsDAO projectsDAO=new ProjectsDAO();
			boolean isTaskCreated = projectsDAO.createNewTask(taskDTO, companyId);
			resp.setContentType("application/json");
			PrintWriter out = resp.getWriter();
			Gson gson = new Gson();
			if (isTaskCreated)
				out.println(gson.toJson("Success"));
			else
				out.println(gson.toJson("Failure"));
			return;
		}else if (action_type.equalsIgnoreCase("taskActivityList")) {
			String companyId = req.getParameter("companyId")==null?"0":req.getParameter("companyId");
			ArrayList<CTaskAcitvityDTO> taskActivityList = CTaskActivityDAO.getTaskActivityList(companyId);
			resp.setContentType("application/json");
			PrintWriter out = resp.getWriter();
			Gson gson = new Gson();
			out.println(gson.toJson(taskActivityList));
			return;
		}
	}
}

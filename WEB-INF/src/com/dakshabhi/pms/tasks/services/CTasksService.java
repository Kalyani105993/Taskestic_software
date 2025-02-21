package com.dakshabhi.pms.tasks.services;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.activation.MimetypesFileTypeMap;
import javax.naming.InitialContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.dakshabhi.common.constants.ConfigConstants;
import com.dakshabhi.pms.tasks.daos.CTaskDAO;
import com.dakshabhi.pms.tasks.dtos.CTaskDTO;
import com.dakshabhi.pms.tasks.dtos.CTaskMessageDTO;
import com.dakshabhi.pms.tasks.dtos.TaskDocumentsDTO;
import com.dakshabhi.pms.users.dtos.CUserLoginDTO;
import com.google.gson.Gson;

@WebServlet(value = "/tasks")
@MultipartConfig
public class CTasksService extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String actionType = req.getParameter("actionType") == null ? "" : req.getParameter("actionType");
		String companyId = ConfigConstants.getCompanyID(req.getSession());
		CTaskDAO taskDAO = new CTaskDAO();
		if (actionType.equalsIgnoreCase("createtask")) {
			CUserLoginDTO cUserLoginDTO = (CUserLoginDTO) req.getSession().getAttribute("userLogin");
			String projectId = req.getParameter("projectId") == null ? "0" : req.getParameter("projectId");
			String taskName = req.getParameter("taskName") == null ? "" : req.getParameter("taskName");
			String taskDescription = req.getParameter("taskDescription") == null ? ""
					: req.getParameter("taskDescription");
			String taskStatusId = req.getParameter("taskStatusId") == null ? "0" : req.getParameter("taskStatusId");
			String taskTypeId = req.getParameter("taskTypeId") == null ? "0" : req.getParameter("taskTypeId");
			String taskPriorityId = req.getParameter("taskPriorityId") == null ? "0"
					: req.getParameter("taskPriorityId");
			String assigneeId = req.getParameter("assigneeId") == null ? "0" : req.getParameter("assigneeId");
			String startDate = req.getParameter("startDate") == "" ? "0000-00-00" : req.getParameter("startDate");
			String dueDateTime = req.getParameter("dueDateTime") == "" ? "0000-00-00 00:00"
					: req.getParameter("dueDateTime");
			String taskEstimatedTime = req.getParameter("taskEstimatedTime") == "" ? "0"
					: req.getParameter("taskEstimatedTime");
			String taskCompletionValue = req.getParameter("taskCompletionValue") == null ? "0"
					: req.getParameter("taskCompletionValue");

			String taskFollower_Ids = req.getParameter("taskfollowers") == null ? "0"
					: req.getParameter("taskfollowers");
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
			taskDTO.setUserId(cUserLoginDTO.getUser_login_id());
			taskDTO.setFollowers(taskFollower_Ids);

			boolean isTaskCreated = taskDAO.createNewTask(taskDTO, companyId);
			resp.setContentType("application/json");
			PrintWriter out = resp.getWriter();
			Gson gson = new Gson();
			if (isTaskCreated)
				out.println(gson.toJson("Success"));
			else
				out.println(gson.toJson("Failure"));
			return;
		} else if (actionType.equalsIgnoreCase("tasklist")) {
			String projectId = req.getParameter("projectId") == null ? "0" : req.getParameter("projectId");
			String filterTask = req.getParameter("filterTask") == null ? "" : req.getParameter("filterTask");
			String filterStatus = req.getParameter("filterStatus") == null ? "" : req.getParameter("filterStatus");
			String filterAssignee = req.getParameter("filterAssignee") == null ? "0"
					: req.getParameter("filterAssignee");
			int startIndex = Integer.parseInt(req.getParameter("startIndex"));
			int endIndex = Integer.parseInt(req.getParameter("endIndex"));
			String pageNo = req.getParameter("pageNo") == null ? "1" : req.getParameter("pageNo");
			ArrayList<CTaskDTO> taskList = taskDAO.getTaskListByProject(projectId, filterTask, filterStatus,
					filterAssignee, companyId, startIndex, endIndex, pageNo);
			resp.setContentType("application/json");
			PrintWriter out = resp.getWriter();
			Gson gson = new Gson();
			out.println(gson.toJson(taskList));
			return;

		} else if (actionType.equalsIgnoreCase("taskdetails")) {
			String taskId = req.getParameter("taskId") == null ? "0" : req.getParameter("taskId");
			CTaskDTO taskDTO = taskDAO.getTaskDetails(taskId);
			resp.setContentType("application/json");
			PrintWriter out = resp.getWriter();
			Gson gson = new Gson();
			out.println(gson.toJson(taskDTO));
			return;

		} else if (actionType.equalsIgnoreCase("updatetask")) {
			CUserLoginDTO cUserLoginDTO = (CUserLoginDTO) req.getSession().getAttribute("userLogin");
			String taskId = req.getParameter("taskId") == null ? "0" : req.getParameter("taskId");
			String taskName = req.getParameter("taskName") == null ? "" : req.getParameter("taskName");
			String taskDescription = req.getParameter("taskDescription") == null ? ""
					: req.getParameter("taskDescription");
			String taskStatusId = req.getParameter("taskStatusId") == null ? "0" : req.getParameter("taskStatusId");
			String taskTypeId = req.getParameter("taskTypeId") == null ? "0" : req.getParameter("taskTypeId");
			String taskPriorityId = req.getParameter("taskPriorityId") == null ? "0"
					: req.getParameter("taskPriorityId");
			String assigneeId = req.getParameter("assigneeId") == null ? "0" : req.getParameter("assigneeId");
			String startDate = req.getParameter("startDate") == "" ? "0000-00-00" : req.getParameter("startDate");
			String dueDateTime = req.getParameter("dueDateTime") == "" ? "0000-00-00 00:00"
					: req.getParameter("dueDateTime");
			String taskEstimatedTime = req.getParameter("taskEstimatedTime") == "" ? "0"
					: req.getParameter("taskEstimatedTime");
			String taskCompletionValue = req.getParameter("taskCompletionValue") == null ? "0"
					: req.getParameter("taskCompletionValue");
			String taskFollower_Ids = req.getParameter("taskfollowers") == null ? "0"
					: req.getParameter("taskfollowers");
			System.out.println("taskFollowersList: " + taskFollower_Ids);

			String due_Date = dueDateTime;
			String[] arrStr = due_Date.split("T");
			String dueDate = arrStr[0];

			CTaskDTO taskDTO = new CTaskDTO();
			taskDTO.setTaskId(Integer.parseInt(taskId));
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
			taskDTO.setUserId(cUserLoginDTO.getUser_login_id());
			taskDTO.setFollowers(taskFollower_Ids);

			boolean isTaskUpdated = taskDAO.updateTask(taskDTO);
			resp.setContentType("application/json");
			PrintWriter out = resp.getWriter();
			Gson gson = new Gson();
			if (isTaskUpdated)
				out.println(gson.toJson("Success"));
			else
				out.println(gson.toJson("Failure"));
			return;

		} else if (actionType.equalsIgnoreCase("deletetask")) {
			CUserLoginDTO cUserLoginDTO = (CUserLoginDTO) req.getSession().getAttribute("userLogin");
			String taskId = req.getParameter("taskId") == null ? "0" : req.getParameter("taskId");

			CTaskDTO taskDTO = new CTaskDTO();
			taskDTO.setTaskId(Integer.parseInt(taskId));
			taskDTO.setUserId(cUserLoginDTO.getUser_employee_id());

			boolean isTaskDeleted = taskDAO.deleteTask(taskDTO);
			resp.setContentType("application/json");
			PrintWriter out = resp.getWriter();
			Gson gson = new Gson();
			if (isTaskDeleted)
				out.println(gson.toJson("Success"));
			else
				out.println(gson.toJson("Failure"));
			return;
		} else if (actionType.equalsIgnoreCase("sendtaskmessage")) {
			CUserLoginDTO cUserLoginDTO = (CUserLoginDTO) req.getSession().getAttribute("userLogin");
			String taskId = req.getParameter("taskId") == null ? "0" : req.getParameter("taskId");
			String taskMessage = req.getParameter("taskMessage") == null ? "" : req.getParameter("taskMessage");
			boolean isTaskMessageSaved = taskDAO.saveTaskMessage(taskId, taskMessage, cUserLoginDTO.getUser_login_id());
			resp.setContentType("application/json");
			PrintWriter out = resp.getWriter();
			Gson gson = new Gson();
			if (isTaskMessageSaved)
				out.println(gson.toJson("Success"));
			else
				out.println(gson.toJson("Failure"));
			return;
		} else if (actionType.equalsIgnoreCase("taskmessagelist")) {
			String taskId = req.getParameter("taskId") == null ? "0" : req.getParameter("taskId");
			ArrayList<CTaskMessageDTO> taskMessageList = taskDAO.getTaskMessagesList(taskId);
			resp.setContentType("application/json");
			PrintWriter out = resp.getWriter();
			Gson gson = new Gson();
			out.println(gson.toJson(taskMessageList));
			return;
		} else if (actionType.equalsIgnoreCase("updatetaskmessage")) {
			String taskMsgId = req.getParameter("taskMsgId") == null ? "0" : req.getParameter("taskMsgId");
			String taskMessage = req.getParameter("taskMessage") == null ? "" : req.getParameter("taskMessage");
			boolean isTaskMessageUpdate = taskDAO.updateTaskMessage(taskMsgId, taskMessage);
			resp.setContentType("application/json");
			PrintWriter out = resp.getWriter();
			Gson gson = new Gson();
			if (isTaskMessageUpdate)
				out.println(gson.toJson("Success"));
			else
				out.println(gson.toJson("Failure"));
			return;
		} else if (actionType.equalsIgnoreCase("deletetaskmessage")) {
			String taskMsgId = req.getParameter("taskMsgId") == null ? "0" : req.getParameter("taskMsgId");
			String deletedBy = req.getParameter("deletedBy") == null ? "0" : req.getParameter("deletedBy");
			boolean isTaskMessageUpdate = taskDAO.deleteTaskMessage(taskMsgId, deletedBy);
			resp.setContentType("application/json");
			PrintWriter out = resp.getWriter();
			Gson gson = new Gson();
			if (isTaskMessageUpdate)
				out.println(gson.toJson("Success"));
			else
				out.println(gson.toJson("Failure"));
			return;
		} else if (actionType.equalsIgnoreCase("updatestatus")) {
			CUserLoginDTO cUserLoginDTO = (CUserLoginDTO) req.getSession().getAttribute("userLogin");
			String taskId = req.getParameter("taskId") == null ? "0" : req.getParameter("taskId");
			String statusid = req.getParameter("statusid") == null ? "0" : req.getParameter("statusid");
			boolean isTaskMessageSaved = taskDAO.updateTaskStatus(taskId, statusid, cUserLoginDTO.getUser_login_id());
			resp.setContentType("application/json");
			PrintWriter out = resp.getWriter();
			Gson gson = new Gson();
			if (isTaskMessageSaved)
				out.println(gson.toJson("Success"));
			else
				out.println(gson.toJson("Failure"));
			return;
		} else if (actionType.equalsIgnoreCase("updatepercentage")) {
			CUserLoginDTO cUserLoginDTO = (CUserLoginDTO) req.getSession().getAttribute("userLogin");
			String taskId = req.getParameter("taskId") == null ? "0" : req.getParameter("taskId");
			String taskcompletionvalue = req.getParameter("taskcompletionvalue") == null ? "0"
					: req.getParameter("taskcompletionvalue");
			boolean isTaskMessageSaved = taskDAO.updateTaskCompletion(taskcompletionvalue, taskId,
					cUserLoginDTO.getUser_login_id());
			resp.setContentType("application/json");
			PrintWriter out = resp.getWriter();
			Gson gson = new Gson();
			if (isTaskMessageSaved)
				out.println(gson.toJson("Success"));
			else
				out.println(gson.toJson("Failure"));
			return;
		} else if (actionType.equalsIgnoreCase("mymessagelist")) {
			CUserLoginDTO cUserLoginDTO = (CUserLoginDTO) req.getSession().getAttribute("userLogin");
			String searchBy = req.getParameter("searchBy") == "" ? "last_sevenDays" : req.getParameter("searchBy");
			System.out.println(searchBy);
			String start_date = req.getParameter("filterStartDateid") == null ? "" : req.getParameter("filterStartDateid");
			String end_date = req.getParameter("filterEndDate") == null ? "" : req.getParameter("filterEndDate");
			System.out.println(start_date);
			System.out.println(end_date);
			ArrayList<CTaskMessageDTO> taskMessageList = taskDAO.getMyTaskMessagesList(cUserLoginDTO.getUser_login_id(),searchBy,start_date,end_date);
			resp.setContentType("application/json");
			PrintWriter out = resp.getWriter();
			Gson gson = new Gson();
			out.println(gson.toJson(taskMessageList));
			return;
		}else if (actionType.equalsIgnoreCase("uploadAttachment")) {//block for Upload files 
			CUserLoginDTO cUserLoginDTO = (CUserLoginDTO) req.getSession().getAttribute("userLogin");
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
							documentsDTO.setCreated_by(cUserLoginDTO.getUser_full_name());
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
						documentsDTO.setCreated_by(cUserLoginDTO.getUser_full_name());
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
		} else if (actionType.equalsIgnoreCase("documentList")) {//block for get document List 

			String taskId = req.getParameter("taskid") == null ? "0" : req.getParameter("taskid");
			int task_id = Integer.parseInt(taskId);
			String list_type = req.getParameter("isadditional") == null ? "0" : req.getParameter("isadditional");
			if (!list_type.equalsIgnoreCase("0")) {
				TaskDocumentsDTO docList = taskDAO.getupdatedocument(task_id);
				resp.setContentType("application/json");
				PrintWriter out = resp.getWriter();
				Gson gson = new Gson();
				out.println(gson.toJson(docList));
			} else {
				ArrayList<TaskDocumentsDTO> docList = taskDAO.documentList(task_id);
				resp.setContentType("application/json");
				PrintWriter out = resp.getWriter();
				Gson gson = new Gson();
				out.println(gson.toJson(docList));
			}

		} else if (actionType.equalsIgnoreCase("deleteAttachment")) {//block for delete file 
			String document_id = req.getParameter("document_id") == null ? "0" : req.getParameter("document_id");
			int documentId = Integer.parseInt(document_id);

			boolean is_deleted = taskDAO.deleteFile(documentId);
			resp.setContentType("application/json");
			PrintWriter out = resp.getWriter();
			Gson gson = new Gson();
			if (is_deleted) {
				System.out.println(documentId + "Document Id File is deleted");
				out.println(gson.toJson("Success"));
			} else
				out.println(gson.toJson("Failure"));
			return;
		} else if (actionType.equalsIgnoreCase("viewAttachment")) {//block for view file 
			String taskId = req.getParameter("taskid") == null ? "0" : req.getParameter("taskid");
			int task_id = Integer.parseInt(taskId);
			String documentId = req.getParameter("documentId") == null ? "0" : req.getParameter("documentId");
			int document_Id = Integer.parseInt(documentId);
			String isadditionaldoc = req.getParameter("isadditional") == null ? "0" : req.getParameter("isadditional");
			String filename = req.getParameter("filename") == null ? "" : req.getParameter("filename");
			if (filename.equals("")) {//it means new file uploaded which does not yet saved in table
				filename = taskDAO.getFileName(task_id, document_Id);
			}

			try {
				String attachmentPath = "";
				
				if (!isadditionaldoc.equals("0")) {//path for tasklog files
					attachmentPath = "/uploads/document/" + task_id + "/update/" + filename;
				} else {//path for edit task files
					attachmentPath = "/uploads/document/" + task_id + "/" + filename;
				}
				System.out.println(attachmentPath);
				resp.setContentType("application/json");
				PrintWriter out = resp.getWriter();
				Gson gson = new Gson();
				out.println(gson.toJson(attachmentPath));

			} catch (Exception e) {
				e.printStackTrace();
			}
			return;
		} else if (actionType.equalsIgnoreCase("downloadAttachment")) { //block for download file 
			String taskId = req.getParameter("taskid") == null ? "0" : req.getParameter("taskid");
			int task_id = Integer.parseInt(taskId);
			String isadditionaldoc = req.getParameter("isadditional") == null ? "0" : req.getParameter("isadditional");
			String document_Name = req.getParameter("document_name") == null ? "" : req.getParameter("document_name");

			String uploadPath = "";

			try {

				InitialContext ic = new InitialContext();
				uploadPath = (String) ic.lookup("java:comp/env/documentpath");
				String attachmentPath = "";
				if (!isadditionaldoc.equals("0")) {
					attachmentPath = uploadPath + task_id + "/update/" + document_Name;

				} else {
					attachmentPath = uploadPath + task_id + "/" + document_Name;
				}
				System.out.println(attachmentPath);
				File file = new File(attachmentPath);

				MimetypesFileTypeMap mimeTypesMap = new MimetypesFileTypeMap();
				String mimeType = mimeTypesMap.getContentType(document_Name);

				resp.setContentType(mimeType);
				resp.setHeader("Content-disposition", "attachment; filename=" + document_Name);

				OutputStream out = resp.getOutputStream();
				FileInputStream in = new FileInputStream(file);
				byte[] buffer = new byte[in.available()];
				int length;
				while ((length = in.read(buffer)) > 0) {
					out.write(buffer, 0, length);
				}
				in.close();
				out.flush();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

	}
}
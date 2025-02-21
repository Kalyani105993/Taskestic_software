package com.dakshabhi.pms.workspace.services;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.naming.InitialContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.dakshabhi.common.constants.ConfigConstants;
import com.dakshabhi.pms.masters.dtos.CTaskPriorityDTO;
import com.dakshabhi.pms.masters.dtos.CTaskStatusDTO;
import com.dakshabhi.pms.tasks.daos.CTaskDAO;
import com.dakshabhi.pms.tasks.dtos.CTaskDTO;
import com.dakshabhi.pms.tasks.dtos.TaskDocumentsDTO;
import com.dakshabhi.pms.users.dtos.CUserLoginDTO;
import com.dakshabhi.pms.workspace.daos.CtaskLogDAO;
import com.dakshabhi.pms.workspace.dtos.CTaskLogDTO;
import com.dakshabhi.pms.workspace.dtos.CTaskLogInfoDTO;
import com.google.gson.Gson;

@WebServlet("/workspace")
@MultipartConfig
public class CWorkspaceService extends HttpServlet {
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
		String companyID = req.getSession().getAttribute("companyID")==null?"":(String) req.getSession().getAttribute("companyID");
		CTaskDAO taskDAO = new CTaskDAO();
		CUserLoginDTO cUserLoginDTO = (CUserLoginDTO) req.getSession().getAttribute("userLogin");
		String actionType = req.getParameter("actionType") == null ? "" : req.getParameter("actionType");
		String companyId = ConfigConstants.getCompanyID(req.getSession());
		if (actionType.equalsIgnoreCase("mytasklist")) {
			String statusid = req.getParameter("statusid") == null ? "" : req.getParameter("statusid");
			String priorityid = req.getParameter("priorityid") == null ? "" : req.getParameter("priorityid");
			String projectid = req.getParameter("projectid") == null ? "" : req.getParameter("projectid");
			String searchBy = req.getParameter("searchBy") == null ? "" : req.getParameter("searchBy");
			String filterStartDate = req.getParameter("from_date") == null ? "" : req.getParameter("from_date");
			String filterEndDate = req.getParameter("to_date") == null ? "" : req.getParameter("to_date");
			int startIndex = Integer.parseInt(req.getParameter("startIndex"));
			int endIndex = Integer.parseInt(req.getParameter("endIndex"));
			String pageNo = req.getParameter("pageNo") == null ? "1" : req.getParameter("pageNo");        
			boolean isupdated = taskDAO.updateoverduedate(companyID);
			if(isupdated)
				System.out.println("Task Overdue status updated");
			else
				System.out.println("Task Overdue status not updated");
			ArrayList<CTaskDTO> myTaskList = taskDAO.getMyTaskList(cUserLoginDTO.getUser_login_id(), statusid,
					priorityid, projectid, companyId, startIndex, endIndex, pageNo,searchBy,filterStartDate,filterEndDate);
			resp.setContentType("application/json");
			PrintWriter out = resp.getWriter();
			Gson gson = new Gson();
			out.println(gson.toJson(myTaskList));
			return;
		} else if (actionType.equalsIgnoreCase("tasksummary")) {
			String projectfiler_id = req.getParameter("projectfiler_id") == "" ? "allproject" :req.getParameter("projectfiler_id");
			String search_by = req.getParameter("search_by")== "" ? "last_3_months" :req.getParameter("search_by");
			String filterStartDateid = req.getParameter("from_date") == "" ? "" :req.getParameter("from_date");
		    String filterEndDate = req.getParameter("to_date") == "" ? "" :req.getParameter("to_date");
		    
			ArrayList<CTaskStatusDTO> myTaskSummary = taskDAO.getMyTaskSummary(cUserLoginDTO.getUser_login_id(),
					companyId,projectfiler_id,search_by,filterStartDateid, filterEndDate);
			resp.setContentType("application/json");
			PrintWriter out = resp.getWriter();
			Gson gson = new Gson();
			out.println(gson.toJson(myTaskSummary));
			return;
		} else if (actionType.equalsIgnoreCase("tasksummaryonready")) {

			String projectfiler_id = req.getParameter("projectfiler_id") == "" ? "allproject" :req.getParameter("projectfiler_id");
			String search_by = req.getParameter("search_by")== "" ? "last_3_months" :req.getParameter("search_by");
			String filterStartDateid = req.getParameter("from_date") == "" ? "" :req.getParameter("from_date");
		    String filterEndDate = req.getParameter("to_date") == "" ? "" :req.getParameter("to_date");
		    
			ArrayList<CTaskStatusDTO> myTaskSummary = taskDAO.getMyTaskSummaryOnReadyNew(cUserLoginDTO.getUser_login_id(),
					companyId,projectfiler_id,search_by,filterStartDateid, filterEndDate);
			resp.setContentType("application/json");
			PrintWriter out = resp.getWriter();
			Gson gson = new Gson();
			out.println(gson.toJson(myTaskSummary));
			return;
		} else if (actionType.equalsIgnoreCase("createdtasklist")) {
			ArrayList<CTaskDTO> myTaskList = taskDAO.getCreatedTaskList(cUserLoginDTO.getUser_login_id(), companyId);
			resp.setContentType("application/json");
			PrintWriter out = resp.getWriter();
			Gson gson = new Gson();
			out.println(gson.toJson(myTaskList));
			return;
		} else if (actionType.equalsIgnoreCase("savetasklog")) {
			String taskId = req.getParameter("taskId") == null ? "0" : req.getParameter("taskId");
			String logDate = req.getParameter("logDate") == null ? "" : req.getParameter("logDate");
			String taskComment = req.getParameter("taskComment") == null ? "" : req.getParameter("taskComment");
			String logHours = req.getParameter("logHours") == null ? "0" : req.getParameter("logHours");
			String taskActivityId = req.getParameter("taskActivityId") == null ? "0"
					: req.getParameter("taskActivityId");
			CTaskLogDTO taskLogDTO = new CTaskLogDTO();
			taskLogDTO.setTaskId(Integer.parseInt(taskId));
			taskLogDTO.setLogDate(logDate);
			taskLogDTO.setLogHours(Integer.parseInt(logHours));
			taskLogDTO.setTaskActivityId(Integer.parseInt(taskActivityId));
			taskLogDTO.setTaskComment(taskComment);
			taskLogDTO.setUserId(cUserLoginDTO.getUser_login_id());
			CtaskLogDAO logDAO = new CtaskLogDAO();
			boolean isSaved = logDAO.saveTskLog(taskLogDTO);
			if (isSaved) { // If task log saved..add same entry for communication.
				String taskMessage = "Time Log: " + logHours + " Hours for " + logDate + ". " + taskComment;
				taskDAO.saveTaskMessage(taskId, taskMessage, cUserLoginDTO.getUser_login_id());
				if(req.getSession().getAttribute("documentsDTO")!=null) {
					TaskDocumentsDTO documentDTO = (TaskDocumentsDTO) req.getSession().getAttribute("documentsDTO");
					if(taskDAO.saveTaskLogfile(documentDTO,taskLogDTO.getTaskLogId())) {
						System.out.println("document details saved...!");
					}else {
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

		}else if (actionType.equalsIgnoreCase("updateAttachment")) {// block for upload additional file from AddLog modal
			CUserLoginDTO cUserLoginDTOs = (CUserLoginDTO) req.getSession().getAttribute("userLogin");
			String taskId = req.getParameter("task_id") == null ? "0" : req.getParameter("task_id");
			int task_id = Integer.parseInt(taskId);
			Part attachmentFile = req.getPart("updateAttachment");
			String discription = req.getParameter("discription") == null ? ""
					: req.getParameter("discription");
			int is_additional = 1;
			TaskDocumentsDTO documentsDTO = null;
			if (attachmentFile != null) {
				String filename = attachmentFile.getSubmittedFileName();
				
				String uploadPath = "";
				
				try {
					InitialContext ic = new InitialContext();
					uploadPath = (String) ic.lookup("java:comp/env/documentpath"); 
					System.out.println(uploadPath);
					String uploadDirectoryPath = uploadPath + "/" + task_id + "/update";

					File attachmentFileDirectory = new File(uploadDirectoryPath);
					System.out.println(attachmentFileDirectory);

					if (!attachmentFileDirectory.exists()) {
						if (attachmentFileDirectory.mkdirs()) {

							FileOutputStream fos = new FileOutputStream(uploadDirectoryPath + "/" + filename);
							InputStream is = attachmentFile.getInputStream();
							byte[] data = new byte[is.available()];
							is.read(data);
							fos.write(data);
							fos.close();
							req.getSession().removeAttribute("documentsDTO");
							documentsDTO = new TaskDocumentsDTO();
							documentsDTO.setTask_id(task_id);
							documentsDTO.setDocument_name(filename);
							documentsDTO.setDocumentDiscription(discription);
							documentsDTO.setCreated_by(cUserLoginDTOs.getUser_full_name());
							documentsDTO.setIsadditional_doc(is_additional);
							req.getSession().setAttribute("documentsDTO", documentsDTO);
						}
					} else {
						FileOutputStream fos = new FileOutputStream(uploadDirectoryPath + "/" + filename);
						InputStream is = attachmentFile.getInputStream();
						byte[] data = new byte[is.available()];
						is.read(data);
						fos.write(data);
						fos.close();
						req.getSession().removeAttribute("documentsDTO");
						documentsDTO = new TaskDocumentsDTO();
						documentsDTO.setTask_id(task_id);
						documentsDTO.setDocument_name(filename);
						documentsDTO.setDocumentDiscription(discription);
						documentsDTO.setCreated_by(cUserLoginDTOs.getUser_full_name());
						documentsDTO.setIsadditional_doc(is_additional);
						req.getSession().setAttribute("documentsDTO", documentsDTO);
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
		}   else if (actionType.equalsIgnoreCase("getActivityLogList")) {
			String searchBy = req.getParameter("searchBy") == "" ? "last_sevenDays" : req.getParameter("searchBy");
			System.out.println(searchBy);
			String start_date = req.getParameter("filterStartDateid") == null ? ""
					: req.getParameter("filterStartDateid");
			String end_date = req.getParameter("filterEndDate") == null ? "" : req.getParameter("filterEndDate");
			System.out.println(start_date);
			System.out.println(end_date);
			String projectid = req.getParameter("projectid") == null ? "0" : req.getParameter("projectid");
			int startIndex = Integer.parseInt(req.getParameter("startIndex"));
			int endIndex = Integer.parseInt(req.getParameter("endIndex"));
			String pageNo = req.getParameter("pageNo") == null ? "1" : req.getParameter("pageNo");
			CtaskLogDAO logDAO = new CtaskLogDAO();
			ArrayList<CTaskLogInfoDTO> cTaskLogInfoDTOList = logDAO.getTaskLogList(Integer.parseInt(projectid),
					searchBy, start_date, end_date, startIndex, endIndex, pageNo);
			System.out.println(cTaskLogInfoDTOList);
			resp.setContentType("application/json");
			PrintWriter out = resp.getWriter();
			Gson gson = new Gson();
			out.println(gson.toJson(cTaskLogInfoDTOList));
			return;
		} else if (actionType.equalsIgnoreCase("getMyActivityLogList")) {
			String searchBy = req.getParameter("searchBy") == "" ? "last_sevenDays" : req.getParameter("searchBy");
			System.out.println(searchBy);
			String start_date = req.getParameter("filterStartDateid") == null ? ""
					: req.getParameter("filterStartDateid");
			String end_date = req.getParameter("filterEndDate") == null ? "" : req.getParameter("filterEndDate");
			System.out.println(start_date);
			System.out.println(end_date);

			CtaskLogDAO logDAO = new CtaskLogDAO();
			ArrayList<CTaskLogInfoDTO> cTaskLogInfoDTOList = logDAO
					.getTaskLogListForUser(cUserLoginDTO.getUser_login_id(), searchBy, start_date, end_date);
			System.out.println(cTaskLogInfoDTOList);
			resp.setContentType("application/json");
			PrintWriter out = resp.getWriter();
			Gson gson = new Gson();
			out.println(gson.toJson(cTaskLogInfoDTOList));
			return;
		} else if (actionType.equalsIgnoreCase("getTaskLogList")) {

			String searchBy = req.getParameter("searchBy") == "" ? "last_sevenDays" : req.getParameter("searchBy");
			System.out.println(searchBy);
			String start_date = req.getParameter("filterStartDateid") == null ? ""
					: req.getParameter("filterStartDateid");
			String end_date = req.getParameter("filterEndDate") == null ? "" : req.getParameter("filterEndDate");
			System.out.println(start_date);
			System.out.println(end_date);
			String projectid = req.getParameter("projectid") == null ? "0" : req.getParameter("projectid");
			int startIndex = Integer.parseInt(req.getParameter("startIndex"));
			int endIndex = Integer.parseInt(req.getParameter("endIndex"));
			String pageNo = req.getParameter("pageNo") == null ? "1" : req.getParameter("pageNo");
			CtaskLogDAO logDAO = new CtaskLogDAO();
			ArrayList<CTaskLogInfoDTO> cTaskLogInfoDTOList = logDAO.getTaskLogList(Integer.parseInt(projectid),
					searchBy, start_date, end_date, startIndex, endIndex, pageNo);
			System.out.println(cTaskLogInfoDTOList);
			resp.setContentType("application/json");
			PrintWriter out = resp.getWriter();
			Gson gson = new Gson();
			out.println(gson.toJson(cTaskLogInfoDTOList));
			return;
		} else if (actionType.equalsIgnoreCase("deleteTaskLog")) {
			String task_log_id = req.getParameter("task_log_id") == null ? "0" : req.getParameter("task_log_id");
			CtaskLogDAO logDAO = new CtaskLogDAO();
			boolean isdeleted = logDAO.deleteTaskLog(Integer.parseInt(task_log_id));
			resp.setContentType("application/json");
			PrintWriter out = resp.getWriter();
			Gson gson = new Gson();
			out.println(gson.toJson(isdeleted));
			return;
		} else if (actionType.equalsIgnoreCase("infoforEdit_task_log")) {
			String task_log_id = req.getParameter("task_log_id") == null ? "0" : req.getParameter("task_log_id");
			CtaskLogDAO logDAO = new CtaskLogDAO();
			CTaskLogInfoDTO taskLogInfoDTO = logDAO.infoforEditTaskLog(Integer.parseInt(task_log_id));
			if (taskLogInfoDTO != null) {
				resp.setContentType("application/json");
				PrintWriter out = resp.getWriter();
				Gson gson = new Gson();
				out.println(gson.toJson(taskLogInfoDTO));
				return;
			}
		} else if (actionType.equalsIgnoreCase("updatetasklog")) {
			String task_log_id = req.getParameter("task_log_id") == null ? "0" : req.getParameter("task_log_id");
			String logDate = req.getParameter("logDate") == null ? "" : req.getParameter("logDate");
			String taskComment = req.getParameter("taskComment") == null ? "" : req.getParameter("taskComment");
			String logHours = req.getParameter("logHours") == null ? "0" : req.getParameter("logHours");
			String taskActivityId = req.getParameter("taskActivityId") == null ? "0"
					: req.getParameter("taskActivityId");
			CTaskLogDTO taskLogDTO = new CTaskLogDTO();
			taskLogDTO.setTaskLogId(Integer.parseInt(task_log_id));
			taskLogDTO.setLogDate(logDate);
			taskLogDTO.setLogHours(Integer.parseInt(logHours));
			taskLogDTO.setTaskActivityId(Integer.parseInt(taskActivityId));
			taskLogDTO.setTaskComment(taskComment);
			taskLogDTO.setUserId(cUserLoginDTO.getUser_login_id());
			CtaskLogDAO logDAO = new CtaskLogDAO();

			boolean isupdated = logDAO.updateTaskLog(taskLogDTO);
			
			resp.setContentType("application/json");
			PrintWriter out = resp.getWriter();
			Gson gson = new Gson();
			if (isupdated) {
				if(req.getSession().getAttribute("documentsDTO")!=null) {
					TaskDocumentsDTO documentDTO = (TaskDocumentsDTO) req.getSession().getAttribute("documentsDTO");
					if(taskDAO.saveTaskLogfile(documentDTO,taskLogDTO.getTaskLogId())) {
						System.out.println("document details saved...!");
					}else {
						System.out.println("failed to save document details...!");
					}
					req.getSession().removeAttribute("documentsDTO");
				}
				out.println(gson.toJson("success"));
				return;
			} else {
				out.println(gson.toJson("failed"));
				return;
			}
		} else if (actionType.equalsIgnoreCase("tasksummarybypriority")) {
		
			String projectfiler_id = req.getParameter("projectfiler_id") == "" ? "allproject" :req.getParameter("projectfiler_id");
			String search_by = req.getParameter("search_by")== "" ? "last_3_months" :req.getParameter("search_by");
			String filterStartDateid = req.getParameter("from_date") == "" ? "" :req.getParameter("from_date");
		    String filterEndDate = req.getParameter("to_date") == "" ? "" :req.getParameter("to_date");
		    
			ArrayList<CTaskPriorityDTO> myTaskSummary = taskDAO	.getMyTaskSummaryByPriority(cUserLoginDTO.getUser_login_id(), companyId,projectfiler_id,search_by,filterStartDateid,filterEndDate);
				
			resp.setContentType("application/json");
			PrintWriter out = resp.getWriter();
			Gson gson = new Gson();
			out.println(gson.toJson(myTaskSummary));
			return;
		} else if (actionType.equalsIgnoreCase("tasksummarybypriorityonready")) {

			String projectfiler_id = req.getParameter("projectfiler_id") == "" ? "allproject" :req.getParameter("projectfiler_id");
			String search_by = req.getParameter("search_by")== "" ? "last_3_months" :req.getParameter("search_by");
			String filterStartDateid = req.getParameter("from_date") == "" ? "" :req.getParameter("from_date");
		    String filterEndDate = req.getParameter("to_date") == "" ? "" :req.getParameter("to_date");
		   
			ArrayList<CTaskPriorityDTO> myTaskSummary = taskDAO.getMyTaskSummaryByPriorityOnReady(cUserLoginDTO.getUser_login_id(), companyId,projectfiler_id,search_by,filterStartDateid,filterEndDate);
					
			resp.setContentType("application/json");
			PrintWriter out = resp.getWriter();
			Gson gson = new Gson();
			out.println(gson.toJson(myTaskSummary));
			return;
		}else if (actionType.equalsIgnoreCase("getTaskLog")) {
			String taskid = req.getParameter("taskid") == "" ? "" :req.getParameter("taskid");
			int startIndex = Integer.parseInt(req.getParameter("startIndex"));
			int endIndex = Integer.parseInt(req.getParameter("endIndex"));
			String pageNo = req.getParameter("pageNo") == null ? "1" : req.getParameter("pageNo");
			ArrayList<CTaskLogInfoDTO> Taskloglist = taskDAO.gettasklog(companyId,taskid, startIndex, endIndex, pageNo);
					
			resp.setContentType("application/json");
			PrintWriter out = resp.getWriter();
			Gson gson = new Gson();
			out.println(gson.toJson(Taskloglist));
			return;
		}
	}
}

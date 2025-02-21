package com.dakshabhi.pms.kanban.services;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dakshabhi.common.constants.ConfigConstants;
import com.dakshabhi.pms.kanban.daos.CKanbanDAO;
import com.dakshabhi.pms.masters.dtos.CTaskStatusDTO;
import com.dakshabhi.pms.tasks.daos.CTaskDAO;
import com.dakshabhi.pms.tasks.dtos.CTaskDTO;
import com.dakshabhi.pms.users.dtos.CUserLoginDTO;
import com.google.gson.Gson;

@WebServlet("/kanban")
@MultipartConfig
public class CKanbanService extends HttpServlet {
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
		String companyID = req.getSession().getAttribute("companyID") == null ? ""
				: (String) req.getSession().getAttribute("companyID");
		CKanbanDAO kanbanDAO = new CKanbanDAO();
		CUserLoginDTO cUserLoginDTO = (CUserLoginDTO) req.getSession().getAttribute("userLogin");
		String actionType = req.getParameter("actionType") == null ? "" : req.getParameter("actionType");
		String companyId = ConfigConstants.getCompanyID(req.getSession());
		
		if (actionType.equalsIgnoreCase("kanbanstatuslist")) { // kanban status list
			String projectId = req.getParameter("projectId") == "" ? "" : req.getParameter("projectId");
			String searchId = req.getParameter("searchId") == "" ? "" : req.getParameter("searchId");
			String startDate = req.getParameter("startDate") == "" ? "" : req.getParameter("startDate");
			String enddate = req.getParameter("enddate") == "" ? "" : req.getParameter("enddate");
			
			ArrayList<CTaskDTO> kanbanstatusList = kanbanDAO.getkanbanstatusList(cUserLoginDTO.getUser_login_id(), companyId,projectId,searchId,startDate,enddate);  // all data kanban 
			resp.setContentType("application/json");
			PrintWriter out = resp.getWriter();
			Gson gson = new Gson();
			out.println(gson.toJson(kanbanstatusList));
			return;

		} 

		else if (actionType.equalsIgnoreCase("kanbantasksummary")) { // kanban summary
			String filterStartDateid = req.getParameter("from_date") == "" ? "" : req.getParameter("from_date");
			String filterEndDate = req.getParameter("to_date") == "" ? "" : req.getParameter("to_date");
			ArrayList<CTaskStatusDTO> kanbantasksummary = kanbanDAO.getkanbantasksummary(cUserLoginDTO.getUser_login_id(),
					companyId, filterStartDateid, filterEndDate, filterEndDate, filterEndDate);
			resp.setContentType("application/json");
			PrintWriter out = resp.getWriter();
			Gson gson = new Gson();
			out.println(gson.toJson(kanbantasksummary));
			return;
		} 
		else if (actionType.equalsIgnoreCase("kanbantasklist")) { // in use to loadmore
			String statusid = req.getParameter("statusid") == null ? "" : req.getParameter("statusid");
			String priorityid = req.getParameter("priorityid") == null ? "" : req.getParameter("priorityid");
			String projectid = req.getParameter("projectid") == null ? "" : req.getParameter("projectid");
			String searchBy = req.getParameter("searchBy") == null ? "" : req.getParameter("searchBy");
			String filterStartDate = req.getParameter("from_date") == null ? "" : req.getParameter("from_date");
			String filterEndDate = req.getParameter("to_date") == null ? "" : req.getParameter("to_date");
			int startIndex = Integer.parseInt(req.getParameter("startIndex"));
			int endIndex = Integer.parseInt(req.getParameter("endIndex"));
			String pageNo = req.getParameter("pageNo") == null ? "1" : req.getParameter("pageNo");
			boolean isupdated = kanbanDAO.updateoverduedate(companyID);
			if (isupdated)
				System.out.println("Task Overdue status updated");
			else
				System.out.println("Task Overdue status not updated");
			ArrayList<CTaskDTO> myTaskList = kanbanDAO.getMyTaskList(cUserLoginDTO.getUser_login_id(), statusid, 
					priorityid, projectid, companyId, startIndex, endIndex, pageNo, searchBy, filterStartDate,
					filterEndDate);
			resp.setContentType("application/json");
			PrintWriter out = resp.getWriter();
			Gson gson = new Gson();
			out.println(gson.toJson(myTaskList));
			return;
		} 
		else if (actionType.equalsIgnoreCase("kanbangroupupdateStatus")) { // kanban group Status
			int taskId = req.getParameter("taskid") == null ? 0 :  Integer.parseInt(req.getParameter("taskid"));
	     	String task_status = req.getParameter("task_status") == null ? "0" : req.getParameter("task_status");
	     	String taskCompletionValue = req.getParameter("taskCompletionValue") == null ? "0"
					: req.getParameter("taskCompletionValue");
     		ArrayList<CTaskDTO> kanbangroupupdateStatus = new CKanbanDAO().getkanbangroupupdateStatus(taskId , task_status,companyId);
			resp.setContentType("application/json");
			PrintWriter out = resp.getWriter();
			Gson gson = new Gson();
			out.println(gson.toJson(kanbangroupupdateStatus));
			return;
		}
		else if (actionType.equalsIgnoreCase("kanbansearch")) { // kanban search bar 
			try {
				String searchEmployeeName = req.getParameter("searchEmployeeName") == null ? "": req.getParameter("searchEmployeeName");
				String taskId = req.getParameter("searchEmployeeName") == null ? "": req.getParameter("searchEmployeeName");
				
				ArrayList<CTaskDTO> kanbanBoardSearch = new CKanbanDAO().getkanbanBoardSearch(searchEmployeeName,taskId);
				resp.setContentType("application/json");
				PrintWriter out = resp.getWriter();
				Gson gson = new Gson();
				out.println(gson.toJson(kanbanBoardSearch));
				return;
				

			} catch (Exception e) {
				e.printStackTrace();
			}
		
		}

	}
}

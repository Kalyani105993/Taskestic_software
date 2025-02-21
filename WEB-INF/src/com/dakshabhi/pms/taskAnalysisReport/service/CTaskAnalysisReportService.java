package com.dakshabhi.pms.taskAnalysisReport.service;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dakshabhi.common.constants.ConfigConstants;
import com.dakshabhi.pms.taskAnalysisReport.dao.CTaskAnalysisReportDAO;
import com.dakshabhi.pms.taskAnalysisReport.dto.CTaskAnalysisReportDTO;
import com.google.gson.Gson;

@WebServlet(value = "/taskanalysisReport")
public class CTaskAnalysisReportService extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		CTaskAnalysisReportDAO objTaskAnalysisReportDAO = new CTaskAnalysisReportDAO();
		String company_id = ConfigConstants.getCompanyID(req.getSession());

		String actionType = req.getParameter("actionType") == null ? "" : req.getParameter("actionType");

		try {
			/* Method: Fetch Columns to display in dynamic filter
			 * Input: Nothing
			 * Output: Column names from pms_project_task_info_rpt
			 */
			if (actionType.equalsIgnoreCase("fetchTaskAnalysisRptRecrds")) {
				ArrayList<CTaskAnalysisReportDTO> cTaskAnalysisRptlist = objTaskAnalysisReportDAO.fetchRptRecords();
				resp.setContentType("application/json");
				PrintWriter out = resp.getWriter();
				Gson gson = new Gson();
				out.println(gson.toJson(cTaskAnalysisRptlist));
				return;

			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		
	}
}

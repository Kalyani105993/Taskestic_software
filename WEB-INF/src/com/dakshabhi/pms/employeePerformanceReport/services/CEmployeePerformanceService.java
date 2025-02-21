package com.dakshabhi.pms.employeePerformanceReport.services;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dakshabhi.common.constants.ConfigConstants;
import com.dakshabhi.pms.employeePerformanceReport.dao.CEmployeePerformanceDAO;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

@WebServlet("/employeeperformance")
public class CEmployeePerformanceService extends HttpServlet {
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		CEmployeePerformanceDAO cEmployeePerformanceDAO = new CEmployeePerformanceDAO();
		String company_id = ConfigConstants.getCompanyID(req.getSession());
		String actionType = req.getParameter("actionType") == null ? "" : req.getParameter("actionType");

		try {
			if (actionType.equalsIgnoreCase("fetchEmpPerformanceTasks")) {
				String from_date = req.getParameter("from_date");
				String to_date = req.getParameter("to_date");
				String project = req.getParameter("project");
				String employee = req.getParameter("employee");
				
				List<Map<String, Object>> empPerformanceResp =  cEmployeePerformanceDAO.fetchEmpPerformanceTasksBySP(company_id, from_date, to_date, project, employee);
				
				resp.setContentType("application/json");
				PrintWriter out = resp.getWriter();
				Gson gson = new GsonBuilder().serializeNulls().create();
				out.println(gson.toJson(empPerformanceResp));
				return;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

}

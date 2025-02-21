package com.dakshabhi.pms.commonFilterApis.services;

import java.io.IOException;
import java.io.OutputStream;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.json.JSONObject;

import com.dakshabhi.common.constants.ConfigConstants;
import com.dakshabhi.pms.commonFilterApis.dao.CCommonFilterAPIDAO;
import com.dakshabhi.pms.commonFilterApis.dao.ExcelExporter;

@WebServlet(value = "/excel")
public class CExportService extends HttpServlet {
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
		
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		CCommonFilterAPIDAO filterAPIDAO = new CCommonFilterAPIDAO();
		String company_id = ConfigConstants.getCompanyID(req.getSession());
		String actionType = req.getParameter("actionType") == null ? "" : req.getParameter("actionType");

		/*
		 * Method: Export To Excel api 
		 * Input: provide data in json & column keys
		 * Output: downloaded excel file
		 */
		if (actionType.equalsIgnoreCase("FnExportToExcel")) {
			try {
		        String export = req.getReader().lines().reduce("", (accumulator, actual) -> accumulator + actual);
			
				JSONObject jsonObject = new JSONObject(export);
				
				resp.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
				DateFormat dateFormatter = new SimpleDateFormat("yyyy-MM-dd_HH:mm:ss");
				String currentDateTime = dateFormatter.format(new Date());

				String headerKey = "Content-Disposition";
				String headerValue = "attachment; filename=users_" + currentDateTime + ".xlsx";
				resp.setHeader(headerKey, headerValue);
	
				ExcelExporter excelExporter = new ExcelExporter(jsonObject);
				excelExporter.export(resp);
				return;
			
			}catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

}

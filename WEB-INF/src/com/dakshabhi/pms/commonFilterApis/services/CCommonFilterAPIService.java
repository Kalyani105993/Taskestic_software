package com.dakshabhi.pms.commonFilterApis.services;

import java.io.BufferedReader;
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

import org.json.JSONObject;

import com.dakshabhi.common.constants.ConfigConstants;
import com.dakshabhi.pms.commonFilterApis.dao.CCommonFilterAPIDAO;
import com.dakshabhi.pms.commonFilterApis.dto.CGlobalQueryObjectDTO;
import com.dakshabhi.pms.commonFilterApis.dto.CMasterDTO;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

@WebServlet(value = "/commonfilterAPI")
public class CCommonFilterAPIService extends HttpServlet {

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
		 * Method: Custom API to get field_id & field_name from view 
		 * Input: master name
		 * means view name Output: primary key & primary name from view
		 */
		if (actionType.equalsIgnoreCase("fetchMasterData")) {
			try {
				String master = req.getParameter("master");
				ArrayList<CMasterDTO> cTaskAnalysisRptlist = filterAPIDAO.fetchMasterData(master, company_id);

				resp.setContentType("application/json");
				PrintWriter out = resp.getWriter();
				Gson gson = new Gson();
				out.println(gson.toJson(cTaskAnalysisRptlist));
				return;
			} catch (Exception e) {
				e.printStackTrace();
			}
		} 
		/*
		 * Method: Dynamic filter method for reports
		 * Input: need provide json parameters, select params  
		 * Output: Arraylist data & columns
		 */
		
		else if (actionType.equalsIgnoreCase("fetchFilteredData")) {
			try {
				String jsonString = req.getParameter("jsonQuery");
				int startIndex = Integer.parseInt(req.getParameter("startIndex"));
				int endIndex = Integer.parseInt(req.getParameter("endIndex"));
				String pageNo = req.getParameter("pageNo") == null ? "1" : req.getParameter("pageNo");
				
				// Convert the JSON string to a JSON object
				JSONObject jsonObject = new JSONObject(jsonString);
				JSONObject params = jsonObject.getJSONObject("params");
				JSONObject selectqry = jsonObject.getJSONObject("selectQuery");
				JSONObject whereqry = jsonObject.getJSONObject("whereQuery");

				HashMap<String, Object> responcefetchFilteredData = filterAPIDAO.fetchFilteredData(params, selectqry,
						whereqry, company_id, startIndex, endIndex, pageNo);

				resp.setContentType("application/json");
				PrintWriter out = resp.getWriter();
				Gson gson = new GsonBuilder().serializeNulls().create();
				out.println(gson.toJson(responcefetchFilteredData));
				return;

			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		/*
		 * Method: globalJsonQueryExecution
		 * Input: need to provide global json object declred in common-functions.js file  
		 * Output: Arraylist object based on provided details
		 */
		else if (actionType.equalsIgnoreCase("globalJsonQueryExecution")) {
			try {
				// Read JSON data from the request
		        BufferedReader reader = req.getReader();
		        StringBuilder sb = new StringBuilder();
		        String line;
		        while ((line = reader.readLine()) != null) {
		            sb.append(line);
		        }
		        String jsonData = sb.toString();
		        
		        Gson gson = new Gson();
		        CGlobalQueryObjectDTO globalQuery = gson.fromJson(jsonData, CGlobalQueryObjectDTO.class);
		        List<Map<String, Object>> responce = filterAPIDAO.globalJsonQueryExecution(globalQuery);
		        
		        resp.setContentType("application/json");
				PrintWriter out = resp.getWriter();
				Gson respgson = new GsonBuilder().serializeNulls().create();
				out.println(respgson.toJson(responce));
				return;
		      
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

}

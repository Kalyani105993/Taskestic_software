package com.dakshabhi.pms.projects.services;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dakshabhi.common.constants.ConfigConstants;
import com.dakshabhi.pms.customers.dtos.CCustomerDTO;
import com.dakshabhi.pms.projects.daos.CProjectDAO;
import com.dakshabhi.pms.projects.dtos.CProjectDTO;
import com.dakshabhi.pms.projects.dtos.CProjectInfoDTO;
import com.dakshabhi.pms.users.dtos.CUserLoginDTO;
import com.google.gson.Gson;

@WebServlet(value = "/projects")
public class CProjectsService extends HttpServlet {

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
		// TODO Auto-generated method stub

		String action_type = req.getParameter("action_type") == null ? "" : req.getParameter("action_type");
		String companyId = ConfigConstants.getCompanyID(req.getSession());
		CUserLoginDTO cUserLoginDTO = (CUserLoginDTO) req.getSession().getAttribute("userLogin");
		if (action_type.equalsIgnoreCase("save")) {
			CProjectDTO objProjectDTO = new CProjectDTO();
			objProjectDTO.setCompany_id(1);
			objProjectDTO.setCustomer_id(Integer.parseInt(req.getParameter("customer_id")));
			objProjectDTO.setProject_name(req.getParameter("project_name"));
			objProjectDTO.setProject_description(req.getParameter("project_description"));
			objProjectDTO.setProject_start_date(req.getParameter("start_date"));
			objProjectDTO.setProject_end_date(req.getParameter("end_date")); 
			objProjectDTO.setProject_status_id(Integer.parseInt(req.getParameter("project_status")));		 
			objProjectDTO.setProject_code(req.getParameter("project_code"));
			objProjectDTO.setProject_type_id(Integer.parseInt(req.getParameter("project_type")));
			objProjectDTO.setCreated_by(cUserLoginDTO.getUser_login_id());
			if (CProjectDAO.createNewProject(objProjectDTO, companyId)) {
				System.out.println("Project created successfully");
				return;
			} else {
				System.out.println("Project creation failed!!!");
			}

		} else if (action_type.equalsIgnoreCase("delete")) {
			String project_id = req.getParameter("project_id") == null ? "" : req.getParameter("project_id");
			if (!project_id.equals("")) {
				CProjectDAO.deleteProject(project_id);
			}
		} else if (action_type.equalsIgnoreCase("infoforedit")) {
			String project_id = req.getParameter("project_id") == null ? "" : req.getParameter("project_id");
			CProjectInfoDTO objProjectInfoDTO = CProjectDAO.getProjectDetails(project_id);
			if (objProjectInfoDTO != null) {

				resp.setContentType("application/json");
				String json = new Gson().toJson(objProjectInfoDTO);
				resp.getWriter().write(json);
				return;
			}
		} else if (action_type.equalsIgnoreCase("update")) {
			CProjectDTO objProjectDTO = new CProjectDTO();
			objProjectDTO.setProject_id(Integer.parseInt(req.getParameter("project_id")));
			objProjectDTO.setCustomer_id(Integer.parseInt(req.getParameter("customer_id")));
			objProjectDTO.setProject_name(req.getParameter("project_name"));
			objProjectDTO.setProject_description(req.getParameter("project_description"));
			objProjectDTO.setProject_start_date(req.getParameter("start_date"));
			objProjectDTO.setProject_end_date(req.getParameter("end_date"));
			 
			objProjectDTO.setProject_status_id(Integer.parseInt(req.getParameter("project_status")));
			  
			objProjectDTO.setProject_code(req.getParameter("project_code"));

			objProjectDTO.setProject_type_id(Integer.parseInt(req.getParameter("project_type")));

			if (CProjectDAO.updateProjectDeails(objProjectDTO)) {
				System.out.println("Project update successfully");
			} else {
				System.out.println("Project updation failed!!!");
			}
			return;

		} else if (action_type.equalsIgnoreCase("searchData")) {
			CProjectDAO cProjectDAO = new CProjectDAO();
			try {

				String project_name = req.getParameter("projectname")==null?"":req.getParameter("projectname");
				String customer_id = req.getParameter("customer")==null?"":req.getParameter("customer");
				// String project_sub_group = "";
				int projectStatus = Integer.parseInt(req.getParameter("project_status_id")==null?"0":req.getParameter("project_status_id"));
				String project_status = Integer.toString(projectStatus);
				if (projectStatus == 0) {
					project_status = "";
				}
 
				Object[] projectInfoList = cProjectDAO.getSearchData(project_name, customer_id, project_status,cUserLoginDTO.getUser_login_id(),
						companyId);

				resp.setContentType("application/json");
				String json = new Gson().toJson(projectInfoList);
				resp.getWriter().write(json);
				return;

			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (action_type.equalsIgnoreCase("list")) {
			try {
				/*
				 * int startIndex = Integer.parseInt(req.getParameter("startIndex")); int
				 * endIndex = Integer.parseInt(req.getParameter("endIndex"));
				 */
				Object[] list = CProjectDAO.getProjectList(cUserLoginDTO.getUser_login_id(),companyId);
				resp.setContentType("application/json");
				String json = new Gson().toJson(list);
				resp.getWriter().write(json);
				return;
			} catch (Exception e) {
				e.printStackTrace();
			}

		} else if (action_type.equalsIgnoreCase("getCustomerNameList")) {
			try {
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
		} else if (action_type.equalsIgnoreCase("projectSummaryList")) {
			try {
				String projectId = req.getParameter("projectid") == null ? "0" : req.getParameter("projectid");
				int project_id = Integer.parseInt(projectId);
				HashMap<String, Object> projectSummaryList = CProjectDAO.getProjectSummaryList(project_id, companyId);

				resp.setContentType("application/json");
				String json = new Gson().toJson(projectSummaryList);
				resp.getWriter().write(json);
				return;
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		resp.sendRedirect("projects.jsp");
	}
}

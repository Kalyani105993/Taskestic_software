package com.dakshabhi.pms.projectsemployee.services;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dakshabhi.common.constants.ConfigConstants;
import com.dakshabhi.pms.employees.dtos.CEmployeeDTO;
import com.dakshabhi.pms.projects.dtos.CProjectDTO;
import com.dakshabhi.pms.projectsemployee.daos.CProjectEmployeeDAO;
import com.dakshabhi.pms.projectsemployee.dtos.CProjectEmployeeDTO;
import com.dakshabhi.pms.projectsemployee.dtos.CProjectEmployeeInfoDTO;
import com.dakshabhi.pms.users.dtos.CUserLoginDTO;
import com.google.gson.Gson;

@WebServlet(value = "/projectsemployee")
public class CProjectEmployeeServices extends HttpServlet {
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		CProjectEmployeeDAO cProjectEmployeeDAO = new CProjectEmployeeDAO();
		
		String actionType = req.getParameter("actionType") == null ? "" : req.getParameter("actionType");
		String companyId = ConfigConstants.getCompanyID(req.getSession());
		if (actionType.equalsIgnoreCase("getProjectName")) {
			try {
				
				ArrayList<CProjectDTO> cProjectDTO = cProjectEmployeeDAO.getProjectNameList(companyId);
				resp.setContentType("application/json");

				PrintWriter out = resp.getWriter();
				Gson gson = new Gson();
				out.println(gson.toJson(cProjectDTO));
				return;
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if (actionType.equalsIgnoreCase("getEmployeeName")) {
			try {
				CUserLoginDTO cUserLoginDTO = (CUserLoginDTO) req.getSession().getAttribute("userLogin");
				ArrayList<CEmployeeDTO> cEmployeeDTOList = null;
				
				if (cUserLoginDTO.getUser_role() == 1) {
					cEmployeeDTOList = cProjectEmployeeDAO.getEmployeeNameList(companyId);
				} else if (cUserLoginDTO.getUser_role() == 2) {
					cEmployeeDTOList = cProjectEmployeeDAO.getEmployeeUnderReportingTo(cUserLoginDTO,companyId);
				}else {
					cEmployeeDTOList = new ArrayList<CEmployeeDTO>();
					CEmployeeDTO cEmployeeDTO = new CEmployeeDTO();
					cEmployeeDTO.setEmployee_id(cUserLoginDTO.getUser_employee_id());
					cEmployeeDTO.setEmployee_name(cUserLoginDTO.getUser_full_name());
					cEmployeeDTOList.add(cEmployeeDTO);
				}
				resp.setContentType("application/json");

				PrintWriter out = resp.getWriter();
				Gson gson = new Gson();
				out.println(gson.toJson(cEmployeeDTOList));
				return;
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if (actionType.equalsIgnoreCase("getnewmembers")) { //Block for getNewMembers
			try {
				CUserLoginDTO cUserLoginDTO = (CUserLoginDTO) req.getSession().getAttribute("userLogin");
				ArrayList<CEmployeeDTO> cEmployeeDTOList = null;
				String projectid = req.getParameter("projectid")==null?"0":req.getParameter("projectid");
				String memberSearchKeyword = req.getParameter("searchkeyword")==null?"":req.getParameter("searchkeyword");
				String departmentid = req.getParameter("departmentid")==null?"0":req.getParameter("departmentid");
				System.out.println(departmentid);
				cEmployeeDTOList = cProjectEmployeeDAO.getNewEmployeeListForProject(projectid,memberSearchKeyword,companyId,departmentid); 
				resp.setContentType("application/json");

				PrintWriter out = resp.getWriter();
				Gson gson = new Gson();
				out.println(gson.toJson(cEmployeeDTOList));
				return;
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if (actionType.equalsIgnoreCase("getprojectmembers")) {
			try {
				CUserLoginDTO cUserLoginDTO = (CUserLoginDTO) req.getSession().getAttribute("userLogin");
				String projectid = req.getParameter("projectid")==null?"0":req.getParameter("projectid");
				String departmentid = req.getParameter("departmentid")==null?"0":req.getParameter("departmentid");
				String listType = req.getParameter("listType")==null?"":req.getParameter("listType");
				int startIndex = Integer.parseInt(req.getParameter("startIndex")== null?"0":req.getParameter("startIndex"));
				int endIndex = Integer.parseInt(req.getParameter("endIndex")== null?"0":req.getParameter("endIndex"));
				String pageNo = req.getParameter("pageNo") == null ? "1" : req.getParameter("pageNo");
				ArrayList<CProjectEmployeeInfoDTO> cProjectEmployeeInfoDTO = cProjectEmployeeDAO.getProjectEmployeeDetails(projectid,companyId,departmentid,cUserLoginDTO.getUser_login_id(),listType, startIndex, endIndex, pageNo);
				resp.setContentType("application/json");

				PrintWriter out = resp.getWriter();
				Gson gson = new Gson();
				out.println(gson.toJson(cProjectEmployeeInfoDTO));
				return;
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if (actionType.equalsIgnoreCase("save")) {
			CProjectEmployeeDTO objProjectEmployeeDTO = new CProjectEmployeeDTO();
			objProjectEmployeeDTO.setCompany_id(1);
			objProjectEmployeeDTO.setProject_id(Integer.parseInt(req.getParameter("project_id")));
			objProjectEmployeeDTO.setEmployee_id(Integer.parseInt(req.getParameter("employee_id")));
			objProjectEmployeeDTO.setDate_added(req.getParameter("date_added"));
		
			if (CProjectEmployeeDAO.saveEmployeeInfo(objProjectEmployeeDTO,companyId)) {
				System.out.println("Project Employee created successfully");
			} else {
				System.out.println("Project Employee creation failed!!!");
			}
		}else if (actionType.equalsIgnoreCase("addnewmembers")) {
			CProjectEmployeeDTO objProjectEmployeeDTO = new CProjectEmployeeDTO();
			objProjectEmployeeDTO.setCompany_id(1);
			objProjectEmployeeDTO.setProject_id(Integer.parseInt(req.getParameter("projectid")));
			objProjectEmployeeDTO.setEmployee_id(Integer.parseInt(req.getParameter("employeeid")));
			//objProjectEmployeeDTO.setDate_added(req.getParameter("date_added"));
		
			if (CProjectEmployeeDAO.saveEmployeeInfo(objProjectEmployeeDTO,companyId)) {
				resp.setContentType("application/json");

				PrintWriter out = resp.getWriter();
				Gson gson = new Gson();
				out.println(gson.toJson("Success"));
				return;
			} else {
				resp.setContentType("application/json");
				PrintWriter out = resp.getWriter();
				Gson gson = new Gson();
				out.println(gson.toJson("Failure"));
				return;
			}
		}else if (actionType.equalsIgnoreCase("deleteprojectemplpyee")) {
			String project_employee_id = req.getParameter("projectEmployeeID") == null ? "" : req.getParameter("projectEmployeeID");
			
			if(CProjectEmployeeDAO.deleteProjectEmployee(project_employee_id)) {
				resp.setContentType("application/json");
				PrintWriter out = resp.getWriter();
				Gson gson = new Gson();
				out.println(gson.toJson("Success"));
				return;
			}else {
				resp.setContentType("application/json");
				PrintWriter out = resp.getWriter();
				Gson gson = new Gson();
				out.println(gson.toJson("Failure"));
			}
			
		} else if (actionType.equalsIgnoreCase("infoforedit")) {
			String projectEmployeeId = req.getParameter("projectEmployeeId") == null ? "" : req.getParameter("projectEmployeeId");
			CProjectEmployeeDTO objCEmployeeDTO = CProjectEmployeeDAO.getProjectEmployeeDetailsForEdit(projectEmployeeId);
			resp.setContentType("application/json");

			PrintWriter out = resp.getWriter();
			Gson gson = new Gson();
			out.println(gson.toJson(objCEmployeeDTO));
			return;
		}else if (actionType.equalsIgnoreCase("update")) {
			CProjectEmployeeDTO objProjectEmployeeDTO = new CProjectEmployeeDTO();
			
			objProjectEmployeeDTO.setProject_employee_id(Integer.parseInt(req.getParameter("project_employee_id")));
			objProjectEmployeeDTO.setProject_id(Integer.parseInt(req.getParameter("project_id")));
			objProjectEmployeeDTO.setEmployee_id(Integer.parseInt(req.getParameter("employee_id")));
			
			if (CProjectEmployeeDAO.updateProjectEmployeeDetails(objProjectEmployeeDTO)) {
				System.out.println("Project Employee update successfully");
			} else {
				System.out.println("Project Employee updation failed!!!");
			}
		}
		 
		resp.sendRedirect("projectsemployee.jsp");
	}
	
	
}

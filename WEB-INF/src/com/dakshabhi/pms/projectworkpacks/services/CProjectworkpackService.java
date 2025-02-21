package com.dakshabhi.pms.projectworkpacks.services;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dakshabhi.common.constants.ConfigConstants;
import com.dakshabhi.pms.employees.daos.CEmployeeDAO;
import com.dakshabhi.pms.employees.dtos.CEmployeeDTO;
import com.dakshabhi.pms.projects.daos.CProjectDAO;
import com.dakshabhi.pms.projects.dtos.CProjectDTO;
import com.dakshabhi.pms.projects.dtos.CProjectInfoDTO;
import com.dakshabhi.pms.projectsemployee.daos.CProjectEmployeeDAO;
import com.dakshabhi.pms.projectsemployee.dtos.CProjectEmployeeDTO;
import com.dakshabhi.pms.projectworkpacks.daos.CProjectworkpacksDAO;
import com.dakshabhi.pms.projectworkpacks.dtos.CProjectworkpacksDTO;
import com.dakshabhi.pms.projectworkpacks.dtos.CProjectworkpacksInfoDTO;
import com.dakshabhi.pms.workpaks.daos.CWorkpackDAO;
import com.dakshabhi.pms.workpaks.dtos.CWorkpackDTO;
import com.google.gson.Gson;

@WebServlet(value = "/projectsworkpack")
public class CProjectworkpackService extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		CProjectworkpacksDAO cProjectworkpacksDAO = new CProjectworkpacksDAO();
		String actionType = req.getParameter("actionType") == null ? "" : req.getParameter("actionType");
		String companyId = ConfigConstants.getCompanyID(req.getSession());
		if (actionType.equalsIgnoreCase("getProjectName")) {
			try {
				CProjectDAO cProjectDAO = new CProjectDAO();
				ArrayList<CProjectDTO> cProjectDTO = cProjectDAO.getProjectNameList(companyId);
				resp.setContentType("application/json");

				PrintWriter out = resp.getWriter();
				Gson gson = new Gson();
				out.println(gson.toJson(cProjectDTO));
				return;
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (actionType.equalsIgnoreCase("getWorkpackName")) {
			try {
				CWorkpackDAO cWorkpackDAO = new CWorkpackDAO();
				ArrayList<CWorkpackDTO> cWorkpackDTO = cWorkpackDAO.getWorkpackNameList(companyId);
				resp.setContentType("application/json");

				PrintWriter out = resp.getWriter();
				Gson gson = new Gson();
				out.println(gson.toJson(cWorkpackDTO));
				return;
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (actionType.equalsIgnoreCase("save")) {
			CProjectworkpacksDTO objProjectWorkpackDTO = new CProjectworkpacksDTO();
			objProjectWorkpackDTO.setCompany_id(1);
			objProjectWorkpackDTO.setProject_id(Integer.parseInt(req.getParameter("project_id")));
			objProjectWorkpackDTO.setWorkpack_id(Integer.parseInt(req.getParameter("workpack_id")));
			objProjectWorkpackDTO.setDate_added(req.getParameter("date_added"));
			objProjectWorkpackDTO.setWorkpack_rate(Integer.parseInt(req.getParameter("workpack_rate")));
			objProjectWorkpackDTO
					.setWorkpack_standard_hours(Integer.parseInt(req.getParameter("workpack_standard_hours")));
			objProjectWorkpackDTO.setWorkpack_start_date(req.getParameter("workpack_start_date"));
			objProjectWorkpackDTO.setWorkpack_end_date(req.getParameter("workpack_end_date"));
			objProjectWorkpackDTO.setWorkpack_booked_hours(Integer.parseInt(req.getParameter("workpack_booked_hours")));

			if (CProjectworkpacksDAO.saveInfo(objProjectWorkpackDTO, companyId)) {
				System.out.println("Project Workpack created successfully");
			} else {
				System.out.println("Project Workpack creation failed!!!");
			}
		} else if (actionType.equalsIgnoreCase("delete")) {
			String project_workpack_id = req.getParameter("project_workpack_id") == null ? ""
					: req.getParameter("project_workpack_id");
			if (!project_workpack_id.equals("")) {
				CProjectworkpacksDAO.deleteProjectWorkpack(project_workpack_id);
			}
		} else if (actionType.equalsIgnoreCase("infoforedit")) {
			String projectWorkpackId = req.getParameter("projectWorkpackId") == null ? ""
					: req.getParameter("projectWorkpackId");
			CProjectworkpacksDTO cProjectworkpacksDTO = CProjectworkpacksDAO
					.getProjectWorkpackDetailsForEdit(projectWorkpackId);
			resp.setContentType("application/json");

			PrintWriter out = resp.getWriter();
			Gson gson = new Gson();
			out.println(gson.toJson(cProjectworkpacksDTO));
			return;
		} else if (actionType.equalsIgnoreCase("update")) {
			CProjectworkpacksDTO objProjectWorkpackDTO = new CProjectworkpacksDTO();

			objProjectWorkpackDTO.setProject_workpack_id(Integer.parseInt(req.getParameter("project_workpack_id")));
			objProjectWorkpackDTO.setProject_id(Integer.parseInt(req.getParameter("project_id")));

			objProjectWorkpackDTO.setWorkpack_id(Integer.parseInt(req.getParameter("workpack_id")));
			objProjectWorkpackDTO.setWorkpack_rate(Integer.parseInt(req.getParameter("workpack_rate")));
			objProjectWorkpackDTO.setWorkpack_standard_hours(Integer.parseInt(req.getParameter("workpack_standard_hours")));
			objProjectWorkpackDTO.setWorkpack_booked_hours(Integer.parseInt(req.getParameter("workpack_booked_hours")));
			objProjectWorkpackDTO.setWorkpack_start_date(req.getParameter("workpack_start_date"));
			objProjectWorkpackDTO.setWorkpack_end_date(req.getParameter("workpack_end_date"));

			if (CProjectworkpacksDAO.updateProjectWorkpackDetails(objProjectWorkpackDTO)) {
				System.out.println("Project Workpack update successfully");
			} else {
				System.out.println("Project Workpack updation failed!!!");
			}
		}

		ArrayList<CProjectworkpacksInfoDTO> cProjectWorkpackInfoDTO = cProjectworkpacksDAO
				.getProjectWorpackDetails(companyId);
		if (cProjectWorkpackInfoDTO != null) {
			req.getSession().setAttribute("projectWorkpackList", cProjectWorkpackInfoDTO);
		}
		resp.sendRedirect("projectsworkpack.jsp");
	}

}

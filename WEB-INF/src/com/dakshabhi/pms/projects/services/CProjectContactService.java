package com.dakshabhi.pms.projects.services;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dakshabhi.common.constants.ConfigConstants;
import com.dakshabhi.pms.customers.daos.CCustomerDAO;
import com.dakshabhi.pms.customers.dtos.CCustomerDTO;
import com.dakshabhi.pms.projects.daos.CProjectContactsDAO;
import com.dakshabhi.pms.projects.daos.CProjectDAO;
import com.dakshabhi.pms.projects.dtos.CProjectContactsDTO;
import com.dakshabhi.pms.projects.dtos.CProjectDTO;
import com.google.gson.Gson;

@WebServlet(value = "/projectcontacts")
public class CProjectContactService extends HttpServlet{
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		String actionType = req.getParameter("actionType") == null ? "" : req.getParameter("actionType");
		String companyId = ConfigConstants.getCompanyID(req.getSession());
		CProjectContactsDAO cProjectContactCustomerIdOnly =new CProjectContactsDAO();
		if (actionType.equalsIgnoreCase("save")) { // block for save new Project contacts
			try {
				CProjectContactsDTO projectContactsDTO = new CProjectContactsDTO();
				projectContactsDTO.setCustomer_id(Integer.parseInt(req.getParameter("customer_id")));
				projectContactsDTO.setProject_id(Integer.parseInt(req.getParameter("project_id")));
				projectContactsDTO.setContact_person_name(req.getParameter("contact_person_name"));
				projectContactsDTO.setContact_person_designation(req.getParameter("contact_person_designation"));
				projectContactsDTO.setContact_person_email(req.getParameter("contact_person_email"));
				projectContactsDTO.setContact_person_phone(req.getParameter("contact_person_phone"));
				
				CProjectContactsDAO dao = new CProjectContactsDAO();
				dao.saveProjectContact(projectContactsDTO,companyId);
				HttpSession session = req.getSession();
				session.setAttribute("projectContactsDTO", projectContactsDTO);

			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if (actionType.equalsIgnoreCase("getAllProjectName")){
			CProjectDAO cAllProjectNameByCutomerID =new CProjectDAO();
			try {
				int customer_id = Integer.parseInt(req.getParameter("id"));
				ArrayList<CProjectDTO> cProjectName = cAllProjectNameByCutomerID.getAllProjectNameByCutomerID(customer_id);
				resp.setContentType("application/json");
				PrintWriter out = resp.getWriter();
				Gson gson = new Gson();
				out.println(gson.toJson(cProjectName));
				return;
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if (actionType.equalsIgnoreCase("infoforedit")) {
			String projectContactId = req.getParameter("project_contact_id") == null ? "" : req.getParameter("project_contact_id");
			CProjectContactsDTO objCProjectContactInfoDTO = CProjectContactsDAO.getProjectContactDetailsForEdit(projectContactId);
			if (objCProjectContactInfoDTO != null) {
				req.getSession().removeAttribute("objCProjectContactInfoDTO");
				req.getSession().setAttribute("objCProjectContactInfoDTO", objCProjectContactInfoDTO);
				resp.sendRedirect("updateprojectcontact.jsp");
				return;
			}	
		}else if (actionType.equalsIgnoreCase("update")) {
			CProjectContactsDTO objProjectContactDTO = new CProjectContactsDTO();
			objProjectContactDTO.setProject_contact_id(Integer.parseInt(req.getParameter("projectContactId")));
			objProjectContactDTO.setCustomer_id(Integer.parseInt(req.getParameter("customer_id")));
			objProjectContactDTO.setProject_id(Integer.parseInt(req.getParameter("project_id")));
			objProjectContactDTO.setContact_person_name(req.getParameter("contact_person_name"));
			objProjectContactDTO.setContact_person_designation(req.getParameter("contact_person_designation"));
			objProjectContactDTO.setContact_person_email(req.getParameter("contact_person_email"));
			objProjectContactDTO.setContact_person_phone(req.getParameter("contact_person_phone"));
			if (CProjectContactsDAO.updateProjectContactDetails(objProjectContactDTO)) {
				System.out.println("Employee update successfully");
			} else {
				System.out.println("Employee updation failed!!!");
			}
			
		}else if (actionType.equalsIgnoreCase("deleteProjectContactById")) {
			String projectContactId = req.getParameter("id");
			CProjectContactsDAO.deleteProjectContact(projectContactId);
			
        }
		
		
		ArrayList<CProjectContactsDTO> cProject = cProjectContactCustomerIdOnly.getProjectContactCustomerIdOnly();
		if (cProject != null) {
			req.getSession().setAttribute("cProjectContactCustomerIdOnly", cProject);
			System.out.println(cProject);
		}
		
		CProjectContactsDAO cProjectContactsDAO = new CProjectContactsDAO();
		ArrayList<CProjectContactsDTO> cProjectContactsDTO = cProjectContactsDAO.getProjectContactDetails(companyId);
		if (cProjectContactsDTO != null) {
			req.getSession().setAttribute("projectcontactsList", cProjectContactsDTO);
		}
		
	     ArrayList<CProjectDTO> projectContactsDTOs = CProjectContactsDAO.getProjectsNameList(); 
	     if(projectContactsDTOs != null) {
	     req.getSession().setAttribute("projectNameList", projectContactsDTOs);
	     System.out.println(projectContactsDTOs); 
		  
		}
		  resp.sendRedirect("projectcontacts.jsp");
		

	
		
	}

}

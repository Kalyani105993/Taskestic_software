package com.dakshabhi.pms.customers.services;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dakshabhi.common.constants.ConfigConstants;
import com.dakshabhi.pms.customers.daos.CCustomerDAO;
import com.dakshabhi.pms.customers.dtos.CCustomerDTO;
import com.google.gson.Gson;

@WebServlet(value = "/customer")
public class CCustomersService extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		String actionType = req.getParameter("actionType") == null ? "" : req.getParameter("actionType");
		String companyId = ConfigConstants.getCompanyID(req.getSession());
		CCustomerDAO cCustomerDAO = new CCustomerDAO();
		if (actionType.equalsIgnoreCase("save")) { // block for save new customer
			try {
				CCustomerDTO detailsDTO = new CCustomerDTO();

				detailsDTO.setCompany_id(1);
				detailsDTO.setCustomer_name(req.getParameter("customer_name"));
				detailsDTO.setCustomer_address(req.getParameter("customer_address"));
				detailsDTO.setCustomer_email(req.getParameter("customer_email"));
				detailsDTO.setCustomer_phone(req.getParameter("customer_phone"));
				
				detailsDTO.setCustomer_alternate_emailId(req.getParameter("altcustomer_email"));
				detailsDTO.setCustomer_alternate_contact(req.getParameter("altcustomer_phone"));
				detailsDTO.setCustomer_type_id(Integer.parseInt(req.getParameter("customer_type")));

				CCustomerDAO dao = new CCustomerDAO();
				int status = 0;
				if (dao.saveCustomer(detailsDTO, companyId)) {
					status = 1;
				}
				resp.setContentType("application/json");

				resp.setCharacterEncoding("UTF-8");

				String json = new Gson().toJson(status);

				resp.getWriter().write(json);

				return;

			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (actionType.equalsIgnoreCase("deleteCustomerById")) { //Block for Delete Customer
			String customerId = req.getParameter("id");
			cCustomerDAO.deleteCustomer(customerId);

		} else if (actionType.equalsIgnoreCase("infoforedit")) {
			String customerId = req.getParameter("customer_id") == null ? "" : req.getParameter("customer_id");
			CCustomerDTO objCCustomerInfoDTO = cCustomerDAO.getCustomerDetailsForEdit(customerId);
			if (objCCustomerInfoDTO != null) {

				resp.setContentType("application/json");

				resp.setCharacterEncoding("UTF-8");

				String json = new Gson().toJson(objCCustomerInfoDTO);

				resp.getWriter().write(json);

				return;
			}
		} else if (actionType.equalsIgnoreCase("update")) {
			CCustomerDTO objCustomerDTO = new CCustomerDTO();
			objCustomerDTO.setCustomer_id(Integer.parseInt(req.getParameter("customer_id")));
			objCustomerDTO.setCompany_id(1);
			objCustomerDTO.setCustomer_name(req.getParameter("customer_name"));
			objCustomerDTO.setCustomer_address(req.getParameter("customer_address"));
			objCustomerDTO.setCustomer_email(req.getParameter("customer_email"));
			objCustomerDTO.setCustomer_phone(req.getParameter("customer_phone"));
			objCustomerDTO.setCustomer_alternate_emailId(req.getParameter("altcustomer_email"));
			objCustomerDTO.setCustomer_alternate_contact(req.getParameter("altcustomer_phone"));
			objCustomerDTO.setCustomer_type_id(Integer.parseInt(req.getParameter("editcustomer_type")));

			if (cCustomerDAO.updateCustomerDetails(objCustomerDTO, companyId)) {
				System.out.println("Customer update successfully");
				resp.setContentType("application/json");

				resp.setCharacterEncoding("UTF-8");

				String json = new Gson().toJson(cCustomerDAO);

				resp.getWriter().write(json);

			} else {
				System.out.println("Customer updation failed!!!");
			}

		} else if (actionType.equalsIgnoreCase("searchByData")) {
			try {
				int startIndex = 0;
				int endIndex = 10;
				String pageNo = req.getParameter("pageNo")== null ? "1" : req.getParameter("pageNo");
				String CustomerName = req.getParameter("name");
				String CustomerEmail = req.getParameter("email");
				String CustomerPhoneNo = req.getParameter("phone");

				Object[] customerInfoList = cCustomerDAO.getSearchData(CustomerName, CustomerEmail, CustomerPhoneNo,
						startIndex, endIndex, companyId, pageNo);

				resp.setContentType("application/json");

				resp.setCharacterEncoding("UTF-8");

				String json = new Gson().toJson(customerInfoList);

				resp.getWriter().write(json);

				return;

			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (actionType.equalsIgnoreCase("list")) {

			try {

				// ArrayList<CCustomerDTO> customerInfoList = cCustomerDAO.getCustomerDetails();
				int startIndex = 0;
				int endIndex = 10;
				String pageNo = req.getParameter("pageNo")== null ? "1" : req.getParameter("pageNo");
				System.out.println("page no cx is: "+pageNo); 
				/* ArrayList<CProjectInfoDTO> projectInfoList */
				Object[] list = cCustomerDAO.getCustomerDetails(startIndex, endIndex, companyId, pageNo);

				resp.setContentType("application/json");

				resp.setCharacterEncoding("UTF-8");

				String json = new Gson().toJson(list);

				resp.getWriter().write(json);

				return;

			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		/*
		 * if (!actionType.equalsIgnoreCase("searchByData")) {
		 * req.getSession().removeAttribute("customerList"); ArrayList<CCustomerDTO>
		 * cCustomerDTO = cCustomerDAO.getCustomerDetails(); if (cCustomerDTO != null) {
		 * req.getSession().setAttribute("customerList", cCustomerDTO); } }
		 */
		resp.sendRedirect("customer.jsp");

	}

}

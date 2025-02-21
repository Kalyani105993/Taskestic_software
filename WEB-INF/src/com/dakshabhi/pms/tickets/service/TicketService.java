package com.dakshabhi.pms.tickets.service;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.dakshabhi.pms.email.dtos.ReadMailDetailDTO;
import com.dakshabhi.pms.tickets.daos.TicketsDAO;
import com.google.gson.Gson;

@WebServlet("/ticketsService")
public class TicketService extends HttpServlet{

	
	/**
	 * Class for manage services related to tikets
	 * 
	 */
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		super.doGet(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String action_type = req.getParameter("actionType") == null ? "" : req.getParameter("actionType");
		String from_name = req.getParameter("from_name") == null ? "": req.getParameter("from_name");
		String from_email = req.getParameter("from_email") == null ? "": req.getParameter("from_email");
		String search_by = req.getParameter("search_by") == null ? "": req.getParameter("search_by");
		
		String pageNo = req.getParameter("pageNo") == null ? "1" : req.getParameter("pageNo");
		  TicketsDAO ticketsdao = new TicketsDAO();
		
		if (action_type.equalsIgnoreCase("showAllMaildetails")) {
			int startIndex = Integer.parseInt(req.getParameter("startIndex"));
			int endIndex = Integer.parseInt(req.getParameter("endIndex"));
			TicketsDAO ticketsDAO  =  new TicketsDAO();
			ArrayList<ReadMailDetailDTO> getmailDetails  = ticketsDAO.getAllMailList(startIndex,endIndex,pageNo);
			resp.setContentType("application/json");
			String json = new Gson().toJson(getmailDetails);
			resp.getWriter().write(json);
			return;
			
		}else if(action_type.equalsIgnoreCase("searchmaildetails")) {
			int startIndex = Integer.parseInt(req.getParameter("startIndex"));
			int endIndex = Integer.parseInt(req.getParameter("endIndex"));
			TicketsDAO ticketsDAO  =  new TicketsDAO();
			ArrayList<ReadMailDetailDTO> searchmailDetails = ticketsDAO.searchEmailDetails(from_name,from_email,search_by,startIndex,endIndex,pageNo);
			resp.setContentType("application/json");
			resp.setCharacterEncoding("UTF-8");
			String json = new Gson().toJson(searchmailDetails);
			resp.getWriter().write(json);
			return;
		}else if (action_type.equalsIgnoreCase("deleteEmailRecord")) { // delete email details
		    int pkid = Integer.parseInt(req.getParameter("pkid"));
		    int isDeleteEmail = ticketsdao.deleteEmail(pkid);
		    resp.setContentType("application/json");
		    resp.setCharacterEncoding("UTF-8");
		    String json = new Gson().toJson(isDeleteEmail);
		    resp.getWriter().write(json);
		    return;
		}
		else if (action_type.equalsIgnoreCase("viewEmailDetails")) { // getviewdata for specific user...
		    int pkid = Integer.parseInt(req.getParameter("pkid"));
		    ReadMailDetailDTO viewEmailDetail = TicketsDAO.viewEmailDetails(pkid);
		    resp.setContentType("application/json");
		    String json = new Gson().toJson(viewEmailDetail);
		    resp.getWriter().write(json);
		    return;
		}

	}
}

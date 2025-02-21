package com.dakshabhi.pms.users.services;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dakshabhi.pms.users.dtos.CUserLoginDTO;
import com.google.gson.Gson;
@WebServlet("/checksession")
public class CCheckSession extends HttpServlet{

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
		CUserLoginDTO cUserLoginDTO = (CUserLoginDTO)req.getSession().getAttribute("userLogin");
		
		resp.setContentType("application/json");
		PrintWriter out = resp.getWriter();
		Gson gson = new Gson();
		
		if(cUserLoginDTO == null){
			out.println(gson.toJson("Failure"));
		}else {
			out.println(gson.toJson("Success"));
		} 
	 
		return;
	}
}

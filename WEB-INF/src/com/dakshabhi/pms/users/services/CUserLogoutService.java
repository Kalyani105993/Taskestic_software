package com.dakshabhi.pms.users.services;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dakshabhi.pms.users.daos.CUserLoginDAO;
import com.dakshabhi.pms.users.dtos.CUserLoginDTO;
@WebServlet(value = "/userlogout")
public class CUserLogoutService  extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String deviceToken = req.getSession().getAttribute("deviceToken") == null ? "" : (String) req.getSession().getAttribute("deviceToken");
   		CUserLoginDTO cUserLoginDTO = CUserLoginDAO.removeDeviceToken(deviceToken);
		req.getSession().removeAttribute("userLogin");
		req.getSession().removeAttribute("allowAccess");
		req.getSession().invalidate();
		resp.sendRedirect("signin.jsp");
		return;
	}
}

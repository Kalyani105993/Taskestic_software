package com.dakshabhi.pms.api.services;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dakshabhi.pms.api.dtos.APIResponseDTO;
import com.dakshabhi.pms.tasks.daos.CTaskDAO;
import com.dakshabhi.pms.tasks.dtos.CTaskDTO;
import com.google.gson.Gson;

@WebServlet("/api/task/list")
public class TaskListAPI extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		APIResponseDTO responseDTO = new APIResponseDTO();
		responseDTO.setResponse(0);
		responseDTO.setReposneText("Declined. Method not allowed.");
		responseDTO.setResponseType("plain");
		resp.setContentType("application/json");
		String json = new Gson().toJson(responseDTO);
		resp.getWriter().write(json);
		return;
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String userId = req.getParameter("userid") == null ? "" : req.getParameter("userid");
		String apikey = req.getParameter("key") == null ? "" : req.getParameter("key");
		if (!apikey.equals("")) {
			CTaskDAO taskDAO = new CTaskDAO();
			ArrayList<CTaskDTO> taskList = taskDAO.getAssignedTaskList(userId);
			APIResponseDTO responseDTO = new APIResponseDTO();
			responseDTO.setResponse(1);
			responseDTO.setReposneText("Success");
			responseDTO.setResponseType("List"); 
			responseDTO.setResponseList(taskList);
			resp.setContentType("application/json");
			String json = new Gson().toJson(responseDTO);
			resp.getWriter().write(json);
			return;
		} else {
			APIResponseDTO responseDTO = new APIResponseDTO();
			responseDTO.setResponse(0);
			responseDTO.setReposneText("Declined. Invalid Request.");
			responseDTO.setResponseType("plain");
			resp.setContentType("application/json");
			String json = new Gson().toJson(responseDTO);
			resp.getWriter().write(json);
			return;
		}
	}
}

package com.dakshabhi.pms.workpaks.services;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dakshabhi.common.constants.ConfigConstants;
import com.dakshabhi.common.utility.StringUtility;
import com.dakshabhi.pms.workpaks.daos.CWorkpackDAO;
import com.dakshabhi.pms.workpaks.dtos.CWorkpackDTO;

@WebServlet(value = "/workpacks")
public class CWorkpacksService extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		doPost(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		CWorkpackDTO objWorkpackDTO = new CWorkpackDTO();
		CWorkpackDAO objWorkpackDAO = new CWorkpackDAO();

		String actionType = req.getParameter("actionType") == null ? "" : req.getParameter("actionType");
		String companyId = ConfigConstants.getCompanyID(req.getSession());
		if (actionType.equalsIgnoreCase("save")) {
			try {
				objWorkpackDTO.setCompany_id(1);
				objWorkpackDTO.setWorkpack_name(StringUtility.removeNull(req.getParameter("workpack_name")));
				objWorkpackDTO
						.setWorkpack_description(StringUtility.removeNull(req.getParameter("workpack_description")));

				objWorkpackDTO.setWorkpack_rate(Double.parseDouble(req.getParameter("workpack_rate")));
				objWorkpackDTO.setWorkpack_start_date(req.getParameter("workpack_start_date"));
				objWorkpackDTO.setWorkpack_end_date(req.getParameter("workpack_end_date"));
				objWorkpackDTO
						.setWorkpack_standard_hours(Integer.parseInt(req.getParameter("workpack_standard_hours")));

				objWorkpackDAO.saveWorkpack(objWorkpackDTO, companyId);

			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (actionType.equalsIgnoreCase("delete")) {
			String workpack_id = req.getParameter("workpack_id") == null ? "" : req.getParameter("workpack_id");
			if (!workpack_id.equals("")) {
				CWorkpackDAO.deleteWorkpack(workpack_id);
			}
		} else if (actionType.equalsIgnoreCase("infoforedit")) {
			String workpack_id = req.getParameter("workpack_id") == null ? "" : req.getParameter("workpack_id");
			CWorkpackDTO objWorkpackInfoDTO = CWorkpackDAO.getWorkpackDetailsById(workpack_id);
			if (objWorkpackInfoDTO != null) {
				req.getSession().removeAttribute("objWorkpackInfoDTO");
				req.getSession().setAttribute("objWorkpackInfoDTO", objWorkpackInfoDTO);
				resp.sendRedirect("updateworkpack.jsp");
				return;
			}
		} else if (actionType.equalsIgnoreCase("update")) {

			objWorkpackDTO.setWorkpack_id(Integer.parseInt(req.getParameter("workpack_id")));
			objWorkpackDTO.setWorkpack_name(StringUtility.removeNull(req.getParameter("workpack_name")));
			objWorkpackDTO.setWorkpack_description(StringUtility.removeNull(req.getParameter("workpack_description")));

			objWorkpackDTO.setWorkpack_rate(Double.parseDouble(req.getParameter("workpack_rate")));
			objWorkpackDTO.setWorkpack_start_date(req.getParameter("workpack_start_date"));
			objWorkpackDTO.setWorkpack_end_date(req.getParameter("workpack_end_date"));
			objWorkpackDTO.setWorkpack_standard_hours(Integer.parseInt(req.getParameter("workpack_standard_hours")));
			if (CWorkpackDAO.updateWorkpackDetails(objWorkpackDTO)) {
				System.out.println("Workpack update successfully");
			} else {
				System.out.println("Workpack updation failed!!!");
			}
		}

		ArrayList<CWorkpackDTO> cWorkpackDTOs = objWorkpackDAO.getWorkpackDetails();
		if (cWorkpackDTOs != null) {
			req.getSession().setAttribute("workpackList", cWorkpackDTOs);
		}
		resp.sendRedirect("workpacks.jsp");
	}

}

package com.dakshabhi.pms.profile.services;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;

import javax.naming.InitialContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import com.dakshabhi.pms.profile.daos.CProfileDAO;
import com.dakshabhi.pms.profile.dtos.CProfileDTO;
import com.google.gson.Gson;

@MultipartConfig
@WebServlet(value = "/profile")
public class CProfileService extends HttpServlet {

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

		if (actionType.equalsIgnoreCase("updatepassword")) {
			String userId = req.getParameter("userid") == null ? "" : req.getParameter("userid");
		
			String newPassword = req.getParameter("newPassword") == null ? "" : req.getParameter("newPassword");
			CProfileDAO cProfileDAO = new CProfileDAO();
			cProfileDAO.updatePassword(userId, newPassword);
			resp.sendRedirect("userprofile.jsp");
			return;

		} else if (actionType.equalsIgnoreCase("getData")) {
			CProfileDAO cProfileDAO = new CProfileDAO();
			CProfileDTO cProfileDTO = new CProfileDTO();
			cProfileDTO.setEmployee_id(Integer.parseInt(req.getParameter("employee_id")));
			CProfileDTO cProfileDTOData = cProfileDAO.getData(cProfileDTO);

			resp.setContentType("application/json");
			String json = new Gson().toJson(cProfileDTOData);
			System.out.println(cProfileDTOData.getEmployee_email());
			resp.getWriter().write(json);
			return;
		} else if (actionType.equalsIgnoreCase("update")) {
			CProfileDAO cProfileDAO = new CProfileDAO();
			CProfileDTO cProfileDTO = new CProfileDTO();
			cProfileDTO.setEmployee_id(Integer.parseInt(req.getParameter("employee_id")));
			cProfileDTO.setEmployee_name(req.getParameter("employee_name"));
			cProfileDTO.setEmployee_email(req.getParameter("employee_email"));
			cProfileDTO.setEmployee_phone(req.getParameter("employee_phone"));
			cProfileDTO.setAadhaar_card_no(req.getParameter("aadhar_card_no"));
			cProfileDTO.setPan_no(req.getParameter("pan_no"));
			cProfileDTO.setPassport_no(req.getParameter("passport_no"));
			cProfileDTO.setPermanent_address(req.getParameter("permanant_address"));
			cProfileDTO.setCurrent_address(req.getParameter("current_address"));
			cProfileDTO.setDOB(req.getParameter("date_of_birth"));
			cProfileDTO.setGender(req.getParameter("gender"));

			boolean data = cProfileDAO.updateData(cProfileDTO);
			if (data) {
				System.out.println("data updated successfully");
			} else {
				System.out.println("data not updated!");
			}
			resp.setContentType("application/json");
			String json = new Gson().toJson("success");
			resp.getWriter().write(json);
			return;
		} else if (actionType.equalsIgnoreCase("getProfilePhoto")) {
			CProfileDAO cProfileDAO = new CProfileDAO();
			CProfileDTO cProfileDTO = new CProfileDTO();
			cProfileDTO.setEmployee_id(Integer.parseInt(req.getParameter("employee_id")));
			CProfileDTO profilePhotoName = cProfileDAO.getProfilePhoto(cProfileDTO);
			profilePhotoName.setEmployee_id(Integer.parseInt(req.getParameter("employee_id")));
			resp.setContentType("application/json");
			String json = new Gson().toJson(profilePhotoName);
			resp.getWriter().write(json);
			return;

		} else if (actionType.equalsIgnoreCase("profilePhoto")) {
			CProfileDAO cProfileDAO = new CProfileDAO();
			CProfileDTO cProfileDTO = new CProfileDTO();
			System.out.println("successfully entered");

			Part file = req.getPart("image");

			System.out.println(file);
			String imageFileName = file.getSubmittedFileName();

			/* String imageFileName = req.getParameter("image"); */
			/* System.out.println(imageFileName); */

			/* System.out.println(imageFileName + "fileName"); */

			String id = req.getParameter("Id");

			/* System.out.println(id); */

			int employee_id = Integer.parseInt(id);
			/* System.out.println(employee_id); */
			cProfileDTO.setEmployee_id(employee_id);

			String uploadPath = "";
			try {
				InitialContext ic = new InitialContext(); 
				uploadPath = (String) ic.lookup("java:comp/env/profilepath");
				System.out.println(uploadPath);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			String uploadPathD = uploadPath + id;
			System.out.println(uploadPathD);

			try {
				File ProfilePhotoDirectory = new File(uploadPathD);

				System.out.println(ProfilePhotoDirectory);

				if (!ProfilePhotoDirectory.exists()) {
					if (ProfilePhotoDirectory.mkdirs()) {
						System.out.println("Profile_photo Directory is created!");
						FileOutputStream fos = new FileOutputStream(uploadPathD + "/" + imageFileName);

						cProfileDTO.setEmployee_id(employee_id);
						cProfileDTO.setProfilePhoto(imageFileName);

						cProfileDAO.updateProfilePhoto(cProfileDTO);

						InputStream is = file.getInputStream();

						byte[] data = new byte[is.available()];

						is.read(data);
						fos.write(data);
						fos.close();
					}
				} else {
					System.out.println("user id folder already exists uploading profile photo");
					CProfileDTO data = cProfileDAO.getProfilePhoto(cProfileDTO);
					System.out.println(data);

					File deleteexistfile = new File(uploadPathD + "/" + data.getProfilePhoto());
					/* System.out.println(deleteexistfile.getName()); */
					deleteexistfile.delete();
					/* System.out.println(deleteexistfile.getName()); */

					FileOutputStream fos = new FileOutputStream(uploadPathD + "/" + imageFileName);

					System.out.println(uploadPathD + "/" + imageFileName);
					cProfileDTO.setEmployee_id(employee_id);
					cProfileDTO.setProfilePhoto(imageFileName);

					cProfileDAO.updateProfilePhoto(cProfileDTO);

					InputStream is = file.getInputStream();

					byte[] data1 = new byte[is.available()];

					is.read(data1);
					fos.write(data1);
					fos.close();

				}
				resp.sendRedirect("userprofile.jsp");
				return;
			} catch (Exception e) {
				e.printStackTrace();
			}

			return;
		}

	}
}

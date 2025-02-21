package com.dakshabhi.pms.profile.daos;


import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.sql.ResultSet;

import com.dakshabhi.common.db.QueryHelper;
import com.dakshabhi.pms.profile.dtos.CProfileDTO;


import com.dakshabhi.common.db.QueryHelper;
import com.dakshabhi.common.security.EncryptionManager;
import com.dakshabhi.common.utility.StringUtility;


public class CProfileDAO {

	public boolean updatePassword(String userId, String newPassword) {

		QueryHelper qh = new QueryHelper();
		try {
			String sql = "update pms_empoyees set employee_password = ? where employee_id = ?";
			qh.addParam(EncryptionManager.encryptBlowfish(newPassword));
			qh.addParam(userId);
			qh.runQuery(sql);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}

		return false;

	}

	public CProfileDTO getData(CProfileDTO cProfileDTO) {
		QueryHelper qh = new QueryHelper();
		try {
			String sql = "SELECT * FROM employee_info_view WHERE employee_id=?";
			qh.addParam(cProfileDTO.getEmployee_id());
			ResultSet rs = qh.runQueryStreamResults(sql);
			
			if(rs.next()) {
				cProfileDTO.setEmployee_email(StringUtility.removeNull(rs.getString("employee_email")));
				cProfileDTO.setEmployee_name(StringUtility.removeNull(rs.getString("employee_name")));
				cProfileDTO.setEmployee_phone(StringUtility.removeNull(rs.getString("employee_phone")));
				cProfileDTO.setAadhaar_card_no(StringUtility.removeNull(rs.getString("aadhar_card_no")));
				cProfileDTO.setPan_no(StringUtility.removeNull(rs.getString("pan_no")));
				cProfileDTO.setPassport_no(StringUtility.removeNull(rs.getString("passport_no")));
				cProfileDTO.setPermanent_address(StringUtility.removeNull(rs.getString("permanant_address")));
				cProfileDTO.setCurrent_address(StringUtility.removeNull(rs.getString("current_address")));
				cProfileDTO.setGender(StringUtility.removeNull(rs.getString("gender")));
				cProfileDTO.setDOB(StringUtility.removeNull(rs.getString("date_of_birth")));
			}
			
		}  catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}
		
		return cProfileDTO;
	}

	public boolean updateData(CProfileDTO cProfileDTO) {
		QueryHelper qh = new QueryHelper();
		try {
			String sql = "UPDATE pms_empoyees SET employee_name = ?, employee_email = ?, employee_phone = ?, aadhar_card_no = ?, pan_no = ?, passport_no = ?, permanant_address = ?, current_address = ?, date_of_birth = ?, gender = ?, modified_by = "+cProfileDTO.getEmployee_id()+", modified_on = CURRENT_TIMESTAMP() WHERE employee_id=?";
			qh.addParam(cProfileDTO.getEmployee_name());
			qh.addParam(cProfileDTO.getEmployee_email());
			qh.addParam(cProfileDTO.getEmployee_phone());
			qh.addParam(cProfileDTO.getAadhaar_card_no());
			qh.addParam(cProfileDTO.getPan_no());
			qh.addParam(cProfileDTO.getPassport_no());
			qh.addParam(cProfileDTO.getPermanent_address());
			qh.addParam(cProfileDTO.getCurrent_address());
			qh.addParam(cProfileDTO.getDOB());
			qh.addParam(cProfileDTO.getGender());
			qh.addParam(cProfileDTO.getEmployee_id());
			qh.runQuery(sql);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}
		return false;
	}

	public boolean updateProfilePhoto(CProfileDTO cProfileDTO) {
		QueryHelper qh = new QueryHelper();
		try {
			String sql = "UPDATE pms_empoyees SET profile_photo = ?, modified_by = "+cProfileDTO.getEmployee_id()+", modified_on = CURRENT_TIMESTAMP() WHERE employee_id=?";
			qh.addParam(cProfileDTO.getProfilePhoto());
			qh.addParam(cProfileDTO.getEmployee_id());
			qh.runQuery(sql);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}	
		
		return false;
	}
	
	public CProfileDTO getProfilePhoto(CProfileDTO cProfileDTO) {
		QueryHelper qh = new QueryHelper();
		try {
			String sql = "SELECT * FROM employee_info_view WHERE employee_id=?";
			qh.addParam(cProfileDTO.getEmployee_id());
			ResultSet rs = qh.runQueryStreamResults(sql);
			
			if(rs.next()) {
				cProfileDTO.setProfilePhoto(StringUtility.removeNull(rs.getString("profile_photo")));
			}
			return cProfileDTO;
		}  catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}
		
		return cProfileDTO;
	}
	
	
}

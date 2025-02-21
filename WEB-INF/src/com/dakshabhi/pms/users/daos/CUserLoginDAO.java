package com.dakshabhi.pms.users.daos;

import java.sql.ResultSet;
import java.util.ArrayList;

import com.dakshabhi.common.db.QueryHelper;
import com.dakshabhi.common.security.EncryptionManager;
import com.dakshabhi.common.utility.StringUtility;
import com.dakshabhi.pms.companies.dtos.CCompanyDTO;
import com.dakshabhi.pms.users.dtos.CUserLoginDTO;

public class CUserLoginDAO {

	public static CUserLoginDTO getUserloginDetails(String companyId, String username, String password ,
			String deviceToken) {
		int employee_id;

		QueryHelper qh = new QueryHelper();
		try {
			String sql_user_login_info = "select * from employee_info_view where (employee_email = ?  or  employee_phone = ?) and employee_password = ? and is_deleted =0 and company_id = ?";
			qh.addParam(username);
			qh.addParam(username);
			qh.addParam(EncryptionManager.encryptBlowfish(password));
			qh.addParam(companyId);
			ResultSet rs = qh.runQueryStreamResults(sql_user_login_info);
			if (rs.next()) {
				CUserLoginDTO cUserLoginDTO = new CUserLoginDTO();
				cUserLoginDTO.setUser_login_id(rs.getInt("employee_id"));
				employee_id = rs.getInt("employee_id");
				cUserLoginDTO.setUser_full_name(StringUtility.removeNull(rs.getString("employee_name")));
				cUserLoginDTO.setUser_email(StringUtility.removeNull(rs.getString("employee_email")));
				cUserLoginDTO.setIs_active(StringUtility.removeNull(rs.getString("is_active")));
				//cUserLoginDTO.setEmployee_phone(StringUtility.removeNull(rs.getString("employee_phone")));
				cUserLoginDTO.setUser_role(rs.getInt("employee_role"));
				cUserLoginDTO.setUser_role_type(rs.getInt("employee_role_type"));
				if(!deviceToken.equals("")) {
					saveDeviceToken(employee_id, deviceToken);
				}
				return cUserLoginDTO;
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}
		return null;
	} 

	public static boolean saveDeviceToken(int employee_id, String deviceToken) {
		QueryHelper qh = new QueryHelper();
		try {
			String sql_to_check_token = "SELECT * from pms_user_device_details where user_id = ? and device_token = ?";
			qh.addParam(employee_id);
			qh.addParam(deviceToken);
			ResultSet resultSet = qh.runQueryStreamResults(sql_to_check_token);
			if (!resultSet.next()) {
				String sql = "INSERT INTO pms_user_device_details (user_id, device_token)values (?, ?)";
				qh.addParam(employee_id);
				qh.addParam(deviceToken);
				qh.runQuery(sql);				
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}
		return false;
	}

	public String getuserPassword(String email, String companyId) {

		QueryHelper qh = new QueryHelper();
		try {
			String sql = "select employee_password from pms_empoyees where is_deleted =0 and employee_email = ? and   company_id = ?";
			qh.addParam(email);
			qh.addParam(companyId);
			ResultSet rs = qh.runQueryStreamResults(sql);
			if (rs.next())
				return StringUtility.removeNull(rs.getString("employee_password"));
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}

		return "";
	}

	public static CUserLoginDTO removeDeviceToken(String deviceToken) {
		QueryHelper qh = new QueryHelper();
		try {
			String sql ="DELETE FROM pms_user_device_details WHERE  device_token = ?";
			qh.addParam(deviceToken);
			qh.runQuery(sql);	
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			qh.releaseConnection();
		}
		return null 
				;
	}

}

package com.dakshabhi.pms.masters.daos;

import java.sql.ResultSet;
import java.util.ArrayList;

import com.dakshabhi.common.db.QueryHelper;
import com.dakshabhi.common.utility.StringUtility;
import com.dakshabhi.pms.masters.dtos.CCustomerTypeDTO;
import com.dakshabhi.pms.masters.dtos.CEmployeeStatusDTO;

public class CEmployeeStatusDAO {

	public static ArrayList<CEmployeeStatusDTO> getEmployeeStatusList(String CompanyID) {
		ArrayList<CEmployeeStatusDTO> cEmployeeStatusDTOList = null;
		CEmployeeStatusDTO cEmployeeStatusDTO = null;
		QueryHelper qh = new QueryHelper();
		try {
			String SqlEmployee = "SELECT * FROM pms_mst_employee_status where company_id = ? and is_deleted = '0' order by is_default desc";
			qh.addParam(CompanyID);
			ResultSet rs = qh.runQueryStreamResults(SqlEmployee);
			while (rs.next()) {
				if (cEmployeeStatusDTOList == null) {
					cEmployeeStatusDTOList = new ArrayList<CEmployeeStatusDTO>();
				}
				cEmployeeStatusDTO = new CEmployeeStatusDTO();
				cEmployeeStatusDTO.setEmployee_status_id(rs.getInt("employee_status_id"));
				cEmployeeStatusDTO.setCompany_id(rs.getInt("company_id"));
				cEmployeeStatusDTO.setEmployee_status_name(rs.getString("employee_status_name"));
				cEmployeeStatusDTO.setEmploye_role_desc(StringUtility.removeNull(rs.getString("Employe_role_desc")));
				cEmployeeStatusDTOList.add(cEmployeeStatusDTO);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return cEmployeeStatusDTOList;
	}

	public static boolean deleteEmployeeStatus(int pkid) {
		QueryHelper qh = new QueryHelper();
		try {
			String SQL = "DELETE from pms_mst_employee_status where employee_status_id = ?";
			qh.addParam(pkid);
			qh.runQuery(SQL);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}
		return false;
		
	}

	public static boolean createEmployeeStatus(int companyid, String empStatus) {
		QueryHelper qh = new QueryHelper();
		try {
			String SQL = "INSERT INTO pms_mst_employee_status (employee_status_name, company_id) VALUES (?,?) ";
			qh.addParam(empStatus);
			qh.addParam(companyid);
			qh.runQuery(SQL);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}
		return false;
		
	}

	public static ArrayList<CEmployeeStatusDTO> populateData(int id) {

		ArrayList<CEmployeeStatusDTO> EmployeeStatusList = new ArrayList<CEmployeeStatusDTO>();
		
		QueryHelper qh = new QueryHelper();
		try {
			String SQL = "SELECT * FROM pms_mst_employee_status where employee_status_id = ?";
			qh.addParam(id);
			ResultSet rs = qh.runQueryStreamResults(SQL);
			
			while(rs.next()) {
				CEmployeeStatusDTO cEmployeeStatusDTO = new CEmployeeStatusDTO();
				
				
				cEmployeeStatusDTO.setCompany_id(rs.getInt("company_id"));
				cEmployeeStatusDTO.setEmployee_status_id(rs.getInt("employee_status_id"));
				cEmployeeStatusDTO.setEmployee_status_name(StringUtility.removeNull(rs.getString("employee_status_name")));
				
				EmployeeStatusList.add(cEmployeeStatusDTO);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.closeConnection();
		}
		return EmployeeStatusList;
	}

	public static boolean updateEmployeeStatus(int id, String empStatus) {
		QueryHelper qh = new QueryHelper();
		try {
			String SQL = "UPDATE pms_mst_employee_status SET employee_status_name = ? WHERE employee_status_id = ?";
			qh.addParam(empStatus);
			qh.addParam(id);
			qh.runQuery(SQL);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			qh.closeConnection();
		}
		return false;
		
	}

}

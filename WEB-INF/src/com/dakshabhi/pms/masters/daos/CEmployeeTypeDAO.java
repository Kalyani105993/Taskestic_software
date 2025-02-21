package com.dakshabhi.pms.masters.daos;

import java.sql.ResultSet;
import java.util.ArrayList;

import com.dakshabhi.common.db.QueryHelper;
import com.dakshabhi.common.utility.StringUtility;
import com.dakshabhi.pms.masters.dtos.CEmployeeStatusDTO;
import com.dakshabhi.pms.masters.dtos.CEmployeeTypeDTO;

public class CEmployeeTypeDAO {

	public static ArrayList<CEmployeeTypeDTO> getEmployeeTypeList(String CompanyID) {
		ArrayList<CEmployeeTypeDTO> cEmployeeTypeList = null;
		QueryHelper qh = new QueryHelper();
		CEmployeeTypeDTO cEmployeeTypeDTO = null;
		try {
			String SqlEmployee = "SELECT * FROM pms_mst_employee_type where is_deleted = 0 and company_id = ? order by is_default desc";
			qh.addParam(CompanyID);
			ResultSet rs = qh.runQueryStreamResults(SqlEmployee);
			while (rs.next()) {
				if (cEmployeeTypeList == null) {
					cEmployeeTypeList = new ArrayList<CEmployeeTypeDTO>();
				}
				cEmployeeTypeDTO = new CEmployeeTypeDTO();
				cEmployeeTypeDTO.setEmployee_type_id(rs.getInt("employee_type_id"));
				cEmployeeTypeDTO.setEmployee_type_name(rs.getString("employee_type_name"));
				cEmployeeTypeDTO.setCompany_id(rs.getInt("company_id"));
				cEmployeeTypeList.add(cEmployeeTypeDTO);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}
		return cEmployeeTypeList;
	}

	public static boolean deleteEmployeeType(int pkid) {
		QueryHelper qh = new QueryHelper();
		try {
			String SQL = "DELETE from pms_mst_employee_type where employee_type_id = ?";
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

	public static boolean createEmployeeType(int companyid, String empType) {
		QueryHelper qh = new QueryHelper();
		try {
			String SQL = "INSERT INTO pms_mst_employee_type (employee_type_name, company_id) VALUES (?,?) ";
			qh.addParam(empType);
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

	public static ArrayList<CEmployeeTypeDTO> populateData(int id) {

		ArrayList<CEmployeeTypeDTO> EmployeeTypeList = new ArrayList<CEmployeeTypeDTO>();
		
		QueryHelper qh = new QueryHelper();
		try {
			String SQL = "SELECT * FROM pms_mst_employee_type where employee_type_id = ?";
			qh.addParam(id);
			ResultSet rs = qh.runQueryStreamResults(SQL);
			
			while(rs.next()) {
				CEmployeeTypeDTO cEmployeeTypeDTO = new CEmployeeTypeDTO();
				
				
				cEmployeeTypeDTO.setCompany_id(rs.getInt("company_id"));
				cEmployeeTypeDTO.setEmployee_type_id(rs.getInt("employee_type_id"));
				cEmployeeTypeDTO.setEmployee_type_name(StringUtility.removeNull(rs.getString("employee_type_name")));
				
				EmployeeTypeList.add(cEmployeeTypeDTO);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.closeConnection();
		}
		return EmployeeTypeList;
	}

	public static boolean updateEmployeeType(int id, String empType) {
		QueryHelper qh = new QueryHelper();
		try {
			String SQL = "UPDATE pms_mst_employee_type SET employee_type_name = ? WHERE employee_type_id = ?";
			qh.addParam(empType);
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

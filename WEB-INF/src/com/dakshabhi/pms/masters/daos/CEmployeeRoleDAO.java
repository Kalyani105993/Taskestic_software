package com.dakshabhi.pms.masters.daos;

import java.sql.ResultSet;
import java.util.ArrayList;

import com.dakshabhi.common.db.QueryHelper;
import com.dakshabhi.common.utility.StringUtility;
import com.dakshabhi.pms.masters.dtos.CCustomerTypeDTO;
import com.dakshabhi.pms.masters.dtos.CEmployeeRoleDTO;

public class CEmployeeRoleDAO {

	public static ArrayList<CEmployeeRoleDTO> getEmployeeRoleList(String CompanyID) {
		ArrayList<CEmployeeRoleDTO> employeeRoleList = null;
		QueryHelper qh = new QueryHelper();
		CEmployeeRoleDTO employeeRoleDTO = null;
		try {
			String sqlEmployeeRoleList = "SELECT * FROM pms_mst_employee_role where company_id = ? order by is_default desc";
			qh.addParam(CompanyID);
			ResultSet rs = qh.runQueryStreamResults(sqlEmployeeRoleList);
			while(rs.next()) {
				if(employeeRoleList == null) {
					employeeRoleList = new ArrayList<CEmployeeRoleDTO>();
				}
				employeeRoleDTO = new CEmployeeRoleDTO();
				employeeRoleDTO.setEmployee_role_id(rs.getInt("employee_role_id"));
				employeeRoleDTO.setEmploye_role_name(StringUtility.removeNull(rs.getString("employe_role_name")));
				employeeRoleDTO.setEmploye_role_desc(StringUtility.removeNull(rs.getString("Employe_role_desc")));
				employeeRoleList.add(employeeRoleDTO);
			}
		} catch (Exception e) {
			qh.releaseConnection();
		}
		return employeeRoleList;
	}

	public static boolean deleteEmployeeRole(int pkid) {
		QueryHelper qh = new QueryHelper();
		try {
			String SQL = "DELETE from pms_mst_employee_role where employee_role_id = ?";
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

	public static boolean createEmployeeRole(int companyid, String empRole) {
		QueryHelper qh = new QueryHelper();
		try {
			String SQL = "INSERT INTO pms_mst_employee_role (employe_role_name, company_id) VALUES (?,?) ";
			qh.addParam(empRole);
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

	public static ArrayList<CEmployeeRoleDTO> populateData(int id) {

		ArrayList<CEmployeeRoleDTO> EmployeeRoleList = new ArrayList<CEmployeeRoleDTO>();
		
		QueryHelper qh = new QueryHelper();
		try {
			String SQL = "SELECT * FROM pms_mst_employee_role where employee_role_id = ?";
			qh.addParam(id);
			ResultSet rs = qh.runQueryStreamResults(SQL);
			
			while(rs.next()) {
				CEmployeeRoleDTO cEmployeeRoleDTO = new CEmployeeRoleDTO();
				
				
				cEmployeeRoleDTO.setCompany_id(rs.getInt("company_id"));
				cEmployeeRoleDTO.setEmployee_role_id(rs.getInt("employee_role_id"));
				cEmployeeRoleDTO.setEmploye_role_name(StringUtility.removeNull(rs.getString("employe_role_name")));
				
				EmployeeRoleList.add(cEmployeeRoleDTO);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.closeConnection();
		}
		return EmployeeRoleList;
	}

	public static boolean updateEmployeeRole(int id, String empRole) {
		QueryHelper qh = new QueryHelper();
		try {
			String SQL = "UPDATE pms_mst_employee_role SET employe_role_name = ? WHERE employee_role_id = ?";
			qh.addParam(empRole);
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

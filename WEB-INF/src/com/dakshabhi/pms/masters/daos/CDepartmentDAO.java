package com.dakshabhi.pms.masters.daos;

import java.sql.ResultSet;
import java.util.ArrayList;

import com.dakshabhi.common.db.QueryHelper;
import com.dakshabhi.common.utility.StringUtility;
import com.dakshabhi.pms.masters.dtos.CCustomerTypeDTO;
import com.dakshabhi.pms.masters.dtos.CDepartmentDTO;

public class CDepartmentDAO {

	public static ArrayList<CDepartmentDTO> getDepartmentList(String CompanyID) {
		ArrayList<CDepartmentDTO> departmentList = null;
		QueryHelper qh = new QueryHelper();
		CDepartmentDTO departmentDTO = null;
		try {
			String sqlDepartmentList = "select * from pms_mst_department where is_deleted = '0' and  company_id = ? order by is_default desc";
			qh.addParam(CompanyID);
			ResultSet rs = qh.runQueryStreamResults(sqlDepartmentList);
			while(rs.next()) {
				if(departmentList == null) {
					departmentList = new ArrayList<CDepartmentDTO>();
				}
				departmentDTO = new CDepartmentDTO();
				departmentDTO.setDepartment_id(rs.getInt("department_id"));
				departmentDTO.setDepartment_name(StringUtility.removeNull(rs.getString("department_name")));
				departmentList.add(departmentDTO);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			qh.releaseConnection();
		}

		return departmentList;
	}

	public static boolean deleteDepartmentType(int pkid) {
		QueryHelper qh = new QueryHelper();
		try {
			String SQL = "DELETE from pms_mst_department where department_id = ?";
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

	public static boolean createDepartmentType(int companyid, String department) {
		QueryHelper qh = new QueryHelper();
		try {
			String SQL = "INSERT INTO pms_mst_department (department_name, company_id) VALUES (?, ?)";
			qh.addParam(department);
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

	public static ArrayList<CDepartmentDTO> populateData(int id) {

		ArrayList<CDepartmentDTO> DepartmentList = new ArrayList<CDepartmentDTO>();
		
		QueryHelper qh = new QueryHelper();
		try {
			String SQL = "SELECT * FROM pms_mst_department where department_id = ?";
			qh.addParam(id);
			ResultSet rs = qh.runQueryStreamResults(SQL);
			
			while(rs.next()) {
				CDepartmentDTO cDepartmentDTO = new CDepartmentDTO();
				
				
				cDepartmentDTO.setDepartment_id(rs.getInt("department_id"));
				cDepartmentDTO.setDepartment_name(StringUtility.removeNull(rs.getString("department_name")));
				cDepartmentDTO.setCompany_id(rs.getInt("company_id"));
				cDepartmentDTO.setIs_active(rs.getInt("is_active"));
				cDepartmentDTO.setIs_deleted(rs.getInt("is_deleted"));
				
				DepartmentList.add(cDepartmentDTO);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.closeConnection();
		}
		return DepartmentList;	
	}

	public static boolean updateDepartmentType(int id, String department) {
		QueryHelper qh = new QueryHelper();
		try {
			String SQL = "UPDATE pms_mst_department SET department_name = ? WHERE department_id = ?";
			qh.addParam(department);
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

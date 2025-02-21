package com.dakshabhi.pms.masters.daos;

import java.sql.ResultSet;
import java.util.ArrayList;

import com.dakshabhi.common.db.QueryHelper;
import com.dakshabhi.common.utility.StringUtility;
import com.dakshabhi.pms.masters.dtos.CProjectGroupDTO;
import com.dakshabhi.pms.masters.dtos.CProjectTypeDTO;

public class CProjectTypeDAO {

	public static ArrayList<CProjectTypeDTO> getProjectType(String CompanyID) {
		ArrayList<CProjectTypeDTO> projectType = null;
		QueryHelper qh = new QueryHelper();
		CProjectTypeDTO projectTypeDTO = null;
		try {
			String sqlSubGroupList = "select * from pms_mst_project_type where company_id = ? and is_deleted = 0 order by is_default desc";
			qh.addParam(CompanyID);
			ResultSet rs = qh.runQueryStreamResults(sqlSubGroupList);
			while(rs.next()) {
				if(projectType == null) {
					projectType = new ArrayList<CProjectTypeDTO>();
				}
				projectTypeDTO = new CProjectTypeDTO();
				projectTypeDTO.setProject_type_id(rs.getInt("project_type_id"));
				projectTypeDTO.setProject_type(StringUtility.removeNull(rs.getString("project_type")));
				projectType.add(projectTypeDTO);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			qh.releaseConnection();
		}

		return projectType;
	}

	public static boolean deleteProjectType(int pkid) {
		QueryHelper qh = new QueryHelper();
		try {
			String SQL = "DELETE from pms_mst_project_type where project_type_id = ?";
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

	public static boolean createProjectType(int companyid, String projectType) {
		QueryHelper qh = new QueryHelper();
		try {
			String SQL = "INSERT INTO pms_mst_project_type (project_type, company_id) VALUES (?,?) ";
			qh.addParam(projectType);
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

	public static ArrayList<CProjectTypeDTO> populateData(int id) {

		ArrayList<CProjectTypeDTO> ProjectTypeList = new ArrayList<CProjectTypeDTO>();
		
		QueryHelper qh = new QueryHelper();
		try {
			String SQL = "SELECT * FROM pms_mst_project_type where project_type_id = ?";
			qh.addParam(id);
			ResultSet rs = qh.runQueryStreamResults(SQL);
			
			while(rs.next()) {
				CProjectTypeDTO cProjectTypeDTO = new CProjectTypeDTO();
				
				
				cProjectTypeDTO.setCompany_id(rs.getInt("company_id"));
				cProjectTypeDTO.setIs_deleted(rs.getInt("is_deleted"));
				cProjectTypeDTO.setProject_type(StringUtility.removeNull(rs.getString("project_type")));
				cProjectTypeDTO.setProject_type_id(rs.getInt("project_type_id"));
				
				ProjectTypeList.add(cProjectTypeDTO);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.closeConnection();
		}
		return ProjectTypeList;
	}

	public static boolean updateProjectType(int id, String projectType) {
		QueryHelper qh = new QueryHelper();
		try {
			String SQL = "UPDATE pms_mst_project_type SET project_type = ? WHERE project_type_id = ?";
			qh.addParam(projectType);
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

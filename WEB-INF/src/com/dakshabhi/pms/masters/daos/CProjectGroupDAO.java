package com.dakshabhi.pms.masters.daos;

import java.sql.ResultSet;
import java.util.ArrayList;

import com.dakshabhi.common.db.QueryHelper;
import com.dakshabhi.common.utility.StringUtility;
import com.dakshabhi.pms.masters.dtos.CEmployeeTypeDTO;
import com.dakshabhi.pms.masters.dtos.CProjectGroupDTO;

public class CProjectGroupDAO {

	public static ArrayList<CProjectGroupDTO> getProjectGroupList(String CompanyID) {

		ArrayList<CProjectGroupDTO> projectGroupList = null;
		QueryHelper qh = new QueryHelper();
		CProjectGroupDTO projectGroupDTO = null;
		try {
			String sqlGroupList = "select * from pms_mst_project_groups where company_id = ?";
			qh.addParam(CompanyID);
			ResultSet rs = qh.runQueryStreamResults(sqlGroupList);
			while(rs.next()) {
				if(projectGroupList == null) {
					projectGroupList = new ArrayList<CProjectGroupDTO>();
				}
				projectGroupDTO = new CProjectGroupDTO();
				projectGroupDTO.setProject_group_id(rs.getInt("project_group_id"));
				projectGroupDTO.setProject_group_name(StringUtility.removeNull(rs.getString("project_group")));
				projectGroupList.add(projectGroupDTO);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			qh.releaseConnection();
		}

		return projectGroupList;

	}

	public static boolean deleteProjectGroup(int pkid) {
		QueryHelper qh = new QueryHelper();
		try {
			String SQL = "DELETE from pms_mst_project_groups where project_group_id = ?";
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

	public static boolean createProjectGroup(int companyid, String projectGroup) {
		QueryHelper qh = new QueryHelper();
		try {
			String SQL = "INSERT INTO pms_mst_project_groups (project_group, company_id) VALUES (?,?) ";
			qh.addParam(projectGroup);
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

	public static ArrayList<CProjectGroupDTO> getprojectGroupID(String companyId) {
		
		ArrayList<CProjectGroupDTO> projectGroup = null;
		QueryHelper qh = new QueryHelper();
		CProjectGroupDTO cProjectGroupDTO = null;
		try {
			String sqlGroupList = "select * from pms_mst_project_groups where company_id = ?";
			qh.addParam(companyId);
			ResultSet rs = qh.runQueryStreamResults(sqlGroupList);
			while(rs.next()) {
				if(projectGroup == null) {
					projectGroup = new ArrayList<CProjectGroupDTO>();
				}
				cProjectGroupDTO = new CProjectGroupDTO();
				cProjectGroupDTO.setProject_group_id(rs.getInt("project_group_id"));
				cProjectGroupDTO.setProject_group_name(StringUtility.removeNull(rs.getString("project_group")));
				projectGroup.add(cProjectGroupDTO);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			qh.releaseConnection();
		}

		return projectGroup;
	}

	public static ArrayList<CProjectGroupDTO> populateData(int id) {

		ArrayList<CProjectGroupDTO> ProjectGroupList = new ArrayList<CProjectGroupDTO>();
		
		QueryHelper qh = new QueryHelper();
		try {
			String SQL = "SELECT * FROM pms_mst_project_groups where project_group_id = ?";
			qh.addParam(id);
			ResultSet rs = qh.runQueryStreamResults(SQL);
			
			while(rs.next()) {
				CProjectGroupDTO cProjectGroupDTO = new CProjectGroupDTO();
				
				
				cProjectGroupDTO.setProject_group_id(rs.getInt("project_group_id"));
				cProjectGroupDTO.setProject_group_name(StringUtility.removeNull(rs.getString("project_group")));
				
				ProjectGroupList.add(cProjectGroupDTO);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.closeConnection();
		}
		return ProjectGroupList;
	}

	public static boolean updateProjectGroup(int id, String projectGroup) {
		QueryHelper qh = new QueryHelper();
		try {
			String SQL = "UPDATE pms_mst_project_groups SET project_group = ? WHERE project_group_id = ?";
			qh.addParam(projectGroup);
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

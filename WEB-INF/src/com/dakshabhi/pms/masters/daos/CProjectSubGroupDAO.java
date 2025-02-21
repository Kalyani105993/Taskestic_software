package com.dakshabhi.pms.masters.daos;

import java.sql.ResultSet;
import java.util.ArrayList;

import com.dakshabhi.common.db.QueryHelper;
import com.dakshabhi.common.utility.StringUtility;
import com.dakshabhi.pms.masters.dtos.CProjectGroupDTO;
import com.dakshabhi.pms.masters.dtos.CProjectSubGroupDTO;

public class CProjectSubGroupDAO {

	public static ArrayList<CProjectSubGroupDTO> getProjectSubGroupList(String CompanyID) {
		ArrayList<CProjectSubGroupDTO> projectSubGroupList = null;
		QueryHelper qh = new QueryHelper();
		CProjectSubGroupDTO projectSubGroupDTO = null;
		try {
			String sqlSubGroupList = "select * from pms_mst_project_sub_groups where company_id = ?";
			qh.addParam(CompanyID);
			ResultSet rs = qh.runQueryStreamResults(sqlSubGroupList);
			while(rs.next()) {
				if(projectSubGroupList == null) {
					projectSubGroupList = new ArrayList<CProjectSubGroupDTO>();
				}
				projectSubGroupDTO = new CProjectSubGroupDTO();
				projectSubGroupDTO.setProject_sub_group_id(rs.getInt("project_sub_group_id"));
				projectSubGroupDTO.setProject_sub_group(StringUtility.removeNull(rs.getString("project_sub_group")));
				projectSubGroupList.add(projectSubGroupDTO);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			qh.releaseConnection();
		}

		return projectSubGroupList;

	}

	public static boolean deleteProjectSubGroup(int pkid) {
		QueryHelper qh = new QueryHelper();
		try {
			String SQL = "DELETE from pms_mst_project_sub_groups where project_sub_group_id = ? ";
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

	public static boolean createProjectSubGroup(int companyid, String projectSubGroup, int projectGroupId) {
		QueryHelper qh = new QueryHelper();
		try {
			String SQL = "INSERT INTO pms_mst_project_sub_groups (project_sub_group, company_id, project_group_id) VALUES (?,?,?) ";
			qh.addParam(projectSubGroup);
			qh.addParam(companyid);
			qh.addParam(projectGroupId);
			qh.runQuery(SQL);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}
		return false;
		
	}

	public static ArrayList<CProjectSubGroupDTO> populateData(int id) {

		ArrayList<CProjectSubGroupDTO> ProjectSubGroupList = new ArrayList<CProjectSubGroupDTO>();
		
		QueryHelper qh = new QueryHelper();
		try {
			String SQL = "SELECT * FROM pms_mst_project_sub_groups where project_sub_group_id = ?";
			qh.addParam(id);
			ResultSet rs = qh.runQueryStreamResults(SQL);
			
			while(rs.next()) {
				CProjectSubGroupDTO cProjectSubGroupDTO = new CProjectSubGroupDTO();
				
				cProjectSubGroupDTO.setProject_group_id(rs.getInt("project_group_id"));
				cProjectSubGroupDTO.setProject_sub_group(StringUtility.removeNull(rs.getString("project_sub_group")));
				cProjectSubGroupDTO.setProject_sub_group_id(rs.getInt("project_sub_group_id"));
				
				ProjectSubGroupList.add(cProjectSubGroupDTO);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.closeConnection();
		}
		return ProjectSubGroupList;
	}

	public static boolean updateProjectSubGroup(int id, String projectSubGroup, int projectGroupId) {
		QueryHelper qh = new QueryHelper();
		try {
			String SQL = "UPDATE pms_mst_project_sub_groups SET project_sub_group = ?, project_group_id = ?  WHERE project_sub_group_id = ?";
			qh.addParam(projectSubGroup);
			qh.addParam(projectGroupId);
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

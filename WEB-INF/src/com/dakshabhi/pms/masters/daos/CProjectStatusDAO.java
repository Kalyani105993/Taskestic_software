package com.dakshabhi.pms.masters.daos;

import java.sql.ResultSet;
import java.util.ArrayList;

import com.dakshabhi.common.db.QueryHelper;
import com.dakshabhi.common.utility.StringUtility;
import com.dakshabhi.pms.masters.dtos.CProjectStatusDTO;

public class CProjectStatusDAO {

	public static ArrayList<CProjectStatusDTO> getProjectStatusList(String CompanyID) {

		ArrayList<CProjectStatusDTO> projectStatusList = null;
		CProjectStatusDTO projectStatusDTO = null;
		QueryHelper qh = new QueryHelper();
		try {
			String sqlProjectStatus = "select * from pms_mst_project_status where company_id = ? and is_deleted = 0  order by is_default desc";
			qh.addParam(CompanyID);
			ResultSet rs = qh.runQueryStreamResults(sqlProjectStatus);
			while (rs.next()) {
				if (projectStatusList == null) {
					projectStatusList = new ArrayList<CProjectStatusDTO>();
				}
				projectStatusDTO = new CProjectStatusDTO();
				projectStatusDTO.setProject_status_id(rs.getInt("project_status_id"));
				projectStatusDTO.setProject_status(StringUtility.removeNull(rs.getString("project_status")));
				projectStatusDTO.setProject_role_desc(StringUtility.removeNull(rs.getString("project_role_desc")));
				projectStatusList.add(projectStatusDTO);

			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}

		return projectStatusList;

	}

	public static boolean deleteProjectStatus(int pkid) {
		QueryHelper qh = new QueryHelper();
		try {
			String SQL = "DELETE from pms_mst_project_status where project_status_id = ?";
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

	public static boolean createProjectStatus(int companyid, String projectStatus) {
		QueryHelper qh = new QueryHelper();
		try {
			String SQL = "INSERT INTO pms_mst_project_status (project_status, company_id) VALUES (?,?) ";
			qh.addParam(projectStatus);
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

	public static boolean updateProjectStatus(int id, String projectStatus) {
		QueryHelper qh = new QueryHelper();
		try {
			String SQL = "UPDATE pms_mst_project_status SET project_status = ? WHERE project_status_id = ?";
			qh.addParam(projectStatus);
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

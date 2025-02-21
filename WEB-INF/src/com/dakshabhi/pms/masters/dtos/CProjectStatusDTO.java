package com.dakshabhi.pms.masters.dtos;

import java.sql.ResultSet;
import java.util.ArrayList;

import com.dakshabhi.common.db.QueryHelper;
import com.dakshabhi.common.utility.StringUtility;

public class CProjectStatusDTO {

	private int project_status_id;
	private String project_status;
	private String project_role_desc;

	public int getProject_status_id() {
		return project_status_id;
	}
    public void setProject_status_id(int project_status_id) {
		this.project_status_id = project_status_id;
	}
	public String getProject_status() {
		return project_status;
	}
   public void setProject_status(String project_status) {
		this.project_status = project_status;
	}
	public String getProject_role_desc() {
		return project_role_desc;
	}
    public void setProject_role_desc(String project_role_desc) {
		this.project_role_desc = project_role_desc;
	}

	public static ArrayList<CProjectStatusDTO> populateData(int id) {

		ArrayList<CProjectStatusDTO> EmployeeTypeList = new ArrayList<CProjectStatusDTO>();
		
		QueryHelper qh = new QueryHelper();
		try {
			String SQL = "SELECT * FROM pms_mst_project_status where project_status_id = ?";
			qh.addParam(id);
			ResultSet rs = qh.runQueryStreamResults(SQL);
			
			while(rs.next()) {
				CProjectStatusDTO cProjectStatusDTO = new CProjectStatusDTO();
				
				
				cProjectStatusDTO.setProject_status_id(rs.getInt("project_status_id"));
				cProjectStatusDTO.setProject_status(StringUtility.removeNull(rs.getString("project_status")));
				
				EmployeeTypeList.add(cProjectStatusDTO);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.closeConnection();
		}
		return EmployeeTypeList;
	}

}

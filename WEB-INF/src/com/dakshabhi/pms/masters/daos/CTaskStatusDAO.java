package com.dakshabhi.pms.masters.daos;

import java.sql.ResultSet;
import java.util.ArrayList;

import com.dakshabhi.common.db.QueryHelper;
import com.dakshabhi.common.utility.StringUtility;
import com.dakshabhi.pms.masters.dtos.CTaskPriorityDTO;
import com.dakshabhi.pms.masters.dtos.CTaskStatusDTO;

public class CTaskStatusDAO {

	
	public static ArrayList<CTaskStatusDTO> getTaskStatusLit(String CompanyID){
		ArrayList<CTaskStatusDTO> taskStatusList = null;
		QueryHelper qh = new QueryHelper();
		try {
			String SQL = "select * from pms_mst_task_status where is_deleted = 0 and company_id = ? order by is_default desc";
			qh.addParam(CompanyID);

			ResultSet rs = qh.runQueryStreamResults(SQL);
			while (rs.next()) {
				if (taskStatusList == null) {
					taskStatusList = new ArrayList<CTaskStatusDTO>();
				}
				CTaskStatusDTO cTaskStatusDTO = new CTaskStatusDTO();
				cTaskStatusDTO.setTaskStatusID(rs.getString("task_status_id"));
				cTaskStatusDTO.setTaskStatus(rs.getString("task_status"));
				cTaskStatusDTO.setTaskRoleDesc(rs.getString("task_role_desc"));
			   taskStatusList.add(cTaskStatusDTO);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}
		return taskStatusList;
	}

	public static boolean deleteTaskStatus(int pkid) {
		QueryHelper qh = new QueryHelper();
		try {
			String SQL = "DELETE from pms_mst_task_status where task_status_id = ?";
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

	public static boolean createTaskStatus(int companyid, String taskStatus) {
		QueryHelper qh = new QueryHelper();
		try {
			String SQL = "INSERT INTO pms_mst_task_status (task_status, company_id) VALUES (?,?) ";
			qh.addParam(taskStatus);
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

	public static ArrayList<CTaskStatusDTO> populateData(int id) {

		ArrayList<CTaskStatusDTO> TaskStatusList = new ArrayList<CTaskStatusDTO>();
		
		QueryHelper qh = new QueryHelper();
		try {
			String SQL = "SELECT * FROM pms_mst_task_status where task_status_id = ?";
			qh.addParam(id);
			ResultSet rs = qh.runQueryStreamResults(SQL);
			
			while(rs.next()) {
				CTaskStatusDTO cTaskStatusDTO = new CTaskStatusDTO();
				
				
				cTaskStatusDTO.setTaskStatus(StringUtility.removeNull(rs.getString("task_status")));
				cTaskStatusDTO.setTaskStatusID(StringUtility.removeNull(rs.getString("task_status_id")));
			//	cTaskStatusDTO.setTask_role_desc(StringUtility.removeNull(rs.getString("task_role_desc")));
				TaskStatusList.add(cTaskStatusDTO);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.closeConnection();
		}
		return TaskStatusList;
	}

	public static boolean updateTaskStatus(int id, String taskStatus) {
		QueryHelper qh = new QueryHelper();
		try {
			String SQL = "UPDATE pms_mst_task_status SET task_status = ? WHERE task_status_id = ?";
			qh.addParam(taskStatus);
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

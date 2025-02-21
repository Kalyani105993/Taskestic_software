package com.dakshabhi.pms.masters.daos;

import java.sql.ResultSet;
import java.util.ArrayList;

import com.dakshabhi.common.db.QueryHelper;
import com.dakshabhi.common.utility.StringUtility;
import com.dakshabhi.pms.masters.dtos.CProjectTypeDTO;
import com.dakshabhi.pms.masters.dtos.CTaskAcitvityDTO; 

public class CTaskActivityDAO {

	
	public static ArrayList<CTaskAcitvityDTO> getTaskActivityList(String CompanyID){
		ArrayList<CTaskAcitvityDTO> taskActivityList = new ArrayList<CTaskAcitvityDTO>();
		QueryHelper qh = new QueryHelper();
		try {
			String SQL = "select * from pms_mst_task_activity where is_deleted = 0 and company_id = ? order by is_default desc";
			qh.addParam(CompanyID);
			
			ResultSet rs = qh.runQueryStreamResults(SQL);
			while(rs.next()) {
				if(taskActivityList == null) {
					taskActivityList = new ArrayList<CTaskAcitvityDTO>(); 
				}
				CTaskAcitvityDTO taskAcitvityDTO = new CTaskAcitvityDTO();
				taskAcitvityDTO.setTaskActivityId(rs.getString("task_activity_id"));
				taskAcitvityDTO.setTaskActivity(rs.getString("task_activity"));
				taskActivityList.add(taskAcitvityDTO);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}
		return taskActivityList;
	}

	public static boolean deleteTaskActivity(int pkid) {
		QueryHelper qh = new QueryHelper();
		try {
			String SQL = "DELETE from pms_mst_task_activity where task_activity_id = ?";
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

	public static boolean createTaskActivity(int companyid, String taskActivity) {
		QueryHelper qh = new QueryHelper();
		try {
			String SQL = "INSERT INTO pms_mst_task_activity (task_activity, company_id) VALUES (?,?) ";
			qh.addParam(taskActivity);
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

	public static ArrayList<CTaskAcitvityDTO> populateData(int id) {

		ArrayList<CTaskAcitvityDTO> TaskActivityList = new ArrayList<CTaskAcitvityDTO>();
		
		
		QueryHelper qh = new QueryHelper();
		try {
			String SQL = "SELECT * FROM pms_mst_task_activity where task_activity_id = ?";
			qh.addParam(id);
			ResultSet rs = qh.runQueryStreamResults(SQL);
			
			while(rs.next()) {
				CTaskAcitvityDTO cTaskActivityDTO = new CTaskAcitvityDTO();
				
				
				cTaskActivityDTO.setTaskActivity(StringUtility.removeNull(rs.getString("task_activity")));
				cTaskActivityDTO.setTaskActivityId(rs.getString("task_activity_id"));
				
				TaskActivityList.add(cTaskActivityDTO);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.closeConnection();
		}
		return TaskActivityList;
	}

	public static boolean updateTaskActivity(int id, String taskActivity) {
		QueryHelper qh = new QueryHelper();
		try {
			String SQL = "UPDATE pms_mst_task_activity SET task_activity = ? WHERE task_activity_id = ?";
			qh.addParam(taskActivity);
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

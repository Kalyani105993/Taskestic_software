package com.dakshabhi.pms.masters.daos;

import java.sql.ResultSet;
import java.util.ArrayList;

import com.dakshabhi.common.db.QueryHelper;
import com.dakshabhi.common.utility.StringUtility;
import com.dakshabhi.pms.masters.dtos.CProjectStatusDTO;
import com.dakshabhi.pms.masters.dtos.CTaskPriorityDTO;

public class CTaskPriorityDAO {

	public static ArrayList<CTaskPriorityDTO> getTaskPriorityList(String CompanyID) {
		ArrayList<CTaskPriorityDTO> taskPriorityList = null;
		QueryHelper qh = new QueryHelper();
		try {
			String SQL = "select * from pms_mst_task_priority where is_deleted = 0 and company_id = ? order by is_default desc";
			qh.addParam(CompanyID);

			ResultSet rs = qh.runQueryStreamResults(SQL);
			while (rs.next()) {
				if (taskPriorityList == null) {
					taskPriorityList = new ArrayList<CTaskPriorityDTO>();
				}
				CTaskPriorityDTO cTaskPriorityDTO = new CTaskPriorityDTO();
				cTaskPriorityDTO.setTaskPriorityId(rs.getString("task_priority_id"));
				cTaskPriorityDTO.setTaskPriority(rs.getString("task_priority"));
				taskPriorityList.add(cTaskPriorityDTO);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}

		return taskPriorityList;
	}

	public static boolean deleteTaskPriority(int pkid) {
		QueryHelper qh = new QueryHelper();
		try {
			String SQL = "DELETE from pms_mst_task_priority where task_priority_id = ?";
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

	public static boolean createTaskPriority(int companyid, String taskPriority) {
		QueryHelper qh = new QueryHelper();
		try {
			String SQL = "INSERT INTO pms_mst_task_priority (task_priority, company_id) VALUES (?,?) ";
			qh.addParam(taskPriority);
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

	public static ArrayList<CTaskPriorityDTO> populateData(int id) {

		ArrayList<CTaskPriorityDTO> TaskPriorityList = new ArrayList<CTaskPriorityDTO>();
		
		QueryHelper qh = new QueryHelper();
		try {
			String SQL = "SELECT * FROM pms_mst_task_priority where task_priority_id = ?";
			qh.addParam(id);
			ResultSet rs = qh.runQueryStreamResults(SQL);
			
			while(rs.next()) {
				CTaskPriorityDTO cTaskPriorityDTO = new CTaskPriorityDTO();
				
				
				cTaskPriorityDTO.setTaskPriority(StringUtility.removeNull(rs.getString("task_priority")));
				cTaskPriorityDTO.setTaskPriorityId(StringUtility.removeNull(rs.getString("task_priority_id")));
				
				TaskPriorityList.add(cTaskPriorityDTO);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.closeConnection();
		}
		return TaskPriorityList;
	}

	public static boolean updateTaskPriority(int id, String taskPriority) {
		QueryHelper qh = new QueryHelper();
		try {
			String SQL = "UPDATE pms_mst_task_priority SET task_priority = ? WHERE task_priority_id = ?";
			qh.addParam(taskPriority);
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

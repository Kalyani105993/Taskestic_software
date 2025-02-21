package com.dakshabhi.pms.masters.daos;

import java.sql.ResultSet;
import java.util.ArrayList;

import com.dakshabhi.common.db.QueryHelper;
import com.dakshabhi.common.utility.StringUtility;
import com.dakshabhi.pms.masters.dtos.CTaskStatusDTO;
import com.dakshabhi.pms.masters.dtos.CTaskTypeDTO;

public class CTaskTypeDAO {

	public static ArrayList<CTaskTypeDTO> getTasktypeList(String CompanyID) {
		ArrayList<CTaskTypeDTO> taskTyleList = null;
		QueryHelper qh = new QueryHelper();
		try {
			String SQL = "select * from pms_mst_task_type where is_deleted = 0 and company_id = ? order by is_default desc";
			qh.addParam(CompanyID);
			
			ResultSet rs = qh.runQueryStreamResults(SQL);
			while(rs.next()) {
				if(taskTyleList == null) {
					taskTyleList = new ArrayList<CTaskTypeDTO>(); 
				}
				CTaskTypeDTO cTaskTypeDTO = new CTaskTypeDTO();
				cTaskTypeDTO.setTasktypeID(rs.getString("task_type_id"));
				cTaskTypeDTO.setTaskType(rs.getString("task_type"));
				taskTyleList.add(cTaskTypeDTO);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}

		return taskTyleList;
	}

	public static boolean deleteTaskType(int pkid) {
		QueryHelper qh = new QueryHelper();
		try {
			String SQL = "DELETE from pms_mst_task_type where task_type_id = ?";
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

	public static boolean createTaskType(int companyid, String taskType) {
		QueryHelper qh = new QueryHelper();
		try {
			String SQL = "INSERT INTO pms_mst_task_type (task_type, company_id) VALUES (?,?) ";
			qh.addParam(taskType);
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

	public static ArrayList<CTaskTypeDTO> populateData(int id) {

		ArrayList<CTaskTypeDTO> TaskTypeList = new ArrayList<CTaskTypeDTO>();
		
		QueryHelper qh = new QueryHelper();
		try {
			String SQL = "SELECT * FROM pms_mst_task_type where task_type_id = ?";
			qh.addParam(id);
			ResultSet rs = qh.runQueryStreamResults(SQL);
			
			while(rs.next()) {
				CTaskTypeDTO cTaskTypeDTO = new CTaskTypeDTO();
				
				
				cTaskTypeDTO.setCompanyID(StringUtility.removeNull(rs.getString("company_id")));
				cTaskTypeDTO.setTaskType(StringUtility.removeNull(rs.getString("task_type")));
				cTaskTypeDTO.setTasktypeID(StringUtility.removeNull(rs.getString("task_type_id")));
				
				TaskTypeList.add(cTaskTypeDTO);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.closeConnection();
		}
		return TaskTypeList;
	}

	public static boolean updateTaskType(int id, String taskType) {
		QueryHelper qh = new QueryHelper();
		try {
			String SQL = "UPDATE pms_mst_task_type SET task_type = ? WHERE task_type_id = ?";
			qh.addParam(taskType);
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

package com.dakshabhi.pms.workspace.daos;

import java.sql.ResultSet;
import java.util.ArrayList;

import com.dakshabhi.common.db.QueryHelper;
import com.dakshabhi.common.formatter.DateFormater;
import com.dakshabhi.common.utility.StringUtility;
import com.dakshabhi.pms.workspace.dtos.CTaskLogDTO;
import com.dakshabhi.pms.workspace.dtos.CTaskLogInfoDTO;

public class CtaskLogDAO {

	public boolean saveTskLog(CTaskLogDTO taskLogDTO) {
		QueryHelper qh = new QueryHelper();
		try {
			String SQL = "insert into pms_task_log(task_id,log_date,log_hours,task_activity_id,taskComments,created_by,created_on) values(?,?,?,?,?,?,now())";
			qh.addParam(taskLogDTO.getTaskId());
			qh.addParam(taskLogDTO.getLogDate());
			qh.addParam(taskLogDTO.getLogHours());
			qh.addParam(taskLogDTO.getTaskActivityId());
			qh.addParam(taskLogDTO.getTaskComment());
			qh.addParam(taskLogDTO.getUserId());
			qh.runQuery(SQL);
			String getlast_id = "SELECT MAX( task_log_id )as task_log_id  FROM pms_task_log";
			ResultSet rs = qh.runQueryStreamResults(getlast_id);
			if (rs.next()) {
				taskLogDTO.setTaskLogId(rs.getInt("task_log_id"));
			}
			return true;

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}

		return false;
	}

	public ArrayList<CTaskLogInfoDTO> getTaskLogList(int projectid, String searchBy, String start_date,
			String end_date, int startIndex, int endIndex, String pageNo) {
		System.out.println(start_date);
		System.out.println(end_date);
		int startLimit = (Integer.parseInt(pageNo) - 1) * endIndex;
		int endLimit = endIndex;
		ArrayList<CTaskLogInfoDTO> cTaskLogInfoDTOList =  new ArrayList<>();
		CTaskLogInfoDTO cTaskLogInfoDTO = null;
		QueryHelper qh = new QueryHelper();
		String sql = null;
		try {
			if (searchBy.equalsIgnoreCase("last_sevenDays")) {
				sql = "select * from pms_task_log_info_view where DATE(task_log_created_on) >= CURDATE() - INTERVAL 7 DAY AND  DATE(task_log_created_on) <= CURDATE() and task_log_is_deleted = 0 and project_id = ? order by task_log_created_on desc limit " + startLimit+ "," + endLimit + "";

			} else if (searchBy.equalsIgnoreCase("today")) {
				sql = "select * from pms_task_log_info_view where  DATE(task_log_created_on) = CURDATE() and task_log_is_deleted = 0 and project_id = ? order by task_log_created_on desc limit " + startLimit+ "," + endLimit + "";

			} else if (searchBy.equalsIgnoreCase("yesterday")) {
				sql = "select * from pms_task_log_info_view where  DATE(task_log_created_on) = DATE_SUB(CURDATE(), INTERVAL 1 DAY) and task_log_is_deleted = 0 and project_id = ? order by task_log_created_on desc limit " + startLimit+ "," + endLimit + "";

			} else if (searchBy.equalsIgnoreCase("this_week")) {

				sql = "select * from pms_task_log_info_view where  YEAR(task_log_created_on) = YEAR(CURDATE())AND WEEK(task_log_created_on) = WEEK(CURDATE()) and task_log_is_deleted = 0 and project_id = ? order by task_log_created_on desc limit " + startLimit+ "," + endLimit + "";

			}else if (searchBy.equalsIgnoreCase("last_week")) {

				sql = "select * from pms_task_log_info_view where  YEAR(task_log_created_on) = YEAR(CURDATE())AND WEEK(task_log_created_on) = WEEK(CURDATE())-1 and task_log_is_deleted = 0 and project_id = ? order by task_log_created_on desc limit " + startLimit+ "," + endLimit + "";

			} else if (searchBy.equalsIgnoreCase("this_month")) {

				sql = "select * from pms_task_log_info_view where YEAR(task_log_created_on) = YEAR(CURDATE())AND Month(task_log_created_on) = Month(CURDATE()) and task_log_is_deleted = 0 and project_id = ? order by task_log_created_on desc limit " + startLimit+ "," + endLimit + "";

			} else if (searchBy.equalsIgnoreCase("last_month")) {

				sql = "select * from pms_task_log_info_view where YEAR(task_log_created_on) = YEAR(CURDATE())AND Month(task_log_created_on) = Month(CURDATE())-1 and task_log_is_deleted = 0 and project_id = ? order by task_log_created_on desc limit " + startLimit+ "," + endLimit + "";

			} else if (searchBy.equalsIgnoreCase("custom_dates")) {

				sql = "select * from pms_task_log_info_view where  date(task_log_created_on) between ? AND ? and task_log_is_deleted = 0 and project_id = ? order by task_log_created_on desc limit " + startLimit+ "," + endLimit + " ";
				
				qh.addParam(start_date);
				qh.addParam(end_date);
			}

			qh.addParam(projectid);
			ResultSet rs = qh.runQueryStreamResults(sql);
			while (rs.next()) {

				cTaskLogInfoDTO = new CTaskLogInfoDTO();
				cTaskLogInfoDTO.setTask_log_id(rs.getInt("task_log_id"));
				cTaskLogInfoDTO.setTask_id(rs.getInt("task_id"));
				cTaskLogInfoDTO.setTask_name(rs.getString("task_name"));
				cTaskLogInfoDTO.setLog_date(DateFormater.getFormatedShortDate(rs.getString("log_date")));
				cTaskLogInfoDTO.setLog_hours(rs.getInt("log_hours"));
				cTaskLogInfoDTO.setTask_activity_id(rs.getInt("task_activity_id"));
				cTaskLogInfoDTO.setTask_activity_name(rs.getString("task_activity_name"));
				cTaskLogInfoDTO.setTaskComments(rs.getString("taskComments"));
				cTaskLogInfoDTO.setTask_log_created_by(rs.getInt("task_log_created_by"));
				cTaskLogInfoDTO.setCreatedBy_employee_name(rs.getString("createdBy_employee_name"));
				cTaskLogInfoDTO.setTask_log_modified_by(rs.getInt("task_log_modified_by"));
				cTaskLogInfoDTO.setModifiedBy_employee_name(rs.getString("modifiedBy_employee_name"));
				cTaskLogInfoDTO.setTask_log_created_on(DateFormater.getFormatedFullDateWithTime(rs.getString("task_log_created_on")));
				cTaskLogInfoDTO.setGroupDate(rs.getString("task_log_created_on"));
				cTaskLogInfoDTO.setTask_log_deleted_by(rs.getInt("task_log_deleted_by"));
				cTaskLogInfoDTO.setDeletedBy_employee_name(rs.getString("deletedBy_employee_name"));
				cTaskLogInfoDTO.setTask_log_deleted_on(rs.getString("task_log_deleted_on"));
				cTaskLogInfoDTO.setEmployee_profile_avatar(StringUtility.removeNull(rs.getString("employee_profile_avatar")));
				cTaskLogInfoDTO.setEstimated_hours(StringUtility.removeNull(rs.getString("task_estimated_time")));
				cTaskLogInfoDTO.setDocument_id(rs.getInt("document_id"));
				cTaskLogInfoDTO.setDocument_name(rs.getString("document_name"));
				if(!"default.jpg".equalsIgnoreCase(cTaskLogInfoDTO.getEmployee_profile_avatar())) {
					cTaskLogInfoDTO.setEmployee_profile_avatar(StringUtility.removeNull(rs.getString("task_log_created_by")) + "/" + StringUtility.removeNull(rs.getString("employee_profile_avatar")));
				}
				cTaskLogInfoDTOList.add(cTaskLogInfoDTO);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}
		return cTaskLogInfoDTOList;
	}

	public boolean deleteTaskLog(int task_log_id) {
		QueryHelper qh = new QueryHelper();
		int isdeleted = 0;
		try {
			
			String query = "UPDATE pms_task_log SET is_deleted = 1 WHERE task_log_id = ?";
			qh.addParam(task_log_id);
			qh.runQuery(query);
			
			String doc_query = "UPDATE pms_task_document SET is_delete = 1 WHERE tasklog_id = ?";
			qh.addParam(task_log_id);
			qh.runQuery(doc_query);
			isdeleted = qh.getNumRecordsUpdated();
			if (isdeleted > 0) {
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}
		return false;
	}
	public CTaskLogInfoDTO infoforEditTaskLog(int task_log_id) {
		 CTaskLogInfoDTO cTaskLogInfoDTO = null;
		QueryHelper qh = new QueryHelper();

		try {
			String query = "select * from pms_task_log_info_view where task_log_id = ?";
			qh.addParam(task_log_id);
			ResultSet rs = qh.runQueryStreamResults(query);
			if (rs.next()) {
				cTaskLogInfoDTO = new CTaskLogInfoDTO();
				cTaskLogInfoDTO.setTask_log_id(rs.getInt("task_log_id"));
				cTaskLogInfoDTO.setTask_id(rs.getInt("task_id"));
//				cTaskLogInfoDTO.setLog_date(DateFormater.getFormatedShortDate(rs.getString("log_date")));
				cTaskLogInfoDTO.setLog_date(rs.getString("log_date"));
				cTaskLogInfoDTO.setLog_hours(rs.getInt("log_hours"));
				cTaskLogInfoDTO.setTaskComments(rs.getString("taskComments"));
				cTaskLogInfoDTO.setTask_activity_id(rs.getInt("task_activity_id"));
				cTaskLogInfoDTO.setDocument_id(rs.getInt("document_id"));
				cTaskLogInfoDTO.setDocument_name(rs.getString("document_name"));
				cTaskLogInfoDTO.setDoc_discription(rs.getString("doc_discription"));
				cTaskLogInfoDTO.setDoc_created_on(rs.getString("doc_created_on"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}
		return cTaskLogInfoDTO;
	}
//	public CTaskLogDTO infoforEditTaskLog(int task_log_id) {
//		CTaskLogDTO cTaskLogDTO = null;
//		QueryHelper qh = new QueryHelper();
//
//		try {
//			String query = "select * from pms_task_log where task_log_id = ?";
//			qh.addParam(task_log_id);
//			ResultSet rs = qh.runQueryStreamResults(query);
//			if (rs.next()) {
//				cTaskLogDTO = new CTaskLogDTO();
//				cTaskLogDTO.setTaskLogId(rs.getInt("task_log_id"));
//				cTaskLogDTO.setTaskId(rs.getInt("task_id"));
//				cTaskLogDTO.setLogDate(DateFormater.getFormatedShortDate(rs.getString("log_date")));
//				cTaskLogDTO.setLogHours(rs.getInt("log_hours"));
//				cTaskLogDTO.setTaskComment(rs.getString("taskComments"));
//				cTaskLogDTO.setTaskActivityId(rs.getInt("task_activity_id"));
//			}
//		} catch (Exception e) {
//			e.printStackTrace();
//		} finally {
//			qh.releaseConnection();
//		}
//		return cTaskLogDTO;
//	}

	public boolean updateTaskLog(CTaskLogDTO taskLogDTO) {
		QueryHelper qh = new QueryHelper();
		int isupdated = 0;
		try {
			String query = "UPDATE pms_task_log SET log_date = ?,log_hours = ?,task_activity_id = ?,taskComments = ? WHERE task_log_id = ?";
			qh.addParam(taskLogDTO.getLogDate());
			qh.addParam(taskLogDTO.getLogHours());
			qh.addParam(taskLogDTO.getTaskActivityId());
			qh.addParam(taskLogDTO.getTaskComment());
			qh.addParam(taskLogDTO.getTaskLogId());

			qh.runQuery(query);
			isupdated = qh.getNumRecordsUpdated();
			if (isupdated > 0) {
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}
		return false;
	}

	public ArrayList<CTaskLogInfoDTO> getTaskLogListForUser(int user_login_id, String searchBy, String start_date,
			String end_date) {
		ArrayList<CTaskLogInfoDTO> cTaskLogInfoDTOList = null;
		CTaskLogInfoDTO cTaskLogInfoDTO = null;
		QueryHelper qh = new QueryHelper();
		String sql = null;
		try {
			String subSQL = " ( assignee_employee_id = ? or find_in_set ( ? ,followers) <> 0 or task_created_by = ?  ) ";
			
			if (searchBy.equalsIgnoreCase("last_sevenDays")) {
				sql = "select * from pms_task_log_info_view where DATE(task_log_created_on) >= CURDATE() - INTERVAL 7 DAY AND  DATE(task_log_created_on) <= CURDATE() and task_log_is_deleted = 0 and "+ subSQL +" order by task_log_created_on desc";

			} else if (searchBy.equalsIgnoreCase("today")) {
				sql = "select * from pms_task_log_info_view where  DATE(task_log_created_on) = CURDATE() and task_log_is_deleted = 0 and "+ subSQL +" order by task_log_created_on desc";

			} else if (searchBy.equalsIgnoreCase("yesterday")) {
				sql = "select * from pms_task_log_info_view where  DATE(task_log_created_on) = DATE_SUB(CURDATE(), INTERVAL 1 DAY) and task_log_is_deleted = 0 and "+ subSQL +" order by task_log_created_on desc";

			} else if (searchBy.equalsIgnoreCase("this_week")) {

				sql = "select * from pms_task_log_info_view where  YEAR(task_log_created_on) = YEAR(CURDATE())AND WEEK(task_log_created_on) = WEEK(CURDATE()) and task_log_is_deleted = 0 and "+ subSQL +" order by task_log_created_on desc";

			}else if (searchBy.equalsIgnoreCase("last_week")) {

				sql = "select * from pms_task_log_info_view where  YEAR(task_log_created_on) = YEAR(CURDATE())AND WEEK(task_log_created_on) = WEEK(CURDATE())-1 and task_log_is_deleted = 0 and "+ subSQL +" order by task_log_created_on desc";

			} else if (searchBy.equalsIgnoreCase("this_month")) {

				sql = "select * from pms_task_log_info_view where YEAR(task_log_created_on) = YEAR(CURDATE())AND Month(task_log_created_on) = Month(CURDATE()) and task_log_is_deleted = 0 and "+ subSQL +" order by task_log_created_on desc";

			} else if (searchBy.equalsIgnoreCase("last_month")) {

				sql = "select * from pms_task_log_info_view where YEAR(task_log_created_on) = YEAR(CURDATE())AND Month(task_log_created_on) = Month(CURDATE())-1 and task_log_is_deleted = 0 and "+ subSQL +" order by task_log_created_on desc";

			} else if (searchBy.equalsIgnoreCase("custom_dates")) {

				sql = "select * from pms_task_log_info_view where  date(task_log_created_on) between ? AND ? and task_log_is_deleted = 0 and "+ subSQL +" order by task_log_created_on desc";
				qh.addParam(start_date);
				qh.addParam(end_date);
			}

			qh.addParam(user_login_id);
			qh.addParam(user_login_id);
			qh.addParam(user_login_id);
			System.out.println(sql);
			ResultSet rs = qh.runQueryStreamResults(sql);
			while (rs.next()) {
				if (cTaskLogInfoDTOList == null) {
					cTaskLogInfoDTOList = new ArrayList<>();
				}
				cTaskLogInfoDTO = new CTaskLogInfoDTO();
				cTaskLogInfoDTO.setTask_log_id(rs.getInt("task_log_id"));
				cTaskLogInfoDTO.setTask_id(rs.getInt("task_id"));
				cTaskLogInfoDTO.setTask_name(rs.getString("task_name"));
				cTaskLogInfoDTO.setLog_date(DateFormater.getFormatedShortDate(rs.getString("log_date")));
				cTaskLogInfoDTO.setLog_hours(rs.getInt("log_hours"));
				cTaskLogInfoDTO.setTask_activity_id(rs.getInt("task_activity_id"));
				cTaskLogInfoDTO.setTask_activity_name(rs.getString("task_activity_name"));
				cTaskLogInfoDTO.setTaskComments(rs.getString("taskComments"));
				cTaskLogInfoDTO.setTask_log_created_by(rs.getInt("task_log_created_by"));
				cTaskLogInfoDTO.setCreatedBy_employee_name(rs.getString("createdBy_employee_name"));
				cTaskLogInfoDTO.setTask_log_modified_by(rs.getInt("task_log_modified_by"));
				cTaskLogInfoDTO.setModifiedBy_employee_name(rs.getString("modifiedBy_employee_name"));
				cTaskLogInfoDTO.setGroupDate(rs.getString("task_log_created_on"));
				cTaskLogInfoDTO.setTask_log_created_on(DateFormater.getFormatedFullDateWithTime(rs.getString("task_log_created_on")));
				cTaskLogInfoDTO.setTask_log_deleted_by(rs.getInt("task_log_deleted_by"));
				cTaskLogInfoDTO.setDeletedBy_employee_name(rs.getString("deletedBy_employee_name"));
				cTaskLogInfoDTO.setTask_log_deleted_on(rs.getString("task_log_deleted_on"));
				cTaskLogInfoDTO.setEmployee_profile_avatar(StringUtility.removeNull(rs.getString("employee_profile_avatar")));
				cTaskLogInfoDTO.setDocument_id(rs.getInt("document_id"));
				cTaskLogInfoDTO.setDocument_name(rs.getString("document_name"));
				if(!"default.jpg".equalsIgnoreCase(cTaskLogInfoDTO.getEmployee_profile_avatar())) {
					cTaskLogInfoDTO.setEmployee_profile_avatar(StringUtility.removeNull(rs.getString("task_log_created_by")) + "/" + StringUtility.removeNull(rs.getString("employee_profile_avatar")));
				}
				cTaskLogInfoDTOList.add(cTaskLogInfoDTO);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}
		return cTaskLogInfoDTOList;
	}

	
 
}

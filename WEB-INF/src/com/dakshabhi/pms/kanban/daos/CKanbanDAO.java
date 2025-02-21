package com.dakshabhi.pms.kanban.daos;

import java.sql.ResultSet;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;

import com.dakshabhi.common.db.QueryHelper;
import com.dakshabhi.common.utility.StringUtility;
import com.dakshabhi.pms.fcm.dtos.PushNotificationRequest;
import com.dakshabhi.pms.fcm.services.Notification;
import com.dakshabhi.pms.masters.dtos.CTaskStatusDTO;
import com.dakshabhi.pms.tasks.dtos.CTaskDTO;


public class CKanbanDAO {
	public ArrayList<CTaskDTO> getkanbanstatusList(int user_login_id,  String companyID,String projectId,String searchId,String startDate,String enddate) {

		QueryHelper qh = new QueryHelper();
		ArrayList<CTaskDTO> taskList = new ArrayList<CTaskDTO>();
		CTaskDTO taskDTO = null;
		int totalListcount = 0;
		try {
			String subSQL = "";
			if (!projectId.equals("")) {
				subSQL += " and project_id = ? ";
			}
			String datefilter = "";
			if (searchId.equalsIgnoreCase("today")) {
				datefilter = " and task_start_date = CURDATE()";
			} else if (searchId.equalsIgnoreCase("yesterday")) {
				datefilter = " and task_start_date = (select subdate(curdate(), 1))";
			} else if (searchId.equalsIgnoreCase("this_week")) {
				datefilter = " and WEEK(task_start_date) = WEEK(NOW()) AND YEAR(task_start_date) = YEAR(NOW())";
			} else if (searchId.equalsIgnoreCase("this_month")) {
				datefilter = " and MONTH(task_start_date) = MONTH(NOW()) AND YEAR(task_start_date) = YEAR(NOW())";
			} else if (searchId.equalsIgnoreCase("last_3_months")) {
				datefilter = " and task_start_date >= last_day(now()) + interval 1 day - interval 3 month";
			} else if (searchId.equalsIgnoreCase("custom_dates")) {
				datefilter = " and date(task_start_date) between '" + startDate + "' AND '" + enddate + "'";
			}
			
			String sql = "SELECT task_id, task_type,task_status_id,task_priority_type,task_due_date,project_id,task_priority,task_start_date,task_completion_value,employee_name,task_name,task_priority_id,modified_on,project_name,task_status, task_status_type, COUNT(task_id) AS totaltasks"
					+ "  FROM pms_project_task_info_view" + "  WHERE is_deleted = 0" + "  AND company_id = ?"
					+ subSQL + datefilter
					+ "  AND (assignee_employee_id = ? OR FIND_IN_SET(?, followers) <> 0 OR created_by = ?)"
					+ "  GROUP BY task_id, task_status_id, task_type,task_status, task_status_type"
					+ "  ORDER BY task_id;";
			
			qh.addParam(companyID);
			if (!projectId.equals("")) {
				qh.addParam(projectId);
			}
			qh.addParam(user_login_id);
			qh.addParam(user_login_id);
			qh.addParam(user_login_id);
			
			ResultSet rs = qh.runQueryStreamResults(sql);
			while (rs.next()) {
				taskDTO = new CTaskDTO();
				taskDTO.setTaskId(rs.getInt("task_id"));
				taskDTO.setTaskType(StringUtility.removeNull(rs.getString("task_type")));
			taskDTO.setTaskStatus(StringUtility.removeNull(rs.getString("task_status")));
				taskDTO.setTaskPriority(StringUtility.removeNull(rs.getString("task_priority")));
				taskDTO.setAssigneeName(StringUtility.removeNull(rs.getString("employee_name")));
				taskDTO.setTaskName(StringUtility.removeNull(rs.getString("task_name")));
				taskDTO.setLastUpdatedDate(StringUtility.removeNull(rs.getString("modified_on")));
				taskDTO.setProjectName(StringUtility.removeNull(rs.getString("project_name")));
				taskDTO.setTaskStatusId(rs.getInt("task_status_id"));
				taskDTO.setTaskPriorityId(rs.getInt("task_priority_id"));
				taskDTO.setTaskStatusType(rs.getInt("task_status_type"));
				taskDTO.setTaskPriorityType(rs.getInt("task_priority_type"));
				taskDTO.setProjectId(rs.getInt("project_id"));
				taskDTO.setStartDate(rs.getString("task_start_date"));
				taskDTO.setDueDate(rs.getString("task_due_date"));
				taskDTO.setTaskCompletionValue(rs.getInt("task_completion_value"));

				taskDTO.setCount(totalListcount);

				taskList.add(taskDTO);
			}

		} catch (Exception e) {
			e.printStackTrace();

		} finally {
			qh.releaseConnection();
		}
		return taskList;

	}

	public ArrayList<CTaskDTO> getkanbangroupupdateStatus(int taskId, String task_status, String companyId) {
		QueryHelper qh = new QueryHelper();
		ArrayList<CTaskDTO> getkanbangroupupdateStatus = new ArrayList<CTaskDTO>();

		try {
			// First, retrieve the task_status_id
			String moveToStatusDetailsQuery = "SELECT task_status_id , task_status_type  FROM pms_mst_task_status_view WHERE task_status = ? AND company_id = ?";
			qh.addParam(task_status);
			qh.addParam(companyId);

			ResultSet moveToStatusDetailsResult = qh.runQueryStreamResults(moveToStatusDetailsQuery);

			if (moveToStatusDetailsResult.next()) {
				int convert2TaskStatusId = moveToStatusDetailsResult.getInt("task_status_id");
				int convert2TaskStatusType = moveToStatusDetailsResult.getInt("task_status_type");

				// Get the task details from pms_project_task_info_view (existingTaskDetails)
				String currentTaskDetailsQuery = "SELECT task_due_date ,task_status_id,task_status_type,task_completion_value FROM pms_project_task_info_view WHERE task_id =? AND is_deleted = '0'";
				qh.addParam(taskId);
			     ResultSet rs = qh.runQueryStreamResults(currentTaskDetailsQuery);
				while (rs.next()) {

					CTaskDTO taskDTO = new CTaskDTO();
				taskDTO.setTaskStatusId(rs.getInt("task_status_id"));
					taskDTO.setDueDate(rs.getString("task_due_date"));
					taskDTO.setTaskCompletionValue(rs.getInt("task_completion_value"));

					System.out.println("Task ID: " + taskDTO.getTaskId());
					System.out.println("Task Status ID: " + taskDTO.getTaskStatusId());
					System.out.println("Due Date: " + taskDTO.getDueDate());
					System.out.println("task completion value: " + taskDTO.getTaskCompletionValue());

				}
				// Update the task status in the database

				LocalDateTime currentDateTime = LocalDateTime.now();
				LocalDateTime tomorrowDateTime = currentDateTime.plusDays(1);
				DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
				String formattedTomorrowDateTime = tomorrowDateTime.format(formatter);

				LocalDate today = LocalDate.now();
				// Calculate tomorrow's date
				LocalDate datetommorow = today.plusDays(1);
				String sql = "UPDATE pms_project_task SET task_status_id = ?, task_due_date = ?,task_due_dateTime=? WHERE task_id = ? AND is_deleted = '0'";
				qh.addParam(convert2TaskStatusId);
				qh.addParam(datetommorow.toString());
				qh.addParam(formattedTomorrowDateTime);
				qh.addParam(taskId);
				qh.runQuery(sql);
			}
			// Now, retrieve the updated task information
			String getUpdatedTaskInfo = "SELECT task_id, task_status_id FROM pms_project_task WHERE task_id = ? AND is_deleted = '0'";
			qh.addParam(taskId);
			ResultSet updatedTaskResult = qh.runQueryStreamResults(getUpdatedTaskInfo);

			while (updatedTaskResult.next()) {
				CTaskDTO taskDTO = new CTaskDTO();
				taskDTO.setTaskId(updatedTaskResult.getInt("task_id"));
				taskDTO.setTaskStatusId(updatedTaskResult.getInt("task_status_id"));
				getkanbangroupupdateStatus.add(taskDTO);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}

		return getkanbangroupupdateStatus;
	}

	public ArrayList<CTaskStatusDTO> getkanbantasksummary(int user_login_id, String companyId, String projectfiler_id,
			String search_by, String filterStartDateid, String filterEndDate) {
		ArrayList<CTaskStatusDTO> taskStatusList = new ArrayList<CTaskStatusDTO>();
		QueryHelper qh = new QueryHelper();
		try {
			String subsql = "";
			String sql = "select task_status_id, task_status, task_status_type,count(task_id) as totaltasks "
					+ " from pms_project_task_info_view where is_deleted = 0  and company_id = ? "
					+ "and ( assignee_employee_id = ? or find_in_set ( ? ,followers) <> 0 or created_by = ?  ) group by task_status_id order by task_status_id";

			qh.addParam(companyId);
			// qh.addParam(projectfiler_id);
			qh.addParam(user_login_id);
			qh.addParam(user_login_id);
			qh.addParam(user_login_id);
			ResultSet rs = qh.runQueryStreamResults(sql);
			while (rs.next()) {
				CTaskStatusDTO taskStatusDTO = new CTaskStatusDTO();
				taskStatusDTO.setTaskStatusID(rs.getString("task_status_id"));
				taskStatusDTO.setTaskStatus(rs.getString("task_status"));
				taskStatusDTO.setTaskCount(rs.getInt("totaltasks"));
				taskStatusDTO.setTaskStatusType(rs.getInt("task_status_type"));
				taskStatusList.add(taskStatusDTO);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}

		return taskStatusList;

	}

	// kanban search bar

	public ArrayList<CTaskDTO> getkanbanBoardSearch(String searchEmployeeName, String taskid) {
		int totalListcount = 0;
		ArrayList<CTaskDTO> cEmployeeList = new ArrayList<>();
		QueryHelper qh = new QueryHelper();
		CTaskDTO cTaskDTO;
		try {
			String SqlEmployee = "SELECT task_id, task_type, task_priority_type, task_status_type, task_status, task_priority, employee_name, task_name, modified_on, project_name, task_status_id, task_priority_id, project_id, task_start_date, task_due_date, task_completion_value FROM pms_project_task_info_view WHERE is_deleted = 0 AND (employee_name = ? OR task_id = ?);";
			
			
			qh.addParam(searchEmployeeName);
			qh.addParam(taskid);
			ResultSet rs = qh.runQueryStreamResults(SqlEmployee);
			while (rs.next()) { // Use a loop to fetch multiple results
				cTaskDTO = new CTaskDTO();
				cTaskDTO.setTaskId(rs.getInt("task_id"));
				cTaskDTO.setTaskType(StringUtility.removeNull(rs.getString("task_type")));
				cTaskDTO.setTaskStatus(StringUtility.removeNull(rs.getString("task_status")));
				cTaskDTO.setTaskPriority(StringUtility.removeNull(rs.getString("task_priority")));
				cTaskDTO.setAssigneeName(StringUtility.removeNull(rs.getString("employee_name")));
				cTaskDTO.setTaskName(StringUtility.removeNull(rs.getString("task_name")));
				cTaskDTO.setLastUpdatedDate(StringUtility.removeNull(rs.getString("modified_on")));
				cTaskDTO.setProjectName(StringUtility.removeNull(rs.getString("project_name")));
				cTaskDTO.setTaskStatusId(rs.getInt("task_status_id"));
				cTaskDTO.setTaskPriorityId(rs.getInt("task_priority_id"));
				cTaskDTO.setTaskStatusType(rs.getInt("task_status_type"));
				cTaskDTO.setTaskPriorityType(rs.getInt("task_priority_type"));
				cTaskDTO.setProjectId(rs.getInt("project_id"));
				cTaskDTO.setStartDate(rs.getString("task_start_date"));
				cTaskDTO.setDueDate(rs.getString("task_due_date"));
				cTaskDTO.setTaskCompletionValue(rs.getInt("task_completion_value"));
				cTaskDTO.setCount(totalListcount);

				cEmployeeList.add(cTaskDTO);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}
		return cEmployeeList;
	}

	public ArrayList<CTaskDTO> getMyTaskList(int user_login_id, String statusid, String priorityid, String projectid,
			String companyID, int startIndex, int endIndex, String pageNo, String searchBy, String filterStartDate,
			String filterEndDate) {
		int startLimit = (Integer.parseInt(pageNo) - 1) * endIndex;
		int endLimit = endIndex;
		int totalListcount = 0;
		ArrayList<CTaskDTO> taskList = new ArrayList<CTaskDTO>();
		QueryHelper qh = new QueryHelper();
		try {

			String subSQL = "";
			if (!statusid.equals("")) {
				subSQL += " and task_status_id = ? ";
			} else {
				subSQL += " and task_status_id <> 7 ";
			}
			if (!projectid.equals("")) {
				subSQL += " and project_id = ? ";
			}
			String datefilter = "";
			if (searchBy.equalsIgnoreCase("today")) {
				datefilter = " and task_start_date = CURDATE()";
			} else if (searchBy.equalsIgnoreCase("yesterday")) {
				datefilter = " and task_start_date = (select subdate(curdate(), 1))";
			} else if (searchBy.equalsIgnoreCase("this_week")) {
				datefilter = " and WEEK(task_start_date) = WEEK(NOW()) AND YEAR(task_start_date) = YEAR(NOW())";
			} else if (searchBy.equalsIgnoreCase("this_month")) {
				datefilter = " and MONTH(task_start_date) = MONTH(NOW()) AND YEAR(task_start_date) = YEAR(NOW())";
			} else if (searchBy.equalsIgnoreCase("last_3_months")) {
				datefilter = " and task_start_date >= last_day(now()) + interval 1 day - interval 3 month";
			} else if (searchBy.equalsIgnoreCase("custom_dates")) {
				datefilter = " and date(task_start_date) between '" + filterStartDate + "' AND '" + filterEndDate + "'";
			}

			String sql = "select * from pms_project_task_info_view WHERE is_deleted = 0  AND company_id =?"
					+ subSQL+datefilter
					+ " AND (assignee_employee_id = ? or"
					+ " FIND_IN_SET(?, followers) <> 0 OR created_by = ?)" + " ORDER BY task_id limit " + startLimit
					+ "," + endLimit + " ";
			
			
			
			
			qh.addParam(companyID);
			if (!statusid.equals("")) {
			    qh.addParam(statusid);
			}
			if (!projectid.equals("")) {
				qh.addParam(projectid);
			}
			qh.addParam(user_login_id);
			qh.addParam(user_login_id);
			qh.addParam(user_login_id);

			ResultSet rs = qh.runQueryStreamResults(sql);
			while (rs.next()) {
				CTaskDTO taskDTO = new CTaskDTO();
				taskDTO.setTaskId(rs.getInt("task_id"));
				taskDTO.setTaskType(StringUtility.removeNull(rs.getString("task_type")));
				taskDTO.setTaskStatus(StringUtility.removeNull(rs.getString("task_status")));
				taskDTO.setTaskPriority(StringUtility.removeNull(rs.getString("task_priority")));
				taskDTO.setAssigneeName(StringUtility.removeNull(rs.getString("employee_name")));
				taskDTO.setTaskName(StringUtility.removeNull(rs.getString("task_name")));
				taskDTO.setLastUpdatedDate(StringUtility.removeNull(rs.getString("modified_on")));
				taskDTO.setProjectName(StringUtility.removeNull(rs.getString("project_name")));
				taskDTO.setTaskStatusId(rs.getInt("task_status_id"));
				taskDTO.setTaskPriorityId(rs.getInt("task_priority_id"));
				taskDTO.setTaskStatusType(rs.getInt("task_status_type"));
				taskDTO.setTaskPriorityType(rs.getInt("task_priority_type"));
				taskDTO.setProjectId(rs.getInt("project_id"));
				taskDTO.setStartDate(rs.getString("task_start_date"));
				taskDTO.setDueDate(rs.getString("task_due_date"));
				taskDTO.setTaskCompletionValue(rs.getInt("task_completion_value"));
				taskDTO.setCount(totalListcount);

				taskList.add(taskDTO);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}
		return taskList;
	}

	public boolean updateoverduedate(String companyID) {
		QueryHelper qh = new QueryHelper();
		ArrayList<Integer> taskStatusIds = new ArrayList<>();
		CTaskDTO cTaskDTO = null;
		String token;
		try {
			String query = "SELECT task_status_id, task_status FROM pms_mst_task_status WHERE task_status_type IN ('1', '3', '4') and company_id = ?;";
			qh.addParam(companyID);
			ResultSet rs = qh.runQueryStreamResults(query);
			while (rs.next()) {
				taskStatusIds.add(rs.getInt("task_status_id"));
			}
			if (taskStatusIds.size() >= 2) {
				String getOverdueSql = "Select * From pms_project_task where task_due_dateTime < now() and company_id = ?  "
						+ "and (task_status_id = " + taskStatusIds.get(1) + " or task_status_id = "
						+ taskStatusIds.get(2) + ")";
				qh.addParam(companyID);
				ResultSet results = qh.runQueryStreamResults(getOverdueSql);
				String sql = "update pms_project_task set task_status_id = " + taskStatusIds.get(0)
						+ " where task_due_dateTime < now() and company_id = ? ";
				sql += " and (task_status_id = " + taskStatusIds.get(1) + " or task_status_id = " + taskStatusIds.get(2)
						+ ")";

				qh.addParam(companyID);
				qh.runQuery(sql);
				while (results.next()) {
					cTaskDTO = new CTaskDTO();
					cTaskDTO.setAssigneeId(results.getInt("assignee_employee_id"));
					cTaskDTO.setTaskName(results.getString("task_name"));
					String getTokenSql = "SELECT * FROM pms_user_device_details where user_id = ?";
					qh.clearParams();
					qh.addParam(cTaskDTO.getAssigneeId());
					ResultSet tokenResultSet = qh.runQueryStreamResults(getTokenSql);
					while (tokenResultSet.next()) {
						token = tokenResultSet.getString("device_token");
						Notification notification = new Notification();
						PushNotificationRequest pushNotificationRequest = new PushNotificationRequest();
						pushNotificationRequest.setToken(token);
						pushNotificationRequest
								.setMessage("This is a reminder that a task assigned to you is now overdue.");
						pushNotificationRequest.setTitle("Task Name: " + cTaskDTO.getTaskName());
						PushNotificationRequest pushNotificationReq = notification
								.notification(pushNotificationRequest);

					}
				}

				return true;

			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}
		return false;
	}

}

package com.dakshabhi.pms.tasks.daos;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Set;

import com.dakshabhi.common.db.QueryHelper;
import com.dakshabhi.common.formatter.DateFormater;
import com.dakshabhi.common.utility.StringUtility;
import com.dakshabhi.pms.fcm.dtos.PushNotificationRequest;
import com.dakshabhi.pms.fcm.services.Notification;
import com.dakshabhi.pms.masters.dtos.CTaskPriorityDTO;
import com.dakshabhi.pms.masters.dtos.CTaskStatusDTO;
import com.dakshabhi.pms.tasks.dtos.CTaskDTO;
import com.dakshabhi.pms.tasks.dtos.CTaskMessageDTO;
import com.dakshabhi.pms.tasks.dtos.TaskDocumentsDTO;
import com.dakshabhi.pms.workspace.dtos.CTaskLogInfoDTO;

public class CTaskDAO {

	public boolean createNewTask(CTaskDTO taskDTO, String companyID) {

		QueryHelper qh = new QueryHelper();
		try {
			String sql = "INSERT INTO  pms_project_task (company_id,project_id,task_name,task_description,task_status_id,task_type_id,task_priority_id,assignee_employee_id,task_start_date,task_due_date,task_due_dateTime,task_estimated_time,task_completion_value,created_by,followers,created_on,modified_on) "
					+ " VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,now(),now())";
			qh.addParam(companyID);
			qh.addParam(taskDTO.getProjectId());
			qh.addParam(taskDTO.getTaskName());
			qh.addParam(taskDTO.getTaskDescription());
			qh.addParam(taskDTO.getTaskStatusId());
			qh.addParam(taskDTO.getTaskTypeId());
			qh.addParam(taskDTO.getTaskPriorityId());
			qh.addParam(taskDTO.getAssigneeId());
			qh.addParam(taskDTO.getStartDate());
			qh.addParam(taskDTO.getDueDate());
			qh.addParam(taskDTO.getDueDateTime());
			qh.addParam(taskDTO.getTaskEstimatedTime());
			qh.addParam(taskDTO.getTaskCompletionValue());
			qh.addParam(taskDTO.getUserId());
			qh.addParam(taskDTO.getFollowers());
			qh.runQuery(sql);

			// task_id ,task_name , assignee_employee_id ,employee_name ,task_description
			// ,created_by
			String viewsql = "Select * FROM pms_project_task_info_view where task_name = ? and  assignee_employee_id = ?  and created_by = ? order by task_id desc";
			qh.clearParams();
			qh.addParam(taskDTO.getTaskName());
			qh.addParam(taskDTO.getAssigneeId());
			qh.addParam(taskDTO.getUserId());
			String token;
			ResultSet rs = qh.runQueryStreamResults(viewsql);
			if (rs.next()) {
				CTaskDTO ctaskDTO = new CTaskDTO();
				ctaskDTO.setTaskId(rs.getInt("task_id"));
				ctaskDTO.setTaskName(StringUtility.removeNull(rs.getString("task_name")));
				ctaskDTO.setAssigneeId(rs.getInt("assignee_employee_id"));
				ctaskDTO.setAssigneeName(StringUtility.removeNull(rs.getString("employee_name")));
				ctaskDTO.setTaskDescription(StringUtility.removeNull(rs.getString("task_description")));

				String getTokenSql = "SELECT * FROM pms_user_device_details where user_id = ?";
				qh.clearParams();
				qh.addParam(ctaskDTO.getAssigneeId());
				ResultSet tokenResultSet = qh.runQueryStreamResults(getTokenSql);
				if (tokenResultSet.next()) {
					token = tokenResultSet.getString("device_token");
					try {
						Notification notification = new Notification();
						PushNotificationRequest pushNotificationRequest = new PushNotificationRequest();
						pushNotificationRequest.setToken(token);
						pushNotificationRequest.setMessage(
								"Task Name: " + ctaskDTO.getTaskName() + ".\n" + ctaskDTO.getTaskDescription());
						pushNotificationRequest.setTitle("You have got new Task.");
						PushNotificationRequest pushNotificationReq = notification
								.notification(pushNotificationRequest);
					} catch (Exception e) {
						e.printStackTrace();
					}

				}

			}

			return true;

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}
		return false;
	}

	public ArrayList<CTaskDTO> getTaskListByProject(String projectId, String filterTask, String filterStatus,
			String filterAssignee, String companyID, int startIndex, int endIndex, String pageNo) {
		int startLimit = (Integer.parseInt(pageNo) - 1) * endIndex;
		int endLimit = endIndex;
		ArrayList<CTaskDTO> taskList = new ArrayList<CTaskDTO>();
		QueryHelper qh = new QueryHelper();
		try {
			String subQuery = "";
			if (!filterStatus.equals("")) {
				subQuery += " and task_status_id = ? ";
			}
			if (!filterAssignee.equals("0")) {
				subQuery += " and assignee_employee_id = ? ";
			}
			String sql = "select * from pms_project_task_info_view where is_deleted = 0 and task_name like ? "
					+ subQuery + " and company_id = ? and project_id = ? order by task_id  desc limit " + startLimit
					+ "," + endLimit + " ";

			qh.addParam("%" + filterTask + "%");
			if (!filterStatus.equals("")) {
				qh.addParam(filterStatus);
			}
			if (!filterAssignee.equals("0")) {
				qh.addParam(filterAssignee);
			}

			qh.addParam(companyID);
			qh.addParam(projectId);
			ResultSet rs = qh.runQueryStreamResults(sql);
			while (rs.next()) {
				CTaskDTO taskDTO = new CTaskDTO();
				taskDTO.setTaskId(rs.getInt("task_id"));
				taskDTO.setTaskType(StringUtility.removeNull(rs.getString("task_type")));
				taskDTO.setTaskStatus(StringUtility.removeNull(rs.getString("task_status")));
				taskDTO.setTaskPriority(StringUtility.removeNull(rs.getString("task_priority")));
				taskDTO.setTaskStatusType(rs.getInt("task_status_type"));
				taskDTO.setTaskPriorityType(rs.getInt("task_priority_type"));
				taskDTO.setAssigneeName(StringUtility.removeNull(rs.getString("employee_name")));
				taskDTO.setTaskName(StringUtility.removeNull(rs.getString("task_name")));
				taskDTO.setLastUpdatedDate(DateFormater
						.getFormatedFullDateWithTime(StringUtility.removeNull(rs.getString("modified_on"))));
				taskDTO.setTaskStatusId(rs.getInt("task_status_id"));
				taskDTO.setTaskPriorityId(rs.getInt("task_priority_id"));
				taskList.add(taskDTO);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}

		return taskList;
	}

	public CTaskDTO getTaskDetails(String taskId) {
		CTaskDTO taskDTO = null;
		QueryHelper qh = new QueryHelper();
		try {
			String sql = "select * from pms_project_task_info_view where task_id = ?";
			qh.addParam(taskId);
			ResultSet rs = qh.runQueryStreamResults(sql);
			if (rs.next()) {
				taskDTO = new CTaskDTO();
				taskDTO.setTaskName(StringUtility.removeNull(rs.getString("task_name")));
				taskDTO.setTaskDescription(StringUtility.removeNull(rs.getString("task_description")));
				taskDTO.setTaskStatusId(rs.getInt("task_status_id"));
				taskDTO.setTaskTypeId(rs.getInt("task_type_id"));
				taskDTO.setTaskPriorityId(rs.getInt("task_priority_id"));
				taskDTO.setAssigneeId(rs.getInt("assignee_employee_id"));
				taskDTO.setStartDate((rs.getString("task_start_date")));
				taskDTO.setDueDate((rs.getString("task_due_date")));
				taskDTO.setDueDateTime((rs.getString("task_due_dateTime")));
				taskDTO.setTaskEstimatedTime(rs.getInt("task_estimated_time"));
				taskDTO.setTaskCompletionValue(rs.getInt("task_completion_value"));

				taskDTO.setFollowers(StringUtility.removeNull(rs.getString("followers")));
				taskDTO.setTaskStatus(StringUtility.removeNull(rs.getString("task_status")));
				taskDTO.setTaskPriority(StringUtility.removeNull(rs.getString("task_priority")));
				taskDTO.setTaskType(StringUtility.removeNull(rs.getString("task_type")));
				taskDTO.setTaskStatusType(rs.getInt("task_status_type"));
				taskDTO.setTaskPriorityType(rs.getInt("task_priority_type"));
				taskDTO.setAssigneeName(StringUtility.removeNull(rs.getString("employee_name")));
				taskDTO.setProjectId(rs.getInt("project_id"));
				taskDTO.setProjectName(StringUtility.removeNull(rs.getString("project_name")));

			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}

		return taskDTO;
	}

	public boolean updateTask(CTaskDTO taskDTO) {
		QueryHelper qh = new QueryHelper();
		try {
			String sql = "update pms_project_task set task_name=?, task_description=?,task_status_id=?,task_type_id=?, "
					+ " task_priority_id=?,assignee_employee_id=?,task_start_date=?, task_due_date=?,task_due_dateTime=?,followers =?, task_estimated_time=?,"
					+ " task_completion_value=?,modified_by=?,modified_on = now() where task_id = ?";
			qh.addParam(taskDTO.getTaskName());
			qh.addParam(taskDTO.getTaskDescription());
			qh.addParam(taskDTO.getTaskStatusId());
			qh.addParam(taskDTO.getTaskTypeId());
			qh.addParam(taskDTO.getTaskPriorityId());
			qh.addParam(taskDTO.getAssigneeId());
			qh.addParam(taskDTO.getStartDate());
			qh.addParam(taskDTO.getDueDate());
			qh.addParam(taskDTO.getDueDateTime());
			qh.addParam(taskDTO.getFollowers());
			qh.addParam(taskDTO.getTaskEstimatedTime());
			qh.addParam(taskDTO.getTaskCompletionValue());
			qh.addParam(taskDTO.getUserId());
			qh.addParam(taskDTO.getTaskId());
			qh.runQuery(sql);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}
		return false;
	}

	public boolean deleteTask(CTaskDTO taskDTO) {
		QueryHelper qh = new QueryHelper();
		try {
			String sql = "update pms_project_task set is_deleted=1,deleted_by=?,deleted_on = now() where task_id = ?";
			qh.addParam(taskDTO.getUserId());
			qh.addParam(taskDTO.getTaskId());
			qh.runQuery(sql);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}
		return false;
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

			if (!priorityid.equals("")) {
				subSQL += " and task_priority_id = ? ";
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
			if (pageNo.equalsIgnoreCase("1")) {
				String countQuery = "select  count(task_id) as listCount from pms_project_task_info_view where is_deleted = 0  and company_id = ? "
						+ datefilter + subSQL
						+ " and ( assignee_employee_id = ? or find_in_set ( ? ,followers) <> 0 or created_by = ?  ) order by task_id desc limit "
						+ startLimit + "," + endLimit + " ";
				qh.addParam(companyID);
				if (!statusid.equals("")) {
					qh.addParam(statusid);
				}
				if (!priorityid.equals("")) {
					qh.addParam(priorityid);
				}
				if (!projectid.equals("")) {
					qh.addParam(projectid);
				}
				qh.addParam(user_login_id);
				qh.addParam(user_login_id);
				qh.addParam(user_login_id);

				ResultSet rset = qh.runQueryStreamResults(countQuery);
				if (rset.next()) {
					totalListcount = rset.getInt("listCount");

				}
			}
			String sql = "select * from pms_project_task_info_view where is_deleted = 0  and company_id = ? "
					+ datefilter + subSQL
					+ " and ( assignee_employee_id = ? or find_in_set ( ? ,followers) <> 0 or created_by = ?  ) order by task_id desc limit "
					+ startLimit + "," + endLimit + " ";

			qh.addParam(companyID);
			if (!statusid.equals("")) {
				qh.addParam(statusid);
			}
			if (!priorityid.equals("")) {
				qh.addParam(priorityid);
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
				taskDTO.setCount(totalListcount);
//				if (!"".equals(StringUtility.removeNull(rs.getString("task_start_date")))) {
//					taskDTO.setStartDate(DateFormater.getFormatedShortDate(rs.getString("task_start_date")));
//				} else {
//					taskDTO.setStartDate("NA");
//				}
//				if (!"".equals(StringUtility.removeNull(rs.getString("task_due_date")))) {
//					taskDTO.setDueDate(DateFormater.getFormatedShortDate(rs.getString("task_due_date")));
//				} else {
//					taskDTO.setDueDate("NA");
//				}
				taskList.add(taskDTO);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}
		return taskList;
	}

	public ArrayList<CTaskDTO> getCreatedTaskList(int user_login_id, String companyID) {
		ArrayList<CTaskDTO> taskList = new ArrayList<CTaskDTO>();
		QueryHelper qh = new QueryHelper();
		try {
			String sql = "select * from pms_project_task_info_view where is_deleted = 0  and company_id = ? and task_status_id <> 4 and created_by = ? order by task_id desc";

			qh.addParam(companyID);
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
				taskDTO.setTaskStatusType(rs.getInt("task_status_type"));
				taskDTO.setTaskPriorityType(rs.getInt("task_priority_type"));
				taskDTO.setProjectId(rs.getInt("project_id"));
				taskList.add(taskDTO);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}
		return taskList;
	}

	public boolean saveTaskMessage(String taskId, String taskMessage, int user_login_id) {
		QueryHelper qh = new QueryHelper();
		try {
			String SQL = "insert into pms_task_messages(task_id,employee_id,message,added_on) values(?,?,?,now())";
			qh.addParam(taskId);
			qh.addParam(user_login_id);
			qh.addParam(taskMessage);
			qh.runQuery(SQL);
			
			String employee_name = "";
			String employe_details_sql ="select employee_name from employee_info_view where employee_id = ?";
			qh.addParam(user_login_id);
			ResultSet rseted = qh.runQueryStreamResults(employe_details_sql);
			if (rseted.next()) {
				employee_name = rseted.getString("employee_name");
			}
			
			String follower;
			String task_name = "";
			
			String task_info_sql = "SELECT task_name , employee_name FROM pms_project_task_info_view WHERE task_id = ?";
			qh.addParam(taskId);
			ResultSet rset = qh.runQueryStreamResults(task_info_sql);
			if (rset.next()) {
				task_name = rset.getString("task_name");
			}
			String get_follower = "Select followers,created_by from pms_project_task where task_id = ?";
			qh.clearParams();
			qh.addParam(taskId);
			ResultSet rs = qh.runQueryStreamResults(get_follower);
			if (rs.next()) {
				follower = rs.getString("followers");
				System.out.println(follower);

				if (follower.equals(""))
					follower = rs.getString("created_by");
				else
					follower = follower + "," + rs.getString("created_by");

				String[] arrOfFollower = follower.split(",");
				HashSet hash_set = new HashSet();
				for (int i = 0; i < arrOfFollower.length; i++) {
					hash_set.add(arrOfFollower[i]);
				}
				System.out.println(hash_set);
				for (Object followerUser : hash_set) {
					// if(user_login_id != Integer.parseInt(followerUser)) {
					String sql = "SELECT * FROM pms_user_device_details where user_id = ?";
					qh.clearParams();
					qh.addParam(followerUser);
					ResultSet resultSet = qh.runQueryStreamResults(sql);
					while (resultSet.next()) {
						try {
							String token = resultSet.getString("device_token");
							Notification notification = new Notification();
							PushNotificationRequest pushNotificationRequest = new PushNotificationRequest();
							pushNotificationRequest.setToken(token);
							pushNotificationRequest
									.setMessage("Task Name: " + task_name + ".\nMessage: " + taskMessage);
							pushNotificationRequest.setTitle(employee_name);
							PushNotificationRequest pushNotificationReq = notification
									.notification(pushNotificationRequest);
						} catch (Exception e) {
							e.printStackTrace();
						}
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

	public ArrayList<CTaskMessageDTO> getTaskMessagesList(String taskId) {
		ArrayList<CTaskMessageDTO> taskMessageList = new ArrayList<CTaskMessageDTO>();
		QueryHelper qh = new QueryHelper();
		try {
			String sql = "select * from task_message_info_view where is_deleted =0 and task_id = ?";
			qh.addParam(taskId);
			ResultSet rs = qh.runQueryStreamResults(sql);
			while (rs.next()) {
				CTaskMessageDTO taskMessageDTO = new CTaskMessageDTO();
				taskMessageDTO.setTaskMessageId(rs.getInt("task_message_id"));
				taskMessageDTO.setTaskMessage(rs.getString("message"));
				taskMessageDTO.setEmployeeId(rs.getInt("employee_id"));
				taskMessageDTO.setEmployeeName(rs.getString("employee_name"));
				taskMessageDTO.setMessageDateTime(DateFormater.getFormatedFullDateWithTime(rs.getString("added_on")));
				taskMessageDTO.setEmployee_profile_avatar(rs.getString("profile_photo"));
				if (!"default.jpg".equalsIgnoreCase(taskMessageDTO.getEmployee_profile_avatar())) {
					taskMessageDTO
							.setEmployee_profile_avatar(rs.getInt("employee_id") + "/" + rs.getString("profile_photo"));
				}
				taskMessageList.add(taskMessageDTO);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}
		return taskMessageList;
	}

	public boolean updateTaskStatus(String taskId, String statusid, int user_login_id) {
		QueryHelper qh = new QueryHelper();
		try {
			String SQL = "update pms_project_task set task_status_id = ?, modified_by=?, modified_on = now() where task_id = ?";
			qh.addParam(statusid);
			qh.addParam(user_login_id);
			qh.addParam(taskId);
			qh.runQuery(SQL);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}
		return false;
	}

	public boolean updateTaskMessage(String taskMsgId, String taskMessage) {
		QueryHelper qh = new QueryHelper();
		try {
			String SQL = "update pms_task_messages set message = ? ,added_on = now() where task_message_id = ?;";
			qh.addParam(taskMessage);
			qh.addParam(taskMsgId);
			qh.runQuery(SQL);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}
		return false;
	}

	public boolean deleteTaskMessage(String taskMsgId, String deletedBy) {
		QueryHelper qh = new QueryHelper();
		try {
			String SQL = "update pms_task_messages set is_deleted = 1 ,deleted_on = now(),deleted_by = ? where task_message_id = ?;";
			qh.addParam(deletedBy);
			qh.addParam(taskMsgId);
			qh.runQuery(SQL);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}
		return false;
	}

	public ArrayList<CTaskStatusDTO> getMyTaskSummary(int user_login_id, String companyId, String projectfiler_id,
			String search_by, String filterStartDateid, String filterEndDate) {
		ArrayList<CTaskStatusDTO> taskStatusList = new ArrayList<CTaskStatusDTO>();
		QueryHelper qh = new QueryHelper();
		try {
			String subsql = "";
			if (search_by.equals("today")) {
				subsql = "and task_start_date = CURDATE()";
			} else if (search_by.equals("yesterday")) {
				subsql = "and task_start_date = (select subdate(curdate(), 1))";
			} else if (search_by.equals("this_week")) {
				subsql = "and WEEK(task_start_date) = WEEK(NOW()) AND YEAR(task_start_date) = YEAR(NOW())";
			} else if (search_by.equals("this_month")) {
				subsql = "and MONTH(task_start_date) = MONTH(NOW()) AND YEAR(task_start_date) = YEAR(NOW())";
			} else if (search_by.equals("last_3_months")) {
				subsql = "and task_start_date >= last_day(now()) + interval 1 day - interval 3 month";
			} else if (search_by.equals("custom_dates")) {
				subsql = "and date(task_start_date) between '" + filterStartDateid + "' AND '" + filterEndDate + "'";
			}
			String sql = "select task_status_id, task_status, task_status_type,count(task_id) as totaltasks "
					+ " from pms_project_task_info_view where is_deleted = 0  and company_id = ? " + subsql
					+ " and project_id=?"
					+ "and ( assignee_employee_id = ? or find_in_set ( ? ,followers) <> 0 or created_by = ?  ) group by task_status_id order by task_status_id";

			qh.addParam(companyId);
			qh.addParam(projectfiler_id);
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

	public ArrayList<CTaskStatusDTO> getMyTaskSummaryOnReadyNew(int user_login_id, String companyId,
			String projectfiler_id, String search_by, String filterStartDateid, String filterEndDate) {
		ArrayList<CTaskStatusDTO> taskStatusList = new ArrayList<CTaskStatusDTO>();
		QueryHelper qh = new QueryHelper();
		try {

			String subsql = "";
			if (search_by.equals("today")) {
				subsql = "and task_start_date = CURDATE()";
			} else if (search_by.equals("yesterday")) {
				subsql = "and task_start_date = (select subdate(curdate(), 1))";
			} else if (search_by.equals("this_week")) {
				subsql = "and WEEK(task_start_date) = WEEK(NOW()) AND YEAR(task_start_date) = YEAR(NOW())";
			} else if (search_by.equals("this_month")) {
				subsql = "and MONTH(task_start_date) = MONTH(NOW()) AND YEAR(task_start_date) = YEAR(NOW())";
			} else if (search_by.equals("last_3_months")) {
				subsql = "and task_start_date >= last_day(now()) + interval 1 day - interval 3 month";
			} else if (search_by.equals("custom_dates")) {
				subsql = "and date(task_start_date) between '" + filterStartDateid + "' AND '" + filterEndDate + "'";
			}
			if (projectfiler_id.equalsIgnoreCase("allproject")) {
				String sql = "select task_status_id, task_status, task_status_type,count(task_id) as totaltasks "
						+ "from pms_project_task_info_view where is_deleted = 0  and company_id = ?" + subsql
						+ " and ( assignee_employee_id = ? or find_in_set ( ? ,followers) <> 0 or created_by = ?  )"
						+ " group by task_status_id order by task_status_id";
				qh.addParam(companyId);
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
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}
		return taskStatusList;
	}

	public ArrayList<CTaskDTO> getAssignedTaskList(String userId) {
		ArrayList<CTaskDTO> taskList = new ArrayList<CTaskDTO>();
		QueryHelper qh = new QueryHelper();
		try {
			String sql = "select * from pms_project_task_info_view where is_deleted = 0  and task_status_id <> 7"
					+ " and  assignee_employee_id = ?   order by task_status_id,task_priority_id,task_id desc";
			qh.addParam(userId);
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
				taskList.add(taskDTO);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}

		return taskList;
	}

	public ArrayList<CTaskPriorityDTO> getMyTaskSummaryByPriority(int user_login_id, String companyId,
			String projectfiler_id, String search_by, String filterStartDateid, String filterEndDate) {
		ArrayList<CTaskPriorityDTO> taskPrirityList = new ArrayList<CTaskPriorityDTO>();
		QueryHelper qh = new QueryHelper();
		try {
			String subsql = "";
			if (search_by.equals("today")) {
				subsql = "and task_start_date = CURDATE()";
			} else if (search_by.equals("yesterday")) {
				subsql = "and task_start_date = (select subdate(curdate(), 1))";
			} else if (search_by.equals("this_week")) {
				subsql = "and WEEK(task_start_date) = WEEK(NOW()) AND YEAR(task_start_date) = YEAR(NOW())";
			} else if (search_by.equals("this_month")) {
				subsql = "and MONTH(task_start_date) = MONTH(NOW()) AND YEAR(task_start_date) = YEAR(NOW())";
			} else if (search_by.equals("last_3_months")) {
				subsql = "and task_start_date >= last_day(now()) + interval 1 day - interval 3 month";
			} else if (search_by.equals("custom_dates")) {
				subsql = "and date(task_start_date) between '" + filterStartDateid + "' AND '" + filterEndDate + "'";
			}

			String sql = "select task_priority_id, task_priority,task_priority_type, count(task_id) as totaltasks "
					+ " from pms_project_task_info_view where is_deleted = 0  and company_id = ? " + subsql
					+ " and project_id=?"
					+ "  and task_status_id <> 7 and (assignee_employee_id = ? or find_in_set ( ? ,followers) <> 0 or created_by = ? ) group by task_priority_id order by task_priority_id";
			qh.addParam(companyId);
			qh.addParam(projectfiler_id);
			qh.addParam(user_login_id);
			qh.addParam(user_login_id);
			qh.addParam(user_login_id);
			ResultSet rs = qh.runQueryStreamResults(sql);
			while (rs.next()) {
				CTaskPriorityDTO taskPriorityDTO = new CTaskPriorityDTO();
				taskPriorityDTO.setTaskPriorityId(rs.getString("task_priority_id"));
				taskPriorityDTO.setTaskPriority(rs.getString("task_priority"));
				taskPriorityDTO.setTaskCount(rs.getInt("totaltasks"));
				taskPriorityDTO.setTaskPriorityType(rs.getInt("task_priority_type"));
				taskPrirityList.add(taskPriorityDTO);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}

		return taskPrirityList;
	}

	public ArrayList<CTaskPriorityDTO> getMyTaskSummaryByPriorityOnReady(int user_login_id, String companyId,
			String projectfiler_id, String search_by, String filterStartDateid, String filterEndDate) {
		ArrayList<CTaskPriorityDTO> taskPrirityList = new ArrayList<CTaskPriorityDTO>();
		QueryHelper qh = new QueryHelper();
		try {

			String subsql = "";
			if (search_by.equals("today")) {
				subsql = "and task_start_date = CURDATE()";
			} else if (search_by.equals("yesterday")) {
				subsql = "and task_start_date = (select subdate(curdate(), 1))";
			} else if (search_by.equals("this_week")) {
				subsql = "and WEEK(task_start_date) = WEEK(NOW()) AND YEAR(task_start_date) = YEAR(NOW())";
			} else if (search_by.equals("this_month")) {
				subsql = "and MONTH(task_start_date) = MONTH(NOW()) AND YEAR(task_start_date) = YEAR(NOW())";
			} else if (search_by.equals("last_3_months")) {
				subsql = "and task_start_date >= last_day(now()) + interval 1 day - interval 3 month";
			} else if (search_by.equals("custom_dates")) {
				subsql = "and date(task_start_date) between '" + filterStartDateid + "' AND '" + filterEndDate + "'";
			}

			if (projectfiler_id.equalsIgnoreCase("allproject")) {

				String sql = "select task_priority_id, task_priority,task_priority_type, count(task_id) as totaltasks "
						+ " from pms_project_task_info_view where is_deleted = 0  and company_id = ? " + subsql + " "
						+ "  and task_status_id <> 7 and (assignee_employee_id = ? or find_in_set ( ? ,followers) <> 0 or created_by = ? ) group by task_priority_id order by task_priority_id";
				qh.addParam(companyId);
				qh.addParam(user_login_id);
				qh.addParam(user_login_id);
				qh.addParam(user_login_id);
				ResultSet rs = qh.runQueryStreamResults(sql);
				while (rs.next()) {
					CTaskPriorityDTO taskPriorityDTO = new CTaskPriorityDTO();
					taskPriorityDTO.setTaskPriorityId(rs.getString("task_priority_id"));
					taskPriorityDTO.setTaskPriority(rs.getString("task_priority"));
					taskPriorityDTO.setTaskCount(rs.getInt("totaltasks"));
					taskPriorityDTO.setTaskPriorityType(rs.getInt("task_priority_type"));
					taskPrirityList.add(taskPriorityDTO);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}

		return taskPrirityList;
	}

	/*
	 * Method for save document details input taskDocumentsDTO output true or false
	 */
	public boolean savefile(TaskDocumentsDTO taskDocumentsDTO) {
		QueryHelper qh = new QueryHelper();
		try {
			String sql = "INSERT INTO  pms_task_document (document_name,discription,task_id,created_by,created_on) VALUES(?,?,?,?,now())";

			qh.addParam(taskDocumentsDTO.getDocument_name());
			qh.addParam(taskDocumentsDTO.getDocumentDiscription());
			qh.addParam(taskDocumentsDTO.getTask_id());
			qh.addParam(taskDocumentsDTO.getCreated_by());
			qh.runQuery(sql);
			return true;

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}
		return false;
	}

	/*
	 * Method for save taskLog Files input - documentDTO ,taskLogId output - boolean
	 * true or false
	 */
	public boolean saveTaskLogfile(TaskDocumentsDTO documentDTO, int taskLogId) {
		QueryHelper qh = new QueryHelper();
		String sql = "";
		try {
			sql = "INSERT INTO  pms_task_document (document_name,discription,task_id,created_by,tasklog_id,created_on) VALUES(?,?,?,?,?,now())";
			qh.addParam(documentDTO.getDocument_name());
			qh.addParam(documentDTO.getDocumentDiscription());
			qh.addParam(documentDTO.getTask_id());
			qh.addParam(documentDTO.getCreated_by());
			qh.addParam(taskLogId);
			qh.runQuery(sql);
			return true;

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}
		return false;
	}

	public CTaskDTO gettaskidid(String companyId) {
		QueryHelper qh = new QueryHelper();
		try {
			String sql = "select task_id from pms_project_task_info_view where company_id = ?";
			qh.addParam(companyId);

			ResultSet rs = qh.runQueryStreamResults(sql);
			CTaskDTO taskDTO = new CTaskDTO();
			while (rs.next()) {
				taskDTO.setTaskId(rs.getInt("task_id"));
			}

			return taskDTO;
		} catch (Exception e) {
			e.printStackTrace();
		}

		return null;
	}

	public boolean updatefile(String filename, String discription, int taskId, String companyId) {
		QueryHelper qh = new QueryHelper();
		try {
			String sql = "UPDATE pms_task_document SET document_name = ?, discription = ? WHERE task_id = ?";
			qh.addParam(filename);
			qh.addParam(discription);
			qh.addParam(taskId);

			qh.runQuery(sql);

			return true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}

		return false;
	}

	/*
	 * Method for get file Name input documentId and task_id output String
	 * (documentName)
	 */
	public String getFileName(int task_id, int document_Id) {

		QueryHelper qh = new QueryHelper();
		String documentName = null;
		try {
			String query = "select document_name from  pms_task_document WHERE task_id = ? and document_id = ?";
			qh.addParam(task_id);
			qh.addParam(document_Id);
			ResultSet rs = qh.runQueryStreamResults(query);
			if (rs.next()) {
				documentName = rs.getString("document_name");
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}
		return documentName;
	}

	public boolean updateTaskCompletion(String taskcompletionvalue, String taskId, int user_login_id) {
		QueryHelper qh = new QueryHelper();
		try {
			String SQL = "update pms_project_task set task_completion_value=?, modified_by=?, modified_on = now() where task_id = ?";
			qh.addParam(taskcompletionvalue);
			qh.addParam(user_login_id);
			qh.addParam(taskId);
			qh.runQuery(SQL);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}
		return false;
	}

	/*
	 * method for get document list which uploaded on edit task input takid output
	 * arrayList (docList)
	 */
	public ArrayList<TaskDocumentsDTO> documentList(int taskid) {
		QueryHelper qh = new QueryHelper();
		ArrayList<TaskDocumentsDTO> docList = new ArrayList<TaskDocumentsDTO>();
		TaskDocumentsDTO taskDocumentsDTO = null;
		try {
			String sql = "SELECT * FROM pms_task_document WHERE task_id = ?  and is_delete ='0' and tasklog_id = '0'";
			qh.addParam(taskid);

			ResultSet rs = qh.runQueryStreamResults(sql);

			while (rs.next()) {
				taskDocumentsDTO = new TaskDocumentsDTO();
				taskDocumentsDTO.setDocument_id(rs.getInt("document_id"));
				taskDocumentsDTO.setDocument_name(rs.getString("document_name"));
				taskDocumentsDTO.setDocumentDiscription(rs.getString("discription"));
				taskDocumentsDTO.setCreated_by(rs.getString("created_by"));
				taskDocumentsDTO.setCreated_on(rs.getString("created_on"));
				taskDocumentsDTO.setTask_id(rs.getInt("task_id"));
				taskDocumentsDTO.setIs_deleted(rs.getInt("is_delete"));
				taskDocumentsDTO.setTaskLog_id(rs.getInt("tasklog_id"));
				docList.add(taskDocumentsDTO);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}

		return docList;
	}

	public boolean deleteFile(String filename, int documentId) {
		QueryHelper qh = new QueryHelper();

		try {
			String sql = "update pms_task_document set is_delete = '1' WHERE document_id = ?";
			qh.addParam(documentId);

			qh.runQuery(sql);
			int recordsUpdated = qh.getNumRecordsUpdated();
			if (recordsUpdated > 0) {
				return true;
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}

		return false;

	}

	public void updateIsUploaded(int task_id) {

		QueryHelper qh = new QueryHelper();
		try {
			String query = "update pms_task_document set is_uploaded ='1'  WHERE task_id = ? ";
			qh.addParam(task_id);
			qh.runQuery(query);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}
	}

	/*
	 * Method for delete file input documentId output true or false
	 */
	public boolean deleteFile(int documentId) {
		QueryHelper qh = new QueryHelper();

		try {
			String sql = "update pms_task_document set is_delete = '1' WHERE document_id = ?";
			qh.addParam(documentId);

			qh.runQuery(sql);
			int recordsUpdated = qh.getNumRecordsUpdated();
			if (recordsUpdated > 0) {
				return true;
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}

		return false;

	}

	/*
	 * method for get additional document which uploaded on TaskLog Modal input
	 * takid output TaskDocumentsDTO (taskDocumentsDTO)
	 */
	public TaskDocumentsDTO getupdatedocument(int task_id) {
		QueryHelper qh = new QueryHelper();
		TaskDocumentsDTO taskDocumentsDTO = null;
		try {
			String sql = "SELECT * FROM pms_task_document WHERE task_id = ? and is_delete ='0' and isadditional_doc = '1'";
			qh.addParam(task_id);

			ResultSet rs = qh.runQueryStreamResults(sql);

			while (rs.next()) {
				taskDocumentsDTO = new TaskDocumentsDTO();
				taskDocumentsDTO.setDocument_id(rs.getInt("document_id"));
				taskDocumentsDTO.setDocument_name(rs.getString("document_name"));
				taskDocumentsDTO.setDocumentDiscription(rs.getString("discription"));
				taskDocumentsDTO.setCreated_by(rs.getString("created_by"));
				taskDocumentsDTO.setCreated_on(rs.getString("created_on"));
				taskDocumentsDTO.setTask_id(rs.getInt("task_id"));
				taskDocumentsDTO.setIs_deleted(rs.getInt("is_delete"));
				taskDocumentsDTO.setIsadditional_doc(rs.getInt("isadditional_doc"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}
		return taskDocumentsDTO;
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

	public ArrayList<CTaskMessageDTO> getMyTaskMessagesList(int user_login_id, String searchBy, String start_date,
			String end_date) {
		ArrayList<CTaskMessageDTO> taskMessageList = new ArrayList<CTaskMessageDTO>();
		QueryHelper qh = new QueryHelper();
		try {
			String subSql = "";
			if (searchBy.equalsIgnoreCase("last_sevenDays")) {
				subSql = " and DATE(added_on) >= CURDATE() - INTERVAL 7 DAY AND  DATE(added_on) <= CURDATE() ";

			} else if (searchBy.equalsIgnoreCase("today")) {
				subSql = " and  DATE(added_on) = CURDATE() ";

			} else if (searchBy.equalsIgnoreCase("yesterday")) {
				subSql = " and  DATE(added_on) = DATE_SUB(CURDATE(), INTERVAL 1 DAY)  ";

			} else if (searchBy.equalsIgnoreCase("this_week")) {

				subSql = " and YEAR(added_on) = YEAR(CURDATE()) AND WEEK(added_on) ";

			} else if (searchBy.equalsIgnoreCase("last_week")) {

				subSql = " and YEAR(added_on) = YEAR(CURDATE()) AND WEEK(added_on) = WEEK(CURDATE())-1 ";

			} else if (searchBy.equalsIgnoreCase("this_month")) {

				subSql = " and YEAR(added_on) = YEAR(CURDATE())AND Month(added_on) = Month(CURDATE()) ";

			} else if (searchBy.equalsIgnoreCase("last_month")) {

				subSql = " and YEAR(added_on) = YEAR(CURDATE())AND Month(added_on) = Month(CURDATE())-1  ";

			} else if (searchBy.equalsIgnoreCase("custom_dates")) {

				subSql = " and date(added_on) between ? AND ?  ";

			}

			String sql = "select * from task_message_info_view where is_deleted =0  and ( task_assignee_employee_id = ? or find_in_set ( ? ,task_followers) <> 0 or task_created_by = ?  ) "
					+ subSql + " order by task_message_id desc ";

			qh.addParam(user_login_id);
			qh.addParam(user_login_id);
			qh.addParam(user_login_id);

			if (searchBy.equalsIgnoreCase("custom_dates")) {
				qh.addParam(start_date);
				qh.addParam(end_date);
			}

			ResultSet rs = qh.runQueryStreamResults(sql);
			while (rs.next()) {
				CTaskMessageDTO taskMessageDTO = new CTaskMessageDTO();
				taskMessageDTO.setTaskMessageId(rs.getInt("task_message_id"));
				taskMessageDTO.setTaskId(rs.getInt("task_id"));
				taskMessageDTO.setTaskName(StringUtility.removeNull(rs.getString("task_name")));
				taskMessageDTO.setTaskMessage(rs.getString("message"));
				taskMessageDTO.setEmployeeId(rs.getInt("employee_id"));
				taskMessageDTO.setEmployeeName(rs.getString("employee_name"));
				taskMessageDTO.setMessageDateTime(DateFormater.getFormatedFullDateWithTime(rs.getString("added_on")));
				taskMessageDTO.setEmployee_profile_avatar(rs.getString("profile_photo"));
				if (!"default.jpg".equalsIgnoreCase(taskMessageDTO.getEmployee_profile_avatar())) {
					taskMessageDTO
							.setEmployee_profile_avatar(rs.getInt("employee_id") + "/" + rs.getString("profile_photo"));
				}
				taskMessageList.add(taskMessageDTO);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}
		return taskMessageList;
	}
	public ArrayList<CTaskLogInfoDTO> gettasklog(String companyId, String taskid, int startIndex, int endIndex, String pageNo) {
		int startLimit = (Integer.parseInt(pageNo) - 1) * endIndex;
		int endLimit = endIndex;
		 ArrayList<CTaskLogInfoDTO>   cTaskLogInfoDTOList =  new  ArrayList<>();
		 CTaskLogInfoDTO  cTaskLogInfoDTO = null ;
		 QueryHelper qh = new QueryHelper();
		 String sql = null;
		try {
			sql = "select * from pms_task_log_info_view where task_log_is_deleted = 0 and task_id = ? order by task_log_created_on desc limit " + startLimit+ "," + endLimit + " ";
			qh.addParam(taskid);
			
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
}

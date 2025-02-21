package com.dakshabhi.pms.api.daos;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.dakshabhi.common.db.QueryHelper;
import com.dakshabhi.common.utility.StringUtility;
import com.dakshabhi.pms.fcm.dtos.PushNotificationRequest;
import com.dakshabhi.pms.fcm.services.Notification;
import com.dakshabhi.pms.projects.dtos.CProjectInfoDTO;
import com.dakshabhi.pms.tasks.dtos.CTaskDTO;

public class ProjectsDAO {

	public List<CProjectInfoDTO> getSearchData(String project_name, String customer_id, String project_status,
			int userID, String companyID) {
		List<CProjectInfoDTO> projectInfoList = new ArrayList<>();
		QueryHelper qh = new QueryHelper();
		CProjectInfoDTO cProjectInfoDTO = null;
		try {

			String sqlProjectNameList = "select * from project_info_view "
					+ " where (created_by = ? or ? in (select project_emp.employee_id from pms_project_employee project_emp where "
					+ " project_emp.is_deleted = 0 and project_emp.project_id = project_info_view.project_id )) "
					+ " and project_info_view.is_deleted = 0 and project_info_view.company_id = ? and project_info_view.customer_deleted= 0 and project_info_view.project_name LIKE '%"
					+ project_name + "%'  AND project_info_view.customer_id LIKE '%" + customer_id
					+ "%' AND convert(project_info_view.project_status_id,char) LIKE '%" + project_status + "%' ";

			qh.addParam(userID);
			qh.addParam(userID);
			qh.addParam(companyID);
			ResultSet rs = qh.runQueryStreamResults(sqlProjectNameList);
			while (rs.next()) {

				cProjectInfoDTO = new CProjectInfoDTO();
				cProjectInfoDTO.setProject_id(rs.getInt("project_id"));
				cProjectInfoDTO.setProject_name(rs.getString("project_name"));
				cProjectInfoDTO.setCustomer_name(StringUtility.removeNull(rs.getString("customer_name")));
				cProjectInfoDTO.setProject_group(rs.getString("project_group"));
				cProjectInfoDTO.setProject_sub_group(rs.getString("project_sub_group"));
				cProjectInfoDTO.setProject_start_date(rs.getString("project_start_date"));
				cProjectInfoDTO.setProject_description(StringUtility.removeNull(rs.getString("project_description")));
				cProjectInfoDTO.setProject_end_date(rs.getString("project_end_date"));
				cProjectInfoDTO.setProject_status(rs.getString("project_status"));
				cProjectInfoDTO.setCustomer_order_no(rs.getString("customer_order_no"));
				cProjectInfoDTO.setCustomer_order_date(rs.getString("customer_order_date"));
				cProjectInfoDTO.setProject_status_id(rs.getInt("project_status_id"));
				((ArrayList<CProjectInfoDTO>) projectInfoList).add(cProjectInfoDTO);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}

		return projectInfoList;
	}

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

}

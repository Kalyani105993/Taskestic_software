package com.dakshabhi.pms.taskAnalysisReport.dao;

import java.sql.ResultSet;
import java.util.ArrayList;

import com.dakshabhi.common.db.QueryHelper;
import com.dakshabhi.common.utility.StringUtility;
import com.dakshabhi.pms.taskAnalysisReport.dto.CTaskAnalysisReportDTO;

public class CTaskAnalysisReportDAO {

	public ArrayList<CTaskAnalysisReportDTO> fetchRptRecords() {
		ArrayList<CTaskAnalysisReportDTO> cTaskAnalysisReportList = null;
		QueryHelper qh = new QueryHelper();
		CTaskAnalysisReportDTO cTaskAnalysisRptDTO = null;
		try {
			String sql = "select * from pms_project_task_info_rpt";
			ResultSet rs = qh.runQueryStreamResults(sql);
			while (rs.next()) {
				if (cTaskAnalysisReportList == null) {
					cTaskAnalysisReportList = new ArrayList<CTaskAnalysisReportDTO>();
				}
				cTaskAnalysisRptDTO = new CTaskAnalysisReportDTO();
				cTaskAnalysisRptDTO.setTask_id(StringUtility.removeNull(rs.getString("task_id")));
				cTaskAnalysisRptDTO.setCompany_id((rs.getString("company_id")));
				cTaskAnalysisRptDTO.setProject_id(StringUtility.removeNull(rs.getString("project_id")));
				cTaskAnalysisRptDTO.setTask_name(StringUtility.removeNull(rs.getString("task_name")));
				cTaskAnalysisRptDTO.setTask_description(StringUtility.removeNull(rs.getString("task_description")));
				cTaskAnalysisRptDTO.setTask_status_id(StringUtility.removeNull(rs.getString("task_status_id")));
				cTaskAnalysisRptDTO.setTask_type_id(StringUtility.removeNull(rs.getString("task_type_id")));
				cTaskAnalysisRptDTO.setTask_priority_id(StringUtility.removeNull(rs.getString("task_priority_id")));
				cTaskAnalysisRptDTO
						.setAssignee_employee_id(StringUtility.removeNull(rs.getString("assignee_employee_id")));
				cTaskAnalysisRptDTO.setTask_start_date(StringUtility.removeNull(rs.getString("task_start_date")));
				cTaskAnalysisRptDTO.setTask_due_date(StringUtility.removeNull(rs.getString("task_due_date")));
				cTaskAnalysisRptDTO.setTask_due_dateTime(StringUtility.removeNull(rs.getString("task_due_dateTime")));
				cTaskAnalysisRptDTO
						.setTask_estimated_time(StringUtility.removeNull(rs.getString("task_estimated_time")));
				cTaskAnalysisRptDTO
						.setTask_completion_value(StringUtility.removeNull(rs.getString("task_completion_value")));
				cTaskAnalysisRptDTO.setIs_deleted(StringUtility.removeNull(rs.getString("is_deleted")));
				cTaskAnalysisRptDTO.setFollowers(StringUtility.removeNull(rs.getString("followers")));
				cTaskAnalysisRptDTO.setCreated_by(StringUtility.removeNull(rs.getString("created_by")));
				cTaskAnalysisRptDTO.setCreated_on(StringUtility.removeNull(rs.getString("created_on")));
				cTaskAnalysisRptDTO.setModified_by(StringUtility.removeNull(rs.getString("modified_by")));
				cTaskAnalysisRptDTO.setModified_on(StringUtility.removeNull(rs.getString("modified_on")));
				cTaskAnalysisRptDTO.setDeleted_by(StringUtility.removeNull(rs.getString("deleted_by")));
				cTaskAnalysisRptDTO.setDeleted_on(StringUtility.removeNull(rs.getString("deleted_on")));
				cTaskAnalysisRptDTO.setTask_type(StringUtility.removeNull(rs.getString("task_type")));
				cTaskAnalysisRptDTO.setTask_status(StringUtility.removeNull(rs.getString("task_status")));
				cTaskAnalysisRptDTO.setTask_status_type(StringUtility.removeNull(rs.getString("task_status_type")));
				cTaskAnalysisRptDTO.setTask_priority(StringUtility.removeNull(rs.getString("task_priority")));
				cTaskAnalysisRptDTO.setTask_priority_type(StringUtility.removeNull(rs.getString("task_priority_type")));
				cTaskAnalysisRptDTO.setEmployee_name(StringUtility.removeNull(rs.getString("employee_name")));
				cTaskAnalysisRptDTO.setProject_name(StringUtility.removeNull(rs.getString("project_name")));
				cTaskAnalysisRptDTO.setProject_is_deleted(StringUtility.removeNull(rs.getString("project_is_deleted")));

				cTaskAnalysisReportList.add(cTaskAnalysisRptDTO);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}

		return cTaskAnalysisReportList;
	}

}

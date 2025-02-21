package com.dakshabhi.pms.workspace.dtos;

public class CTaskLogInfoDTO {

	private int task_log_id;
	private int task_id;
	private String task_name;
	private String log_date;
	private int log_hours;
	private int task_activity_id;
	private String task_activity_name = "";
	private String taskComments = "";
	private int task_log_is_deleted;
	private int task_log_created_by;
	private String createdBy_employee_name = "";
	private String employee_profile_avatar = "";
	private int task_log_modified_by;
	private String modifiedBy_employee_name = "";
	private String task_log_created_on;
	private String task_log_modified_on;
	private int task_log_deleted_by;
	private String deletedBy_employee_name;
	private int project_task_is_deleted;
	private String task_log_deleted_on;
	private String groupDate;
	private String estimated_hours;
	private String employee_profile_pic;
	private int document_id;
	private String document_name;
	private String doc_discription;
	private String doc_created_on;
	
	
	
	public String getDoc_discription() {
		return doc_discription;
	}

	public void setDoc_discription(String doc_discription) {
		this.doc_discription = doc_discription;
	}

	public String getDoc_created_on() {
		return doc_created_on;
	}

	public void setDoc_created_on(String doc_created_on) {
		this.doc_created_on = doc_created_on;
	}

	public int getDocument_id() {
		return document_id;
	}

	public void setDocument_id(int document_id) {
		this.document_id = document_id;
	}

	public String getDocument_name() {
		return document_name;
	}

	public void setDocument_name(String document_name) {
		this.document_name = document_name;
	}

	public String getEstimated_hours() {
		return estimated_hours;
	}

	public void setEstimated_hours(String estimated_hours) {
		this.estimated_hours = estimated_hours;
	}

	public String getEmployee_profile_pic() {
		return employee_profile_pic;
	}

	public void setEmployee_profile_pic(String employee_profile_pic) {
		this.employee_profile_pic = employee_profile_pic;
	}

	public String getGroupDate() {
		return groupDate;
	}

	public void setGroupDate(String groupDate) {
		this.groupDate = groupDate;
	}

	public String getEmployee_profile_avatar() {
		return employee_profile_avatar;
	}

	public void setEmployee_profile_avatar(String employee_profile_avatar) {
		this.employee_profile_avatar = employee_profile_avatar;
	}

	public String getTask_name() {
		return task_name;
	}

	public void setTask_name(String task_name) {
		this.task_name = task_name;
	}

	public int getTask_log_id() {
		return task_log_id;
	}

	public void setTask_log_id(int task_log_id) {
		this.task_log_id = task_log_id;
	}

	public int getTask_id() {
		return task_id;
	}

	public void setTask_id(int task_id) {
		this.task_id = task_id;
	}

	public String getLog_date() {
		return log_date;
	}

	public void setLog_date(String log_date) {
		this.log_date = log_date;
	}

	public int getLog_hours() {
		return log_hours;
	}

	public void setLog_hours(int log_hours) {
		this.log_hours = log_hours;
	}

	public int getTask_activity_id() {
		return task_activity_id;
	}

	public void setTask_activity_id(int task_activity_id) {
		this.task_activity_id = task_activity_id;
	}

	public String getTask_activity_name() {
		return task_activity_name;
	}

	public void setTask_activity_name(String task_activity_name) {
		this.task_activity_name = task_activity_name;
	}

	public String getTaskComments() {
		return taskComments;
	}

	public void setTaskComments(String taskComments) {
		this.taskComments = taskComments;
	}

	public int getTask_log_is_deleted() {
		return task_log_is_deleted;
	}

	public void setTask_log_is_deleted(int task_log_is_deleted) {
		this.task_log_is_deleted = task_log_is_deleted;
	}

	public int getTask_log_created_by() {
		return task_log_created_by;
	}

	public void setTask_log_created_by(int task_log_created_by) {
		this.task_log_created_by = task_log_created_by;
	}

	public String getCreatedBy_employee_name() {
		return createdBy_employee_name;
	}

	public void setCreatedBy_employee_name(String createdBy_employee_name) {
		this.createdBy_employee_name = createdBy_employee_name;
	}

	public int getTask_log_modified_by() {
		return task_log_modified_by;
	}

	public void setTask_log_modified_by(int task_log_modified_by) {
		this.task_log_modified_by = task_log_modified_by;
	}

	public String getModifiedBy_employee_name() {
		return modifiedBy_employee_name;
	}

	public void setModifiedBy_employee_name(String modifiedBy_employee_name) {
		this.modifiedBy_employee_name = modifiedBy_employee_name;
	}

	public String getTask_log_created_on() {
		return task_log_created_on;
	}

	public void setTask_log_created_on(String task_log_created_on) {
		this.task_log_created_on = task_log_created_on;
	}

	public String getTask_log_modified_on() {
		return task_log_modified_on;
	}

	public void setTask_log_modified_on(String task_log_modified_on) {
		this.task_log_modified_on = task_log_modified_on;
	}

	public int getTask_log_deleted_by() {
		return task_log_deleted_by;
	}

	public void setTask_log_deleted_by(int task_log_deleted_by) {
		this.task_log_deleted_by = task_log_deleted_by;
	}

	public String getDeletedBy_employee_name() {
		return deletedBy_employee_name;
	}

	public void setDeletedBy_employee_name(String deletedBy_employee_name) {
		this.deletedBy_employee_name = deletedBy_employee_name;
	}

	public int getProject_task_is_deleted() {
		return project_task_is_deleted;
	}

	public void setProject_task_is_deleted(int project_task_is_deleted) {
		this.project_task_is_deleted = project_task_is_deleted;
	}

	public String getTask_log_deleted_on() {
		return task_log_deleted_on;
	}

	public void setTask_log_deleted_on(String task_log_deleted_on) {
		this.task_log_deleted_on = task_log_deleted_on;
	}

}

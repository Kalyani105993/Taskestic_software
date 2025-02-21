package com.dakshabhi.pms.employeeDailyWork.dtos;

public class CEmployeeDailyWorkInfoDTO {
	
	private int employee_daily_work_id;
	
	private String employee_name;
	private String work_date;
	private String project_name;
	private String workpack_name;
	private int workpack_standard_hours;
	private int workpack_booked_hours;
	private float work_hours;
	private float approved_hours;
	private float rejected_hours;
	private String Reporting_to;
	private int is_approved;
	private String approved_date;
	private String approved_remark;
	private int employee_id;
	private int project_id;
	private int workpack_id;
	private int approved_by;
	private int is_deleted;
	public int getEmployee_daily_work_id() {
		return employee_daily_work_id;
	}
	public void setEmployee_daily_work_id(int employee_daily_work_id) {
		this.employee_daily_work_id = employee_daily_work_id;
	}
	
	public String getEmployee_name() {
		return employee_name;
	}
	public void setEmployee_name(String employee_name) {
		this.employee_name = employee_name;
	}
	public String getWork_date() {
		return work_date;
	}
	public void setWork_date(String work_date) {
		this.work_date = work_date;
	}
	public String getProject_name() {
		return project_name;
	}
	public void setProject_name(String project_name) {
		this.project_name = project_name;
	}
	public String getWorkpack_name() {
		return workpack_name;
	}
	public void setWorkpack_name(String workpack_name) {
		this.workpack_name = workpack_name;
	}
	public int getWorkpack_standard_hours() {
		return workpack_standard_hours;
	}
	public void setWorkpack_standard_hours(int workpack_standard_hours) {
		this.workpack_standard_hours = workpack_standard_hours;
	}
	public int getWorkpack_booked_hours() {
		return workpack_booked_hours;
	}
	public void setWorkpack_booked_hours(int workpack_booked_hours) {
		this.workpack_booked_hours = workpack_booked_hours;
	}
	public float getWork_hours() {
		return work_hours;
	}
	public void setWork_hours(float work_hours) {
		this.work_hours = work_hours;
	}
	public float getApproved_hours() {
		return approved_hours;
	}
	public void setApproved_hours(float approved_hours) {
		this.approved_hours = approved_hours;
	}
	public float getRejected_hours() {
		return rejected_hours;
	}
	public void setRejected_hours(float rejected_hours) {
		this.rejected_hours = rejected_hours;
	}
	public String getReporting_to() {
		return Reporting_to;
	}
	public void setReporting_to(String reporting_to) {
		Reporting_to = reporting_to;
	}
	public int getIs_approved() {
		return is_approved;
	}
	public void setIs_approved(int is_approved) {
		this.is_approved = is_approved;
	}
	public String getApproved_date() {
		return approved_date;
	}
	public void setApproved_date(String approved_date) {
		this.approved_date = approved_date;
	}
	public String getApproved_remark() {
		return approved_remark;
	}
	public void setApproved_remark(String approved_remark) {
		this.approved_remark = approved_remark;
	}
	public int getEmployee_id() {
		return employee_id;
	}
	public void setEmployee_id(int employee_id) {
		this.employee_id = employee_id;
	}
	public int getProject_id() {
		return project_id;
	}
	public void setProject_id(int project_id) {
		this.project_id = project_id;
	}
	public int getWorkpack_id() {
		return workpack_id;
	}
	public void setWorkpack_id(int workpack_id) {
		this.workpack_id = workpack_id;
	}
	public int getApproved_by() {
		return approved_by;
	}
	public void setApproved_by(int approved_by) {
		this.approved_by = approved_by;
	}
	public int getIs_deleted() {
		return is_deleted;
	}
	public void setIs_deleted(int is_deleted) {
		this.is_deleted = is_deleted;
	}
	

}

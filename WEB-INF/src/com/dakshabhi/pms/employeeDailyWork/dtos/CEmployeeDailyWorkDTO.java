package com.dakshabhi.pms.employeeDailyWork.dtos;

public class CEmployeeDailyWorkDTO {
	
	private int employee_daily_work_id;
	private int company_id;
	private int employee_id;
	private int project_id;
	private int workpack_id;
	private String work_date;
	private float work_hours;
	private String work_added_date;
	private int is_approved;
	private int approved_by;
	private float approved_hours;
	private float rejected_hours;
	private String approved_date;
	private String approved_remark;
	private int is_deleted;
	
	
	public int getEmployee_daily_work_id() {
		return employee_daily_work_id;
	}
	public void setEmployee_daily_work_id(int employee_daily_work_id) {
		this.employee_daily_work_id = employee_daily_work_id;
	}
	public int getCompany_id() {
		return company_id;
	}
	public void setCompany_id(int company_id) {
		this.company_id = company_id;
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
	public String getWork_date() {
		return work_date;
	}
	public void setWork_date(String work_date) {
		this.work_date = work_date;
	}
	public float getWork_hours() {
		return work_hours;
	}
	public void setWork_hours(float work_hours) {
		this.work_hours = work_hours;
	}
	public String getWork_added_date() {
		return work_added_date;
	}
	public void setWork_added_date(String work_added_date) {
		this.work_added_date = work_added_date;
	}
	public int getIs_approved() {
		return is_approved;
	}
	public void setIs_approved(int is_approved) {
		this.is_approved = is_approved;
	}
	public int getApproved_by() {
		return approved_by;
	}
	public void setApproved_by(int approved_by) {
		this.approved_by = approved_by;
	}
	public float getApproved_hours() {
		return approved_hours;
	}
	public void setApproved_hours(float approved_hours) {
		this.approved_hours = approved_hours;
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
	public int getIs_deleted() {
		return is_deleted;
	}
	public void setIs_deleted(int is_deleted) {
		this.is_deleted = is_deleted;
	}
	public float getRejected_hours() {
		return rejected_hours;
	}
	public void setRejected_hours(float rejected_hours) {
		this.rejected_hours = rejected_hours;
	}
	
	
	
	

}

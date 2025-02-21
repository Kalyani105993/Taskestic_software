package com.dakshabhi.pms.projectsemployee.dtos;

public class CProjectEmployeeDTO {
	
	private int project_employee_id;
	private int company_id;
	private int project_id;
	private int employee_id;
	private String date_added;
	private int is_deleted;
	private int is_active;
	
	
	public int getProject_employee_id() {
		return project_employee_id;
	}
	public void setProject_employee_id(int project_employee_id) {
		this.project_employee_id = project_employee_id;
	}
	public int getCompany_id() {
		return company_id;
	}
	public void setCompany_id(int company_id) {
		this.company_id = company_id;
	}
	public int getProject_id() {
		return project_id;
	}
	public void setProject_id(int project_id) {
		this.project_id = project_id;
	}
	public int getEmployee_id() {
		return employee_id;
	}
	public void setEmployee_id(int employee_id) {
		this.employee_id = employee_id;
	}
	public String getDate_added() {
		return date_added;
	}
	public void setDate_added(String date_added) {
		this.date_added = date_added;
	}
	public int getIs_deleted() {
		return is_deleted;
	}
	public void setIs_deleted(int is_deleted) {
		this.is_deleted = is_deleted;
	}
	public int getIs_active() {
		return is_active;
	}
	public void setIs_active(int is_active) {
		this.is_active = is_active;
	}
	
	
	
	

}

package com.dakshabhi.pms.projectsemployee.dtos;

public class CProjectEmployeeInfoDTO {

	private int project_employee_id;
	private int company_id;
	private int project_id;
	private int employee_id;
	private String date_added;
	private int is_deleted;
	private String project_name;
	private String employee_name;
	private String employee_dempartment;
	private String employee_role;
	private String employee_profile_avatar;
	private String employee_email;
	private String is_active;

	public String getEmployee_email() {
		return employee_email;
	}

	public void setEmployee_email(String employee_email) {
		this.employee_email = employee_email;
	}

	public String getEmployee_profile_avatar() {
		return employee_profile_avatar;
	}

	public void setEmployee_profile_avatar(String employee_profile_avatar) {
		this.employee_profile_avatar = employee_profile_avatar;
	}

	public String getEmployee_dempartment() {
		return employee_dempartment;
	}

	public void setEmployee_dempartment(String employee_dempartment) {
		this.employee_dempartment = employee_dempartment;
	}

	public String getEmployee_role() {
		return employee_role;
	}

	public void setEmployee_role(String employee_role) {
		this.employee_role = employee_role;
	}

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

	public String getProject_name() {
		return project_name;
	}

	public void setProject_name(String project_name) {
		this.project_name = project_name;
	}

	public String getEmployee_name() {
		return employee_name;
	}

	public void setEmployee_name(String employee_name) {
		this.employee_name = employee_name;
	}

	public String getIs_active() {
		return is_active;
	}

	public void setIs_active(String is_active) {
		this.is_active = is_active;
	}
	
	
	
}

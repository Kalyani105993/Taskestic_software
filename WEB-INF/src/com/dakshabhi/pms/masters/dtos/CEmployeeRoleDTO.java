package com.dakshabhi.pms.masters.dtos;

public class CEmployeeRoleDTO {
	
	private int employee_role_id;
	private int company_id;
	private String employe_role_name;
	private String employe_role_desc;
	
	public int getEmployee_role_id() {
		return employee_role_id;
	}
	public void setEmployee_role_id(int employee_role_id) {
		this.employee_role_id = employee_role_id;
	}
	public int getCompany_id() {
		return company_id;
	}
	public void setCompany_id(int company_id) {
		this.company_id = company_id;
	}
	public String getEmploye_role_name() {
		return employe_role_name;
	}
	public void setEmploye_role_name(String employe_role_name) {
		this.employe_role_name = employe_role_name;
	}
	public String getEmploye_role_desc() {
		return employe_role_desc;
	}
	public void setEmploye_role_desc(String employe_role_desc) {
		this.employe_role_desc = employe_role_desc;
	}
	
	

}

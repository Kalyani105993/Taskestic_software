package com.dakshabhi.pms.Security.dto;

public class CAllowAccessDTO {

	public boolean customerSectionAllowed = false;
	public boolean projectSectionAllowed = false;
	public boolean employeeSectionAllowed = false;
	public boolean workpackSectionAllowed = false;
	public boolean projectContactSectionAllowed = false;
	public boolean projectWorkpackSectionAllowed = false;
	public boolean projectEmployeeSectionAllowed = false;
	public boolean employeeDailyWorkSectionAllowed = false;
	public boolean employeeWorkApprovalSectionAllowed = false;
	public boolean workspaceSectionAllowed = false;

	public boolean isWorkspaceSectionAllowed() {
		return workspaceSectionAllowed;
	}

	public void setWorkspaceSectionAllowed(boolean workspaceSectionAllowed) {
		this.workspaceSectionAllowed = workspaceSectionAllowed;
	}

	public boolean isCustomerSectionAllowed() {
		return customerSectionAllowed;
	}

	public void setCustomerSectionAllowed(boolean customerSectionAllowed) {
		this.customerSectionAllowed = customerSectionAllowed;
	}

	public boolean isProjectSectionAllowed() {
		return projectSectionAllowed;
	}

	public void setProjectSectionAllowed(boolean projectSectionAllowed) {
		this.projectSectionAllowed = projectSectionAllowed;
	}

	public boolean isEmployeeSectionAllowed() {
		return employeeSectionAllowed;
	}

	public void setEmployeeSectionAllowed(boolean employeeSectionAllowed) {
		this.employeeSectionAllowed = employeeSectionAllowed;
	}

	public boolean isWorkpackSectionAllowed() {
		return workpackSectionAllowed;
	}

	public void setWorkpackSectionAllowed(boolean workpackSectionAllowed) {
		this.workpackSectionAllowed = workpackSectionAllowed;
	}

	public boolean isProjectContactSectionAllowed() {
		return projectContactSectionAllowed;
	}

	public void setProjectContactSectionAllowed(boolean projectContactSectionAllowed) {
		this.projectContactSectionAllowed = projectContactSectionAllowed;
	}

	public boolean isProjectWorkpackSectionAllowed() {
		return projectWorkpackSectionAllowed;
	}

	public void setProjectWorkpackSectionAllowed(boolean projectWorkpackSectionAllowed) {
		this.projectWorkpackSectionAllowed = projectWorkpackSectionAllowed;
	}

	public boolean isProjectEmployeeSectionAllowed() {
		return projectEmployeeSectionAllowed;
	}

	public void setProjectEmployeeSectionAllowed(boolean projectEmployeeSectionAllowed) {
		this.projectEmployeeSectionAllowed = projectEmployeeSectionAllowed;
	}

	public boolean isEmployeeDailyWorkSectionAllowed() {
		return employeeDailyWorkSectionAllowed;
	}

	public void setEmployeeDailyWorkSectionAllowed(boolean employeeDailyWorkSectionAllowed) {
		this.employeeDailyWorkSectionAllowed = employeeDailyWorkSectionAllowed;
	}

	public boolean isEmployeeWorkApprovalSectionAllowed() {
		return employeeWorkApprovalSectionAllowed;
	}

	public void setEmployeeWorkApprovalSectionAllowed(boolean employeeWorkApprovalSectionAllowed) {
		this.employeeWorkApprovalSectionAllowed = employeeWorkApprovalSectionAllowed;
	}

}

package com.dakshabhi.pms.projects.dtos;

public class CProjectContactsDTO {

	private int project_contact_id;
	private int company_id;
	private int project_id;
	private int customer_id;
	private String contact_person_name;
	private String contact_person_designation;
	private String contact_person_email;
	private String contact_person_phone;
	private int is_active;
	private int is_deleted;
	private String project_name;
	private String customer_name;

	public String getProject_name() {
		return project_name;
	}

	public void setProject_name(String project_name) {
		this.project_name = project_name;
	}

	public String getCustomer_name() {
		return customer_name;
	}

	public void setCustomer_name(String customer_name) {
		this.customer_name = customer_name;
	}

	public int getProject_contact_id() {
		return project_contact_id;
	}

	public void setProject_contact_id(int project_contact_id) {
		this.project_contact_id = project_contact_id;
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

	public int getCustomer_id() {
		return customer_id;
	}

	public void setCustomer_id(int customer_id) {
		this.customer_id = customer_id;
	}

	public String getContact_person_name() {
		return contact_person_name;
	}

	public void setContact_person_name(String contact_person_name) {
		this.contact_person_name = contact_person_name;
	}

	public String getContact_person_designation() {
		return contact_person_designation;
	}

	public void setContact_person_designation(String contact_person_designation) {
		this.contact_person_designation = contact_person_designation;
	}

	public String getContact_person_email() {
		return contact_person_email;
	}

	public void setContact_person_email(String contact_person_email) {
		this.contact_person_email = contact_person_email;
	}

	public String getContact_person_phone() {
		return contact_person_phone;
	}

	public void setContact_person_phone(String contact_person_phone) {
		this.contact_person_phone = contact_person_phone;
	}

	public int getIs_active() {
		return is_active;
	}

	public void setIs_active(int is_active) {
		this.is_active = is_active;
	}

	public int getIs_deleted() {
		return is_deleted;
	}

	public void setIs_deleted(int is_deleted) {
		this.is_deleted = is_deleted;
	}

}

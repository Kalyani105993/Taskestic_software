package com.dakshabhi.pms.projects.dtos;

public class CProjectDTO {

	private int project_id;
	private int company_id;
	private int customer_id;
	private String project_name;
	private String project_description;
	private int project_group_id;
	private int project_sub_group_id;
	private String project_inp_number;
	private String project_start_date;
	private String project_end_date;
	private int project_status_id;
	private int is_active;
	private int is_deleted;
	private String customer_order_no;
	private String customer_order_date;
	private String project_code;
	private int project_type_id;
	private int created_by;

	public int getCreated_by() {
		return created_by;
	}

	public void setCreated_by(int created_by) {
		this.created_by = created_by;
	}

	public int getProject_type_id() {
		return project_type_id;
	}

	public void setProject_type_id(int project_type_id) {
		this.project_type_id = project_type_id;
	}

	public String getProject_code() {
		return project_code;
	}

	public void setProject_code(String project_code) {
		this.project_code = project_code;
	}

	public int getProject_id() {
		return project_id;
	}

	public void setProject_id(int project_id) {
		this.project_id = project_id;
	}

	public int getCompany_id() {
		return company_id;
	}

	public void setCompany_id(int company_id) {
		this.company_id = company_id;
	}

	public int getCustomer_id() {
		return customer_id;
	}

	public void setCustomer_id(int customer_id) {
		this.customer_id = customer_id;
	}

	public String getProject_name() {
		return project_name;
	}

	public void setProject_name(String project_name) {
		this.project_name = project_name;
	}

	public String getProject_description() {
		return project_description;
	}

	public void setProject_description(String project_description) {
		this.project_description = project_description;
	}

	public int getProject_group_id() {
		return project_group_id;
	}

	public void setProject_group_id(int project_group_id) {
		this.project_group_id = project_group_id;
	}

	public int getProject_sub_group_id() {
		return project_sub_group_id;
	}

	public void setProject_sub_group_id(int project_sub_group_id) {
		this.project_sub_group_id = project_sub_group_id;
	}

	public String getProject_inp_number() {
		return project_inp_number;
	}

	public void setProject_inp_number(String project_inp_number) {
		this.project_inp_number = project_inp_number;
	}

	public String getProject_start_date() {
		return project_start_date;
	}

	public void setProject_start_date(String project_start_date) {
		this.project_start_date = project_start_date;
	}

	public String getProject_end_date() {
		return project_end_date;
	}

	public void setProject_end_date(String project_end_date) {
		this.project_end_date = project_end_date;
	}

	public int getProject_status_id() {
		return project_status_id;
	}

	public void setProject_status_id(int project_status_id) {
		this.project_status_id = project_status_id;
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

	public String getCustomer_order_no() {
		return customer_order_no;
	}

	public void setCustomer_order_no(String customer_order_no) {
		this.customer_order_no = customer_order_no;
	}

	public String getCustomer_order_date() {
		return customer_order_date;
	}

	public void setCustomer_order_date(String customer_order_date) {
		this.customer_order_date = customer_order_date;
	}

}

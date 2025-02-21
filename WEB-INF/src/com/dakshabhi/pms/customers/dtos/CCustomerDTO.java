package com.dakshabhi.pms.customers.dtos;

public class CCustomerDTO {

	private int customer_id;
	private int company_id;
	private String customer_name;
	private String customer_address;
	private String customer_email;
	private String customer_phone;
	private int is_active;
	private int is_deleted;
	private int customer_type_id;
	private String customer_type;
	private String customer_alternate_emailId;
	private String customer_alternate_contact;
	

	public String getCustomer_alternate_emailId() {
		return customer_alternate_emailId;
	}

	public void setCustomer_alternate_emailId(String customer_alternate_emailId) {
		this.customer_alternate_emailId = customer_alternate_emailId;
	}

	public String getCustomer_alternate_contact() {
		return customer_alternate_contact;
	}

	public void setCustomer_alternate_contact(String customer_alternate_contact) {
		this.customer_alternate_contact = customer_alternate_contact;
	}

	public String getCustomer_type() {
		return customer_type;
	}

	public void setCustomer_type(String customer_type) {
		this.customer_type = customer_type;
	}

	public int getCustomer_type_id() {
		return customer_type_id;
	}

	public void setCustomer_type_id(int customer_type_id) {
		this.customer_type_id = customer_type_id;
	}

	public int getCustomer_id() {
		return customer_id;
	}

	public void setCustomer_id(int customer_id) {
		this.customer_id = customer_id;
	}

	public int getCompany_id() {
		return company_id;
	}

	public void setCompany_id(int company_id) {
		this.company_id = company_id;
	}

	public String getCustomer_name() {
		return customer_name;
	}

	public void setCustomer_name(String customer_name) {
		this.customer_name = customer_name;
	}

	public String getCustomer_address() {
		return customer_address;
	}

	public void setCustomer_address(String customer_address) {
		this.customer_address = customer_address;
	}

	public String getCustomer_email() {
		return customer_email;
	}

	public void setCustomer_email(String customer_email) {
		this.customer_email = customer_email;
	}

	public String getCustomer_phone() {
		return customer_phone;
	}

	public void setCustomer_phone(String customer_phone) {
		this.customer_phone = customer_phone;
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

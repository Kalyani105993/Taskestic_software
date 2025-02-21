package com.dakshabhi.pms.users.dtos;

public class CUserLoginDTO {

	private int user_login_id;
	private String user_full_name;
	private int user_role;
	private int user_employee_id;
	private String user_email = ""; 
	private int user_role_type;
	private String device_token;
	private String is_active;

	public int getUser_role_type() {
		return user_role_type;
	}

	public void setUser_role_type(int user_role_type) {
		this.user_role_type = user_role_type;
	}

	public String getUser_email() {
		return user_email;
	}

	public void setUser_email(String user_email) {
		this.user_email = user_email;
	}

	public int getUser_employee_id() {
		return user_employee_id;
	}

	public void setUser_employee_id(int user_employee_id) {
		this.user_employee_id = user_employee_id;
	}

	public int getUser_login_id() {
		return user_login_id;
	}

	public void setUser_login_id(int user_login_id) {
		this.user_login_id = user_login_id;
	}

	public String getUser_full_name() {
		return user_full_name;
	}

	public void setUser_full_name(String user_full_name) {
		this.user_full_name = user_full_name;
	}

	public int getUser_role() {
		return user_role;
	}

	public void setUser_role(int user_role) {
		this.user_role = user_role;
	}

	public String getDevice_token() {
		return device_token;
	}

	public void setDevice_token(String string) {
		this.device_token = string;
	}

	public String getIs_active() {
		return is_active;
	}

	public void setIs_active(String is_active) {
		this.is_active = is_active;
	}
	
	
	

}

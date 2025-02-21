package com.dakshabhi.pms.companies.dtos;

public class CCompanyDTO {
	private String company_name;
	private String company_address;
	private String company_phone;
	private int company_id;
	private String from_login;
	private String to_login;
	private String timezone;
	private String isToggelSwitchOn;

	public int getCompany_id() {
		return company_id;
	}

	public void setCompany_id(int company_id) {
		this.company_id = company_id;
	}

	public String getCompany_address() {
		return company_address;
	}

	public void setCompany_address(String company_address) {
		this.company_address = company_address;
	}

	public String getCompany_phone() {
		return company_phone;
	}

	public void setCompany_phone(String company_phone) {
		this.company_phone = company_phone;
	}

	public String getCompany_email() {
		return company_email;
	}

	public void setCompany_email(String company_email) {
		this.company_email = company_email;
	}

	private String company_email;

	public String getCompany_name() {
		return company_name;
	}

	public void setCompany_name(String company_name) {
		this.company_name = company_name;
	}

	public String getFrom_login() {
		return from_login;
	}

	public void setFrom_login(String from_login) {
		this.from_login = from_login;
	}

	public String getTo_login() {
		return to_login;
	}

	public void setTo_login(String to_login) {
		this.to_login = to_login;
	}

	public String getTimezone() {
		return timezone;
	}

	public void setTimezone(String timezone) {
		this.timezone = timezone;
	}

	public String getIsToggelSwitchOn() {
		return isToggelSwitchOn;
	}

	public void setIsToggelSwitchOn(String isToggelSwitchOn) {
		this.isToggelSwitchOn = isToggelSwitchOn;
	}
	
	

}

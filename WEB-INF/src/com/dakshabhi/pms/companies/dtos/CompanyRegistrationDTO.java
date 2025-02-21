package com.dakshabhi.pms.companies.dtos;

public class CompanyRegistrationDTO {

	private String companyID = "";
	private String companyName = "";
	private String companyURL = "";
	private String companyEmail = "";
	private String companyPhone = "";
	private String companyKey = "";
	private String userPasword = "";

	public String getCompanyID() {
		return companyID;
	}

	public void setCompanyID(String companyID) {
		this.companyID = companyID;
	}

	public String getCompanyName() {
		return companyName;
	}

	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}

	public String getCompanyURL() {
		return companyURL;
	}

	public void setCompanyURL(String companyURL) {
		this.companyURL = companyURL;
	}

	public String getCompanyEmail() {
		return companyEmail;
	}

	public void setCompanyEmail(String companyEmail) {
		this.companyEmail = companyEmail;
	}

	public String getCompanyPhone() {
		return companyPhone;
	}

	public void setCompanyPhone(String companyPhone) {
		this.companyPhone = companyPhone;
	}

	public String getCompanyKey() {
		return companyKey;
	}

	public void setCompanyKey(String companyKey) {
		this.companyKey = companyKey;
	}

	public String getUserPasword() {
		return userPasword;
	}

	public void setUserPasword(String userPasword) {
		this.userPasword = userPasword;
	}

}

package com.dakshabhi.pms.workpaks.dtos;

import java.util.Date;

public class CWorkpackDTO {
	private int workpack_id;
	private int company_id;
	private String workpack_name;
	private String workpack_description;
	private double workpack_rate;
	private String workpack_start_date;
	private String workpack_end_date;
	private int workpack_standard_hours;
	private int is_deleted;
	
	
	public int getWorkpack_id() {
		return workpack_id;
	}
	public void setWorkpack_id(int workpack_id) {
		this.workpack_id = workpack_id;
	}
	public int getCompany_id() {
		return company_id;
	}
	public void setCompany_id(int company_id) {
		this.company_id = company_id;
	}
	public String getWorkpack_name() {
		return workpack_name;
	}
	public void setWorkpack_name(String workpack_name) {
		this.workpack_name = workpack_name;
	}
	public String getWorkpack_description() {
		return workpack_description;
	}
	public void setWorkpack_description(String workpack_description) {
		this.workpack_description = workpack_description;
	}
	public double getWorkpack_rate() {
		return workpack_rate;
	}
	public void setWorkpack_rate(double workpack_rate) {
		this.workpack_rate = workpack_rate;
	}
	public String getWorkpack_start_date() {
		return workpack_start_date;
	}
	public void setWorkpack_start_date(String workpack_start_date) {
		this.workpack_start_date = workpack_start_date;
	}
	public String getWorkpack_end_date() {
		return workpack_end_date;
	}
	public void setWorkpack_end_date(String workpack_end_date) {
		this.workpack_end_date = workpack_end_date;
	}
	public int getWorkpack_standard_hours() {
		return workpack_standard_hours;
	}
	public void setWorkpack_standard_hours(int workpack_standard_hours) {
		this.workpack_standard_hours = workpack_standard_hours;
	}
	public int getIs_deleted() {
		return is_deleted;
	}
	public void setIs_deleted(int is_deleted) {
		this.is_deleted = is_deleted;
	}
	
	
	
	
	
	
	

}

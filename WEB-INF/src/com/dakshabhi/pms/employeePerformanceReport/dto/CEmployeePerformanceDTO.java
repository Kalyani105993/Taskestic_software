package com.dakshabhi.pms.employeePerformanceReport.dto;

public class CEmployeePerformanceDTO {

	private int employee_id;
	private String employee_name = "";
	private String task_priority = "";
	private String task_status = "";
	private int task_status_id;
	private int task_priority_id;
	private int task_status_type;
	private int task_priority_type;
	private int task_count;

	public int getEmployee_id() {
		return employee_id;
	}

	public void setEmployee_id(int employee_id) {
		this.employee_id = employee_id;
	}

	public String getEmployee_name() {
		return employee_name;
	}

	public void setEmployee_name(String employee_name) {
		this.employee_name = employee_name;
	}

	public String getTask_priority() {
		return task_priority;
	}

	public void setTask_priority(String task_priority) {
		this.task_priority = task_priority;
	}

	public String getTask_status() {
		return task_status;
	}

	public void setTask_status(String task_status) {
		this.task_status = task_status;
	}

	public int getTask_status_id() {
		return task_status_id;
	}

	public void setTask_status_id(int task_status_id) {
		this.task_status_id = task_status_id;
	}

	public int getTask_priority_id() {
		return task_priority_id;
	}

	public void setTask_priority_id(int task_priority_id) {
		this.task_priority_id = task_priority_id;
	}

	public int getTask_status_type() {
		return task_status_type;
	}

	public void setTask_status_type(int task_status_type) {
		this.task_status_type = task_status_type;
	}

	public int getTask_priority_type() {
		return task_priority_type;
	}

	public void setTask_priority_type(int task_priority_type) {
		this.task_priority_type = task_priority_type;
	}

	public int getTask_count() {
		return task_count;
	}

	public void setTask_count(int task_count) {
		this.task_count = task_count;
	}

}

package com.dakshabhi.pms.tasks.dtos;

public class CTaskMessageDTO {

	private int taskMessageId = 0;
	private String taskMessage = "";
	private int employeeId = 0;
	private String employeeName = "";
	private String messageDateTime = "";
	private String employee_profile_avatar;
	private int taskId = 0;
	private String taskName = "";

	public String getTaskName() {
		return taskName;
	}

	public void setTaskName(String taskName) {
		this.taskName = taskName;
	}

	public int getTaskId() {
		return taskId;
	}

	public void setTaskId(int taskId) {
		this.taskId = taskId;
	}

	public String getEmployee_profile_avatar() {
		return employee_profile_avatar;
	}

	public void setEmployee_profile_avatar(String employee_profile_avatar) {
		this.employee_profile_avatar = employee_profile_avatar;
	}

	public int getTaskMessageId() {
		return taskMessageId;
	}

	public void setTaskMessageId(int taskMessageId) {
		this.taskMessageId = taskMessageId;
	}

	public String getTaskMessage() {
		return taskMessage;
	}

	public void setTaskMessage(String taskMessage) {
		this.taskMessage = taskMessage;
	}

	public int getEmployeeId() {
		return employeeId;
	}

	public void setEmployeeId(int employeeId) {
		this.employeeId = employeeId;
	}

	public String getEmployeeName() {
		return employeeName;
	}

	public void setEmployeeName(String employeeName) {
		this.employeeName = employeeName;
	}

	public String getMessageDateTime() {
		return messageDateTime;
	}

	public void setMessageDateTime(String messageDateTime) {
		this.messageDateTime = messageDateTime;
	}
}

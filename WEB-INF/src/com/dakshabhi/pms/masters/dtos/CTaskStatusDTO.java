package com.dakshabhi.pms.masters.dtos;

public class CTaskStatusDTO {

	private String taskStatusID = "";
	private String taskStatus = "";
	private int taskCount = 0; 
	private int taskStatusType = 0;
	private String taskRoleDesc = "";
	public String getTaskStatusID() {
		return taskStatusID;
	}
	public void setTaskStatusID(String taskStatusID) {
		this.taskStatusID = taskStatusID;
	}
	public String getTaskStatus() {
		return taskStatus;
	}
	public void setTaskStatus(String taskStatus) {
		this.taskStatus = taskStatus;
	}
	public int getTaskCount() {
		return taskCount;
	}
	public void setTaskCount(int taskCount) {
		this.taskCount = taskCount;
	}
	public int getTaskStatusType() {
		return taskStatusType;
	}
	public void setTaskStatusType(int taskStatusType) {
		this.taskStatusType = taskStatusType;
	}
	public String getTaskRoleDesc() {
		return taskRoleDesc;
	}
	public void setTaskRoleDesc(String taskRoleDesc) {
		this.taskRoleDesc = taskRoleDesc;
	}
	

  
	

}

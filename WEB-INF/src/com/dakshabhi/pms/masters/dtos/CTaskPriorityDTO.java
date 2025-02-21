package com.dakshabhi.pms.masters.dtos;

public class CTaskPriorityDTO {
	private String taskPriorityId = "";
	private String taskPriority = "";
	private int taskCount = 0;
	private int taskPriorityType = 0;

	public int getTaskPriorityType() {
		return taskPriorityType;
	}

	public void setTaskPriorityType(int taskPriorityType) {
		this.taskPriorityType = taskPriorityType;
	}

	public int getTaskCount() {
		return taskCount;
	}

	public void setTaskCount(int taskCount) {
		this.taskCount = taskCount;
	}

	public String getTaskPriorityId() {
		return taskPriorityId;
	}

	public void setTaskPriorityId(String taskPriorityId) {
		this.taskPriorityId = taskPriorityId;
	}

	public String getTaskPriority() {
		return taskPriority;
	}

	public void setTaskPriority(String taskPriority) {
		this.taskPriority = taskPriority;
	}

}

package com.dakshabhi.pms.workspace.dtos;

public class CTaskLogDTO {

	private int taskLogId = 0;
	private int taskId = 0;
	private String logDate = "";
	private int logHours = 0;
	private int taskActivityId = 0;
	private String taskComment = "";
	private int userId = 0;

	public int getTaskLogId() {
		return taskLogId;
	}

	public void setTaskLogId(int taskLogId) {
		this.taskLogId = taskLogId;
	}

	public int getTaskId() {
		return taskId;
	}

	public void setTaskId(int taskId) {
		this.taskId = taskId;
	}

	public String getLogDate() {
		return logDate;
	}

	public void setLogDate(String logDate) {
		this.logDate = logDate;
	}

	public int getLogHours() {
		return logHours;
	}

	public void setLogHours(int logHours) {
		this.logHours = logHours;
	}

	public int getTaskActivityId() {
		return taskActivityId;
	}

	public void setTaskActivityId(int taskActivityId) {
		this.taskActivityId = taskActivityId;
	}

	public String getTaskComment() {
		return taskComment;
	}

	public void setTaskComment(String taskComment) {
		this.taskComment = taskComment;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}
}

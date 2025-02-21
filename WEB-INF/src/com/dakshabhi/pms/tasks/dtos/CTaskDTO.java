package com.dakshabhi.pms.tasks.dtos;

public class CTaskDTO {

	private int taskId = 0;
	private int projectId = 0;
	private String taskName = "";
	private String taskDescription = "";
	private int taskStatusId = 0;
	private String taskStatus = "";
	private int taskTypeId = 0;
	private String taskType = "";
	private int taskPriorityId = 0;
	private String taskPriority = "";
	private int assigneeId = 0;
	private String assigneeName = "";
	private String startDate = "";
	private String dueDate = "";
	private String dueDateTime = "";
	private int taskEstimatedTime = 0;
	private int taskCompletionValue = 0;
	private int userId = 0;
	private String lastUpdatedDate = "";
	private String projectName = "";
	private String followers = "";
	private int taskStatusType = 0;
	private int taskPriorityType = 0;
	private int count = 0;



	public String getDueDateTime() {
		return dueDateTime;
	}

	public void setDueDateTime(String dueDateTime) {
		this.dueDateTime = dueDateTime;
	}

	public int getTaskStatusType() {
		return taskStatusType;
	}

	public void setTaskStatusType(int taskStatusType) {
		this.taskStatusType = taskStatusType;
	}

	public int getTaskPriorityType() {
		return taskPriorityType;
	}

	public void setTaskPriorityType(int taskPriorityType) {
		this.taskPriorityType = taskPriorityType;
	}

	public String getFollowers() {
		return followers;
	}

	public void setFollowers(String followers) {
		this.followers = followers;
	}

	public String getProjectName() {
		return projectName;
	}

	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}

	public String getLastUpdatedDate() {
		return lastUpdatedDate;
	}

	public void setLastUpdatedDate(String lastUpdatedDate) {
		this.lastUpdatedDate = lastUpdatedDate;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public int getTaskId() {
		return taskId;
	}

	public void setTaskId(int taskId) {
		this.taskId = taskId;
	}

	public int getProjectId() {
		return projectId;
	}

	public void setProjectId(int projectId) {
		this.projectId = projectId;
	}

	public String getTaskName() {
		return taskName;
	}

	public void setTaskName(String taskName) {
		this.taskName = taskName;
	}

	public String getTaskDescription() {
		return taskDescription;
	}

	public void setTaskDescription(String taskDescription) {
		this.taskDescription = taskDescription;
	}

	public int getTaskStatusId() {
		return taskStatusId;
	}

	public void setTaskStatusId(int taskStatusId) {
		this.taskStatusId = taskStatusId;
	}

	public String getTaskStatus() {
		return taskStatus;
	}

	public void setTaskStatus(String taskStatus) {
		this.taskStatus = taskStatus;
	}

	public int getTaskTypeId() {
		return taskTypeId;
	}

	public void setTaskTypeId(int taskTypeId) {
		this.taskTypeId = taskTypeId;
	}

	public String getTaskType() {
		return taskType;
	}

	public void setTaskType(String taskType) {
		this.taskType = taskType;
	}

	public int getTaskPriorityId() {
		return taskPriorityId;
	}

	public void setTaskPriorityId(int taskPriorityId) {
		this.taskPriorityId = taskPriorityId;
	}

	public String getTaskPriority() {
		return taskPriority;
	}

	public void setTaskPriority(String taskPriority) {
		this.taskPriority = taskPriority;
	}

	public int getAssigneeId() {
		return assigneeId;
	}

	public void setAssigneeId(int assigneeId) {
		this.assigneeId = assigneeId;
	}

	public String getAssigneeName() {
		return assigneeName;
	}

	public void setAssigneeName(String assigneeName) {
		this.assigneeName = assigneeName;
	}

	public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public String getDueDate() {
		return dueDate;
	}

	public void setDueDate(String dueDate) {
		this.dueDate = dueDate;
	}

	public int getTaskEstimatedTime() {
		return taskEstimatedTime;
	}

	public void setTaskEstimatedTime(int taskEstimatedTime) {
		this.taskEstimatedTime = taskEstimatedTime;
	}

	public int getTaskCompletionValue() {
		return taskCompletionValue;
	}

	public void setTaskCompletionValue(int taskCompletionValue) {
		this.taskCompletionValue = taskCompletionValue;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}
	
	

}

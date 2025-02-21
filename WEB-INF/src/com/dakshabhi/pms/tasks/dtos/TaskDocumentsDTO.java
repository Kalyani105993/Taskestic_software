package com.dakshabhi.pms.tasks.dtos;

public class TaskDocumentsDTO {
	
	private int document_id;
	private int taskLog_id;
	private String document_name;
	private String documentDiscription;
	private String created_by;
	private String created_on;
	private int task_id;
	private int is_deleted;
	
	public int getTaskLog_id() {
		return taskLog_id;
	}
	public void setTaskLog_id(int taskLog_id) {
		this.taskLog_id = taskLog_id;
	}
	private int isadditional_doc = 0;
	
	
	
	public int getIsadditional_doc() {
		return isadditional_doc;
	}
	public void setIsadditional_doc(int isadditional_doc) {
		this.isadditional_doc = isadditional_doc;
	}
	public int getIs_deleted() {
		return is_deleted;
	}
	public void setIs_deleted(int is_deleted) {
		this.is_deleted = is_deleted;
	}
	public int getDocument_id() {
		return document_id;
	}
	public void setDocument_id(int document_id) {
		this.document_id = document_id;
	}
	public String getDocument_name() {
		return document_name;
	}
	public void setDocument_name(String document_name) {
		this.document_name = document_name;
	}
	public String getDocumentDiscription() {
		return documentDiscription;
	}
	public void setDocumentDiscription(String documentDiscription) {
		this.documentDiscription = documentDiscription;
	}
	
	public String getCreated_by() {
		return created_by;
	}
	public void setCreated_by(String created_by) {
		this.created_by = created_by;
	}
	public String getCreated_on() {
		return created_on;
	}
	public void setCreated_on(String created_on) {
		this.created_on = created_on;
	}
	public int getTask_id() {
		return task_id;
	}
	public void setTask_id(int task_id) {
		this.task_id = task_id;
	}
	
	

}

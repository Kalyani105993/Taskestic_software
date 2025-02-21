package com.dakshabhi.pms.masters.dtos;

public class CProjectSubGroupDTO {

	private int project_sub_group_id;
	private int project_group_id;
	private String project_sub_group;
	private String project_group;

	public int getProject_sub_group_id() {
		return project_sub_group_id;
	}

	public void setProject_sub_group_id(int project_sub_group_id) {
		this.project_sub_group_id = project_sub_group_id;
	}

	public int getProject_group_id() {
		return project_group_id;
	}

	public void setProject_group_id(int project_group_id) {
		this.project_group_id = project_group_id;
	}

	public String getProject_sub_group() {
		return project_sub_group;
	}

	public void setProject_sub_group(String project_sub_group) {
		this.project_sub_group = project_sub_group;
	}

	public String getProject_group() {
		return project_group;
	}

	public void setProject_group(String project_group) {
		this.project_group = project_group;
	}

}

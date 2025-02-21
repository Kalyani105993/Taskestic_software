package com.dakshabhi.pms.commonFilterApis.dto;

public class CJoinDTO {
	
	public String table;
    public String type;
    public CJoinConditionDTO on;
    
	public String getTable() {
		return table;
	}
	public void setTable(String table) {
		this.table = table;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public CJoinConditionDTO getOn() {
		return on;
	}
	public void setOn(CJoinConditionDTO on) {
		this.on = on;
	}
    
    

}

package com.dakshabhi.pms.commonFilterApis.dto;

public class CConditionDTO {
	public String field;
    public String operator;
    public String value;
    
	public String getField() {
		return field;
	}
	public void setField(String field) {
		this.field = field;
	}
	public String getOperator() {
		return operator;
	}
	public void setOperator(String operator) {
		this.operator = operator;
	}
	public String getValue() {
		return value;
	}
	public void setValue(String value) {
		this.value = value;
	}
    
    
}

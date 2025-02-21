package com.dakshabhi.pms.commonFilterApis.dto;

import java.util.List;

public class CGlobalQueryObjectDTO {
	 public String operation;
	    public List<String> columns;
	    public String table;
	    public List<CConditionDTO> conditions;
	    public List<CJoinDTO> joins;
	    
		public String getOperation() {
			return operation;
		}
		public void setOperation(String operation) {
			this.operation = operation;
		}
		public List<String> getColumns() {
			return columns;
		}
		public void setColumns(List<String> columns) {
			this.columns = columns;
		}
		public String getTable() {
			return table;
		}
		public void setTable(String table) {
			this.table = table;
		}
		public List<CConditionDTO> getConditions() {
			return conditions;
		}
		public void setConditions(List<CConditionDTO> conditions) {
			this.conditions = conditions;
		}
		public List<CJoinDTO> getJoins() {
			return joins;
		}
		public void setJoins(List<CJoinDTO> joins) {
			this.joins = joins;
		}
	    
	    
}

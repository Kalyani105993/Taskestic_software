package com.dakshabhi.pms.employeePerformanceReport.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.naming.InitialContext;

import com.dakshabhi.common.db.QueryHelper;
import com.dakshabhi.common.db.SQLResults;
import com.dakshabhi.pms.commonFilterApis.dao.CCommonFilterAPIDAO;
import com.dakshabhi.pms.commonFilterApis.dto.CMasterDTO;
import com.dakshabhi.pms.employeePerformanceReport.dto.CEmployeePerformanceDTO;

public class CEmployeePerformanceDAO {

	/*
	 * Method: Fetch employee performance details Input: company_id, from_date,
	 * to_date, if you want (project, employee) Output: Customized json responce
	 */
	public List<Map<String, Object>> fetchEmpPerformanceTasksBySP(String company_id, String from_date, String to_date,
			String project, String employee) {
		
		List<Map<String, Object>> dataList = new ArrayList<>();
		QueryHelper qh = new QueryHelper();

		if (employee == "") {employee = "0";}
		if (project == "") {project = "0";}
		
		if (to_date == "") {to_date = from_date;} 

		try {
			InitialContext ic = new InitialContext();
			String dbName = (String) ic.lookup("java:comp/env/Database");
			String conURL = "jdbc:mysql://localhost:3306/" + dbName
					+ "?autoReconnect=true&allowPublicKeyRetrieval=true&useSSL=false&useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";
			String username = (String) ic.lookup("java:comp/env/UID");
			String password = (String) ic.lookup("java:comp/env/password");
			
			Connection connection = DriverManager.getConnection(conURL, username, password);

			String storedProcedureCall = "{CALL create_emp_performance_sp(?, ? , ?, ?, ?)}";
			
			CallableStatement callableStatement = connection.prepareCall(storedProcedureCall);
			callableStatement.setString(1, from_date);
			callableStatement.setString(2, to_date);
			callableStatement.setString(3, company_id);
			callableStatement.setString(4, employee);
			callableStatement.setString(5, project);
			callableStatement.execute();

			ResultSet resultSet = callableStatement.getResultSet();

			if (resultSet != null) {
				ResultSetMetaData metaData = resultSet.getMetaData();
				int columnCount = metaData.getColumnCount();

				while (resultSet.next()) {
					Map<String, Object> dataMap = new LinkedHashMap<>();
					for (int colIndex = 1; colIndex <= columnCount; colIndex++) {
						String columnName = metaData.getColumnName(colIndex);
						Object columnValue = resultSet.getObject(columnName);
						dataMap.put(columnName, columnValue);
					}

					dataList.add(dataMap);
				}
				
				
			}
			callableStatement.close();
			connection.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}
		return dataList;

	}

}

package com.dakshabhi.pms.commonFilterApis.dao;

import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONObject;

import com.dakshabhi.common.db.QueryHelper;
import com.dakshabhi.common.db.SQLResults;
import com.dakshabhi.pms.commonFilterApis.dto.CConditionDTO;
import com.dakshabhi.pms.commonFilterApis.dto.CGlobalQueryObjectDTO;
import com.dakshabhi.pms.commonFilterApis.dto.CJoinDTO;
import com.dakshabhi.pms.commonFilterApis.dto.CMasterDTO;

public class CCommonFilterAPIDAO {

	/*
	 * Method: Custom API to get field_id & field_name from view 
	 * Input: master name
	 * means view name Output: primary key & primary name from view
	 */
	public ArrayList<CMasterDTO> fetchMasterData(String master, String company_id) {
		ArrayList<CMasterDTO> cMasterDataList = null;
		QueryHelper qh = new QueryHelper();
		CMasterDTO cMasterDTO = null;
		try {
			String sql = "select field_id, field_name from " + master + " where company_id = ?";
			qh.addParam(company_id);
			ResultSet rs = qh.runQueryStreamResults(sql);
			while (rs.next()) {
				if (cMasterDataList == null) {
					cMasterDataList = new ArrayList<CMasterDTO>();
				}
				cMasterDTO = new CMasterDTO();
				cMasterDTO.setField_id(rs.getInt("field_id"));
				cMasterDTO.setField_name(rs.getString("field_name"));

				cMasterDataList.add(cMasterDTO);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}
		return cMasterDataList;
	}

	/*
	 * Method: Dynamic filter method for reports Input: need provide json
	 * parameters, select params Output: Arraylist data & columns
	 */
	public HashMap<String, Object> fetchFilteredData(JSONObject params, JSONObject selectqry, JSONObject whereqry,
			String company_id, int startIndex, int endIndex, String pageNo) {
		int startLimit = (Integer.parseInt(pageNo) - 1) * endIndex;
		int endLimit = endIndex;
		ArrayList<Object> fetchFilteredDataList = new ArrayList<>();
		HashMap<String, Object> responce = new HashMap<>();
		QueryHelper qh = new QueryHelper();
		try {
			String query = "Select ";
			String view = (String) params.get("viewName");
			int deleteStatus = (int) params.get("is_deleted");
			String orderBy = (String) params.get("ORDER BY");

			if (!selectqry.keySet().isEmpty()) {
				for (String currentKey : selectqry.keySet()) {
					Object key = selectqry.get(currentKey);
					String value = key.toString();
					query += value + ", ";
				}
				query = query.substring(0, query.length() - 2);
			} else {
				query += "*";
			}
			query += " FROM " + view + " ";
			query += " WHERE ";
			if (!whereqry.keySet().isEmpty()) {
				for (String currentKey : whereqry.keySet()) {
					Object key = whereqry.get(currentKey);
					String value = key.toString();
					String val = String.format("'%s'", value.toString());
					query += currentKey + " " + val + " AND ";
				}
				query += "company_id = " + company_id;
			} else {
				query += "company_id = " + company_id + " AND " + "is_deleted = " + deleteStatus;
			}

			query += " ORDER BY " + orderBy;
			
			// addition for limiting the records
			query += " LIMIT "+startLimit+", "+endLimit+" ";

			System.out.println("task analysis query : " + query);

//			String sql = "select * from pms_employee_daily_work";
			SQLResults sqlRs = qh.runQuery(query);

			List<Object> objects = sqlRs.toList();
			ArrayList<String> columnNames = sqlRs.getColumnNames();
			int colCount = sqlRs.getColumnCount();
			int rowCount = sqlRs.getRowCount();

			for (int rowIndex = 0; rowIndex < rowCount; rowIndex++) {
				HashMap<String, Object> map = new HashMap<>();
				for (int colCountIndex = 0; colCountIndex < colCount; colCountIndex++) {
					map.put(columnNames.get(colCountIndex), objects.get(colCountIndex));
				}
				for (int removefObjIndex = 0; removefObjIndex < colCount; removefObjIndex++) {
					objects.remove(0);
				}
				fetchFilteredDataList.add(map);
			}

			responce.put("data", fetchFilteredDataList);
			responce.put("columns", columnNames);

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}

		return responce;
	}

	/*
	 * Method: Fetch any data by providing json  
	 * Input: JSON Object	
	 * Output: List object data
	 */
	public List<Map<String, Object>> globalJsonQueryExecution(CGlobalQueryObjectDTO globalQuery) {
		List<Map<String, Object>> dataList = new ArrayList<>();
		QueryHelper qh = new QueryHelper();
		
		try {
			StringBuilder queryBuilder = new StringBuilder();

			// Append the operation
			if ("select".equalsIgnoreCase(globalQuery.operation)) {
				queryBuilder.append("SELECT ");
				queryBuilder.append(String.join(", ", globalQuery.columns));
				queryBuilder.append(" FROM ");
				queryBuilder.append(globalQuery.table);

				// Append conditions
				if (!globalQuery.conditions.isEmpty()) {
					queryBuilder.append(" WHERE ");
					for (int i = 0; i < globalQuery.conditions.size(); i++) {
						CConditionDTO condition = globalQuery.conditions.get(i);
						queryBuilder.append(condition.field).append(" ").append(condition.operator).append(" '")
								.append(condition.value).append("'");
						if (i < globalQuery.conditions.size() - 1) {
							queryBuilder.append(" AND ");
						}
					}
				}

				// Append joins
				for (CJoinDTO join : globalQuery.joins) {
					queryBuilder.append(" ").append(join.type.toUpperCase()).append(" JOIN ").append(join.table)
							.append(" ON ").append(join.on.left).append(" = ").append(join.on.right);
				}
			}
			System.out.println("globalJsonQueryExecution query: " + queryBuilder.toString());
			ResultSet resultSet  = qh.runQueryStreamResults(queryBuilder.toString());
			
			if (resultSet != null) {
				ResultSetMetaData metaData = resultSet.getMetaData();
				int columnCount = metaData.getColumnCount();

				while (resultSet.next()) {
					Map<String, Object> dataMap = new HashMap<>();
					for (int colIndex = 1; colIndex <= columnCount; colIndex++) {
						String columnName = metaData.getColumnName(colIndex);
						Object columnValue = resultSet.getObject(columnName);
						dataMap.put(columnName, columnValue);
					}

					dataList.add(dataMap);
				}
				
				
			}

		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			qh.releaseConnection();
		}
		return dataList;
	}

}

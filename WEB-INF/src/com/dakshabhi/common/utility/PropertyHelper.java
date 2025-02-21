package com.dakshabhi.common.utility;

import java.sql.ResultSet;

import com.dakshabhi.common.db.QueryHelper;

public class PropertyHelper {

	public static String get(String tokenName) {
		return get(tokenName, "");
	}

	public static String get(String tokenName, String defaultValue) {

		QueryHelper helper = new QueryHelper();
		try {
			String sql = "select tokenvalue from properties where token = ?";
			helper.addParam(tokenName);
			ResultSet rs = helper.runQueryStreamResults(sql);
			if (rs.next()) {
				return StringUtility.removeNull(rs.getString("tokenvalue"));
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			helper.releaseConnection();
		}

		return defaultValue;

	}
}

package com.dakshabhi.pms.api.daos;

import java.sql.ResultSet;

import com.dakshabhi.common.db.QueryHelper;
import com.dakshabhi.common.utility.StringUtility;
import com.dakshabhi.pms.api.dtos.CompanyDTO;

public class CompanyDAO {

	
	public CompanyDTO getCompanyInfoByKey(String appKey) {
		QueryHelper qh = new QueryHelper();
		try {
			String sql = "select * from pms_companies where sitekey = ?";
			qh.addParam(appKey);
			ResultSet rs = qh.runQueryStreamResults(sql);
			if(rs.next()) {
				CompanyDTO companyDTO = new CompanyDTO();
				companyDTO.setCompanyID(rs.getInt("company_id"));
				companyDTO.setCompanyName(StringUtility.removeNull(rs.getString("company_name")));
				companyDTO.setCompanyURL(StringUtility.removeNull(rs.getString("siteurl")));
				return companyDTO;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			qh.releaseConnection();
		}
		return null;
	}
}

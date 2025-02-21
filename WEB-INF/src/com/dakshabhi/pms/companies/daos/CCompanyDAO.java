package com.dakshabhi.pms.companies.daos;

/***
 * Class for all operations related to Company
 * 
 */
import java.sql.ResultSet;
import java.util.ArrayList;

import com.dakshabhi.common.db.QueryHelper;
import com.dakshabhi.common.utility.StringUtility;
import com.dakshabhi.pms.companies.dtos.CCompanyDTO;

public class CCompanyDAO {
	/*
	 * Method for fetch company name by company id Input: Company ID Output:
	 * CompanyDTO
	 */
	public static CCompanyDTO getCompanyName(String company_id) {
		CCompanyDTO cCompanyDTO = new CCompanyDTO();
		QueryHelper qh = new QueryHelper();
		try {
			String sql = "select * from pms_companies where company_id = ?";
			qh.addParam(company_id);
			ResultSet rs = qh.runQueryStreamResults(sql);
			if (rs.next()) {
				cCompanyDTO.setCompany_id(rs.getInt("company_id"));
				cCompanyDTO.setCompany_name(StringUtility.removeNull(rs.getString("company_name")));
				cCompanyDTO.setCompany_email(StringUtility.removeNull(rs.getString("company_email")));
				cCompanyDTO.setCompany_address(StringUtility.removeNull(rs.getString("company_address")));
				cCompanyDTO.setCompany_phone(StringUtility.removeNull(rs.getString("company_phone")));
				cCompanyDTO.setFrom_login(StringUtility.removeNull(rs.getString("from_login")));
				cCompanyDTO.setTo_login(StringUtility.removeNull(rs.getString("to_login")));
				cCompanyDTO.setTimezone(rs.getString("time_zone"));
				cCompanyDTO.setIsToggelSwitchOn(StringUtility.removeNull(rs.getString("isToggleOn")));

			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}

		return cCompanyDTO;
	}

	/*
	 * Method for update company details Input: CompanyDTO, Company ID Output:
	 * CompanyDTO
	 */
	public CCompanyDTO updateCompanyDetails(CCompanyDTO cCompanyDTO, String company_id) {
		QueryHelper qh = new QueryHelper();
		try {
			String sql = "UPDATE pms_companies SET company_name = ?, company_address = ?, company_phone = ?, company_email = ? ,from_login = ?, to_login = ? , time_zone = ? , isToggleOn = ? WHERE company_id = ?;";

			qh.addParam(cCompanyDTO.getCompany_name());
			qh.addParam(cCompanyDTO.getCompany_address());
			qh.addParam(cCompanyDTO.getCompany_phone());
			qh.addParam(cCompanyDTO.getCompany_email());
			qh.addParam(cCompanyDTO.getFrom_login());
			qh.addParam(cCompanyDTO.getTo_login());
			qh.addParam(cCompanyDTO.getTimezone());
			qh.addParam(cCompanyDTO.getIsToggelSwitchOn());
			qh.addParam(company_id);
			
			qh.runQuery(sql);

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}

		return cCompanyDTO;
	}

	/*
	 * Method for get CompanyID by URL Input: URL Output: Company ID
	 */

	public static String getCompanyIDByURL(String url) {
		QueryHelper qh = new QueryHelper();
		try {
			String sql = "select company_id from pms_companies where siteurl = ?";
			qh.addParam(url);
			ResultSet rs = qh.runQueryStreamResults(sql);
			if (rs.next()) {
				return rs.getString("company_id");
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}
		return "";
	}
	
	/*
	 * Method for fetch company information by url id Input:
	 * CompanyDTO
	 */
	public static CCompanyDTO getCompanyInfoByUrl(String url) {
		CCompanyDTO cCompanyDTO = new CCompanyDTO();
		QueryHelper qh = new QueryHelper();
		try {
			String sql = "select * from pms_companies where siteurl = ?";
			qh.addParam(url);
			ResultSet rs = qh.runQueryStreamResults(sql);
			if (rs.next()) {
				cCompanyDTO.setCompany_id(rs.getInt("company_id"));
				cCompanyDTO.setCompany_name(StringUtility.removeNull(rs.getString("company_name")));
				cCompanyDTO.setCompany_email(StringUtility.removeNull(rs.getString("company_email")));
				cCompanyDTO.setCompany_address(StringUtility.removeNull(rs.getString("company_address")));
				cCompanyDTO.setCompany_phone(StringUtility.removeNull(rs.getString("company_phone")));
				cCompanyDTO.setFrom_login(StringUtility.removeNull(rs.getString("from_login")));
				cCompanyDTO.setTo_login(StringUtility.removeNull(rs.getString("to_login")));

			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}

		return cCompanyDTO;
	}



	/*
	 * Method for get other company list Input: none Output: Arraylist of CompanyDTO
	 * 
	 */
	public ArrayList<CCompanyDTO> getOtherCompanyList() {
		ArrayList<CCompanyDTO> otherCompanyList = new ArrayList<CCompanyDTO>();
		QueryHelper qh = new QueryHelper();
		try {
			String sql = "select * from pms_companies where company_id <> 1 ";
			ResultSet rs = qh.runQueryStreamResults(sql);
			while (rs.next()) {
				CCompanyDTO companyDTO = new CCompanyDTO();
				companyDTO.setCompany_id(rs.getInt("company_id"));
				companyDTO.setCompany_name(rs.getString("company_name"));
				otherCompanyList.add(companyDTO);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}

		return otherCompanyList;
	}

	/*
	 * Method for check company Emial and Phone is alredy exists input company_id
	 * ,isexistvalue ,checkfor output true or false
	 */
	public boolean isalreadyexists(String company_id, String isexistvalue, String checkfor) {
		QueryHelper qh = new QueryHelper();
		try {
			String query = "";
			if (("company_email").equalsIgnoreCase(checkfor)) {
				query = "select * from pms_companies where isexpired = 0 and company_id <> ? and company_email = ?";

			} else if (("company_phone").equalsIgnoreCase(checkfor)) {
				query = "select * from pms_companies where isexpired = 0 and company_id <> ? and company_phone = ?";
			}
			qh.addParam(company_id);
			qh.addParam(isexistvalue);
			ResultSet rs = qh.runQueryStreamResults(query);
			if (rs.next()) {
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}
		return false;
	}

}

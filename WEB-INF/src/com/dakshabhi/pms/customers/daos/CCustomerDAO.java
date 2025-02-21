package com.dakshabhi.pms.customers.daos;

import java.sql.ResultSet;
import java.util.ArrayList;

import com.dakshabhi.common.constants.ConfigConstants;
import com.dakshabhi.common.db.QueryHelper;
import com.dakshabhi.common.utility.StringUtility;
import com.dakshabhi.pms.customers.dtos.CCustomerDTO;

public class CCustomerDAO {
	
 /* Method: Save Customer Info
  * Input: CustomerDTO, Company Id
  * Output: true/false
  */
	public boolean saveCustomer(CCustomerDTO detailsDTO, String companyID) {
		QueryHelper qh = new QueryHelper();
		try {
			String query = ("INSERT INTO pms_customers(company_id, customer_name, customer_address, customer_email, customer_phone,customer_alternate_email,customer_alternate_contact,customer_type_id)"
					+ "values (?, ?, ?, ?, ?, ?, ?, ?)");
			qh.addParam(companyID);
			qh.addParam(StringUtility.removeNull(detailsDTO.getCustomer_name()));
			qh.addParam(StringUtility.removeNull(detailsDTO.getCustomer_address()));
			qh.addParam(StringUtility.removeNull(detailsDTO.getCustomer_email()));
			qh.addParam(StringUtility.removeNull(detailsDTO.getCustomer_phone()));
			qh.addParam(StringUtility.removeNull(detailsDTO.getCustomer_alternate_emailId()));
			qh.addParam(StringUtility.removeNull(detailsDTO.getCustomer_alternate_contact()));
			qh.addParam(detailsDTO.getCustomer_type_id());

			qh.runQuery(query);
			qh.clearParams();
			int status = qh.getNumRecordsUpdated();
			if (status > 0) {
				return true;
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}
		return false;

	}

	public boolean deleteCustomer(String customerId) {

		QueryHelper qh = new QueryHelper();
		try {
			String sqlUpdateCustomer = "update pms_customers set is_deleted =1 where customer_id = ?";
			qh.addParam(customerId);
			qh.runQuery(sqlUpdateCustomer);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}

		return false;
	}

	public Object[] getCustomerDetails(int startIndex, int endIndex, String companyID, String pageNo) {
		Object[] list = null;
		int startLimit = (Integer.parseInt(pageNo)-1)* endIndex;
		int endLimit = endIndex;
		ArrayList<CCustomerDTO> cCustomerDTOs = null;
		QueryHelper qh = new QueryHelper();
		CCustomerDTO cCustomerDTO = null;
		int count = 0;
		try {
			String getCount = "select count(customer_id) as count from pms_customers where company_id = ? and is_deleted =0";
			qh.addParam(companyID);
			ResultSet rSet = qh.runQueryStreamResults(getCount);
			if (rSet.next()) {
				count = rSet.getInt("count");
				System.out.println(count);
			}
			qh.clearParams();

			String sqlCustomer = "select * from pms_customers where company_id = ? and  is_deleted = 0 limit "+startLimit+","+endLimit+"  ";
			qh.addParam(companyID);
			ResultSet rs = qh.runQueryStreamResults(sqlCustomer);
			
			while (rs.next()) {
				if (cCustomerDTOs == null) {
					cCustomerDTOs = new ArrayList<CCustomerDTO>();
				}
				cCustomerDTO = new CCustomerDTO();
				cCustomerDTO.setCompany_id(rs.getInt("company_id"));
				cCustomerDTO.setCustomer_id(rs.getInt("customer_id"));
				cCustomerDTO.setCustomer_name(rs.getString("customer_name"));
				cCustomerDTO.setCustomer_address(rs.getString("customer_address"));
				cCustomerDTO.setCustomer_email(rs.getString("customer_email"));
				cCustomerDTO.setCustomer_phone(rs.getString("customer_phone"));
				cCustomerDTO.setCustomer_alternate_contact(rs.getString("customer_alternate_contact"));
				cCustomerDTO.setCustomer_alternate_emailId(rs.getString("customer_alternate_email"));
				cCustomerDTO.setCustomer_type_id(Integer.parseInt(rs.getString("customer_type_id")));

				cCustomerDTO.setIs_active(rs.getInt("is_active"));
				cCustomerDTO.setIs_deleted(rs.getInt("is_deleted"));
				cCustomerDTOs.add(cCustomerDTO);
			}
			list = new Object[] { cCustomerDTOs, count };

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}
		return list;
	}

	public CCustomerDTO getCustomerDetailsForEdit(String customerId) {
		CCustomerDTO customerInfoDTO = null;
		QueryHelper qh = new QueryHelper();
		try {
			String sqlCustomerInfo = "select * from pms_customers where is_deleted =0 and customer_id = ? ";
			qh.addParam(customerId);
			ResultSet rs = qh.runQueryStreamResults(sqlCustomerInfo);
			if (rs.next()) {
				customerInfoDTO = new CCustomerDTO();
				customerInfoDTO.setCompany_id(rs.getInt("company_id"));
				customerInfoDTO.setCustomer_id(rs.getInt("customer_id"));
				customerInfoDTO.setCustomer_name(rs.getString("customer_name"));
				customerInfoDTO.setCustomer_address(rs.getString("customer_address"));
				customerInfoDTO.setCustomer_email(rs.getString("customer_email"));
				customerInfoDTO.setCustomer_phone(rs.getString("customer_phone"));
				customerInfoDTO.setCustomer_alternate_emailId(rs.getString("customer_alternate_email"));
				customerInfoDTO.setCustomer_alternate_contact(rs.getString("customer_alternate_contact"));
				customerInfoDTO.setIs_active(rs.getInt("is_active"));
				customerInfoDTO.setIs_deleted(rs.getInt("is_deleted"));
				customerInfoDTO.setCustomer_type_id(rs.getInt("customer_type_id"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}
		return customerInfoDTO;

	}

	public boolean updateCustomerDetails(CCustomerDTO objCustomerDTO, String companyID) {
		QueryHelper qh = new QueryHelper();
		try {
			String sqlUpdateCustomer = "update pms_customers set company_id = ? , customer_name = ?,customer_address = ?  ,customer_email = ? ,customer_phone = ?,customer_alternate_email = ?,customer_alternate_contact = ? ,customer_type_id = ?  where customer_id = ? ";
			qh.addParam(companyID);
			qh.addParam(objCustomerDTO.getCustomer_name());
			qh.addParam(objCustomerDTO.getCustomer_address());
			qh.addParam(objCustomerDTO.getCustomer_email());
			qh.addParam(objCustomerDTO.getCustomer_phone());
			qh.addParam(objCustomerDTO.getCustomer_alternate_emailId());
			qh.addParam(objCustomerDTO.getCustomer_alternate_contact());
			qh.addParam(objCustomerDTO.getCustomer_type_id());
			qh.addParam(objCustomerDTO.getCustomer_id());
			qh.runQuery(sqlUpdateCustomer);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}
		return false;
	}

	public Object[] getSearchData(String customer_name, String customer_email, String customer_phone, int startIndex,
			int endIndex, String companyID, String pageNo) {
		int startLimit = (Integer.parseInt(pageNo)-1)* endIndex;
		int endLimit = endIndex;
		ArrayList<CCustomerDTO> cCustomerList = null;
		Object[] obj = null;
		QueryHelper qh = new QueryHelper();
		CCustomerDTO cCustomerDTO = null;
		int count = 0;
		try {
			String getCount = "select count(customer_id) as count from pms_customers where company_id = ? and customer_name LIKE '%"
					+ customer_name + "%' AND customer_email LIKE '%" + customer_email + "%' AND customer_phone LIKE '%"
					+ customer_phone + "%' and is_deleted = 0 ";
			qh.addParam(companyID);
			ResultSet rSet = qh.runQueryStreamResults(getCount);
			if (rSet.next()) {
				count = rSet.getInt("count");
			}

			qh.clearParams();
			String sqlCustomer = "SELECT * FROM pms_customers where company_id = ? and customer_name LIKE '%"
					+ customer_name + "%' AND customer_email LIKE '%" + customer_email + "%' AND customer_phone LIKE '%"
					+ customer_phone + "%' and is_deleted = 0 limit "+startLimit+","+endLimit+"";
			qh.addParam(companyID);
			ResultSet rs = qh.runQueryStreamResults(sqlCustomer);
			while (rs.next()) {
				if (cCustomerList == null) {
					cCustomerList = new ArrayList<CCustomerDTO>();
				}
				cCustomerDTO = new CCustomerDTO();
				cCustomerDTO.setCompany_id(rs.getInt("company_id"));
				cCustomerDTO.setCustomer_id(rs.getInt("customer_id"));
				cCustomerDTO.setCustomer_name(rs.getString("customer_name"));
				cCustomerDTO.setCustomer_address(rs.getString("customer_address"));
				cCustomerDTO.setCustomer_email(rs.getString("customer_email"));
				cCustomerDTO.setCustomer_phone(rs.getString("customer_phone"));
				cCustomerDTO.setIs_active(rs.getInt("is_active"));
				cCustomerDTO.setIs_deleted(rs.getInt("is_deleted"));
				cCustomerList.add(cCustomerDTO);
			}
			obj = new Object[] { cCustomerList, count };
			System.out.println(cCustomerList);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}

		return obj;

	}

}

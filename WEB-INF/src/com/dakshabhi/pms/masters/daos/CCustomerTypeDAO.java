package com.dakshabhi.pms.masters.daos;

import java.sql.ResultSet;
import java.util.ArrayList;

import com.dakshabhi.common.db.QueryHelper;
import com.dakshabhi.common.utility.StringUtility;
import com.dakshabhi.pms.masters.dtos.CCustomerTypeDTO;

public class CCustomerTypeDAO {

	public static ArrayList<CCustomerTypeDTO> getCustomerTypeList(String CompanyID) {
		ArrayList<CCustomerTypeDTO> customerTypeList = new ArrayList<CCustomerTypeDTO>();
		QueryHelper qh = new QueryHelper();
		try {
			String SQL = "select * from pms_mst_customer_type where is_deleted = 0 and company_id = ? order by is_default desc";
			qh.addParam(CompanyID);

			ResultSet rs = qh.runQueryStreamResults(SQL);
			while (rs.next()) {
				CCustomerTypeDTO customerTypeDTO = new CCustomerTypeDTO();
				customerTypeDTO.setCustomer_type_id(rs.getInt("customer_type_id"));
				customerTypeDTO.setCustomer_type(rs.getString("customer_type"));
				customerTypeList.add(customerTypeDTO);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}
		return customerTypeList;
	}

	public static boolean deleteCustomerType(int pkid) {
		QueryHelper qh = new QueryHelper();
		try {
			String SQL = "DELETE from pms_mst_customer_type where customer_type_id = ?";
			qh.addParam(pkid);
			qh.runQuery(SQL);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}
		return false;
		
		
	}

	public static boolean createCustomerType(int companyid, String cxType) {
		
		QueryHelper qh = new QueryHelper();
		try {
			String SQL = "INSERT INTO pms_mst_customer_type (customer_type, company_id) VALUES (?, ?)";
			qh.addParam(cxType);
			qh.addParam(companyid);
			qh.runQuery(SQL);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}
		return false;
	}

	public static ArrayList<CCustomerTypeDTO> populateData(int id) {

		ArrayList<CCustomerTypeDTO> CustomerTypeList = new ArrayList<CCustomerTypeDTO>();
		
		QueryHelper qh = new QueryHelper();
		try {
			String SQL = "SELECT * FROM pms_mst_customer_type where customer_type_id = ?";
			qh.addParam(id);
			ResultSet rs = qh.runQueryStreamResults(SQL);
			
			while(rs.next()) {
				CCustomerTypeDTO cCustomerTypeDTO = new CCustomerTypeDTO();
				
				
				cCustomerTypeDTO.setCustomer_type_id(rs.getInt("customer_type_id"));
				cCustomerTypeDTO.setCustomer_type(StringUtility.removeNull(rs.getString("customer_type")));
				cCustomerTypeDTO.setCompany_id(rs.getInt("company_id"));
				
				CustomerTypeList.add(cCustomerTypeDTO);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.closeConnection();
		}
		return CustomerTypeList;
		
		}

	public static boolean updateCustomerType(String cxType, int id) {
		QueryHelper qh = new QueryHelper();
		try {
			String SQL = "UPDATE pms_mst_customer_type SET customer_type = ? WHERE customer_type_id = ?";
			qh.addParam(cxType);
			qh.addParam(id);
			qh.runQuery(SQL);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			qh.closeConnection();
		}
		return false;
		
	}
	
	}

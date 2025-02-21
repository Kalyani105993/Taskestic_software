package com.dakshabhi.pms.projects.daos;

import java.sql.ResultSet;
import java.util.ArrayList;

import com.dakshabhi.common.constants.ConfigConstants;
import com.dakshabhi.common.db.QueryHelper;
import com.dakshabhi.common.utility.StringUtility;
import com.dakshabhi.pms.customers.dtos.CCustomerDTO;
import com.dakshabhi.pms.projects.dtos.CProjectContactsDTO;
import com.dakshabhi.pms.projects.dtos.CProjectDTO;

public class CProjectContactsDAO {
	
	public void saveProjectContact(CProjectContactsDTO projectContactsDTO, String companyId) {
		QueryHelper qh = new QueryHelper();
		try {
			String query = ("INSERT INTO pms_project_contacts(company_id,customer_id,project_id, contact_person_name, contact_person_designation, contact_person_email,contact_person_phone)"
					+ "values (?, ?, ?, ?, ?, ?, ?)");
			qh.addParam(companyId);
			qh.addParam(projectContactsDTO.getCustomer_id());
			qh.addParam(projectContactsDTO.getProject_id());
			qh.addParam(StringUtility.removeNull(projectContactsDTO.getContact_person_name()));
			qh.addParam(StringUtility.removeNull(projectContactsDTO.getContact_person_designation()));
			qh.addParam(StringUtility.removeNull(projectContactsDTO.getContact_person_email()));
			qh.addParam(StringUtility.removeNull(projectContactsDTO.getContact_person_phone()));
			qh.runQuery(query);
			qh.clearParams();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}

	}
	
	public ArrayList<CProjectContactsDTO> getProjectContactDetails(String companyId) {
		ArrayList<CProjectContactsDTO> cProjectContactDTOs = null;
		QueryHelper qh = new QueryHelper();
		CProjectContactsDTO cProjectContactDTO = null;
		try {
			String sqlProjectContact = "select * from project_contacts_info_view where is_deleted = 0 and company_id = ?";
			qh.addParam(companyId);

			ResultSet rs = qh.runQueryStreamResults(sqlProjectContact);
			while (rs.next()) {
				if (cProjectContactDTOs == null) {
					cProjectContactDTOs = new ArrayList<CProjectContactsDTO>();
				}
				cProjectContactDTO = new CProjectContactsDTO();
				cProjectContactDTO.setProject_contact_id(rs.getInt("project_contact_id"));
				cProjectContactDTO.setCompany_id(rs.getInt("company_id"));
				cProjectContactDTO.setProject_id(rs.getInt("project_id"));
				cProjectContactDTO.setCustomer_id(rs.getInt("customer_id"));
				cProjectContactDTO.setProject_name(StringUtility.removeNull(rs.getString("project_name")));
				cProjectContactDTO.setCustomer_name(StringUtility.removeNull(rs.getString("customer_name")));
				cProjectContactDTO.setContact_person_name(rs.getString("contact_person_name"));
				cProjectContactDTO.setContact_person_designation(rs.getString("contact_person_designation"));
				cProjectContactDTO.setContact_person_email(rs.getString("contact_person_email"));
				cProjectContactDTO.setContact_person_phone(rs.getString("contact_person_phone"));
				cProjectContactDTO.setIs_active(rs.getInt("is_active"));
				cProjectContactDTO.setIs_deleted(rs.getInt("is_deleted"));
				cProjectContactDTOs.add(cProjectContactDTO);
			}

		} catch (Exception e) {
			qh.releaseConnection();
		}
		return cProjectContactDTOs;
	}
	
	public ArrayList<CProjectContactsDTO> getProjectContactCustomerIdOnly() {
		ArrayList<CProjectContactsDTO> cProjectContactDTOs = null;
		QueryHelper qh = new QueryHelper();
		CProjectContactsDTO cProjectContactDTO = null;
		
		try {
			String sqlProjectContact = "select customer_id, customer_name from pms_customers;";

			ResultSet rs = qh.runQueryStreamResults(sqlProjectContact);
			while (rs.next()) {
				if (cProjectContactDTOs == null) {
					cProjectContactDTOs = new ArrayList<CProjectContactsDTO>();
				}
				cProjectContactDTO = new CProjectContactsDTO();
				cProjectContactDTO.setCustomer_id(rs.getInt("customer_id"));
				cProjectContactDTO.setCustomer_name(rs.getString("customer_name"));
				cProjectContactDTOs.add(cProjectContactDTO);
			}

		} catch (Exception e) {
			qh.releaseConnection();
		}
		return cProjectContactDTOs;
	}
	
	public static boolean deleteProjectContact(String projectContactId) {

		QueryHelper qh = new QueryHelper();
		try {
			String sqlDeleteProjectContact = "update pms_project_contacts set is_deleted =1 where project_contact_id = ?";
			qh.addParam(projectContactId);
			qh.runQuery(sqlDeleteProjectContact);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}

		return false;
	}

	public static CProjectContactsDTO getProjectContactDetailsForEdit(String projectContactId) {
		CProjectContactsDTO projectContactInfoDTO = null;
		QueryHelper qh = new QueryHelper();
		try {
			String sqlProjectContactInfo = "select * from pms_project_contacts where is_deleted =0 and project_contact_id = ? ";
			qh.addParam(projectContactId);
			ResultSet rs = qh.runQueryStreamResults(sqlProjectContactInfo);
			if (rs.next()) {
				projectContactInfoDTO = new CProjectContactsDTO();
				projectContactInfoDTO.setProject_contact_id(rs.getInt("project_contact_id"));
				projectContactInfoDTO.setCompany_id(rs.getInt("company_id"));
				projectContactInfoDTO.setProject_id(rs.getInt("project_id"));
				projectContactInfoDTO.setCustomer_id(rs.getInt("customer_id"));
				projectContactInfoDTO.setContact_person_name(rs.getString("contact_person_name"));
				projectContactInfoDTO.setContact_person_designation(rs.getString("contact_person_designation"));
				projectContactInfoDTO.setContact_person_email(rs.getString("contact_person_email"));
				projectContactInfoDTO.setContact_person_phone(rs.getString("contact_person_phone"));
				projectContactInfoDTO.setIs_active(rs.getInt("is_active"));
				projectContactInfoDTO.setIs_deleted(rs.getInt("is_deleted"));
//				
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}
		return projectContactInfoDTO;
	}

	public static boolean updateProjectContactDetails(CProjectContactsDTO objProjectContactDTO) {
		QueryHelper qh = new QueryHelper();
		try {
			String sqlUpdateProjectContact = "update pms_project_contacts set  customer_id = ?,  project_id = ?, contact_person_name = ?  ,contact_person_designation = ? ,contact_person_email = ?, contact_person_phone = ? where project_contact_id = ?";
		
			qh.addParam(objProjectContactDTO.getCustomer_id());
			qh.addParam(objProjectContactDTO.getProject_id());
			qh.addParam(objProjectContactDTO.getContact_person_name());
			qh.addParam(objProjectContactDTO.getContact_person_designation());
			qh.addParam(objProjectContactDTO.getContact_person_email());
			qh.addParam(objProjectContactDTO.getContact_person_phone());
			
			qh.addParam(objProjectContactDTO.getProject_contact_id());
			
			qh.runQuery(sqlUpdateProjectContact);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}
		return false;
	}
	
	public static ArrayList<CProjectDTO> getProjectsNameList() {
		ArrayList<CProjectDTO> projectNameList = null;
		QueryHelper qh = new QueryHelper();
		CProjectDTO projectContactsDTO = null;
		try {
			String sqlProjectNameList = "SELECT project_id,project_name FROM pms_projects where company_id= ?";
			qh.addParam(1);
			ResultSet rs = qh.runQueryStreamResults(sqlProjectNameList);
			while (rs.next()) {
				if (projectNameList == null) {
					projectNameList = new ArrayList<CProjectDTO>();
				}
				projectContactsDTO = new CProjectDTO();
				projectContactsDTO.setProject_id(rs.getInt("project_id"));
				projectContactsDTO.setProject_name(StringUtility.removeNull(rs.getString("project_name")));
				projectNameList.add(projectContactsDTO);
			}
			System.out.println(projectNameList);
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			qh.releaseConnection();
		}

		return projectNameList;
	}


	
	

}


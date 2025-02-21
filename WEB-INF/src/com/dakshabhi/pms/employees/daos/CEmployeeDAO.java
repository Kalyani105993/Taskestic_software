package com.dakshabhi.pms.employees.daos;

import java.sql.ResultSet;
import java.util.ArrayList;

import com.dakshabhi.common.constants.ConfigConstants;
import com.dakshabhi.common.db.QueryHelper;
import com.dakshabhi.common.security.EncryptionManager;
import com.dakshabhi.common.utility.StringUtility;
import com.dakshabhi.pms.employees.dtos.CEmployeeDTO;
import com.dakshabhi.pms.employees.dtos.CEmployeeInfoDTO;

public class CEmployeeDAO {

	public Object[] getAllEmployeeDetails(int startIndex, int endIndex, String companyID, String pageNo) {
		int count = 0;
		ArrayList<CEmployeeInfoDTO> cEmployeeList = null;
		QueryHelper qh = new QueryHelper();
		CEmployeeInfoDTO cEmployeeDTO = null;
		Object[] cEmployeeListObj = null;
		int startLimit = (Integer.parseInt(pageNo) - 1) * endIndex;
		int endLimit = endIndex;
		try {
			String getCount = "select count(employee_id) as count from employee_info_view where is_deleted =0 and company_id = ?";
			qh.addParam(companyID);
			ResultSet result = qh.runQueryStreamResults(getCount);
			if (result.next()) {
				count = result.getInt("count");
			}
			System.out.println("Total No of Records " + count);
			
			String sqlEmployees = "SELECT * FROM employee_info_view WHERE company_id = ? and is_deleted = 0 limit "
					+ startLimit + "," + endLimit + " ";
			qh.addParam(companyID);
			ResultSet rs = qh.runQueryStreamResults(sqlEmployees);
			while (rs.next()) {
				if (cEmployeeList == null) {
					cEmployeeList = new ArrayList<CEmployeeInfoDTO>();
				}
				cEmployeeDTO = new CEmployeeInfoDTO();
				cEmployeeDTO.setEmployee_id(rs.getInt("employee_id"));
				cEmployeeDTO.setCompany_id(rs.getInt("company_id"));
				cEmployeeDTO.setEmployee_code(rs.getString("employee_code"));
				cEmployeeDTO.setEmployee_name(rs.getString("employee_name"));
				cEmployeeDTO.setDepartment_id(rs.getInt("department_id"));
				cEmployeeDTO.setRemporting_to(rs.getInt("remporting_to"));
				cEmployeeDTO.setEmployee_role(rs.getInt("employee_role"));
				cEmployeeDTO.setEmployee_email(rs.getNString("employee_email"));
				cEmployeeDTO.setEmployee_phone(rs.getString("employee_phone"));
				cEmployeeDTO.setDepartment_name(StringUtility.removeNull(rs.getString("department_name")));
				cEmployeeDTO.setEmployee_role_name(StringUtility.removeNull(rs.getString("employee_role_name")));
				cEmployeeDTO.setReporting_to_name(StringUtility.removeNull(rs.getString("reporting_to_name")));
				cEmployeeDTO.setIs_active(rs.getInt("is_active"));
				cEmployeeDTO.setEmployee_status(rs.getString("employee_status_name"));
				cEmployeeDTO.setEmployee_profile_avatar(StringUtility.removeNull(rs.getString("profile_photo")));
				if (!"default.jpg".equalsIgnoreCase(cEmployeeDTO.getEmployee_profile_avatar())) {
					cEmployeeDTO.setEmployee_profile_avatar(StringUtility.removeNull(rs.getString("employee_id")) + "/"
							+ StringUtility.removeNull(rs.getString("profile_photo")));
				}
				cEmployeeList.add(cEmployeeDTO);
			}
			cEmployeeListObj = new Object[] { cEmployeeList, count };
		} catch (Exception e) {
			qh.releaseConnection();
		}
		return cEmployeeListObj;
	}

	public ArrayList<CEmployeeInfoDTO> getEmployeeDetails(int employee_id, String companyID) {

		ArrayList<CEmployeeInfoDTO> cEmployeeList = null;
		QueryHelper qh = new QueryHelper();
		CEmployeeInfoDTO cEmployeeDTO = null;
		try {
			String sqlEmployees = "SELECT * FROM employee_info_view WHERE company_id = ? and is_deleted = 0 and  (remporting_to = ? or employee_id =?)";
			qh.addParam(companyID);
			qh.addParam(employee_id);
			qh.addParam(employee_id);

			ResultSet rs = qh.runQueryStreamResults(sqlEmployees);
			while (rs.next()) {
				if (cEmployeeList == null) {
					cEmployeeList = new ArrayList<CEmployeeInfoDTO>();
				}
				cEmployeeDTO = new CEmployeeInfoDTO();
				cEmployeeDTO.setEmployee_id(rs.getInt("employee_id"));
				cEmployeeDTO.setCompany_id(rs.getInt("company_id"));
				cEmployeeDTO.setEmployee_code(rs.getString("employee_code"));
				cEmployeeDTO.setEmployee_name(rs.getString("employee_name"));
				cEmployeeDTO.setDepartment_id(rs.getInt("department_id"));
				cEmployeeDTO.setRemporting_to(rs.getInt("remporting_to"));
				cEmployeeDTO.setEmployee_role(rs.getInt("employee_role"));
				cEmployeeDTO.setEmployee_email(rs.getNString("employee_email"));
				cEmployeeDTO.setEmployee_phone(rs.getString("employee_phone"));
				cEmployeeDTO.setDepartment_name(StringUtility.removeNull(rs.getString("department_name")));
				cEmployeeDTO.setEmployee_role_name(StringUtility.removeNull(rs.getString("employee_role_name")));
				cEmployeeDTO.setReporting_to_name(StringUtility.removeNull(rs.getString("reporting_to_name")));
				cEmployeeDTO.setIs_active(rs.getInt("is_active"));
				cEmployeeList.add(cEmployeeDTO);
			}

		} catch (Exception e) {
			qh.releaseConnection();
		}
		return cEmployeeList;
	}

	public boolean saveEmployee(CEmployeeDTO cEmployeeDTO, String companyID) {

		QueryHelper qh = new QueryHelper();
		int status = 0;
		try {
			String query = "INSERT INTO `pms_empoyees` (`company_id`, `employee_code`, `employee_name`, `department_id`, `remporting_to`, `employee_role`,"
					+ " `employee_email`, `employee_phone`, `employee_password`, `employee_type`, `aadhar_card_no`, `passport_no`, `pan_no`,"
					+ " `current_address`, `permanant_address`, `date_of_birth`, `gender`, `employee_status`, `date_joining`, `created_by`, `created_on`) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,now())";
			qh.addParam(companyID);
			qh.addParam(StringUtility.removeNull(cEmployeeDTO.getEmployee_code()));
			qh.addParam(StringUtility.removeNull(cEmployeeDTO.getEmployee_name()));
			qh.addParam(cEmployeeDTO.getDepartment_id());
			qh.addParam(cEmployeeDTO.getRemporting_to());
			qh.addParam(cEmployeeDTO.getEmployee_role());
			qh.addParam(StringUtility.removeNull(cEmployeeDTO.getEmployee_email()));
			qh.addParam(StringUtility.removeNull(cEmployeeDTO.getEmployee_phone()));
			qh.addParam(getuniquepassword());
			qh.addParam(cEmployeeDTO.getEmployee_type());
			qh.addParam(StringUtility.removeNull(cEmployeeDTO.getAadhar_card_no()));
			qh.addParam(StringUtility.removeNull(cEmployeeDTO.getPassport_no()));
			qh.addParam(StringUtility.removeNull(cEmployeeDTO.getPan_no()));
			qh.addParam(StringUtility.removeNull(cEmployeeDTO.getCurrent_address()));
			qh.addParam(cEmployeeDTO.getPermanant_address());
			qh.addParam(cEmployeeDTO.getDate_of_birth());
			qh.addParam(StringUtility.removeNull(cEmployeeDTO.getGender()));
			qh.addParam(cEmployeeDTO.getEmployee_status());
			qh.addParam(cEmployeeDTO.getDate_joining());
			qh.addParam(cEmployeeDTO.getCreated_by());
			qh.runQuery(query);
			qh.clearParams();
			status = qh.getNumRecordsUpdated();
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

	private String getuniquepassword() {

		// return
		// EncryptionManager.encryptBlowfish(RandomStringUtils.randomAlphanumeric(8));
		return EncryptionManager.encryptBlowfish("abc@123");

	}

	public boolean deleteEmployee(String employeeId) {
		QueryHelper qh = new QueryHelper();
		try {
			String sqlUpdateEmployee = "update pms_empoyees set is_deleted =1 where employee_id = ?";
			qh.addParam(employeeId);
			qh.runQuery(sqlUpdateEmployee);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}
		return false;

	}

	public CEmployeeDTO getEmployeeDetailsForEdit(String employeeId) {
		CEmployeeDTO employeeInfoDTO = null;
		QueryHelper qh = new QueryHelper();
		try {
			String sqlEmployeeInfo = "select * from pms_empoyees where is_deleted =0 and employee_id = ? ";
			qh.addParam(employeeId);
			ResultSet rs = qh.runQueryStreamResults(sqlEmployeeInfo);
			if (rs.next()) {

				employeeInfoDTO = new CEmployeeDTO();
				employeeInfoDTO.setEmployee_id(rs.getInt("employee_id"));
				employeeInfoDTO.setCompany_id(rs.getInt("company_id"));
				employeeInfoDTO.setEmployee_code(rs.getString("employee_code"));
				employeeInfoDTO.setEmployee_name(rs.getString("employee_name"));
				employeeInfoDTO.setDepartment_id(rs.getInt("department_id"));
				employeeInfoDTO.setRemporting_to(rs.getInt("remporting_to"));
				employeeInfoDTO.setEmployee_role(rs.getInt("employee_role"));
				employeeInfoDTO.setEmployee_email(rs.getNString("employee_email"));
				employeeInfoDTO.setEmployee_phone(rs.getString("employee_phone"));
				employeeInfoDTO.setIs_active(rs.getInt("is_active"));
				employeeInfoDTO.setEmployee_type(rs.getInt("employee_type"));
				employeeInfoDTO.setAadhar_card_no(rs.getString("aadhar_card_no"));
				employeeInfoDTO.setPassport_no(rs.getString("passport_no"));
				employeeInfoDTO.setPan_no(rs.getString("pan_no"));
				employeeInfoDTO.setCurrent_address(rs.getString("current_address"));
				employeeInfoDTO.setPermanant_address(rs.getString("permanant_address"));
				employeeInfoDTO.setDate_of_birth(rs.getString("date_of_birth"));
				employeeInfoDTO.setGender(rs.getString("gender"));
				employeeInfoDTO.setEmployee_status(rs.getInt("employee_status"));
				employeeInfoDTO.setDate_joining(rs.getString("date_joining"));
				employeeInfoDTO.setCreated_by(rs.getString("created_by"));
				employeeInfoDTO.setCreated_on(rs.getString("created_on"));
				employeeInfoDTO.setModified_by(rs.getString("modified_by"));
				employeeInfoDTO.setModified_on(rs.getString("modified_on"));
				employeeInfoDTO.setDeleted_by(rs.getString("deleted_by"));
				employeeInfoDTO.setDeleted_on(rs.getString("deleted_on"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}
		return employeeInfoDTO;
	}

	public boolean updateEmployeeDetails(CEmployeeDTO objEmployeeDTO) {
		QueryHelper qh = new QueryHelper();
		try {

			String sqlUpdateemployee = "update pms_empoyees set employee_code = ? , employee_name = ? , department_id = ? , remporting_to = ?,employee_role = ?  ,employee_email = ? ,employee_phone = ? ,employee_type =?,aadhar_card_no = ?,passport_no = ?,pan_no = ?,current_address =?,permanant_address =?,date_of_birth =?,gender =? ,employee_status= ?,date_joining =?  where employee_id = ? ";
			qh.addParam(objEmployeeDTO.getEmployee_code());
			qh.addParam(objEmployeeDTO.getEmployee_name());
			qh.addParam(objEmployeeDTO.getDepartment_id());
			qh.addParam(objEmployeeDTO.getRemporting_to());
			qh.addParam(objEmployeeDTO.getEmployee_role());
			qh.addParam(objEmployeeDTO.getEmployee_email());
			qh.addParam(objEmployeeDTO.getEmployee_phone());
			qh.addParam(objEmployeeDTO.getEmployee_type());
			qh.addParam(StringUtility.removeNull(objEmployeeDTO.getAadhar_card_no()));
			qh.addParam(StringUtility.removeNull(objEmployeeDTO.getPassport_no()));
			qh.addParam(StringUtility.removeNull(objEmployeeDTO.getPan_no()));
			qh.addParam(StringUtility.removeNull(objEmployeeDTO.getCurrent_address()));
			qh.addParam(StringUtility.removeNull(objEmployeeDTO.getPermanant_address()));
			qh.addParam(objEmployeeDTO.getDate_of_birth());
			qh.addParam(StringUtility.removeNull(objEmployeeDTO.getGender()));
			qh.addParam(objEmployeeDTO.getEmployee_status());
			qh.addParam(objEmployeeDTO.getDate_joining());
			qh.addParam(objEmployeeDTO.getEmployee_id());
			qh.runQuery(sqlUpdateemployee);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}

		return false;
	}

	public static ArrayList<CEmployeeDTO> getReportingListByEmployeeId(String companyID) {
		ArrayList<CEmployeeDTO> cEmployeeDTOs = null;
		QueryHelper qh = new QueryHelper();
		CEmployeeDTO cEmployeeDTO = null;

		try {
			String sqlEmployeeRoleList = "Select employee_name,employee_id from employee_info_view where company_id = ? and is_deleted = 0 and employee_role_type in( 1,2) ";
			qh.addParam(companyID);
			ResultSet rs = qh.runQueryStreamResults(sqlEmployeeRoleList);
			while (rs.next()) {
				if (cEmployeeDTOs == null) {
					cEmployeeDTOs = new ArrayList<CEmployeeDTO>();
				}
				cEmployeeDTO = new CEmployeeDTO();
				cEmployeeDTO.setEmployee_name(rs.getString("employee_name"));
				cEmployeeDTO.setEmployee_id(rs.getInt("employee_id"));
				cEmployeeDTOs.add(cEmployeeDTO);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}
		return cEmployeeDTOs;
	}

	public ArrayList<CEmployeeDTO> getAllEmployeeNameByID(int employee_id) {
		ArrayList<CEmployeeDTO> cEmployeeList = null;
		QueryHelper qh = new QueryHelper();
		CEmployeeDTO cEmployeeDTO = null;
		try {
			String SqlEmployee = "SELECT employee_name,employee_id FROM pms_empoyees where is_deleted = 0  and employee_id=?";
			qh.addParam(employee_id);
			ResultSet rs = qh.runQueryStreamResults(SqlEmployee);
			while (rs.next()) {
				if (cEmployeeList == null) {
					cEmployeeList = new ArrayList<CEmployeeDTO>();
				}
				cEmployeeDTO = new CEmployeeDTO();
				cEmployeeDTO.setEmployee_name(rs.getString("employee_name"));
				cEmployeeDTO.setEmployee_role(rs.getInt("employee_id"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}
		return cEmployeeList;

	}

	public Object[] getSearchData(String employee_code, String employee_name, String employee_email,
			String employee_phone, String department_Id, String searchStatusListData, String employeeRole,
			int startIndex, int endIndex, String companyID, String pageNo) {
		ArrayList<CEmployeeInfoDTO> cEmployeeInfoList = null;
		QueryHelper qh = new QueryHelper();
		CEmployeeInfoDTO cEmployeeInfoDTO = null;
		Object[] cEmployeeInfoListObj = null;
		int startLimit = (Integer.parseInt(pageNo) - 1) * endIndex;
		int endLimit = endIndex;
		int count = 0;
		try {
			String getCount = "SELECT count(employee_id) as count FROM employee_info_view where company_id = ? and is_deleted = 0 and employee_code LIKE '%"
					+ employee_code + "%'  AND employee_name LIKE '%" + employee_name + "%'  AND employee_email LIKE '%"
					+ employee_email + "%'  AND employee_phone LIKE '%" + employee_phone
					+ "%' AND convert(department_id,char) LIKE '%" + department_Id
					+ "%' AND convert(employee_role,char) LIKE '%" + employeeRole
					+ "%' AND convert(employee_status,char) LIKE '%" + searchStatusListData + "%' ";

			qh.addParam(companyID);
			ResultSet result = qh.runQueryStreamResults(getCount);
			if (result.next()) {
				count = result.getInt("count");
			}
			qh.clearParams();

			String search_query = "SELECT * FROM employee_info_view Where  company_id = ? and  is_deleted = 0 and employee_code LIKE '%"
					+ employee_code + "%'  AND employee_name LIKE '%" + employee_name + "%'  AND employee_email LIKE '%"
					+ employee_email + "%'  AND employee_phone LIKE '%" + employee_phone
					+ "%' AND convert(department_id,char) LIKE '%" + department_Id
					+ "%' AND convert(employee_role,char) LIKE '%" + employeeRole
					+ "%' AND convert(employee_status,char) LIKE '%" + searchStatusListData + "%' limit " + startLimit
					+ "," + endLimit + " ";

			qh.addParam(companyID);
			ResultSet rs = qh.runQueryStreamResults(search_query);
			while (rs.next()) {
				if (cEmployeeInfoList == null) {
					cEmployeeInfoList = new ArrayList<CEmployeeInfoDTO>();
				}
				cEmployeeInfoDTO = new CEmployeeInfoDTO();
				cEmployeeInfoDTO.setEmployee_id(rs.getInt("employee_id"));
				cEmployeeInfoDTO.setEmployee_code(rs.getString("employee_code"));
				cEmployeeInfoDTO.setEmployee_name(rs.getString("employee_name"));
				cEmployeeInfoDTO.setDepartment_id(rs.getInt("department_id"));
				cEmployeeInfoDTO.setRemporting_to(rs.getInt("remporting_to"));
				cEmployeeInfoDTO.setEmployee_role(rs.getInt("employee_role"));
				cEmployeeInfoDTO.setEmployee_email(rs.getString("employee_email"));
				cEmployeeInfoDTO.setEmployee_phone(rs.getString("employee_phone"));
				cEmployeeInfoDTO.setDepartment_name(StringUtility.removeNull(rs.getString("department_name")));
				cEmployeeInfoDTO.setEmployee_role_name(StringUtility.removeNull(rs.getString("employee_role_name")));
				cEmployeeInfoDTO.setReporting_to_name(StringUtility.removeNull(rs.getString("reporting_to_name")));
				cEmployeeInfoDTO.setIs_active(rs.getInt("is_active"));
				cEmployeeInfoDTO.setEmployee_status(rs.getString("employee_status_name"));
				cEmployeeInfoDTO.setEmployee_profile_avatar(rs.getString("profile_photo"));
				if (!"default.jpg".equalsIgnoreCase(cEmployeeInfoDTO.getEmployee_profile_avatar())) {
					cEmployeeInfoDTO.setEmployee_profile_avatar(StringUtility.removeNull(rs.getString("employee_id"))
							+ "/" + StringUtility.removeNull(rs.getString("profile_photo")));
				}
				cEmployeeInfoList.add(cEmployeeInfoDTO);
			}
			System.out.println("Total No of Records by search " + count);
			cEmployeeInfoListObj = new Object[] { cEmployeeInfoList, count };

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}
		return cEmployeeInfoListObj;
	}

	public boolean isalreadyexists(String companyId, String isexistvalue, String checkfor) {
		
		QueryHelper qh = new QueryHelper();
		try {
			String query = "";
			if(("employee_email").equalsIgnoreCase(checkfor)) {
				
				 query = "select employee_id from pms_empoyees where is_deleted = 0 and company_id = ? and employee_email = ?";
			}else if (("employee_phone").equalsIgnoreCase(checkfor)){
				
				 query = "select employee_id from pms_empoyees where is_deleted = 0 and company_id = ? and employee_phone = ?";
			}
			qh.addParam(companyId);
			qh.addParam(isexistvalue);
			ResultSet rs = qh.runQueryStreamResults(query);
			if(rs.next()) {
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			qh.releaseConnection();
		}
		return false;
	}
}

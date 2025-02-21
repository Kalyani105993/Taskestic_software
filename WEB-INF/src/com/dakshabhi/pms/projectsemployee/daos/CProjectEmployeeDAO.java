package com.dakshabhi.pms.projectsemployee.daos;

import java.sql.ResultSet;
import java.util.ArrayList;

import com.dakshabhi.common.db.QueryHelper;
import com.dakshabhi.common.utility.StringUtility;
import com.dakshabhi.pms.employees.dtos.CEmployeeDTO;
import com.dakshabhi.pms.projects.dtos.CProjectDTO;
import com.dakshabhi.pms.projectsemployee.dtos.CProjectEmployeeDTO;
import com.dakshabhi.pms.projectsemployee.dtos.CProjectEmployeeInfoDTO;
import com.dakshabhi.pms.users.dtos.CUserLoginDTO;

public class CProjectEmployeeDAO {

	public ArrayList<CProjectDTO> getProjectNameList(String companyID) {
		ArrayList<CProjectDTO> projectNameList = null;
		QueryHelper qh = new QueryHelper();
		CProjectDTO projectDTO = null;
		try {
			String sqlProjectNameList = "select project_name, project_id from pms_projects where is_deleted=0 and company_id= ?";
			qh.addParam(companyID);
			ResultSet rs = qh.runQueryStreamResults(sqlProjectNameList);
			while (rs.next()) {
				if (projectNameList == null) {
					projectNameList = new ArrayList<CProjectDTO>();
				}
				projectDTO = new CProjectDTO();
				projectDTO.setProject_id(rs.getInt("project_id"));
				projectDTO.setProject_name(rs.getString("project_name"));
				projectNameList.add(projectDTO);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}

		return projectNameList;
	}

	public ArrayList<CEmployeeDTO> getEmployeeNameList(String companyID) {
		ArrayList<CEmployeeDTO> employeeNameList = null;
		QueryHelper qh = new QueryHelper();
		CEmployeeDTO employeeDTO = null;
		try {
			String sqlEmployeeNameList = "select employee_id, employee_name from pms_empoyees where is_deleted=0 and company_id= ?";
			qh.addParam(companyID);
			ResultSet rs = qh.runQueryStreamResults(sqlEmployeeNameList);
			while (rs.next()) {
				if (employeeNameList == null) {
					employeeNameList = new ArrayList<CEmployeeDTO>();
				}
				employeeDTO = new CEmployeeDTO();
				employeeDTO.setEmployee_id(rs.getInt("employee_id"));
				employeeDTO.setEmployee_name(rs.getString("employee_name"));
				employeeNameList.add(employeeDTO);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}

		return employeeNameList;
	}

	public static boolean saveEmployeeInfo(CProjectEmployeeDTO objProjectEmployeeDTO, String companyID) {
		QueryHelper qh = new QueryHelper();
		try {
			String sqlCreateProjectemployee = "insert into pms_project_employee(company_id,project_id,employee_id, date_added)"
					+ " values(?,?,?,now())";

			qh.addParam(companyID);
			qh.addParam(objProjectEmployeeDTO.getProject_id());
			qh.addParam(objProjectEmployeeDTO.getEmployee_id());

			qh.runQuery(sqlCreateProjectemployee);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}

		return false;
	}

	 
	public static boolean deleteProjectEmployee(String project_employee_id) {
		QueryHelper qh = new QueryHelper();
		try {
			String sqlDelete = "update pms_project_employee set is_deleted = 1 where project_employee_id = ?";
			qh.addParam(project_employee_id);
			qh.runQuery(sqlDelete);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}
		return false;

	}

	public static CProjectEmployeeDTO getProjectEmployeeDetailsForEdit(String projectEmployeeId) {
		CProjectEmployeeDTO projectEmployeeDTO = null;
		QueryHelper qh = new QueryHelper();
		try {
			String sqlEmployeeInfo = "select * from pms_project_employee where is_deleted =0 and project_employee_id = ? ";
			qh.addParam(projectEmployeeId);
			ResultSet rs = qh.runQueryStreamResults(sqlEmployeeInfo);
			if (rs.next()) {

				projectEmployeeDTO = new CProjectEmployeeDTO();
				projectEmployeeDTO.setEmployee_id(rs.getInt("employee_id"));
				projectEmployeeDTO.setProject_id(rs.getInt("project_id"));

			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}
		return projectEmployeeDTO;
	}

	public static boolean updateProjectEmployeeDetails(CProjectEmployeeDTO objProjectEmployeeDTO) {
		QueryHelper qh = new QueryHelper();
		try {

			String sqlUpdateProjectemployee = "update pms_project_employee set project_id = ? , employee_id = ?  where project_employee_id = ? ";
			qh.addParam(objProjectEmployeeDTO.getProject_id());
			qh.addParam(objProjectEmployeeDTO.getEmployee_id());

			qh.addParam(objProjectEmployeeDTO.getProject_employee_id());

			qh.runQuery(sqlUpdateProjectemployee);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}

		return false;
	}

	public ArrayList<CEmployeeDTO> getEmployeeUnderReportingTo(CUserLoginDTO cUserLoginDTO, String companyID) {
		ArrayList<CEmployeeDTO> employeeList = new ArrayList<CEmployeeDTO>();
		QueryHelper qh = new QueryHelper();
		CEmployeeDTO cEmployeeDTO = null;
		try {
			// Add logged in user in list
			cEmployeeDTO = new CEmployeeDTO();
			cEmployeeDTO.setEmployee_id(cUserLoginDTO.getUser_employee_id());
			cEmployeeDTO.setEmployee_name(cUserLoginDTO.getUser_full_name());
			employeeList.add(cEmployeeDTO);

			String sqlWorkpackNameList = "select employee_id, employee_name from pms_empoyees where remporting_to = ? and is_deleted=0 and company_id =?";

			qh.addParam(cUserLoginDTO.getUser_login_id());
			qh.addParam(companyID);
			ResultSet rs = qh.runQueryStreamResults(sqlWorkpackNameList);
			while (rs.next()) {
				cEmployeeDTO = new CEmployeeDTO();
				cEmployeeDTO.setEmployee_id(rs.getInt("employee_id"));
				cEmployeeDTO.setEmployee_name(rs.getString("employee_name"));

				employeeList.add(cEmployeeDTO);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}

		return employeeList;
	}
/*
 * Method for getNewEmployeeList for project
 * Input- projectid, memberSearchKeyword, companyID, departmentid
 * Output- ArrarList employeeList
 */
	public ArrayList<CEmployeeDTO> getNewEmployeeListForProject(String projectid, String memberSearchKeyword,
			String companyID, String departmentid) {
		ArrayList<CEmployeeDTO> employeeList = new ArrayList<CEmployeeDTO>();
		QueryHelper qh = new QueryHelper();
		CEmployeeDTO cEmployeeDTO = null;
		try {
			String deptfilterquery = "";
			if(!"0".equals(departmentid)){
				deptfilterquery = " and department_id = '"+departmentid+"' ";
			}
			String sqlWorkpackNameList = "select employee_id, employee_name,profile_photo from employee_info_view where  employee_id not in (select employee_id from pms_project_employee where company_id = ? and is_deleted =0 and project_id = ? ) and employee_name like '"
					+ memberSearchKeyword + "%' and is_deleted=0 and company_id =  ? "+ deptfilterquery +"";
			System.out.println("SQL : " + sqlWorkpackNameList);
			qh.addParam(companyID);
			qh.addParam(projectid);
			// qh.addParam("%"+memberSearchKeyword+"%");
			qh.addParam(companyID);

			ResultSet rs = qh.runQueryStreamResults(sqlWorkpackNameList);
			while (rs.next()) {
				cEmployeeDTO = new CEmployeeDTO();
				cEmployeeDTO.setEmployee_id(rs.getInt("employee_id"));
				cEmployeeDTO.setEmployee_name(rs.getString("employee_name"));
				cEmployeeDTO.setEmployee_profile_avatar(StringUtility.removeNull(rs.getString("profile_photo")));
				if (!"default.jpg".equalsIgnoreCase(cEmployeeDTO.getEmployee_profile_avatar())) {
					cEmployeeDTO.setEmployee_profile_avatar(StringUtility.removeNull(rs.getString("employee_id")) + "/"
							+ StringUtility.removeNull(rs.getString("profile_photo")));
				}
				employeeList.add(cEmployeeDTO);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}

		return employeeList;
	}

	public ArrayList<CProjectEmployeeInfoDTO> getProjectEmployeeDetails(String projectid, String companyID, String departmentid, int userLoginid, String listType, int startIndex, int endIndex, String pageNo) {
		int startLimit = (Integer.parseInt(pageNo) - 1) * endIndex;
		int endLimit = endIndex;
		ArrayList<CProjectEmployeeInfoDTO> cProjectemployeeList = new ArrayList<CProjectEmployeeInfoDTO>();
		QueryHelper qh = new QueryHelper();
		CProjectEmployeeInfoDTO cProjectemployeeDTO = null;
		try {
			String deptfilterquery = "";
			String subquery = "";
			String limit = "";
			if(!"0".equals(departmentid)){
				deptfilterquery = " and department_id = ? ";
				qh.addParam(departmentid);
				
			}
			if(listType.equalsIgnoreCase("getFollowers")) {
				subquery = " and employee_id != ? ";
				qh.addParam(userLoginid);
			}
			if(endLimit!=0) {
				limit = "limit " + startLimit + "," + endLimit + "";
			}
			String sqlProjectEmployees = "select * from project_employee_info_view where is_deleted = 0 " + deptfilterquery + subquery +" and company_id = ? and project_id = ? "+ limit+" ";
			qh.addParam(companyID);
			qh.addParam(projectid);

			ResultSet rs = qh.runQueryStreamResults(sqlProjectEmployees);
			while (rs.next()) {

				cProjectemployeeDTO = new CProjectEmployeeInfoDTO();
				cProjectemployeeDTO.setProject_employee_id(rs.getInt("project_employee_id"));
				cProjectemployeeDTO.setProject_name(rs.getString("project_name"));
				cProjectemployeeDTO.setEmployee_id(rs.getInt("employee_id"));
				cProjectemployeeDTO.setEmployee_name(rs.getString("employee_name"));
				cProjectemployeeDTO.setEmployee_dempartment(rs.getString("department_name"));
				cProjectemployeeDTO.setEmployee_role(rs.getString("employe_role_name"));
				cProjectemployeeDTO.setEmployee_email(rs.getString("employee_email"));
				cProjectemployeeDTO.setEmployee_profile_avatar(rs.getString("profile_photo"));
				if (!"default.jpg".equalsIgnoreCase(cProjectemployeeDTO.getEmployee_profile_avatar())) {
					cProjectemployeeDTO.setEmployee_profile_avatar(StringUtility.removeNull(rs.getString("employee_id"))
							+ "/" + StringUtility.removeNull(rs.getString("profile_photo")));
				}
				cProjectemployeeList.add(cProjectemployeeDTO);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}
		return cProjectemployeeList;
	}

}

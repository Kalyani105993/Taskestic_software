package com.dakshabhi.pms.employeeDailyWork.daos;

import java.sql.ResultSet;
import java.util.ArrayList;

import com.dakshabhi.common.db.QueryHelper;
import com.dakshabhi.common.utility.StringUtility;
import com.dakshabhi.pms.customers.dtos.CCustomerDTO;
import com.dakshabhi.pms.employeeDailyWork.dtos.CEmployeeDailyWorkDTO;
import com.dakshabhi.pms.employeeDailyWork.dtos.CEmployeeDailyWorkInfoDTO;
import com.dakshabhi.pms.employees.dtos.CEmployeeDTO;
import com.dakshabhi.pms.projectsemployee.dtos.CProjectEmployeeInfoDTO;
import com.dakshabhi.pms.projectworkpacks.dtos.CProjectworkpacksInfoDTO;
import com.dakshabhi.pms.users.dtos.CUserLoginDTO;

public class CEmployeeDailyWorkDAO {

	public ArrayList<CCustomerDTO> getCustomerList(String companyId) {
		ArrayList<CCustomerDTO> customerList = null;
		QueryHelper qh = new QueryHelper();
		CCustomerDTO customerDTO = null;
		try {
			String sqlCustomerList = "select * from pms_customers where company_id = ?";
			qh.addParam(companyId);
			ResultSet rs = qh.runQueryStreamResults(sqlCustomerList);
			while (rs.next()) {
				if (customerList == null) {
					customerList = new ArrayList<CCustomerDTO>();
				}
				customerDTO = new CCustomerDTO();
				customerDTO.setCustomer_id(rs.getInt("customer_id"));
				customerDTO.setCustomer_name(StringUtility.removeNull(rs.getString("customer_name")));

				customerList.add(customerDTO);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}

		return customerList;
	}

	public ArrayList<CProjectworkpacksInfoDTO> getWorkpackNameListByProjectId(String projectId) {
		ArrayList<CProjectworkpacksInfoDTO> workpackNameList = null;
		QueryHelper qh = new QueryHelper();
		CProjectworkpacksInfoDTO cProjectworkpacksInfoDTO = null;
		try {
			String sqlWorkpackNameList = "select workpack_id,workpack_name from project_workpacks_info_view where is_deleted=0 and project_id= ?";
			qh.addParam(projectId);
			ResultSet rs = qh.runQueryStreamResults(sqlWorkpackNameList);
			while (rs.next()) {
				if (workpackNameList == null) {
					workpackNameList = new ArrayList<CProjectworkpacksInfoDTO>();
				}
				cProjectworkpacksInfoDTO = new CProjectworkpacksInfoDTO();
				cProjectworkpacksInfoDTO.setWorkpack_id(rs.getInt("workpack_id"));
				cProjectworkpacksInfoDTO.setWorkpack_name(rs.getString("workpack_name"));

				workpackNameList.add(cProjectworkpacksInfoDTO);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}

		return workpackNameList;
	}

	public ArrayList<CEmployeeDTO> getAllEmployee() {
		ArrayList<CEmployeeDTO> employeeList = null;
		QueryHelper qh = new QueryHelper();
		CEmployeeDTO cEmployeeDTO = null;
		try {
			String sqlWorkpackNameList = "select employee_id, employee_name from pms_empoyees where is_deleted=0 and company_id =?";
			qh.addParam(1);

			ResultSet rs = qh.runQueryStreamResults(sqlWorkpackNameList);
			while (rs.next()) {
				if (employeeList == null) {
					employeeList = new ArrayList<CEmployeeDTO>();
				}
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

	public ArrayList<CProjectEmployeeInfoDTO> getProjectNameListByEmployeeId(String employeeId) {
		ArrayList<CProjectEmployeeInfoDTO> projectNameList = null;
		QueryHelper qh = new QueryHelper();
		CProjectEmployeeInfoDTO projectEmpDTO = null;
		try {
			String sqlProjectNameList = "select project_name, project_id from project_employee_info_view where is_deleted=0 and employee_id= ?";
			qh.addParam(employeeId);
			ResultSet rs = qh.runQueryStreamResults(sqlProjectNameList);
			while (rs.next()) {
				if (projectNameList == null) {
					projectNameList = new ArrayList<CProjectEmployeeInfoDTO>();
				}
				projectEmpDTO = new CProjectEmployeeInfoDTO();
				projectEmpDTO.setProject_id(rs.getInt("project_id"));
				projectEmpDTO.setProject_name(rs.getString("project_name"));
				projectNameList.add(projectEmpDTO);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}

		return projectNameList;
	}

	public boolean saveEmployeeDailyWorkInfo(CEmployeeDailyWorkDTO objEmployeeDailyWorkDTO) {
		QueryHelper qh = new QueryHelper();
		try {
			String sqlCreateEmployeeDailyWork = "insert into pms_employee_daily_work(company_id, employee_id, project_id, workpack_id, work_date, work_hours, work_added_date)"
					+ " values(?, ?, ?, ?, ?, ?, now())";

			qh.addParam(objEmployeeDailyWorkDTO.getCompany_id());
			qh.addParam(objEmployeeDailyWorkDTO.getEmployee_id());
			qh.addParam(objEmployeeDailyWorkDTO.getProject_id());
			qh.addParam(objEmployeeDailyWorkDTO.getWorkpack_id());
			qh.addParam(objEmployeeDailyWorkDTO.getWork_date());
			qh.addParam(objEmployeeDailyWorkDTO.getWork_hours());

			qh.runQuery(sqlCreateEmployeeDailyWork);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}

		return false;
	}

	public ArrayList<CEmployeeDailyWorkDTO> getDateandWorkHoursDetails(String employee_id, String project_id,
			String workpackId) {
		ArrayList<CEmployeeDailyWorkDTO> employeeDailyWorkHoursList = null;
		QueryHelper qh = new QueryHelper();
		CEmployeeDailyWorkDTO cEmployeeDailyWorkDTO = null;
		try {
			String sqlProjectSChedulingList = "Select work_date, work_hours  from pms_employee_daily_work where employee_id = ? and  project_id = ? and  workpack_id = ?";
			qh.addParam(employee_id);
			qh.addParam(project_id);
			qh.addParam(workpackId);

			ResultSet rs = qh.runQueryStreamResults(sqlProjectSChedulingList);
			while (rs.next()) {
				if (employeeDailyWorkHoursList == null) {
					employeeDailyWorkHoursList = new ArrayList<CEmployeeDailyWorkDTO>();
				}
				cEmployeeDailyWorkDTO = new CEmployeeDailyWorkDTO();
				cEmployeeDailyWorkDTO.setWork_date(rs.getString("work_date"));
				cEmployeeDailyWorkDTO.setWork_hours(rs.getFloat("work_hours"));

				employeeDailyWorkHoursList.add(cEmployeeDailyWorkDTO);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}

		return employeeDailyWorkHoursList;
	}

	public ArrayList<CEmployeeDTO> getEmployeeNameList() {
		ArrayList<CEmployeeDTO> employeeNameList = null;
		QueryHelper qh = new QueryHelper();
		CEmployeeDTO cEmployeeDTO = null;

		try {
			String sqlEmployeeName = "SELECT employee_name,employee_id FROM pms_empoyees where is_deleted = 0";
			ResultSet rs = qh.runQueryStreamResults(sqlEmployeeName);
			while (rs.next()) {
				if (employeeNameList == null) {
					employeeNameList = new ArrayList<CEmployeeDTO>();
				}
				cEmployeeDTO = new CEmployeeDTO();
				cEmployeeDTO.setEmployee_id(rs.getInt("employee_id"));
				cEmployeeDTO.setEmployee_name(rs.getString("employee_name"));

				employeeNameList.add(cEmployeeDTO);
			}
			System.out.println(employeeNameList);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}

		return employeeNameList;
	}

	// created by dnyaneshwar

	public ArrayList<CEmployeeDailyWorkInfoDTO> getCustomerDetailsForEdit(String employeeId, String fromDate,
			String toDate) {
		ArrayList<CEmployeeDailyWorkInfoDTO> employeeDailyWorkInfoViewDTO = null;
		QueryHelper qh = new QueryHelper();
		CEmployeeDailyWorkInfoDTO cEmployeeDailyWorkInfoDTO = null;
		try {
			String sqlQuery = "SELECT * FROM pms_employee_daily_work_info_view WHERE convert(employee_id,char) like '"
					+ employeeId + "' AND work_date BETWEEN '" + fromDate + "' AND '" + toDate + "'";
			ResultSet rs = qh.runQueryStreamResults(sqlQuery);
			while (rs.next()) {
				if (employeeDailyWorkInfoViewDTO == null) {
					employeeDailyWorkInfoViewDTO = new ArrayList<CEmployeeDailyWorkInfoDTO>();
				}
				cEmployeeDailyWorkInfoDTO = new CEmployeeDailyWorkInfoDTO();
				cEmployeeDailyWorkInfoDTO.setEmployee_daily_work_id(rs.getInt("employee_daily_work_id"));
				cEmployeeDailyWorkInfoDTO.setProject_id(rs.getInt("project_id"));
				cEmployeeDailyWorkInfoDTO.setWorkpack_id(rs.getInt("workpack_id"));
				cEmployeeDailyWorkInfoDTO.setWork_date(rs.getString("work_date"));
				cEmployeeDailyWorkInfoDTO.setProject_name(rs.getString("project_name"));
				cEmployeeDailyWorkInfoDTO.setWorkpack_name(rs.getString("workpack_name"));
				cEmployeeDailyWorkInfoDTO.setWorkpack_standard_hours(rs.getInt("workpack_standard_hours"));
				cEmployeeDailyWorkInfoDTO.setWorkpack_booked_hours(rs.getInt("workpack_booked_hours"));
				cEmployeeDailyWorkInfoDTO.setWork_hours(rs.getFloat("work_hours"));
				cEmployeeDailyWorkInfoDTO.setApproved_hours(rs.getFloat("approved_hours"));
				cEmployeeDailyWorkInfoDTO.setRejected_hours(rs.getFloat("rejected_hours"));
				cEmployeeDailyWorkInfoDTO.setApproved_remark(StringUtility.removeNull(rs.getString("approved_remark")));

				employeeDailyWorkInfoViewDTO.add(cEmployeeDailyWorkInfoDTO);
			}
			System.out.println("employeeDailyWorkInfoViewDTO list: "+employeeDailyWorkInfoViewDTO);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}

		return employeeDailyWorkInfoViewDTO;
	}

	public ArrayList<CEmployeeDailyWorkDTO> getPendingWorkDatesForEdit(String employee_id, String project_id,
			String workpack_id) {

		ArrayList<CEmployeeDailyWorkDTO> workDateList = null;
		QueryHelper qh = new QueryHelper();
		CEmployeeDailyWorkDTO cEmployeeDailyWorkDTO = null;

		try {
			String sqlEmployeeName = "select work_date from pms_employee_daily_work where employee_id = ? and project_id =? and workpack_id = ? and is_approved = 0";
			qh.addParam(employee_id);
			qh.addParam(project_id);
			qh.addParam(workpack_id);

			ResultSet rs = qh.runQueryStreamResults(sqlEmployeeName);
			while (rs.next()) {
				if (workDateList == null) {
					workDateList = new ArrayList<CEmployeeDailyWorkDTO>();
				}
				cEmployeeDailyWorkDTO = new CEmployeeDailyWorkDTO();
				cEmployeeDailyWorkDTO.setWork_date(rs.getString("work_date"));

				workDateList.add(cEmployeeDailyWorkDTO);
			}
			System.out.println(workDateList);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}

		return workDateList;
	}

	// created by dnyaneshwar
	public boolean updateProjectWorkpackDetails(String daily_work_id, String approved_hours,
			String rejected_hours, String approved_remark, int approvedby_id) {
		QueryHelper qh = new QueryHelper();
		try {

			String sqlupdateEmployee = "UPDATE pms_employee_daily_work SET approved_hours = ?,rejected_hours=?,approved_remark= ?, is_approved =1, approved_by = ?, approved_date=now() WHERE  employee_daily_work_id = ?";

			qh.addParam(approved_hours);
			qh.addParam(rejected_hours);
			qh.addParam(approved_remark);
			qh.addParam(approvedby_id);
			qh.addParam(daily_work_id);
			qh.runQuery(sqlupdateEmployee);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}

		return false;
	}

	public ArrayList<CEmployeeDTO> getEmployeeUnderReportingTo(CUserLoginDTO cUserLoginDTO,String companyId) {
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
			qh.addParam(companyId);
			
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
	
	public ArrayList<CEmployeeDailyWorkDTO> getDailyWorkDetails(String employee_id, String project_id,
			String workpack_id, String work_date) {

		ArrayList<CEmployeeDailyWorkDTO> workDateList = null;
		QueryHelper qh = new QueryHelper();
		CEmployeeDailyWorkDTO cEmployeeDailyWorkDTO = null;

		try {
			String sqlEmployeeName = "select * from pms_employee_daily_work where employee_id = ? and project_id =? and workpack_id = ? and work_date = ?";
			qh.addParam(employee_id);
			qh.addParam(project_id);
			qh.addParam(workpack_id);
			qh.addParam(work_date);

			ResultSet rs = qh.runQueryStreamResults(sqlEmployeeName);
			while (rs.next()) {
				if (workDateList == null) {
					workDateList = new ArrayList<CEmployeeDailyWorkDTO>();
				}
				cEmployeeDailyWorkDTO = new CEmployeeDailyWorkDTO();
				cEmployeeDailyWorkDTO.setEmployee_daily_work_id(rs.getInt("employee_daily_work_id"));
				cEmployeeDailyWorkDTO.setWork_date(rs.getString("work_date"));
				cEmployeeDailyWorkDTO.setWork_hours(rs.getFloat("work_hours"));
				cEmployeeDailyWorkDTO.setIs_approved(rs.getInt("is_approved"));
				cEmployeeDailyWorkDTO.setApproved_hours(rs.getFloat("approved_hours"));
				cEmployeeDailyWorkDTO.setRejected_hours(rs.getFloat("rejected_hours"));
				cEmployeeDailyWorkDTO.setApproved_remark(StringUtility.removeNull(rs.getString("approved_remark")));

				workDateList.add(cEmployeeDailyWorkDTO);
			}
			System.out.println(workDateList);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}

		return workDateList;
	}

	public ArrayList<CEmployeeDailyWorkDTO> getInfoForEdit(String employee_id, String project_id,
			String workpack_id, String work_date) {

		ArrayList<CEmployeeDailyWorkDTO> workDateList = null;
		QueryHelper qh = new QueryHelper();
		CEmployeeDailyWorkDTO cEmployeeDailyWorkDTO = null;

		try {
			String sqlEmployeeName = "select * from pms_employee_daily_work where employee_id = ? and project_id =? and workpack_id = ? and work_date = ? and is_approved = 0";
			qh.addParam(employee_id);
			qh.addParam(project_id);
			qh.addParam(workpack_id);
			qh.addParam(work_date);

			ResultSet rs = qh.runQueryStreamResults(sqlEmployeeName);
			while (rs.next()) {
				if (workDateList == null) {
					workDateList = new ArrayList<CEmployeeDailyWorkDTO>();
				}
				cEmployeeDailyWorkDTO = new CEmployeeDailyWorkDTO();
				cEmployeeDailyWorkDTO.setEmployee_daily_work_id(rs.getInt("employee_daily_work_id"));
				cEmployeeDailyWorkDTO.setWork_date(rs.getString("work_date"));
				cEmployeeDailyWorkDTO.setWork_hours(rs.getFloat("work_hours"));
				cEmployeeDailyWorkDTO.setIs_approved(rs.getInt("is_approved"));
				cEmployeeDailyWorkDTO.setApproved_hours(rs.getFloat("approved_hours"));
				cEmployeeDailyWorkDTO.setRejected_hours(rs.getFloat("rejected_hours"));
				cEmployeeDailyWorkDTO.setApproved_remark(StringUtility.removeNull(rs.getString("approved_remark")));

				workDateList.add(cEmployeeDailyWorkDTO);
			}
			System.out.println(workDateList);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}

		return workDateList;
	}

	public boolean updateHours(String employee_daily_work_id, String work_date, String work_hours) {
		QueryHelper qh = new QueryHelper();
		try {

			String sqlUpdateHours = "update pms_employee_daily_work set work_date = ? ,work_hours = ? where employee_daily_work_id = ? ";
			qh.addParam(work_date);
			qh.addParam(work_hours);

			qh.addParam(employee_daily_work_id);

			qh.runQuery(sqlUpdateHours);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}

		return false;
	}

	public boolean updateBookedHoursInProjectWorkpack(String daily_work_id, String approved_hours,float existingApprovedHours) {
		
		QueryHelper qh = new QueryHelper();
		try {
			
			String sqlupdatebookedHrs = "update  pms_project_workpacks pw, pms_employee_daily_work edw set pw.workpack_booked_hours = (pw.workpack_booked_hours + ?)  where  edw.project_id = pw.project_id  and edw.workpack_id = pw.workpack_id  and  edw.employee_daily_work_id = ?";
			  
			qh.addParam((Float.parseFloat(approved_hours ) - existingApprovedHours)); 
			qh.addParam(daily_work_id);

			qh.runQuery(sqlupdatebookedHrs);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}

		return false;
	}

	public ArrayList<CEmployeeDailyWorkDTO> getAllApprovedHours(String project_id, String workpack_id, String employee_id) {
		ArrayList<CEmployeeDailyWorkDTO> approvedHoursList = null;
		QueryHelper qh = new QueryHelper();
		CEmployeeDailyWorkDTO cEmployeeDailyWorkDTO = null;

		try {
			String sqlApprovedHours = "select approved_hours from pms_employee_daily_work where employee_id = ? and project_id =? and workpack_id = ?";
			qh.addParam(employee_id);
			qh.addParam(project_id);
			qh.addParam(workpack_id);

			ResultSet rs = qh.runQueryStreamResults(sqlApprovedHours);
			while (rs.next()) {
				if (approvedHoursList == null) {
					approvedHoursList = new ArrayList<CEmployeeDailyWorkDTO>();
				}
				cEmployeeDailyWorkDTO = new CEmployeeDailyWorkDTO();
				cEmployeeDailyWorkDTO.setApproved_hours(rs.getFloat("approved_hours"));
				
				

				approvedHoursList.add(cEmployeeDailyWorkDTO);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}

		return approvedHoursList;
		
	}

	public float getExitingApprovedHours(String daily_work_id) {
		QueryHelper qh = new QueryHelper();
		try {
			String sqlExistingApprovedHours = "select approved_hours from pms_employee_daily_work where is_deleted =0 and employee_daily_work_id = ?  ";
			qh.addParam(daily_work_id);
			ResultSet rs = qh.runQueryStreamResults(sqlExistingApprovedHours);
			if(rs.next())
				return rs.getFloat("approved_hours");
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			qh.releaseConnection();
		}
		return 0;
	}

	
}

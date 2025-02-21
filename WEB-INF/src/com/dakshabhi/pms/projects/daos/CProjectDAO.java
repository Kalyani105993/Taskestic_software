package com.dakshabhi.pms.projects.daos;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import com.dakshabhi.common.constants.ConfigConstants;
import com.dakshabhi.common.db.QueryHelper;
import com.dakshabhi.common.utility.StringUtility;
import com.dakshabhi.pms.customers.dtos.CCustomerDTO;
import com.dakshabhi.pms.masters.daos.CProjectStatusDAO;
import com.dakshabhi.pms.masters.daos.CProjectTypeDAO;
import com.dakshabhi.pms.masters.daos.CTaskStatusDAO;
import com.dakshabhi.pms.masters.daos.CTaskTypeDAO;
import com.dakshabhi.pms.masters.dtos.CProjectStatusDTO;
import com.dakshabhi.pms.masters.dtos.CProjectTypeDTO;
import com.dakshabhi.pms.masters.dtos.CTaskStatusDTO;
import com.dakshabhi.pms.masters.dtos.CTaskTypeDTO;
import com.dakshabhi.pms.projects.dtos.CProjectDTO;
import com.dakshabhi.pms.projects.dtos.CProjectInfoDTO;
import com.google.gson.JsonObject;

/**
 * Class for manage all operations related to projects
 * 
 * @author dakshabhi
 *
 */
public class CProjectDAO {
	/*
	 * Method for get project list Return: arraylist of project details
	 */

	/* ArrayList<CProjectInfoDTO> */
	public static Object[] getProjectList(int userId, String companyID) {
		Object[] obj = null;
		/* System.out.println("dao"); */
		ArrayList<CProjectInfoDTO> projectInfoList = null;
		CProjectInfoDTO projectInfoDTO = null;
		QueryHelper qh = new QueryHelper(); 
		try {
		 
			String sqlProjectInfo = "select * from project_info_view "
					+ " where (created_by = ? or ? in (select project_emp.employee_id from pms_project_employee project_emp where project_emp.is_deleted = 0 and project_emp.project_id = project_info_view.project_id )) "
					+ " and project_info_view.is_deleted = 0 and project_info_view.company_id = ?";
			qh.addParam(userId);
			qh.addParam(userId);
			qh.addParam(companyID);
			 
			ResultSet rs = qh.runQueryStreamResults(sqlProjectInfo);
			
			while (rs.next()) {
				if (projectInfoList == null)
					projectInfoList = new ArrayList<CProjectInfoDTO>();
				projectInfoDTO = new CProjectInfoDTO();
				projectInfoDTO.setProject_id(rs.getInt("project_id"));
				projectInfoDTO.setCustomer_id(rs.getInt("customer_id"));
				projectInfoDTO.setProject_name(StringUtility.removeNull(rs.getString("project_name")));
				projectInfoDTO.setProject_description(StringUtility.removeNull(rs.getString("project_description")));
				projectInfoDTO.setProject_inp_number(StringUtility.removeNull(rs.getString("project_name")));
				projectInfoDTO.setProject_start_date(StringUtility.removeNull(rs.getString("project_start_date")));
				projectInfoDTO.setProject_end_date(StringUtility.removeNull(rs.getString("project_end_date")));
				projectInfoDTO.setIs_active(rs.getInt("is_active"));
				projectInfoDTO.setCustomer_name(StringUtility.removeNull(rs.getString("customer_name")));
				projectInfoDTO.setProject_group(StringUtility.removeNull(rs.getString("project_group")));
				projectInfoDTO.setProject_sub_group(StringUtility.removeNull(rs.getString("project_sub_group")));
				projectInfoDTO.setProject_status(StringUtility.removeNull(rs.getString("project_status")));
				projectInfoDTO.setCustomer_order_no(StringUtility.removeNull(rs.getString("customer_order_no")));
				projectInfoDTO.setCustomer_order_date(StringUtility.removeNull(rs.getString("customer_order_date")));
				projectInfoDTO.setProject_status_id(rs.getInt("project_status_id"));
				projectInfoList.add(projectInfoDTO);
			} 
			obj = new Object[] { projectInfoList, projectInfoList.size() };
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}

		/* projectInfoList */
		return obj;
	}

	/*
	 * Method for create new project
	 */
	public static boolean createNewProject(CProjectDTO objProjectDto,String companyID) {
		QueryHelper qh = new QueryHelper();
		try {
			String sqlCreateProject = "insert into pms_projects(company_id,customer_id,project_name,project_description,project_start_date,project_end_date,project_status_id,project_code,project_type_id,created_by,created_on) "
					+ " values(?,?,?,?,?,?,?,?,?,?,now())";
			qh.addParam(companyID);
			qh.addParam(objProjectDto.getCustomer_id());
			qh.addParam(objProjectDto.getProject_name());
			qh.addParam(objProjectDto.getProject_description()); 
			qh.addParam(objProjectDto.getProject_start_date());
			qh.addParam(objProjectDto.getProject_end_date());
			qh.addParam(objProjectDto.getProject_status_id()); 
			qh.addParam(objProjectDto.getProject_code());
			qh.addParam(objProjectDto.getProject_type_id());
			qh.addParam(objProjectDto.getCreated_by());
			qh.runQuery(sqlCreateProject);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}

		return false;
	}

	/*
	 * Method for delete project
	 */
	public static boolean deleteProject(String project_id) {
		QueryHelper qh = new QueryHelper();
		try {
			String sqlDelete = "update pms_projects set is_deleted = 1 where project_id = ?";
			qh.addParam(project_id);
			qh.runQuery(sqlDelete);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}
		return false;

	}

	/*
	 * Method for fetch one project details Return: project info details
	 */
	public static CProjectInfoDTO getProjectDetails(String project_id) {
		CProjectInfoDTO projectInfoDTO = null;
		QueryHelper qh = new QueryHelper();
		try {
			String sqlProjectInfo = "select * from project_info_view where is_deleted =0 and project_id = ? ";
			qh.addParam(project_id);
			ResultSet rs = qh.runQueryStreamResults(sqlProjectInfo);

			if (rs.next()) {
				projectInfoDTO = new CProjectInfoDTO();
				projectInfoDTO.setProject_id(rs.getInt("project_id"));
				projectInfoDTO.setCustomer_id(rs.getInt("customer_id"));
				projectInfoDTO.setProject_name(StringUtility.removeNull(rs.getString("project_name")));
				projectInfoDTO.setProject_description(StringUtility.removeNull(rs.getString("project_description")));
				/*
				 * projectInfoDTO.setProject_inp_number(StringUtility.removeNull(rs.getString(
				 * "project_inp_number")));
				 */
				projectInfoDTO.setProject_start_date(StringUtility.removeNull(rs.getString("project_start_date")));
				projectInfoDTO.setProject_end_date(StringUtility.removeNull(rs.getString("project_end_date")));
				projectInfoDTO.setIs_active(rs.getInt("is_active"));
				projectInfoDTO.setCustomer_name(StringUtility.removeNull(rs.getString("customer_name")));
				/*
				 * projectInfoDTO.setProject_group_id(rs.getInt("project_group_id"));
				 * projectInfoDTO.setProject_sub_group_id(rs.getInt("project_sub_group_id"));
				 */
				projectInfoDTO.setProject_status_id(rs.getInt("project_status_id"));
				/*
				 * projectInfoDTO.setProject_group(StringUtility.removeNull(rs.getString(
				 * "project_group")));
				 * projectInfoDTO.setProject_sub_group(StringUtility.removeNull(rs.getString(
				 * "project_sub_group")));
				 */
				projectInfoDTO.setProject_status(StringUtility.removeNull(rs.getString("project_status")));
				projectInfoDTO.setProject_code(StringUtility.removeNull(rs.getString("project_code")));
				projectInfoDTO.setProject_type_id(rs.getInt("project_type_id"));
				projectInfoDTO.setProject_type(StringUtility.removeNull(rs.getString("project_type")));
				/*
				 * projectInfoDTO.setCustomer_order_no(StringUtility.removeNull(rs.getString(
				 * "customer_order_no")));
				 * projectInfoDTO.setCustomer_order_date(StringUtility.removeNull(rs.getString(
				 * "customer_order_date")));
				 */

			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}
		return projectInfoDTO;
	}

	/*
	 * Method for update project details
	 */
	public static boolean updateProjectDeails(CProjectDTO objProjectDTO) {
		QueryHelper qh = new QueryHelper();
		try {

			String sqlUpdateproject = "update pms_projects set customer_id = ? ,project_name = ? ,project_description = ? ,project_start_date = ? ,project_end_date = ? ,project_status_id = ?, project_code=?, project_type_id=? where project_id = ? ";
			qh.addParam(objProjectDTO.getCustomer_id());
			qh.addParam(objProjectDTO.getProject_name());
			qh.addParam(objProjectDTO.getProject_description());
			/*
			 * qh.addParam(objProjectDTO.getProject_group_id());
			 * qh.addParam(objProjectDTO.getProject_sub_group_id());
			 * qh.addParam(objProjectDTO.getProject_inp_number());
			 */
			qh.addParam(objProjectDTO.getProject_start_date());
			qh.addParam(objProjectDTO.getProject_end_date());
			qh.addParam(objProjectDTO.getProject_status_id());
			/*
			 * qh.addParam(objProjectDTO.getCustomer_order_no());
			 * qh.addParam(objProjectDTO.getCustomer_order_date());
			 */
			qh.addParam(objProjectDTO.getProject_code());
			qh.addParam(objProjectDTO.getProject_type_id());
			qh.addParam(objProjectDTO.getProject_id());

			qh.runQuery(sqlUpdateproject);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}

		return false;
	}

	public ArrayList<CProjectDTO> getAllProjectNameByCutomerID(int customer_id) {
		ArrayList<CProjectDTO> cProjectContactDTOs = null;
		QueryHelper qh = new QueryHelper();
		CProjectDTO cProjectContactDTO = null;

		try {
			String sqlProjectContact = "SELECT project_name,project_id FROM pms_projects where is_deleted=0 and customer_id = ?";
			qh.addParam(customer_id);
			ResultSet rs = qh.runQueryStreamResults(sqlProjectContact);
			while (rs.next()) {
				if (cProjectContactDTOs == null) {
					cProjectContactDTOs = new ArrayList<CProjectDTO>();
				}
				cProjectContactDTO = new CProjectDTO();
				cProjectContactDTO.setProject_name(rs.getString("project_name"));
				cProjectContactDTO.setProject_id(rs.getInt("project_id"));
				cProjectContactDTOs.add(cProjectContactDTO);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}
		return cProjectContactDTOs;
	}

	public static ArrayList<CProjectDTO> getProjectNameList(String companyID) {
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

	public Object[] getSearchData(String project_name, String customer_id, String project_status,int userID, String companyID) {
		Object[] obj = null;
		ArrayList<CProjectInfoDTO> projectInfoList = new ArrayList<CProjectInfoDTO>();
		QueryHelper qh = new QueryHelper();
		CProjectInfoDTO cProjectInfoDTO = null;
		try {
			
			String sqlProjectNameList = "select * from project_info_view "
					+ " where (created_by = ? or ? in (select project_emp.employee_id from pms_project_employee project_emp where "
					+ " project_emp.is_deleted = 0 and project_emp.project_id = project_info_view.project_id )) "
					+ " and project_info_view.is_deleted = 0 and project_info_view.company_id = ? and project_info_view.customer_deleted= 0 and project_info_view.project_name LIKE '%" + project_name 
					+ "%'  AND project_info_view.customer_id LIKE '%" + customer_id   +  "%' AND convert(project_info_view.project_status_id,char) LIKE '%" + project_status +  "%' ";
			
			qh.addParam(userID);
			qh.addParam(userID);
			qh.addParam(companyID);
			ResultSet rs = qh.runQueryStreamResults(sqlProjectNameList);
			while (rs.next()) {
				 
				cProjectInfoDTO = new CProjectInfoDTO();
				cProjectInfoDTO.setProject_id(rs.getInt("project_id"));
				cProjectInfoDTO.setProject_name(rs.getString("project_name"));
				cProjectInfoDTO.setCustomer_name(StringUtility.removeNull(rs.getString("customer_name")));
				cProjectInfoDTO.setProject_group(rs.getString("project_group"));
				cProjectInfoDTO.setProject_sub_group(rs.getString("project_sub_group"));
				cProjectInfoDTO.setProject_start_date(rs.getString("project_start_date"));
				cProjectInfoDTO.setProject_description(StringUtility.removeNull(rs.getString("project_description")));
				cProjectInfoDTO.setProject_end_date(rs.getString("project_end_date"));
				cProjectInfoDTO.setProject_status(rs.getString("project_status"));
				cProjectInfoDTO.setCustomer_order_no(rs.getString("customer_order_no"));
				cProjectInfoDTO.setCustomer_order_date(rs.getString("customer_order_date")); 
				cProjectInfoDTO.setProject_status_id(rs.getInt("project_status_id"));
				projectInfoList.add(cProjectInfoDTO);
			}

			obj = new Object[] { projectInfoList, projectInfoList.size() };
			// System.out.println(projectInfoList);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}

		return obj;
	}

	public static ArrayList<CCustomerDTO> getCustomerNameList(String companyID) {
		ArrayList<CCustomerDTO> customerNameList = null;
		QueryHelper qh = new QueryHelper();
		CCustomerDTO customerDTO = null;
		try {
			String sqlCustomerNameList = "SELECT customer_id,customer_name FROM pms_customers where is_deleted = 0 and company_id = ?";
			qh.addParam(companyID);
			ResultSet rs = qh.runQueryStreamResults(sqlCustomerNameList);
			while (rs.next()) {
				if (customerNameList == null) {
					customerNameList = new ArrayList<CCustomerDTO>();
				}
				customerDTO = new CCustomerDTO();
				customerDTO.setCustomer_id(rs.getInt("customer_id"));
				customerDTO.setCustomer_name(StringUtility.removeNull(rs.getString("customer_name")));
				customerNameList.add(customerDTO);
			}
			System.out.println(customerNameList);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}

		return customerNameList;
	}

	public static HashMap<String, Object> getProjectSummaryList(int project_id,String companyID) {

		QueryHelper qh = new QueryHelper();
		HashMap<String, Object> taskCountMap = new HashMap<>();
		try {
			// ArrayList<Object> statusList = new ArrayList<>();
			JsonObject jsonObj = new JsonObject();

//			String status_name;
			int totalTask = 0;
			String query = "select task_status, count(task_id) as tot from pms_project_task_info_view where is_deleted =0 and project_id = ? group by task_status_id;";
			qh.addParam(project_id);
			ResultSet rs = qh.runQueryStreamResults(query);
			while (rs.next()) {
				jsonObj.addProperty(rs.getString("task_status"), rs.getInt("tot"));
				totalTask = totalTask + rs.getInt("tot");
			}

			taskCountMap.put("status_list", jsonObj);
			taskCountMap.put("TotalTask", totalTask);

			String getMembers = "select count(project_employee_id) as projectMembersCount from project_employee_info_view where is_deleted = 0 and company_id = ? and project_id = ?;";
			qh.addParam(companyID);
			qh.addParam(project_id);
			ResultSet result = qh.runQueryStreamResults(getMembers);
			if (result.next()) {
				taskCountMap.put("membersCount", result.getInt("projectMembersCount"));
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}

		return taskCountMap;
	}

}

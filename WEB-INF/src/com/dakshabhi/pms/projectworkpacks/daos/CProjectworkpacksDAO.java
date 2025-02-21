package com.dakshabhi.pms.projectworkpacks.daos;

import java.sql.ResultSet;
import java.util.ArrayList;

import com.dakshabhi.common.constants.ConfigConstants;
import com.dakshabhi.common.db.QueryHelper;
import com.dakshabhi.pms.projectworkpacks.dtos.CProjectworkpacksDTO;
import com.dakshabhi.pms.projectworkpacks.dtos.CProjectworkpacksInfoDTO;

public class CProjectworkpacksDAO {

	public static boolean saveInfo(CProjectworkpacksDTO objProjectWorkpackDTO,String companyID) {
		QueryHelper qh = new QueryHelper();
		try {
			String sqlCreateProjectworkpack = "insert into pms_project_workpacks(company_id,project_id,workpack_id,date_added, workpack_rate, workpack_standard_hours, workpack_start_date, workpack_end_date,workpack_booked_hours) "
					+ " values(?,?,?,now(),?, ?, ?, ?, ?)";
			qh.addParam(companyID);
			qh.addParam(objProjectWorkpackDTO.getProject_id());
			qh.addParam(objProjectWorkpackDTO.getWorkpack_id());
			qh.addParam(objProjectWorkpackDTO.getWorkpack_rate());
			qh.addParam(objProjectWorkpackDTO.getWorkpack_standard_hours());
			qh.addParam(objProjectWorkpackDTO.getWorkpack_start_date());
			qh.addParam(objProjectWorkpackDTO.getWorkpack_end_date());
			qh.addParam(objProjectWorkpackDTO.getWorkpack_booked_hours());

			qh.runQuery(sqlCreateProjectworkpack);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}

		return false;
	}

	public ArrayList<CProjectworkpacksInfoDTO> getProjectWorpackDetails(String companyID) {
		ArrayList<CProjectworkpacksInfoDTO> cProjectworkpackList = null;
		QueryHelper qh = new QueryHelper();
		CProjectworkpacksInfoDTO cProjectworkpackDTO = null;
		try {
			String sqlProjectWorkpacks = "select * from project_workpacks_info_view where company_id = ? and is_deleted = 0";
			qh.addParam(companyID);

			ResultSet rs = qh.runQueryStreamResults(sqlProjectWorkpacks);
			while (rs.next()) {
				if (cProjectworkpackList == null) {
					cProjectworkpackList = new ArrayList<CProjectworkpacksInfoDTO>();
				}
				cProjectworkpackDTO = new CProjectworkpacksInfoDTO();
				cProjectworkpackDTO.setProject_workpack_id(rs.getInt("project_workpack_id"));
				cProjectworkpackDTO.setProject_name(rs.getString("project_name"));
				cProjectworkpackDTO.setWorkpack_name(rs.getString("workpack_name"));
				cProjectworkpackDTO.setWorkpack_rate(rs.getInt("workpack_rate"));
				cProjectworkpackDTO.setWorkpack_standard_hours(rs.getInt("workpack_standard_hours"));
				cProjectworkpackDTO.setWorkpack_start_date(rs.getString("workpack_start_date"));
				cProjectworkpackDTO.setWorkpack_end_date(rs.getString("workpack_end_date"));
				cProjectworkpackDTO.setWorkpack_booked_hours(rs.getInt("workpack_booked_hours"));
				cProjectworkpackList.add(cProjectworkpackDTO);
			}

		} catch (Exception e) {
			qh.releaseConnection();
		}
		return cProjectworkpackList;
	}

	public static boolean deleteProjectWorkpack(String project_workpack_id) {
		QueryHelper qh = new QueryHelper();
		try {
			String sqlDelete = "update pms_project_workpacks set is_deleted = 1 where project_workpack_id = ?";
			qh.addParam(project_workpack_id);
			qh.runQuery(sqlDelete);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}
		return false;

	}

	public static boolean updateProjectWorkpackDetails(CProjectworkpacksDTO objProjectWorkpackDTO) {
		QueryHelper qh = new QueryHelper();
		try {

			String sqlUpdateProjectWorkpack = "update pms_project_workpacks set project_id = ? , workpack_id = ?  , workpack_rate = ?, workpack_standard_hours = ? , workpack_booked_hours=? ,  workpack_start_date = ? , workpack_end_date = ?  where project_workpack_id = ? ";
			qh.addParam(objProjectWorkpackDTO.getProject_id());
			qh.addParam(objProjectWorkpackDTO.getWorkpack_id());
			qh.addParam(objProjectWorkpackDTO.getWorkpack_rate());
			qh.addParam(objProjectWorkpackDTO.getWorkpack_standard_hours());
			qh.addParam(objProjectWorkpackDTO.getWorkpack_booked_hours());
			qh.addParam(objProjectWorkpackDTO.getWorkpack_start_date());
			qh.addParam(objProjectWorkpackDTO.getWorkpack_end_date());

			qh.addParam(objProjectWorkpackDTO.getProject_workpack_id());

			qh.runQuery(sqlUpdateProjectWorkpack);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}

		return false;
	}

	public static CProjectworkpacksDTO getProjectWorkpackDetailsForEdit(String projectWorkpackId) {
		CProjectworkpacksDTO projectWorkpacksDTO = null;
		QueryHelper qh = new QueryHelper();
		try {
			String sqlEmployeeInfo = "select * from pms_project_workpacks where is_deleted =0 and project_workpack_id = ? ";
			qh.addParam(projectWorkpackId);
			ResultSet rs = qh.runQueryStreamResults(sqlEmployeeInfo);
			if (rs.next()) {

				projectWorkpacksDTO = new CProjectworkpacksDTO();
				projectWorkpacksDTO.setProject_id(rs.getInt("project_id"));
				projectWorkpacksDTO.setWorkpack_id(rs.getInt("workpack_id"));

			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}
		return projectWorkpacksDTO;
	}

}

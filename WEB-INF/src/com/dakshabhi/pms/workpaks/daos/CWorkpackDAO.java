package com.dakshabhi.pms.workpaks.daos;

import java.sql.ResultSet;
import java.util.ArrayList;

import com.dakshabhi.common.db.QueryHelper;
import com.dakshabhi.common.utility.StringUtility;
import com.dakshabhi.pms.workpaks.dtos.CWorkpackDTO;

public class CWorkpackDAO {

	public void saveWorkpack(CWorkpackDTO objWorkpackDTO, String companyID) {
		QueryHelper qh = new QueryHelper();
		try {
			String query = ("INSERT INTO pms_workpacks(company_id, workpack_name, workpack_description, workpack_rate, workpack_start_date ,workpack_end_date, workpack_standard_hours)"
					+ " values (?,?, ?, ? ,? ,? ,?)");
			qh.addParam(companyID);
			qh.addParam(StringUtility.removeNull(objWorkpackDTO.getWorkpack_name()));
			qh.addParam(StringUtility.removeNull(objWorkpackDTO.getWorkpack_description()));
			qh.addParam(objWorkpackDTO.getWorkpack_rate());
			qh.addParam(objWorkpackDTO.getWorkpack_start_date());
			qh.addParam(objWorkpackDTO.getWorkpack_end_date());
			qh.addParam(objWorkpackDTO.getWorkpack_standard_hours());

			qh.runQuery(query);
			qh.clearParams();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}

	}

	public ArrayList<CWorkpackDTO> getWorkpackDetails() {
		ArrayList<CWorkpackDTO> cWorkpackList = null;
		QueryHelper qh = new QueryHelper();
		CWorkpackDTO cWorkpackDTO = null;
		try {
			String sqlWorkpacks = "select * from pms_workpacks where company_id = ? and is_deleted = 0";
			qh.addParam("1");

			ResultSet rs = qh.runQueryStreamResults(sqlWorkpacks);
			while (rs.next()) {
				if (cWorkpackList == null) {
					cWorkpackList = new ArrayList<CWorkpackDTO>();
				}
				cWorkpackDTO = new CWorkpackDTO();
				cWorkpackDTO.setWorkpack_id(rs.getInt("workpack_id"));
				cWorkpackDTO.setCompany_id(rs.getInt("company_id"));
				cWorkpackDTO.setWorkpack_name(rs.getString("workpack_name"));
				cWorkpackDTO.setWorkpack_description(rs.getString("workpack_description"));
				cWorkpackDTO.setWorkpack_rate(rs.getDouble("workpack_rate"));
				cWorkpackDTO.setWorkpack_start_date(rs.getString("workpack_start_date"));
				cWorkpackDTO.setWorkpack_end_date(rs.getString("workpack_end_date"));
				cWorkpackDTO.setWorkpack_standard_hours(rs.getInt("workpack_standard_hours"));

				cWorkpackList.add(cWorkpackDTO);
			}

		} catch (Exception e) {
			qh.releaseConnection();
		}
		return cWorkpackList;
	}

	public static boolean deleteWorkpack(String workpack_id) {
		QueryHelper qh = new QueryHelper();
		try {
			String sqlDelete = "update pms_workpacks set is_deleted = 1 where workpack_id = ?";
			qh.addParam(workpack_id);
			qh.runQuery(sqlDelete);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}
		return false;

	}

	public static CWorkpackDTO getWorkpackDetailsById(String workpack_id) {
		CWorkpackDTO workpackInfoDTO = null;
		QueryHelper qh = new QueryHelper();
		try {
			String sqlWorkpackInfo = "select * from pms_workpacks where is_deleted =0 and workpack_id = ? ";
			qh.addParam(workpack_id);
			ResultSet rs = qh.runQueryStreamResults(sqlWorkpackInfo);
			if (rs.next()) {

				workpackInfoDTO = new CWorkpackDTO();
				workpackInfoDTO.setWorkpack_id(rs.getInt("workpack_id"));
				workpackInfoDTO.setCompany_id(rs.getInt("company_id"));
				workpackInfoDTO.setWorkpack_name(rs.getString("workpack_name"));
				workpackInfoDTO.setWorkpack_description(rs.getString("workpack_description"));
				workpackInfoDTO.setWorkpack_rate(rs.getDouble("workpack_rate"));
				workpackInfoDTO.setWorkpack_start_date(rs.getString("workpack_start_date"));
				workpackInfoDTO.setWorkpack_end_date(rs.getString("workpack_end_date"));
				workpackInfoDTO.setWorkpack_standard_hours(rs.getInt("workpack_standard_hours"));

			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}
		return workpackInfoDTO;
	}

	public static boolean updateWorkpackDetails(CWorkpackDTO objWorkpackDTO) {
		QueryHelper qh = new QueryHelper();
		try {

			String sqlUpdateWorkpack = "update pms_workpacks set workpack_name = ? ,workpack_description = ? ,workpack_rate = ? ,workpack_start_date = ?  ,workpack_end_date = ? ,workpack_standard_hours = ? where workpack_id = ? ";

			qh.addParam(StringUtility.removeNull(objWorkpackDTO.getWorkpack_name()));
			qh.addParam(StringUtility.removeNull(objWorkpackDTO.getWorkpack_description()));
			qh.addParam(objWorkpackDTO.getWorkpack_rate());
			qh.addParam(objWorkpackDTO.getWorkpack_start_date());
			qh.addParam(objWorkpackDTO.getWorkpack_end_date());
			qh.addParam(objWorkpackDTO.getWorkpack_standard_hours());

			qh.addParam(objWorkpackDTO.getWorkpack_id());

			qh.runQuery(sqlUpdateWorkpack);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}

		return false;
	}

	public ArrayList<CWorkpackDTO> getWorkpackNameList(String companyID) {
		ArrayList<CWorkpackDTO> workpackNameList = null;
		QueryHelper qh = new QueryHelper();
		CWorkpackDTO workpackDTO = null;
		try {
			String sqlWorkpackNameList = "select * from pms_workpacks where is_deleted=0 and company_id= ?";
			qh.addParam(companyID);
			ResultSet rs = qh.runQueryStreamResults(sqlWorkpackNameList);
			while (rs.next()) {
				if (workpackNameList == null) {
					workpackNameList = new ArrayList<CWorkpackDTO>();
				}
				workpackDTO = new CWorkpackDTO();
				workpackDTO.setWorkpack_id(rs.getInt("workpack_id"));
				workpackDTO.setWorkpack_name(rs.getString("workpack_name"));

				workpackNameList.add(workpackDTO);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}

		return workpackNameList;
	}
}

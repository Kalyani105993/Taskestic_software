package com.dakshabhi.pms.tickets.daos;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.dakshabhi.common.db.QueryHelper;
import com.dakshabhi.common.utility.StringUtility;
import com.dakshabhi.pms.email.dtos.ReadMailDetailDTO;
import com.dakshabhi.pms.masters.dtos.CDepartmentDTO;

public class TicketsDAO {

	/***
	 * Method for get List of email
	 * 
	 * @param pageNo
	 * @param endIndex
	 * @param startIndex
	 * @return Arraylist of ReadMailDetailDTO
	 */
	public ArrayList<ReadMailDetailDTO> getAllMailList(int startIndex, int endIndex, String pageNo) {

		int startLimit = (Integer.parseInt(pageNo) - 1) * endIndex;
		int endLimit = endIndex;

		ArrayList<ReadMailDetailDTO> getAllMaildetailList = new ArrayList<ReadMailDetailDTO>();
		QueryHelper qh = new QueryHelper();
		try {
			String sql = "SELECT * FROM pms_dakshabhi_mail_details WHERE is_deleted = 0 ORDER BY pkid DESC limit "
					+ startLimit + "," + endLimit + "";
			System.out.println("query " + sql);
			ResultSet rs = qh.runQueryStreamResults(sql);
			while (rs.next()) {
				ReadMailDetailDTO readMailDetailDTO = new ReadMailDetailDTO(); // Create a new object for each row
				readMailDetailDTO.setPkid(rs.getInt("pkid"));
				readMailDetailDTO.setFromName(StringUtility.removeNull(rs.getString("from_name")));
				readMailDetailDTO.setToName(StringUtility.removeNull(rs.getString("to_name")));
				readMailDetailDTO.setFromEmail(StringUtility.removeNull(rs.getString("from_Email")));
				readMailDetailDTO.setToEmail(StringUtility.removeNull(rs.getString("to_Email")));
				readMailDetailDTO.setEmailSubject(StringUtility.removeNull(rs.getString("email_Subject")));
				readMailDetailDTO.setEmailBody(StringUtility.removeNull(rs.getString("email_body")));
				readMailDetailDTO.setSend_date(StringUtility.removeNull(rs.getString("send_date")));
				getAllMaildetailList.add(readMailDetailDTO);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}

		return getAllMaildetailList;
	}

	/***
	 * Method for search email details
	 * 
	 * @param from_name
	 * @param from_email
	 * @param search_by
	 * @param pageNo
	 * @param endIndex
	 * @param startIndex
	 * @return Arraylist of ReadMailDetailDTO
	 */
	public ArrayList<ReadMailDetailDTO> searchEmailDetails(String from_name, String from_email, String search_by,
			int startIndex, int endIndex, String s_pageNo) {

		int startLimit = (Integer.parseInt(s_pageNo) - 1) * endIndex;
		int endLimit = endIndex;

		ArrayList<ReadMailDetailDTO> searchEmailList = new ArrayList<>();
		QueryHelper qh = new QueryHelper();

		try {

			String subquery = "";
			if (!from_name.isEmpty()) {

				subquery = "WHERE from_name like ?";
				qh.addParam("%" + from_name + "%");

			} else if (!from_email.isEmpty()) {

				subquery = "WHERE from_email like ?";
				qh.addParam("%" + from_email + "%");

			} else if (search_by.equals("today")) {

				subquery = "WHERE DATE(send_date) = CURDATE()";

			} else if (search_by.equals("yesterday")) {

				subquery = "WHERE DATE(send_date) = (select subdate(curdate(), 1))";

			} else if (search_by.equals("this_week")) {

				subquery = "WHERE WEEK(send_date) = WEEK(NOW()) AND YEAR(send_date) = YEAR(NOW())";

			} else if (search_by.equals("this_month")) {

				subquery = "WHERE MONTH(send_date) = MONTH(NOW()) AND YEAR(send_date) = YEAR(NOW())";

			} else if (search_by.equals("last_3_months")) {

				subquery = "WHERE send_date >= last_day(now()) + interval 1 day - interval 3 month";
			}

			String sql = "SELECT * FROM pms_dakshabhi_mail_details " + subquery + " limit " + startLimit + ","
					+ endLimit + "";
			System.out.println("query: " + sql);
			ResultSet rs = qh.runQueryStreamResults(sql);
			while (rs.next()) {
				ReadMailDetailDTO readMailDetailDTO = new ReadMailDetailDTO();
				readMailDetailDTO.setFromName(StringUtility.removeNull(rs.getString("from_name")));
				readMailDetailDTO.setToName(StringUtility.removeNull(rs.getString("to_name")));
				readMailDetailDTO.setFromEmail(StringUtility.removeNull(rs.getString("from_Email")));
				readMailDetailDTO.setToEmail(StringUtility.removeNull(rs.getString("to_Email")));
				readMailDetailDTO.setEmailSubject(StringUtility.removeNull(rs.getString("email_Subject")));
				readMailDetailDTO.setEmailBody(StringUtility.removeNull(rs.getString("email_body")));
				readMailDetailDTO.setSend_date(StringUtility.removeNull(rs.getString("send_date")));
				searchEmailList.add(readMailDetailDTO);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.releaseConnection();
		}
		return searchEmailList;
	}

	public int deleteEmail(int pkid) { // delete email details
		QueryHelper qh = new QueryHelper();
		int deletedCount = 0;
		try {
			String deleteSQL = "UPDATE pms_dakshabhi_mail_details SET is_deleted = 1 WHERE pkid = ?";
			qh.addParam(pkid);
			qh.runQuery(deleteSQL);
		} catch (Exception e) {
			e.printStackTrace(); 
		}
		return deletedCount;
	}

	public static ReadMailDetailDTO viewEmailDetails(int pkid) { // getviewdata for specific user...
		ReadMailDetailDTO readMailDetailDTO = null;
		QueryHelper qh = new QueryHelper();

		try {
			String SQL = "SELECT * FROM pms_dakshabhi_mail_details where pkid = ?";
			qh.addParam(pkid);
			ResultSet rs = qh.runQueryStreamResults(SQL);

			if (rs.next()) {
				readMailDetailDTO = new ReadMailDetailDTO();
				readMailDetailDTO.setPkid(rs.getInt("pkid"));
				readMailDetailDTO.setFromName(StringUtility.removeNull(rs.getString("from_name")));
				readMailDetailDTO.setToName(StringUtility.removeNull(rs.getString("to_name")));
				readMailDetailDTO.setFromEmail(StringUtility.removeNull(rs.getString("from_Email")));
				readMailDetailDTO.setToEmail(StringUtility.removeNull(rs.getString("to_Email")));
				readMailDetailDTO.setEmailSubject(StringUtility.removeNull(rs.getString("email_Subject")));
				readMailDetailDTO.setEmailBody(StringUtility.removeNull(rs.getString("email_body")));
				readMailDetailDTO.setSend_date(StringUtility.removeNull(rs.getString("send_date")));
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			qh.closeConnection();
		}

		return readMailDetailDTO;
	}
}

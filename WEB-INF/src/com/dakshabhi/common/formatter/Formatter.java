package com.dakshabhi.common.formatter;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.GregorianCalendar;

import com.dakshabhi.common.log.Loger;

public class Formatter {

	/*
	 * This method will return the formatted date object The Format Can be
	 * "dd-MMM-yyyy" "dd-MM-yyyy"
	 */
	public static String dateFormat(String format, Object dt) {
		java.text.Format frt = new java.text.SimpleDateFormat(format);
		return frt.format(dt);
	}

	public static java.sql.Date parseSQLDate(String dateString, String format) {
		SimpleDateFormat sdf = new SimpleDateFormat(format);
		Date date = null;
		try {
			date = new java.util.Date();
			date = sdf.parse(dateString);
			return new java.sql.Date(date.getTime());
		} catch (ParseException e) {
			Loger.log("Parse Exception " + e);
			e.printStackTrace();
		}
		return null;
	}

	public static String sqlFormat(String currentFormat, String sqlForamt, String date) {
		String sqlDate = "";
		try {
			SimpleDateFormat sdf = new SimpleDateFormat(currentFormat);
			Date cDate = sdf.parse(date);
			SimpleDateFormat df = new SimpleDateFormat(sqlForamt);
			sqlDate = df.format(cDate);
			return sqlDate;
		} catch (Exception e) {
			Loger.log("Exception Formatter : sqlFormat" + e);
			e.printStackTrace();
		}
		return null;
	}

	public static String parseDate(String dateString) {
		String[] splitDate = dateString.split("-");
		String year = splitDate[0];
		String month = splitDate[1];
		String day = splitDate[2].substring(0, 2);
		String date = month + "-" + day + "-" + year;
		return date;
	}

	public static int actualDifference(java.util.Date date1, java.util.Date date2) {
		GregorianCalendar gc1 = new GregorianCalendar();
		GregorianCalendar gc2 = new GregorianCalendar();
		gc1.setTime(date1);
		gc2.setTime(date2);
		long millies = gc2.getTimeInMillis() - gc1.getTimeInMillis();
		int day = (int) (millies / 1000 / 24 / 60 / 60);
		if (day < 0)
			day = day * -1;
		return day;
	}

	public static String parseDateNew(String dateString) {
		String[] splitDate = dateString.split("-");
		String year = splitDate[0];
		String month = splitDate[1];
		String day = splitDate[2].substring(0, 2);
		String date = month + "/" + day + "/" + year;
		return date;
	}

	public static String parseDateInmmddyyyy(String dateString) {
		String[] splitDate = dateString.split("-");
		String month = splitDate[0];
		String day = splitDate[1];
		String year = splitDate[2];
		String date = month + "/" + day + "/" + year;
		return date;
	}

	public static String parseDateTommddyyyy(String dateString) {
		String[] splitDate = dateString.split("/");
		String month = splitDate[0];
		String day = splitDate[1];
		String year = splitDate[2];
		String date = month + "-" + day + "-" + year;
		return date;
	}

	public static String parseDateToyyyymmdd(String dateString) {
		String[] splitDate = dateString.split("/");
		String month = splitDate[0];
		String day = splitDate[1];
		String year = splitDate[2];
		String date = year + "/" + month + "/" + day;
		return date;
	}
}

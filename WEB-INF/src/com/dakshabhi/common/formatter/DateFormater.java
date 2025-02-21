package com.dakshabhi.common.formatter;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.TimeZone;

public class DateFormater {
	static TimeZone destinationTZ = TimeZone.getTimeZone("Asia/Kolkata");
	static TimeZone soruceTZ = TimeZone.getTimeZone("Asia/Kolkata");
	
	public static String getFormatedFullDate(String inputDate) {
		try {
			if (inputDate != null && !"".equals(inputDate)) {
				SimpleDateFormat srourceFormatter = new SimpleDateFormat("yyyy-M-dd hh:mm:ss");
				String timeZone = Calendar.getInstance().getTimeZone().getID();
				srourceFormatter.setTimeZone(TimeZone.getTimeZone(timeZone));
				Date actualDate = srourceFormatter.parse(inputDate);
				SimpleDateFormat formatter = new SimpleDateFormat("dd MMMM yyyy");
				formatter.setTimeZone(destinationTZ);
				return formatter.format(actualDate);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}

	public static String getFormatedShortDate(String inputDate) {
		try {
			if (inputDate != null && !"".equals(inputDate)) {
				SimpleDateFormat srourceFormatter = new SimpleDateFormat("yyyy-M-dd");
				String timeZone = Calendar.getInstance().getTimeZone().getID();
				srourceFormatter.setTimeZone(TimeZone.getTimeZone(timeZone));
				Date actualDate = srourceFormatter.parse(inputDate);
				
				
				SimpleDateFormat formatter = new SimpleDateFormat("dd MMMM yyyy");
				formatter.setTimeZone(destinationTZ);
				return formatter.format(actualDate);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}

	public static String getFormatedFullDateWithTime(String inputDate) {
		try {
			if (inputDate != null && !"".equals(inputDate)) {				
				SimpleDateFormat srourceFormatter = new SimpleDateFormat("yyyy-M-dd hh:mm:ss");
				String timeZone = Calendar.getInstance().getTimeZone().getID();
				srourceFormatter.setTimeZone(TimeZone.getTimeZone(timeZone));
				Date actualDate = srourceFormatter.parse(inputDate);
				
				SimpleDateFormat formatter = new SimpleDateFormat("dd MMMM yyyy hh:mm a");
				formatter.setTimeZone(destinationTZ);
				return formatter.format(actualDate);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}

}

package com.dakshabhi.common.utility;

import java.io.IOException;

import java.io.InputStream;

import org.apache.commons.io.IOUtils;

public class Utility {

	public static String getResourceFileAsString(Class<?> clazz, String name) throws IOException {
		InputStream in = clazz.getResourceAsStream(name);
		try {
			return IOUtils.toString(in);
		} catch (Exception ex) {
			System.out.println("error loading: " + clazz + " : " + name);
		} finally {
			IOUtils.closeQuietly(in);
		}
		return null;
	}

	public static String getMonthStringToNumber(int month) {

		switch (month) {
		case 1:
			return "January";
		case 2:
			return "February";
		case 3:
			return "March";
		case 4:
			return "April";
		case 5:
			return "May";
		case 6:
			return "Jun";
		case 7:
			return "July";
		case 8:
			return "August";
		case 9:
			return "September";
		case 10:
			return "October";
		case 11:
			return "November";
		case 12:
			return "December";

		}
		return null;
	}

}

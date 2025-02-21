
package com.dakshabhi.common.constants;

import javax.servlet.http.HttpSession;

import com.dakshabhi.common.log.Loger;

public class ConfigConstants {
	/**
	 * Singlton Object
	 */
	private static ConfigConstants cc = null;

	public static int MAX_FILES = 3;

	public static int FILE_SIZE = 3000000;

	public static String FILE_EXTENSIONS = ".doc,.txt,.zip";

	private Boolean debug = Boolean.FALSE;

	private Boolean info = Boolean.FALSE;

	private Boolean level3 = Boolean.FALSE;

	public static int COMPANY_ID_old = -1;

	public boolean isCustomerSectionAllowed = false;
	public boolean isProjectSectionAllowed = false;
	public boolean isEmployeeSectionAllowed = false;
	public boolean isWorkpackSectionAllowed = false;
	public boolean isProjectContactSectionAllowed = false;
	public boolean isProjectWorkpackSectionAllowed = false;
	public boolean isProjectEmployeeSectionAllowed = false;
	public boolean isEmployeeDailyWorkSectionAllowed = false;
	public boolean isEmployeeWorkApprovalSectionAllowed = false;

	public ConfigConstants() {
		try {
//			InitialContext ic = new InitialContext();
//			debug = Boolean.valueOf((String) ic
//					.lookup("java:comp/env/DebugLevel"));
//
//			info = Boolean.valueOf((String) ic.lookup("java:comp/env/Info"));
//
//			level3 = Boolean
//					.valueOf((String) ic.lookup("java:comp/env/Level3"));
		} catch (Exception ee) {
			Loger.log("error in ConfigConstants class-" + ee);
		}

	}

	/**
	 * getInstance of singlton ConfigConstants object
	 */
	public static ConfigConstants getInstance() {

		if (cc != null) {
			return cc;
		} else {
			cc = new ConfigConstants();
			return cc;
		}
	}

	public Boolean getDebug() {
		return debug;
	}

	public Boolean getInfo() {
		return info;
	}

	public Boolean getLevel3() {
		return level3;
	}

	public static String getCompanyID(HttpSession session) {
		return session.getAttribute("companyID") == null ? "" : (String) session.getAttribute("companyID");
	}
	
	public static String getCompanyName(HttpSession session) {
		return session.getAttribute("companyName") == null ? "" : (String) session.getAttribute("companyName");
	}
}

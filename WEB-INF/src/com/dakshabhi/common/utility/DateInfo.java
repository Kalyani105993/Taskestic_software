package com.dakshabhi.common.utility;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.dakshabhi.common.log.Loger;

public class DateInfo {
	
	public java.sql.Date string2date(String d) {
		SimpleDateFormat sdf = new SimpleDateFormat("MM-dd-yyyy");
        Date d1 = null;
		try {
			d1 = sdf.parse(d);
		}
		catch (ParseException e) {
			Loger.log("Parse Exception " + e);
            e.printStackTrace();

		}

		return(new java.sql.Date(d1.getTime()));
	

	}
	

}

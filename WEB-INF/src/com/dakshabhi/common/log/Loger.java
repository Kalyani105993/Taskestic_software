package com.dakshabhi.common.log;

import com.dakshabhi.common.constants.ConfigConstants;

public class Loger {
	public static final int DEBUG = 0;

	public static final int INFO = 1;

	public static final int LEVEL3 = 2;

	private static ConfigConstants config = ConfigConstants.getInstance();

	public static void log(int debugLevel, Object message) {
   
        if(message instanceof Exception /*&& DEBUG == debugLevel*/ ){
            Exception ex = (Exception) message;
            ex.printStackTrace();
        }           

	}

	public static void log(Object message) {
		System.out.println(message);
		int debugLevel = 10;
		// Get the debug level from the file
		// DEBUG
		if (DEBUG == debugLevel) {
			if (config.getDebug().booleanValue()) {
				//System.out.println(message);
			}
		}

		// INFO
		if (INFO == debugLevel) {
			if (config.getInfo().booleanValue()) {
				//System.out.println(message);
			}
		}

		// LEVEL3
		if (LEVEL3 == debugLevel) {
			if (config.getLevel3().booleanValue()) {
				//System.out.println(message);
			}
		}
        if(message instanceof Exception /*&& DEBUG == debugLevel*/ ){
            Exception ex = (Exception) message;
            ex.printStackTrace();
        } 
	}

	public static void log(int message) {
		System.out.println(message);
		int debugLevel = 0;
		// Get the debug level from the file
		// DEBUG
		if (DEBUG == debugLevel) {
			if (config.getDebug().booleanValue()) {
				//System.out.println(message);
			}
		}

		// INFO
		if (INFO == debugLevel) {
			if (config.getInfo().booleanValue()) {
				//System.out.println(message);
			}
		}

		// LEVEL3
		if (LEVEL3 == debugLevel) {
			if (config.getLevel3().booleanValue()) {
				//System.out.println(message);
			}
		}

	}

	public static void log(double message) {
		System.out.println(message);
		int debugLevel = 0;
		// Get the debug level from the file
		// DEBUG
		if (DEBUG == debugLevel) {
			if (config.getDebug().booleanValue()) {
				//System.out.println(message);
			}
		}

		// INFO
		if (INFO == debugLevel) {
			if (config.getInfo().booleanValue()) {
				//System.out.println(message);
			}
		}

		// LEVEL3
		if (LEVEL3 == debugLevel) {
			if (config.getLevel3().booleanValue()) {
				//System.out.println(message);
			}
		}

	}
}

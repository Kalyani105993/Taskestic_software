package com.dakshabhi.common.utility;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Properties;

public final class PropertyReader  {

	Properties prop = null;

	private static String propertyPath = null;

	private static final String CLASS_NAME = "PropertyReader";

	public PropertyReader() {
		String dbConfigPath = System.getenv("DB_CONFIG_PATH");
		init(dbConfigPath);
	}

	private void init(String dbConfigPath) {
		if (dbConfigPath == null) {
			File newconfFile = new File("db.properties");

			if (!newconfFile.exists()) {
				boolean newConfFileCreated = false;
				try {
					newConfFileCreated = newconfFile.createNewFile();
					FileOutputStream fos = new FileOutputStream(newconfFile);
					fos.write("db.driver = ".getBytes());
					fos.write("db.url = ".getBytes());
					fos.write("db.username = ".getBytes());
					fos.write("db.password = ".getBytes());
				} catch (Exception e) {

				}

				if (newConfFileCreated) {
					System.out.println("Unable to get system property DB_CONFIG_PATH");
					System.out.println("You need to either configure value for DB_CONFIG_PATH or ");
					System.out.println(" sample config file db.properties was created for you at location...");
					System.out.println(" path: " + newconfFile.getAbsolutePath());
				} else {
					System.out.println("Unable to get system property DB_CONFIG_PATH");
					System.out.println("You need to either configure value for DB_CONFIG_PATH or ");
					System.out.println("create a db.propeties file at " + newconfFile.getAbsolutePath());
				}

			}else{
				initProperties(newconfFile);
			}
		} else {
			File newconfFile = new File(dbConfigPath + File.separator + "db.properties");	
			if (!newconfFile.exists()) {
				System.out.println("Unable to locate db.properties at:" + newconfFile.getAbsolutePath());
			} else{
				initProperties(newconfFile);
			}
		}
	}

	private void initProperties(File propertiesFile) {
		try {
			prop = new Properties();
			prop.load(new FileInputStream(propertiesFile));
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}

	public PropertyReader(String configFilePath) {
		init(configFilePath);
	}

	/**
	 * 
	 * @param propertyKey
	 * @return
	 */
	public String getProperty(String key) {
		return prop.getProperty(key);
	}

}

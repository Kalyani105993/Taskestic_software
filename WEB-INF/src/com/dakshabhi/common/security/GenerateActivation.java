package com.dakshabhi.common.security;

public class GenerateActivation {

	/**
	 * This method will generate the Activation Key
	 * 
	 * @return the Activation Key
	 */
	public String getActiationKey() {
		java.util.UUID activationkey = java.util.UUID.randomUUID();

		return activationkey.toString();
	}

	/**
	 * This method will generate the password with the Specified number of the
	 * length
	 * 
	 * @param passwordSize
	 * @return the password with the Specified size
	 */
	public String PwGen(int passwordSize) {
		char[] pw = new char[passwordSize];
		int c = 'A';
		int r1 = 0;
		for (int i = 0; i < passwordSize; i++) {
			r1 = (int) (Math.random() * 3);
			switch (r1) {
			case 0:
				c = '0' + (int) (Math.random() * 10);
				break;
			case 1:
				c = 'a' + (int) (Math.random() * 26);
				break;
			case 2:
				c = 'A' + (int) (Math.random() * 26);
				break;
			}
			pw[i] = (char) c;
		}
		return new String(pw);
	}
}

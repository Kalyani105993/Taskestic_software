package com.dakshabhi.common.security;

import java.security.MessageDigest;

public class GenerateEncrypt {
	private static String convertedToHex(byte[] data) {
		StringBuffer buf = new StringBuffer();

		for (int i = 0; i < data.length; i++) {
			int halfOfByte = (data[i] >>> 4) & 0x0F;
			int twoHalfBytes = 0;

			do {
				if ((0 <= halfOfByte) && (halfOfByte <= 9)) {
					buf.append((char) ('0' + halfOfByte));
				}

				else {
					buf.append((char) ('a' + (halfOfByte - 10)));
				}

				halfOfByte = data[i] & 0x0F;

			} while (twoHalfBytes++ < 1);
		}
		return buf.toString();
	}

	public static String MD5(String code) {
		try {
			MessageDigest md;
			md = MessageDigest.getInstance("MD5");
			byte[] md5 = new byte[64];
			md.update(code.getBytes("iso-8859-1"), 0, code.length());
			md5 = md.digest();
			return convertedToHex(md5);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	} 
}

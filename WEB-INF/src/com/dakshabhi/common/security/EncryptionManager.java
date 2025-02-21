package com.dakshabhi.common.security;

import java.io.UnsupportedEncodingException;

import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;

import org.apache.commons.codec.DecoderException;
import org.apache.commons.codec.binary.Hex;
import org.bouncycastle.jce.provider.BouncyCastleProvider;

public class EncryptionManager {

	private static final String ENCODING = "utf-8";

	private SecretKeySpec secretKey = null;

	public static String encryptBlowfish(String str) {
		byte[] encrypted = encryptBlowfishBytes(str);
		return getHexString(encrypted);
	}

	private static byte[] encryptBlowfishBytes(String str) {
		byte[] encrypted = null;
		// Long s = System.currentTimeMillis();
		try {
			Cipher cipher = null;
			// Create the Cipher and initialize it with the secret key spec
			cipher = Cipher.getInstance("Blowfish/ECB/PKCS5Padding", new BouncyCastleProvider());
			// cipher = SecurityInstances.cipherBlowfish;
			cipher.init(Cipher.ENCRYPT_MODE, new EncryptionManager().getKey());

			// Encrypt the string using the encoding
			encrypted = cipher.doFinal(str.getBytes(EncryptionManager.ENCODING));

		} catch (java.security.InvalidKeyException e) {
			e.printStackTrace();

		} catch (java.io.UnsupportedEncodingException e) {
			e.printStackTrace();

		} catch (java.security.GeneralSecurityException e) {
			e.printStackTrace();
		}
		return encrypted;
	}

	public static String decryptBlowfish(String str) {
		byte[] encrypted = getBytesFromHex(str);
		return decryptBlowfishBytes(encrypted);
	}

	private static String decryptBlowfishBytes(byte[] encrypted) {
		String decrypted = null;

		try {
			// Create the Cipher and initialize it with the secret key spec
			Cipher cipher = Cipher.getInstance("Blowfish/ECB/PKCS5Padding", new BouncyCastleProvider());
			cipher.init(Cipher.DECRYPT_MODE, new EncryptionManager().getKey());

			decrypted = new String(cipher.doFinal(encrypted), EncryptionManager.ENCODING);

		} catch (java.security.InvalidKeyException e) {
			e.printStackTrace();

		} catch (BadPaddingException e) {
			e.printStackTrace();

		} catch (java.security.GeneralSecurityException e) {
			e.printStackTrace();

		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}

		return decrypted;
	}

	private static String getHexString(byte[] ba) {

		char[] buf = null;
		// Convert encoded array of bytes into an array of characters
		// representing the hexidecimal values of each byte in order.
		buf = Hex.encodeHex(ba);

		// return the string created using this character array
		return new String(buf);
	}

	private static byte[] getBytesFromHex(String hex) {
		char[] charArrFromHexStr = null;
		byte[] buf = null;
		try {
			// We have the string of hexadecimal characters. convert it into
			// array of characters
			charArrFromHexStr = hex.toCharArray();
			// Convert this array of characters representing hexidecimal values
			// into an array of bytes
			// of those same values.
			buf = Hex.decodeHex(charArrFromHexStr);
		} catch (DecoderException dd) {
			dd.printStackTrace();
		}
		return buf;
	}

	private SecretKey getKey() {
		if (secretKey == null) {
			synchronized (this) {
				secretKey = new SecretKeySpec("K".getBytes(), "Blowfish");
			}
		}

		return secretKey;
	}
}

package net.hncu.onlineShoes.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

/**
 * MD5 加密工具
 */
public class MD5Util {
	private static final char[] hex="0123456789abcdef".toCharArray();
	private MD5Util() {
	}
	/**
	 * 把 pwd 进行MD5加密
	 * @param pwd 未加密的密码
	 * @return MD5加密后的密码
	 */
	public static String mkMD5Pwd(String pwd) {
		try {
			MessageDigest md5 = MessageDigest.getInstance("MD5");
			byte[] digest = md5.digest( pwd.getBytes() ); //长度一定为16
			pwd="";
			for (byte b : digest) {
				pwd+=hex[b>>4&0xf];
				pwd+=hex[b&0xf];
			}
		} catch (NoSuchAlgorithmException e) {
			throw new RuntimeException(e);
		}
		return pwd;
	}
	
	public static void main(String[] args) {
		int i = -125;
		System.out.println( Integer.toHexString(i&0xff) +" - "+ ( i&0xf ) );
		System.out.println( mkMD5Pwd("123456") );
	}
}

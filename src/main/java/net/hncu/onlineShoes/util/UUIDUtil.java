package net.hncu.onlineShoes.util;

import java.util.UUID;
/**
 * uuid工具
 */
public class UUIDUtil {
	private UUIDUtil() {}
	/**
	 * 生成一个32位的激活码
	 * @return 激活码
	 */
	public static String getACode() {
		return UUID.randomUUID().toString().replaceAll("-", "");
	}
	/**
	 * 生成一个32位的图片名称
	 * @return 图片名称
	 */
	public static String getImgName() {
		return UUID.randomUUID().toString().replaceAll("-", "");
	}
}

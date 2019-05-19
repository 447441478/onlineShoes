package net.hncu.onlineShoes.util;

public class BitUtil {
	
	/**
	 * 判断 flag 是否置起
	 * @param value
	 * @param flag
	 * @return
	 */
	public static boolean hasBit(int value, int flag) {
		return (value & flag) == flag;
	}
	/**
	 * 判断 flag 是否置起
	 * @param value
	 * @param flag
	 * @return
	 */
	public static boolean hasBit(Integer value, int flag) {
		if(value == null) return false;
		return (value & flag) == flag;
	}
	public static boolean hasBit(Integer value, Integer flag) {
		if(value == null || flag == null) return false;
		return (value & flag) == flag;
	}
	/**
	 * 置起 flag 位
	 * @param value
	 * @param flag
	 * @return
	 */
	public static int addBit(int value, int flag) {
		return value |= flag;
	}
	/**
	 * 移除 flag 位
	 * @param value
	 * @param flag
	 * @return
	 */
	public static int removeBit(int value, int flag) {
		return value &= ~flag;
	}
}

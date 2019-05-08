package net.hncu.onlineShoes;

import net.hncu.onlineShoes.util.BitUtil;

public class TestBitUtil {
	
	public static void main(String[] args) {
		int value = 5;
		int flag = 0x2;
		System.out.println(BitUtil.hasBit(value, flag));
		value = BitUtil.addBit(value, flag);
		System.out.println(BitUtil.hasBit(value, flag));
		value = BitUtil.removeBit(value, flag);
		System.out.println(BitUtil.hasBit(value, flag));
	}
}

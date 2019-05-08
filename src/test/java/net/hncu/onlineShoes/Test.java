package net.hncu.onlineShoes;

import java.util.Calendar;

import net.hncu.onlineShoes.util.DateUtil;

public class Test {
	
	public static void main(String[] args) {
		Calendar c = Calendar.getInstance();
		c.set(Calendar.HOUR_OF_DAY, 0);
		c.set(Calendar.MINUTE, 0);
		c.set(Calendar.SECOND, 0);
		c.add(Calendar.DATE, -1);
		String dateConversionString = DateUtil.dateConversionString(c.getTime());
		System.out.println(dateConversionString);
		System.out.println("1223__".matches("^\\w{3,20}$"));
		System.out.println("1@1.1".matches("^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*$"));
		System.out.println("e10adc3949ba5abbe56e057f20f883e".matches("^[0-9a-f]{32}$"));
	}
}

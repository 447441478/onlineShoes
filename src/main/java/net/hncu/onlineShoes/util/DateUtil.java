package net.hncu.onlineShoes.util;
/**
 * 日期处理工具
 */

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class DateUtil {
	public static final String PATTERN_DateTime = "yyyy-MM-dd HH:mm:ss";
	public static final String PATTERN_Date = "yyyy-MM-dd";
	//日期格式模板
	private static final SimpleDateFormat sdf_DateTime = new SimpleDateFormat(PATTERN_DateTime);
	private static final SimpleDateFormat sdf_Date = new SimpleDateFormat(PATTERN_Date);
	
	private DateUtil() {}
	/**
	 * 把日期类对象转化成  yyyy-MM-dd HH:mm:ss 的字符串
	 * @param date 被转化的日期类对象
	 * @return 转化后的字符串
	 */
	public static String dateTimeConversionString(Date date) {
		if(date == null)
			date = new Date();
		return sdf_DateTime.format(date);
	}
	/**
	 * 把long型值转化成  yyyy-MM-dd HH:mm:ss 的字符串
	 * @param time
	 * @return
	 */
	public static String timeConversionString(long time) {
		return sdf_DateTime.format(new Date(time));
	}
	/**
	 * 获得当前时间的字符串日期
	 * @return
	 */
	public static String getCurrentDateTimeString() {
		return sdf_DateTime.format(new Date());
	}
	/**
	 * 把字符串对象(yyyy-MM-dd HH:mm:ss)转化成日期类对象
	 * @param source 字符串的日期表示形式
	 * @return 转化后的日期类对象
	 */
	public static Date stringConversionDateTime(String source) {
		if (source == null || source.trim().isEmpty()) 
			return new Date();
		try {
			return sdf_DateTime.parse(source);
		} catch (ParseException e) {
			e.printStackTrace();
			return new Date();
		}
	}
	public static Boolean isBefore(String startTime, String endTime) {
		if(startTime == null || endTime == null) {
			return false;
		}
		return stringConversionDateTime(startTime).getTime() - stringConversionDateTime(startTime).getTime() < 50;
	}
	
	public static String dateConversionString(Date date) {
		if(date == null)
			date = new Date();
		return sdf_Date.format(date);
	}
	public static boolean isBefore(Long startTime, Long endTime) {
		if(startTime == null || endTime == null)
			return false;
		return startTime - endTime < 0;
	}
	/**
	 * 获取 yyyy-MM-dd 00:00:00
	 * @return
	 */
	public static String getDayFirstSeconds(long time) {
		long dayMilliSeconds = 24*60*60*1000;
		return timeConversionString(time/dayMilliSeconds*dayMilliSeconds);
	}
	/**
	 * 获取 yyyy-MM-dd 23:59:59
	 * @return
	 */
	public static String getDayLastSeconds(long time) {
		long dayMilliSeconds = 24*60*60*1000;
		return timeConversionString((time/dayMilliSeconds+1)*dayMilliSeconds-1000);
	}
}

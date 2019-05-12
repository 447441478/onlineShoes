package net.hncu.onlineShoes.util;

import java.util.HashMap;
import java.util.Map;

public class Msg {
	public static class Code{
		public static final int SUCCESS = 200; //成功
		public static final int FAIL = 400;  //失败
	}
	private int code;  //请求响应状态码  
	private String info;  //请求响应信息
	private Map<String, Object> datas = new HashMap<>();  //请求响应数据
	/**
	 * 获得成功数据的基本模板
	 * @return
	 */
	public static Msg success() {
		Msg msg = new Msg();
		msg.setCode(Msg.Code.SUCCESS);
		msg.setInfo("success");
		return msg;
	}
	/**
	 * 获得失败数据的基本模板
	 * @return
	 */
	public static Msg fail() {
		Msg msg = new Msg();
		msg.setCode(Msg.Code.FAIL);
		msg.setInfo("fail");
		return msg;
	}
	/**
	 * 添加数据
	 * @param key 
	 * @param value
	 * @return
	 */
	public Msg add(String key,Object value) {
		this.datas.put(key, value);
		return this;
	}
	
	public int getCode() {
		return code;
	}
	public Msg setCode(int code) {
		this.code = code;
		return this;
	}
	public String getInfo() {
		return info;
	}
	public Msg setInfo(String info) {
		this.info = info;
		return this;
	}
	public Msg setInfo(Object info) {
		this.info = info.toString();
		return this;
	}
	public Map<String, Object> getDatas() {
		return datas;
	}
	public void setDatas(Map<String, Object> datas) {
		this.datas = datas;
	}
	
	
}

package net.hncu.onlineShoes;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Calendar;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import net.hncu.onlineShoes.util.DateUtil;

public class Test {
	HttpServletRequest request;
	
	
	public static void main(String[] args) {
		Calendar c = Calendar.getInstance();
		c.setTimeInMillis(1558108800000L);
		c.set(Calendar.HOUR_OF_DAY, 0);
		c.set(Calendar.MINUTE, 0);
		c.set(Calendar.SECOND, 0);
		System.out.println(DateUtil.timeConversionString(c.getTimeInMillis()));
		
		/*String dateConversionString = DateUtil.dateConversionString(c.getTime());
		System.out.println(dateConversionString);
		System.out.println("1223__".matches("^\\w{3,20}$"));
		System.out.println("1@1.1".matches("^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*$"));
		System.out.println("e10adc3949ba5abbe56e057f20f883e".matches("^[0-9a-f]{32}$"));*/
	}
	
	public void a11(){
		String name = request.getParameter("name");
		String pwd = request.getParameter("pwd");
		Connection con = null;
		try {
			if(name != null && !"".equals(name.trim()) && pwd != null && !"".equals(pwd.trim())) {
				name = name.trim();
				pwd = pwd.trim();
				Class.forName("com.mysql.jdbc.Driver.class");
				con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/test?useUnicode=true&CharacterEncoding=utf-8", "root", "123");
				String sql = "insert into user(name,pwd) value (?,?)";
				PreparedStatement ps = con.prepareStatement(sql);
				ps.setString(1, name);
				ps.setString(2, pwd);
				int i = ps.executeUpdate();
				System.out.println("i=" + i);
			}
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if(con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
	}
}

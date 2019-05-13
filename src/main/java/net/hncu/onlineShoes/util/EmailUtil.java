package net.hncu.onlineShoes.util;

import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.Message.RecipientType;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.apache.log4j.Logger;

import net.hncu.onlineShoes.domain.User;

public class EmailUtil {
	
	public static boolean sendEmail(User user, String emailCode) {
		if(user == null || emailCode == null) {
			return false;
		}
		String msg = "邮箱验证码："+emailCode+"，五分钟内有效，请马上进行验证。";
		new SendMailThread(user, msg).start();
		return true;
	}
	
	
	
	/**
	 * &emsp;&emsp;发送邮箱的线程
	 * <br/><br/><b>CreateTime:</b><br/>&emsp;&emsp;&emsp; 2018年9月30日 上午12:26:08	
	 * @author 宋进宇&emsp;<a href='mailto:447441478@qq.com'>447441478@qq.com</a>
	 */
	private static class SendMailThread extends Thread{
		private Logger log = Logger.getLogger(SendMailThread.class);

		private User user;
		private String msg;
		
		public SendMailThread(User user, String msg) {
			super();
			this.user = user;
			this.msg = msg;
		}

		@Override
		public void run() {
			Properties p = new Properties();
			p.setProperty("mail.transport.protocol", "SMTP"); //设置邮件发送协议
			p.setProperty("mail.smtp.host", "smtp.163.com"); //设置邮件服务器
			p.setProperty("mail.smtp.port", "25"); //设置发送邮件的端口号，默认 25
			p.setProperty("mail.smtp.auth", "true"); // 登录认证为true
			p.setProperty("mail.smtp.timeout","2000"); //设置超时时间
			
			//技术入口：	
			Session session = Session.getDefaultInstance(p,new Authenticator() {
				@Override
				protected PasswordAuthentication getPasswordAuthentication() {
					return new PasswordAuthentication("17707471144@163.com", "wy123456");
				}
			});
			
			//设置消息内容
			Message message = new MimeMessage(session);
			try {
				//设置发送者
				message.setFrom( new InternetAddress("17707471144@163.com") );
				//设置接收者
				message.setRecipient( RecipientType.TO, new InternetAddress( user.getEmail() ) );
				//设置主题
				message.setSubject("HNCU-WhaleShoesStore,验证邮件");
				//设置信息内容
				message.setContent(msg, "text/html;charset=utf-8");
				
				//发送
				Transport.send(message);
				log.info("发送邮件成功，接收者id:"+user.getUserId());
			} catch ( Exception e) {
				log.error(e);
				e.printStackTrace();
			}
			
		}

	}
}

package net.hncu.onlineShoes;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import net.hncu.onlineShoes.domain.User;
import net.hncu.onlineShoes.domain.UserMapper;

public class MybatisTest {
	@Test
	public void getUser() {
		@SuppressWarnings("resource")
		ApplicationContext applicationContext = new ClassPathXmlApplicationContext("applicationContext.xml");
		SqlSessionFactory sqlSessionFactory = applicationContext.getBean(SqlSessionFactory.class);
		SqlSession session = sqlSessionFactory.openSession();
		UserMapper userMapper = session.getMapper(UserMapper.class);
		User user = userMapper.selectByPrimaryKey(1);
		System.out.println( user );
	}
}

package net.hncu.onlineShoes.user.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import net.hncu.onlineShoes.domain.User;
import net.hncu.onlineShoes.domain.UserMapper;

@Service("userService")
public class UserServiceImpl implements UserService{
	@Autowired
	UserMapper userMapper;

	@Override
	public String regist(User user) {
		if(user == null) {
			return null;
		}
		userMapper.insertSelective(user);
		return "注册成功";
	}
	
	
}

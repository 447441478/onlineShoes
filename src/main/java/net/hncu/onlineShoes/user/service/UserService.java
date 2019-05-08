package net.hncu.onlineShoes.user.service;

import org.springframework.stereotype.Service;

import net.hncu.onlineShoes.domain.User;

@Service("userService")
public interface UserService {

	String regist(User user);

}

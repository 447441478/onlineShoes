package net.hncu.onlineShoes.interceptor;

import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import net.hncu.onlineShoes.domain.User;
import net.hncu.onlineShoes.domain.UserExample;
import net.hncu.onlineShoes.domain.UserMapper;
import net.hncu.onlineShoes.user.controller.UserController;

public class AutoLoginInterceptor implements HandlerInterceptor{
	@Autowired
	UserMapper userMapper;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		request.getServletContext().setAttribute("APP_DIR", request.getContextPath());
		HttpSession session = request.getSession();
		User _user = UserController.getUser(session);
		if(_user != null && _user.getUserId() != null) { //用户已登录直接放行
			return true;
		}
		Cookie[] cookies = request.getCookies();
		if(cookies != null) {
			String username = null;
			String password = null;
			for (Cookie cookie : cookies) {
				String key = cookie.getName();
				if("username".equals(key)) {
					username = cookie.getValue();
				}
				if("password".equals(key)) {
					password = cookie.getValue();
				}
				if(username != null && password != null) {
					if(UserController.checkUsername(username) && UserController.checkPassword(password)) {
						UserExample example = new UserExample();
						example
						.createCriteria()
						.andUsernameEqualTo(username)
						.andPasswordEqualTo(password);
						List<User> list = userMapper.selectByExample(example);	
						if(list.size()>0) {
							User user = list.get(0);
							session.setAttribute("user", user);
						}
					}
					break;
				}
			}
		}
		return true;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
	}

}

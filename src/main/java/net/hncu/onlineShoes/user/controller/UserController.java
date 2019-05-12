package net.hncu.onlineShoes.user.controller;

import java.io.IOException;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import net.hncu.onlineShoes.domain.Address;
import net.hncu.onlineShoes.domain.AddressExample;
import net.hncu.onlineShoes.domain.AddressMapper;
import net.hncu.onlineShoes.domain.ShoesItemMapper;
import net.hncu.onlineShoes.domain.User;
import net.hncu.onlineShoes.domain.UserExample;
import net.hncu.onlineShoes.domain.UserExample.Criteria;
import net.hncu.onlineShoes.domain.UserMapper;
import net.hncu.onlineShoes.user.service.UserService;
import net.hncu.onlineShoes.util.CheckCodeGenerator;
import net.hncu.onlineShoes.util.Msg;

@RequestMapping("/user")
@Controller
public class UserController {
	private static Logger logger = Logger.getLogger(UserController.class);
	private static final String ROOT = "user/";
	
	@Autowired
	UserMapper userMapper;
	
	@Autowired
	UserService userService;
	
	@Autowired
	ShoesItemMapper shoesItemMapper;
	
	@Autowired
	AddressMapper addressMapper;
	
	@RequestMapping(path="/regist",method=RequestMethod.GET)
	public String registIndex() {
		return ROOT+"regist";
	}
	@RequestMapping(path="/check",method=RequestMethod.GET)
	@ResponseBody
	public Msg check(@RequestParam(name="username",defaultValue="") String username) {
		if (checkUsername(username)) {
			UserExample userExample = new UserExample();
			userExample.createCriteria().andUsernameEqualTo(username);
			List<User> selectByExample = userMapper.selectByExample(userExample);
			if(selectByExample == null || selectByExample.isEmpty()) {
				return Msg.success();
			}
		} 
		return Msg.fail();
	}
	@RequestMapping(path="/regist",method=RequestMethod.POST)
	@ResponseBody
	public Msg regist(User user) {
		if(checkUser(user)) {
			String res = userService.regist(user);
			if(res != null) {
				logger.info("成功注册一个新用户");
				return Msg.success().setInfo(res);
			}
		}
		logger.info("注册失败");
		return Msg.fail();
	}
	
	@RequestMapping(path="/login",method=RequestMethod.GET)
	public String loginIndex(HttpSession session) {
		if(session.getAttribute("errorLoginNum") == null) {
			session.setAttribute("errorLoginNum", 0); //初始化错误次数
		}
		return ROOT+"login";
	}
	@RequestMapping(path="/checkCode",method=RequestMethod.GET)
	public void checkCode(HttpServletResponse response,HttpSession session,HttpServletRequest request) {
		try {
			logger.info(request.getRemoteAddr() + "获取验证码");
			String checkCode = CheckCodeGenerator.CheckCodeOfImgCanFolat(28, response.getOutputStream());
			session.setAttribute("checkCode", checkCode);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	@RequestMapping(path="/login",method=RequestMethod.POST)
	@ResponseBody
	public Msg login(User user,@RequestParam(defaultValue="")String checkCode,
		@RequestParam(defaultValue="false")Boolean autoLogin,HttpSession session,
		HttpServletResponse response,
		HttpServletRequest request) {
		
		if(!(checkUsername(user.getUsername()) && checkPassword(user.getPassword()))) {
			return Msg.fail().setInfo("数据异常");
		}
		Integer errorLoginNum = (Integer) session.getAttribute("errorLoginNum");
		if(errorLoginNum == null) {
			errorLoginNum = 0;
		}
		if(errorLoginNum >= 3) {
			if(!checkCode.matches("^[0-9a-zA-Z]{4}$")) {
				return Msg.fail().setInfo("验证码非法");
			}
			if(!checkCode.equalsIgnoreCase((String) session.getAttribute("checkCode"))) {
				return Msg.fail().setInfo("验证码错误");
			}
		}
		UserExample userExample = new UserExample();
		userExample.createCriteria().andUsernameEqualTo(user.getUsername()).andPasswordEqualTo(user.getPassword());
		List<User> users = userMapper.selectByExample(userExample);
		if(users.size() > 0 ) {
			session.setAttribute("errorLoginNum", 0); //清空错误次数
			session.setAttribute("user", users.get(0));
			return Msg.success();
		}
		
		errorLoginNum++;
		session.setAttribute("errorLoginNum", errorLoginNum);
		logger.info(request.getRemoteAddr() + "登录失败");
		return Msg.fail().setInfo("账号/密码错误");
	}
	@RequestMapping(path="/logout",method=RequestMethod.GET)
	@ResponseBody
	public Msg logout(HttpSession session,HttpServletResponse response) {
		session.removeAttribute("user");
		return Msg.success().setInfo("您已安全退出");
	}
	
	public static boolean checkUsername(String username) {
		if(username == null) 
			return false;
		return username.matches("^\\w{3,20}$");
	}
	public static boolean checkPassword(String password) {
		if(password == null) 
			return false;
		return password.matches("^[0-9a-f]{32}$");
	}
	public static boolean checkEmail(String email) {
		if(email == null)
			return false;
		if(email.length()>50) {
			return false;
		}
		return email.matches("^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*$");
	}
	public static boolean checkUser(User user) {
		if(user == null) {
			return false;
		}
		boolean checkUsername = checkUsername(user.getUsername());
		boolean checkPassword = checkPassword(user.getPassword());
		boolean checkEmail = checkEmail(user.getEmail());
		return checkUsername && checkEmail && checkPassword;
	}
	
	@RequestMapping(path="/memberCenter",method=RequestMethod.GET)
	public String memberCenterIndex(HttpSession session, Model model) throws JsonProcessingException {
		User user = getUser(session);
		if(user == null || user.getUserId() == 0) {
			return loginIndex(session);
		}
		Integer userId = user.getUserId();
		AddressExample example = new AddressExample();
		example.createCriteria().andUserIdEqualTo(userId);
		List<Address> addrs = addressMapper.selectByExample(example);
		Address address = new Address();
		if(addrs.size() > 0) {
			address = addrs.get(0);
		}
		ObjectMapper om = new ObjectMapper();
		model.addAttribute("address", om.writeValueAsString(address));
		return ROOT+"memberCenter";
	}
	@ResponseBody
	@RequestMapping(path="/updateMember",method=RequestMethod.POST)
	public Msg updateMember(@RequestParam(name="email",required=true)String email,
			@RequestParam(name="oldPwd",defaultValue="")String oldPwd,
			@RequestParam(name="newPwd",defaultValue="")String newPwd,
			HttpSession session) {
		User user = getUser(session);
		if(!checkEmail(email)) {
			return Msg.fail().setInfo("邮箱格式错误");
		}
		UserExample example = new UserExample();
		Criteria criteria = example.createCriteria();
		criteria.andUserIdEqualTo(user.getUserId());
		User user2 = new User();
		user2.setUserId(user.getUserId());
		user2.setEmail(email);
		if(!"".equals(oldPwd)) {
			if(!checkPassword(oldPwd)) {
				return Msg.fail().setInfo("旧密码格式错误");
			}
			if(!checkPassword(newPwd)) {
				return Msg.fail().setInfo("新密码格式错误");
			}
			if(!oldPwd.equals(user.getPassword())) {
				return Msg.fail().setInfo("旧密码不正确");
			}
			criteria.andPasswordEqualTo(oldPwd);
			user2.setPassword(newPwd);
		}
		int i = userMapper.updateByExampleSelective(user2, example);
		if(i == 1) {
			user.setEmail(email);
			if(oldPwd.equals(user.getPassword())) {
				user.setPassword(newPwd);
			}
		}
		return Msg.success().setInfo(i);
	}
	
	public static User getUser(HttpSession session) {
		return (User) session.getAttribute("user");
	}
	
	@ResponseBody
	@RequestMapping(path="/addAddr",method=RequestMethod.POST)
	public Msg addAddr(Address address,
			HttpSession session) {
		User user = UserController.getUser(session);
		Integer userId = user.getUserId();
		AddressExample example = new AddressExample();
		example.createCriteria().andUserIdEqualTo(userId);
		List<Address> addrs = addressMapper.selectByExample(example);
		address.setUserId(userId);
		address.setCreateTime(new Date());
		if(addrs.size() == 0) {
			addressMapper.insertSelective(address);
		} else {
			address.setAddrId(addrs.get(0).getAddrId());
			addressMapper.updateByPrimaryKeySelective(address);
		}
		return Msg.success();
	}
	
	
}

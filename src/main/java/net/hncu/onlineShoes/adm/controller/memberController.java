package net.hncu.onlineShoes.adm.controller;

import java.util.Date;
import java.util.List;

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
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import net.hncu.onlineShoes.comm.SearchField;
import net.hncu.onlineShoes.domain.User;
import net.hncu.onlineShoes.domain.UserExample;
import net.hncu.onlineShoes.domain.UserExample.Criteria;
import net.hncu.onlineShoes.domain.UserMapper;
import net.hncu.onlineShoes.util.BitUtil;
import net.hncu.onlineShoes.util.Msg;

@RequestMapping("/adm/member")
@Controller
public class memberController {
	private static final String ROOT = "adm/member/";
	private static final Logger LOG = Logger.getLogger(memberController.class);
	
	@Autowired
	UserMapper userMapper;
	
	@RequestMapping(path="/manageMember",method= {RequestMethod.GET})
	public String index(Model model) throws JsonProcessingException {
		PageHelper.startPage(1,10);
		List<User> users = userMapper.selectByExample(null);
		PageInfo<User> pageInfo = new PageInfo<>(users);
		users = pageInfo.getList();
		ObjectMapper om = new ObjectMapper();
		model.addAttribute("users", om.writeValueAsString(users));
		model.addAttribute("total", pageInfo.getTotal());
		return ROOT + "manageMember";
	}
	
	@RequestMapping(path="/get",method=RequestMethod.GET)
	@ResponseBody
	public Msg get(@RequestParam(defaultValue="1") Integer currentPage, 
			@RequestParam(defaultValue="10") Integer pageSize, 
			@RequestParam(defaultValue="") String orderColum,
			@RequestParam(defaultValue="false") Boolean isDesc,
			@RequestParam(defaultValue="") String keyWord,
			@RequestParam(defaultValue="false")Boolean openTime,
			@RequestParam(defaultValue="0") Long startTime,
			@RequestParam(defaultValue="0") Long endTime,
			HttpSession session) {
		LOG.info("获取用户信息");
		User user = (User) session.getAttribute("user");
		if(user == null) {
			return Msg.fail();
		}
		int flag = user.getFlag();
		if(!BitUtil.hasBit(flag, User.Flag.SUPER_MANAGER) &&  BitUtil.hasBit(flag, User.Flag.MEMBER_MANAGER)) {
			return Msg.fail();
		}
		PageHelper.startPage(currentPage, pageSize);
		UserExample example = new UserExample();
		if(!"".equals(orderColum)) {
			String orderByClause = SearchField.UserDef.getOrderByField(orderColum, isDesc);
			example.setOrderByClause(orderByClause);
		}
		keyWord = keyWord.trim();
		Criteria criteria = example.createCriteria();
		if(!"".equals(keyWord)) {
			criteria.andUsernameLike(keyWord);
		}
		if(openTime) {
			criteria.andCreateTimeBetween(new Date(startTime), new Date(endTime));
		}
		List<User> users = userMapper.selectByExample(example);
		PageInfo<User> pageInfo = new PageInfo<>(users);
		users = pageInfo.getList();
		return Msg.success()
				.add("users", users)
				.add("total", pageInfo.getTotal())
				.add("keyWord", keyWord)
				.add("openTime", openTime)
				.add("startTime", startTime)
				.add("endTime", endTime);
	}
	@RequestMapping(path="/update",method=RequestMethod.GET)
	public String updateIndex(@RequestParam(name="userId",required=true)Integer userId, Model model) throws JsonProcessingException {
		User user = userMapper.selectByPrimaryKey(userId);
		ObjectMapper om = new ObjectMapper();
		model.addAttribute("member", om.writeValueAsString(user));
		return ROOT + "updateMember";
	}
	@ResponseBody
	@RequestMapping(path="/update",method=RequestMethod.POST)
	public Msg update(@RequestParam(name="userId",required=true)Integer userId,
			@RequestParam(name="email",required=true)String email,
			@RequestParam(name="flag",required=true)Integer flag) throws JsonProcessingException {
		User user = new User();
		user.setUserId(userId);
		user.setEmail(email);
		user.setFlag(flag);
		userMapper.updateByPrimaryKeySelective(user);
		return Msg.success();
	}
}

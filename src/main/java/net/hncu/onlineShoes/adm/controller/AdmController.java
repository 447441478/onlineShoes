package net.hncu.onlineShoes.adm.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import net.hncu.onlineShoes.domain.CommentMapper;
import net.hncu.onlineShoes.domain.OrderDetailMapper;
import net.hncu.onlineShoes.domain.ShoesMapper;
import net.hncu.onlineShoes.domain.UserMapper;

@RequestMapping("/adm")
@Controller
public class AdmController {
	private static final String ROOT = "adm/";
	@Autowired
	ShoesMapper shoesMapper;
	
	@Autowired
	UserMapper userMapper;
	
	@Autowired
	OrderDetailMapper orderDetailMapper;
	
	@Autowired
	CommentMapper commentMapper;
	
	@RequestMapping(method={RequestMethod.GET})
	public String index() {
		return ROOT + "index";
	}
	
	@RequestMapping(path="/welcome",method={RequestMethod.GET})
	public String welcome(Model Model) {
		long shoesTotal = shoesMapper.getTotal();
		long userTotal = userMapper.getTotal();
		long orderDetailTotal = orderDetailMapper.getTotal();
		long commentTotal = commentMapper.getTotal();
		Model.addAttribute("shoesTotal", shoesTotal);
		Model.addAttribute("userTotal", userTotal);
		Model.addAttribute("orderDetailTotal", orderDetailTotal);
		Model.addAttribute("commentTotal", commentTotal);
		return ROOT + "welcome";
	}
	
	
}

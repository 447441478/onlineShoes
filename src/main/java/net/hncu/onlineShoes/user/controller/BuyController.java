package net.hncu.onlineShoes.user.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
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

import net.hncu.onlineShoes.domain.OrderDetail;
import net.hncu.onlineShoes.domain.ShoesItem;
import net.hncu.onlineShoes.domain.ShoesItemMapper;
import net.hncu.onlineShoes.domain.User;
import net.hncu.onlineShoes.user.service.OrderDetailService;
import net.hncu.onlineShoes.user.service.ShoesItemService;
import net.hncu.onlineShoes.util.Msg;

@Controller
@RequestMapping("/buy")
public class BuyController {
	private static Logger logger = Logger.getLogger(BuyController.class);
	private static final String ROOT = "buy/";
	
	@Autowired
	private ShoesItemMapper shoesItemMapper;
	
	@Autowired
	private ShoesItemService shoesItemService;
	
	@Autowired
	private OrderDetailService orderDetailService;
	
	@RequestMapping(path="/fromBasket", method=RequestMethod.GET)
	public String fromBasket(@RequestParam(value="shoesId",required=true)Integer[] shoesIds,
			@RequestParam(value="shoesSizeId",required=true)Integer[] shoesSizeIds,
			@RequestParam(value="buyNum",required=true)Integer[] buyNums,
			HttpSession session, HttpServletRequest request) {
		if(shoesIds == null || shoesSizeIds == null || buyNums == null || shoesIds.length != shoesSizeIds.length || shoesIds.length != buyNums.length) {
			return "redirect:/";
		}
		User user = UserController.getUser(session);
		if(user == null || user.getUserId() == 0) {
			logger.info("非法访问");
			return "redirect:/";
		}
		List<ShoesItem> shoesItems = new ArrayList<>();
		for (int i = 0; i < buyNums.length; i++) {
			ShoesItem shoesItem = new ShoesItem();
			shoesItem.setUserId(user.getUserId());
			shoesItem.setShoesSizeId(shoesSizeIds[i]);
			shoesItem.setShoesId(shoesIds[i]);
			shoesItem.setAmount(buyNums[i]);
			shoesItem.setFlag(ShoesItem.Flag.ADD);
			shoesItems.add(shoesItem);
		}
		boolean boo = shoesItemService.updateShoesItems(shoesItems);
		if(!boo) {
			String referer = request.getHeader("Referer");
			String targetPath = "/";
			if(referer != null) {
				targetPath = referer;
			}
			return "redirect:"+targetPath;
		}
		List<Map<String, Object>> select4Order = shoesItemMapper.select4Order(user.getUserId(), ShoesItem.Flag.ADD, Arrays.asList(shoesSizeIds));
		session.setAttribute("order", select4Order);
		return"redirect:/" + ROOT;
	}
	
	@RequestMapping(path="", method=RequestMethod.GET)
	public String index(Model model,HttpSession session) throws JsonProcessingException {
		ObjectMapper objectMapper = new ObjectMapper();
		@SuppressWarnings("unchecked")
		List<Map<String, Object>> order = (List<Map<String, Object>>) session.getAttribute("order");
		if(order == null || order.isEmpty()) {
			return"redirect:/";
		}
		model.addAttribute("orderJson", objectMapper.writeValueAsString(order));
		return ROOT + "buy";
	}
	@RequestMapping(path="/pay", method=RequestMethod.POST)
	@ResponseBody
	public Msg pay(@RequestParam(name="name",required=true)String name,
			@RequestParam(name="tel",required=true)String tel,
			@RequestParam(name="addr",required=true)String addr,
			@RequestParam(name="payMethod",required=true)Integer payMethod,
			HttpSession session) throws JsonProcessingException {
		name = name.trim();
		tel = tel.trim();
		addr = addr.trim();
		if("".equals(name)) {
			return Msg.fail().setInfo("收货人姓名不能为空.");
		}
		if("".equals(tel)) {
			return Msg.fail().setInfo("收货人电话不能为空.");
		}
		if(!tel.matches("^[1][3,4,5,7,8][0-9]{9}$")) {
			return Msg.fail().setInfo("请输入正确的电话号码.");
		}
		if("".equals(addr)) {
			return Msg.fail().setInfo("收货人地址不能为空.");
		}
		OrderDetail orderDetail = new OrderDetail(UserController.getUser(session).getUserId(),name,tel,addr,payMethod);
		@SuppressWarnings("unchecked")
		List<Map<String, Object>> order = (List<Map<String, Object>>) session.getAttribute("order");
		try {
			String res = orderDetailService.addOrder(order,orderDetail);
			session.removeAttribute("order");
			if("".equals(res)) {
				return Msg.success().setInfo("库存不足,订单已取消。");
			}
			return Msg.success().setInfo(res);
		}catch (Exception e) {
			logger.error("111", e);
			return Msg.fail().setInfo("-1");
		}
	}
	
}

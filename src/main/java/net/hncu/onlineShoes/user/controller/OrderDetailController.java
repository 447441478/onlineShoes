package net.hncu.onlineShoes.user.controller;

import java.util.List;

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
import net.hncu.onlineShoes.domain.OrderDetailExample;
import net.hncu.onlineShoes.domain.OrderDetailExample.Criteria;
import net.hncu.onlineShoes.domain.OrderDetailMapper;
import net.hncu.onlineShoes.domain.User;
import net.hncu.onlineShoes.shoes.controller.ShoesController;
import net.hncu.onlineShoes.user.controller.UserController;
import net.hncu.onlineShoes.util.Msg;

@RequestMapping("/order")
@Controller
public class OrderDetailController {
	private static Logger logger = Logger.getLogger(OrderDetailController.class);
	public static final String ROOT = "order/";
	
	@Autowired
	OrderDetailMapper orderDetailMapper;
	
	@RequestMapping(path="",method=RequestMethod.GET)
	public String index(HttpServletRequest request, HttpSession session, Model model) throws JsonProcessingException {
		User user = UserController.getUser(session);
		if(user == null || user.getUserId() == 0) {
			logger.info("未登录访问...");
			return "/";
		}
		OrderDetailExample example = new OrderDetailExample();
		Criteria criteria = example.createCriteria();
		criteria.andUserIdEqualTo(user.getUserId());
		List<OrderDetail> orderDetails = orderDetailMapper.selectByExampleWithShoes(example);
		ObjectMapper om = new ObjectMapper();
		model.addAttribute("orderDetails", om.writeValueAsString(orderDetails));
		String shoesRoot = ShoesController.getShoesRoot(request.getContextPath());
		model.addAttribute("shoesRoot", shoesRoot);
		return ROOT + "orderDetail";
	}
	
	@RequestMapping(path="/changeOrderState",method=RequestMethod.POST)
	@ResponseBody
	public Msg changeOrderState(@RequestParam(name="orderDetailId",required=true) Integer orderDetailId,
			@RequestParam(name="flag",required=true)Integer flag,
			@RequestParam(name="newFlag",required=true)Integer newFlag) {
		if(orderDetailId == null || flag == null || newFlag == null) {
			return Msg.fail();
		}
		OrderDetailExample example = new OrderDetailExample();
		Criteria criteria = example.createCriteria();
		criteria.andOrderDetailIdEqualTo(orderDetailId);
		criteria.andFlagEqualTo(flag);
		OrderDetail record = new OrderDetail();
		switch (flag) {
			case OrderDetail.Flag.INIT:
				if( newFlag != OrderDetail.Flag.APPLY_REFUND && newFlag !=  OrderDetail.Flag.DELIVERED ) {
					newFlag = null;
				}
				break;
			case OrderDetail.Flag.DELIVERED:
				if( newFlag != OrderDetail.Flag.ACCEPTED ) {
					newFlag = null;
				}
				break;
			case OrderDetail.Flag.ACCEPTED:
				if( newFlag != OrderDetail.Flag.COMPLETE_TRANSACTION ) {
					newFlag = null;
				}
				break;
			case OrderDetail.Flag.COMPLETE_TRANSACTION:
				if( newFlag != OrderDetail.Flag.EVALUATED ) {
					newFlag = null;
				}
				break;
			default:
				newFlag = null;
		}
		if(newFlag != null) {
			record.setFlag(newFlag);
			orderDetailMapper.updateByExampleSelective(record, example);
			return Msg.success();
		} else {
			return Msg.fail();
		}
	}
	
}

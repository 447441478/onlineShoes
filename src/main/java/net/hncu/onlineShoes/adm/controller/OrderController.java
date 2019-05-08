package net.hncu.onlineShoes.adm.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import net.hncu.onlineShoes.domain.OrderDetail;
import net.hncu.onlineShoes.domain.OrderDetailExample;
import net.hncu.onlineShoes.domain.OrderDetailExample.Criteria;
import net.hncu.onlineShoes.domain.OrderDetailMapper;
import net.hncu.onlineShoes.domain.User;
import net.hncu.onlineShoes.user.controller.UserController;
import net.hncu.onlineShoes.util.Msg;

@RequestMapping("/adm/order")
@Controller
public class OrderController {
	private static final String ROOT = "adm/order/";
	private static final Logger LOG = Logger.getLogger(OrderController.class);
	
	@Autowired
	OrderDetailMapper orderDetailMapper;
	
	@RequestMapping(path="/manageOrder",method=RequestMethod.GET)
	public String index(HttpSession session,Model model) throws JsonProcessingException {
		User user = UserController.getUser(session);
		LOG.info("userId:" + user.getUserId());
		List<OrderDetail> orderDetails = orderDetailMapper.selectByExampleWithShoes(new OrderDetailExample());
		ObjectMapper om = new ObjectMapper();
		model.addAttribute("orderDetails", om.writeValueAsString(orderDetails));
		return ROOT + "/manageOrder";
	}
	
	@RequestMapping(path="/sendGoods",method=RequestMethod.GET)
	public String sendGoods() {
		return ROOT + "sendGoods";
	}
	
	@RequestMapping(path="/sendGoods",method=RequestMethod.POST)
	public Msg sendGoodsUpdate(@RequestParam(name="orderDetailId",required=true) Integer orderDetailId,
			@RequestParam(name="logisticsId",required=true) String logisticsId) {
		OrderDetailExample example = new OrderDetailExample();
		Criteria criteria = example.createCriteria();
		criteria.andOrderDetailIdEqualTo(orderDetailId);
		criteria.andFlagEqualTo(OrderDetail.Flag.INIT);
		OrderDetail record = new OrderDetail();
		record.setLogisticsId(logisticsId);
		record.setFlag(OrderDetail.Flag.DELIVERED);
		orderDetailMapper.updateByExampleSelective(record, example);
		return Msg.success();
	}
	@RequestMapping(path="/completeTransaction",method=RequestMethod.POST)
	public Msg completeTransaction(@RequestParam(name="orderDetailId",required=true) Integer orderDetailId) {
		OrderDetailExample example = new OrderDetailExample();
		Criteria criteria = example.createCriteria();
		criteria.andOrderDetailIdEqualTo(orderDetailId);
		criteria.andFlagEqualTo(OrderDetail.Flag.ACCEPTED);
		OrderDetail record = new OrderDetail();
		record.setFlag(OrderDetail.Flag.COMPLETE_TRANSACTION);
		orderDetailMapper.updateByExampleSelective(record, example);
		return Msg.success();
	}
	
}

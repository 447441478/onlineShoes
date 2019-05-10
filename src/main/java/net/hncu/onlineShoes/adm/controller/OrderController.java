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
import org.springframework.web.bind.annotation.ResponseBody;

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
	
	@RequestMapping(path="/updateOrder",method=RequestMethod.GET)
	public String updateOrder(@RequestParam(name="orderDetailId",required=true) Integer orderDetailId,
			Model model) throws JsonProcessingException {
		OrderDetail orderDetail = orderDetailMapper.selectByPrimaryKeyWithShoes(orderDetailId);
		ObjectMapper om = new ObjectMapper();
		model.addAttribute("orderDetail", om.writeValueAsString(orderDetail));
		return ROOT + "updateOrder";
	}
	@RequestMapping(path="/updateOrder",method=RequestMethod.POST)
	public Msg updateOrder(@RequestParam(name="orderDetailId",required=true) Integer orderDetailId,
			@RequestParam(name="name",required=true) String name,
			@RequestParam(name="tel",required=true) String tel,
			@RequestParam(name="addr",required=true) String addr) {
		OrderDetailExample example = new OrderDetailExample();
		Criteria criteria = example.createCriteria();
		criteria.andOrderDetailIdEqualTo(orderDetailId);
		criteria.andFlagEqualTo(OrderDetail.Flag.INIT);
		OrderDetail record = new OrderDetail();
		record.setName(name);
		record.setTel(tel);
		record.setAddr(addr);
		orderDetailMapper.updateByExampleSelective(record, example);
		return Msg.success();
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
			case OrderDetail.Flag.APPLY_REFUND:
				if( newFlag != OrderDetail.Flag.COMPLETE_REFUND ) {
					newFlag = null;
				}
				break;
			case OrderDetail.Flag.ACCEPTED:
				if( newFlag != OrderDetail.Flag.COMPLETE_TRANSACTION ) {
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

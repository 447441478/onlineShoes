package net.hncu.onlineShoes.user.controller;

import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import net.hncu.onlineShoes.domain.ShoesItem;
import net.hncu.onlineShoes.domain.ShoesItemExample;
import net.hncu.onlineShoes.domain.ShoesItemMapper;
import net.hncu.onlineShoes.domain.User;
import net.hncu.onlineShoes.shoes.controller.ShoesController;
import net.hncu.onlineShoes.util.BitUtil;
import net.hncu.onlineShoes.util.Msg;

@RequestMapping("/basket")
@Controller
public class BasketController {
	private static Logger logger = Logger.getLogger(BuyController.class);
	private static final String ROOT = "basket/";
	
	@Autowired
	private ShoesItemMapper shoesItemMapper;
	
	@RequestMapping(path="",method=RequestMethod.GET)
	public String index(HttpSession session, HttpServletRequest request) throws JsonProcessingException {
		User user = UserController.getUser(session);
		initShoppingCar(user);
		List<Map<String, Object>> carInfo = shoesItemMapper.select4ShoppingCar(user.getUserId(), ShoesItem.Flag.ADD);
		ObjectMapper objectMapper = new ObjectMapper();
		request.setAttribute("carInfo", objectMapper.writeValueAsString(carInfo));
		String shoesRoot = ShoesController.getShoesRoot(request.getContextPath());
		request.setAttribute("shoesRoot", shoesRoot);
		return ROOT + "basket";
	}
	
	
	@RequestMapping(path="/add",method=RequestMethod.GET)
	public String add(ShoesItem shoesItem,
			HttpSession session,HttpServletRequest request) {
		User user = (User) session.getAttribute("user");
		if(user == null || user.getUserId() == 0) {
			String referer = request.getHeader("Referer");
			String targetPath = "/";
			if(referer != null) {
				targetPath = referer;
			}
			logger.info("未登录：添加购物车,ip:"+request.getRemoteAddr());
			return "redirect:"+targetPath;
		}
		if(BitUtil.hasBit(user.getFlag(), User.Flag.FREEZE)) { //判断是否冻结
			logger.info("用户已被冻结,userId:"+user.getUserId());
			return "redirect:/";
		}
		shoesItem.setUserId(user.getUserId());
		boolean addToCar = addToCar(shoesItem, user);
		if(!addToCar) {
			return "/";
		}
		return "redirect:/" + ROOT;
	}
	
	private void initShoppingCar(User user) {
		if(user == null || user.getUserId() == 0) {
			logger.info("非法访问");
			return ;
		}
		ShoesItemExample example = new ShoesItemExample();
		example.createCriteria().andUserIdEqualTo(user.getUserId());
		List<ShoesItem> shoppingCar = shoesItemMapper.selectByExample(example);
		user.setShoppingCar(shoppingCar);
	}
	
	private boolean addToCar(ShoesItem shoesItem,User user) {
		if(user == null) {
			return false;
		}
		initShoppingCar(user);
		List<ShoesItem> shoppingCar = user.getShoppingCar();
		if(shoesItem == null || shoppingCar == null) {
			return false;
		}
		shoesItem.setFlag(BitUtil.addBit(shoesItem.getFlag(), ShoesItem.Flag.ADD));
		Iterator<ShoesItem> iterator = shoppingCar.iterator();
		boolean isAdd = true;
		while (iterator.hasNext()) {
			ShoesItem shoesItem2 = (ShoesItem) iterator.next();
			if(shoesItem.equals(shoesItem2)) {
				shoesItem.setAmount(shoesItem.getAmount()+shoesItem2.getAmount());
				int rt = shoesItemMapper.updateByPrimaryKeySelective(shoesItem);
				logger.info("shoesItemMapper  updateByPrimaryKeySelective  rt:" + rt);
				shoesItem2.setAmount(shoesItem.getAmount());
				return true;
			}
		}
		if(isAdd) {
			int rt = shoesItemMapper.insert(shoesItem);
			logger.info("shoesItemMapper  insert  rt:" + rt);
			return true;
		}
		return false;
	}
	
	@RequestMapping(path="/del",method=RequestMethod.GET)
	@ResponseBody
	public Msg del(@RequestParam(value = "shoesId",required=true)Integer shoesId,
			@RequestParam(value = "shoesSizeId",required=true)Integer shoesSizeId,
			HttpSession session,HttpServletRequest request) {
		User user = (User) session.getAttribute("user");
		if(user == null || user.getUserId() == 0) {
			logger.info("未登录：移除购物车,ip:"+request.getRemoteAddr());
			return Msg.fail();
		}
		if(BitUtil.hasBit(user.getFlag(), User.Flag.FREEZE)) { //判断是否冻结
			logger.info("用户已被冻结,userId:"+user.getUserId());
			return Msg.fail();
		}
		ShoesItem record = new ShoesItem();
		record.setUserId(user.getUserId());
		record.setShoesId(shoesId);
		record.setShoesSizeId(shoesSizeId);
		record.setFlag(ShoesItem.Flag.DEL);
		record.setAmount(0);
		int rt = shoesItemMapper.updateByPrimaryKeySelective(record);
		return Msg.success().setInfo("rt:"+rt);
	}
	
}

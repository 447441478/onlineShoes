package net.hncu.onlineShoes.shoes.controller;

import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import net.hncu.onlineShoes.domain.Comment;
import net.hncu.onlineShoes.domain.CommentExample;
import net.hncu.onlineShoes.domain.CommentMapper;
import net.hncu.onlineShoes.domain.OrderDetail;
import net.hncu.onlineShoes.domain.OrderDetailMapper;
import net.hncu.onlineShoes.domain.Shoes;
import net.hncu.onlineShoes.domain.ShoesExample;
import net.hncu.onlineShoes.domain.ShoesMapper;
import net.hncu.onlineShoes.domain.User;
import net.hncu.onlineShoes.shoes.service.CommnetService;
import net.hncu.onlineShoes.shoes.service.ShoesService;
import net.hncu.onlineShoes.user.controller.UserController;
import net.hncu.onlineShoes.util.FileUtil;
import net.hncu.onlineShoes.util.Msg;


@Controller
public class ShoesController {
	
	@Autowired
	private ShoesService shoesService;
	
	@Autowired
	private CommnetService commnetService;
	
	@Autowired
	private OrderDetailMapper orderDetailMapper;
	
	@Autowired
	private CommentMapper commentMapper;
	
	@Autowired
	private ShoesMapper shoesMapper;
	
	@RequestMapping("/home")
	public String home(Model model, HttpServletRequest request) throws JsonProcessingException {
		PageHelper.startPage(0, 8);
		ShoesExample example = new ShoesExample();
		example.createCriteria()
			.andStockOutEqualTo(Shoes.StockOut.UP);
		example.setOrderByClause("online_time desc");
		List<Shoes> shoess = shoesMapper.selectByExample(example);
		PageInfo<Shoes> pageInfo = new PageInfo<>(shoess);
		List<Shoes> newProduct = pageInfo.getList();
		ObjectMapper om = new ObjectMapper();
		model.addAttribute("newProduct", om.writeValueAsString(getViewList(newProduct, request)));
		List<Shoes> hotProduct = shoesMapper.select4HotProduct();
		model.addAttribute("hotProduct", om.writeValueAsString(getViewList(hotProduct, request)));
		
		return "home";
	}
	@RequestMapping("/brand/{brandId}")
	public String brand(@PathVariable Integer brandId, Model model) {
		if(brandId == 0) {
			return "home";
		}
		model.addAttribute("brandId", brandId);
		return "shoesList";
	}
	@RequestMapping(value="/products",method={RequestMethod.GET})
	@ResponseBody
	public Msg products(@RequestParam(defaultValue="-1") int brandId,
			@RequestParam(defaultValue="") String keyWord,
			@RequestParam(defaultValue="1") int currentPage,
			@RequestParam(defaultValue="16") int pageSize,
			HttpServletRequest request) {
			PageInfo<Shoes> pageInfo = null;
			if(brandId != -1) {
				pageInfo = shoesService.getShoesListByBrandIdPaging(brandId,currentPage,pageSize);
			}
			if(!keyWord.isEmpty()) {
				pageInfo = shoesService.getShoesListByKeyWordPaging(keyWord,currentPage,pageSize);
			}
			if(pageInfo == null) {
				return Msg.fail();
			}
			long total = pageInfo.getTotal();
			List<Shoes> list = pageInfo.getList();
		return Msg.success().add("total", total).add("products", getViewList(list,request));
	}
	/**
	 * 把值对象集合转化成前端视图对象集合
	 * @param shoesList
	 * @param request 
	 * @return
	 */
	private List<Map<String,Object>> getViewList(List<Shoes> shoesList, HttpServletRequest request){
		List<Map<String,Object>> res = new ArrayList<>();
		if(shoesList == null) {
			return res;
		}
		String contextPath = request.getContextPath();
		for (Shoes shoes : shoesList) {
			HashMap<String, Object> map = new HashMap<>();
			map.put("imgUrl", FileUtil.PRODUCT_PATH+"/"+shoes.getImgUuid()+shoes.getImgSuffix());
			map.put("jumpUrl",getShoesRoot(contextPath)+shoes.getShoesId());
			map.put("name", shoes.getName());
			map.put("price", shoes.getOutPrice().doubleValue());
			map.put("brandId", shoes.getBrandId());
			double ratio = shoes.getRatio().doubleValue();
			if(100 - ratio > 0) {
				map.put("discountPrice", new BigDecimal(shoes.getOutPrice().doubleValue()*ratio/100).setScale(2,BigDecimal.ROUND_HALF_UP).doubleValue());
				map.put("useDiscount", true);
				map.put("priceStyle", "discounPrice");
			}
			res.add(map);
		}
		return res;
	}
	
	public static String getShoesRoot(String contextPath) {
		return contextPath+"/shoes/";
	}
	
	@RequestMapping(value="/shoes/{id}",method=RequestMethod.GET)
	public String product(@PathVariable Integer id,
			@RequestParam(name="size",defaultValue="-1") Integer shoeSize,
			@RequestParam(name="orderDetailId",defaultValue="-1") Integer orderDetailId,
			Model model) throws JsonProcessingException {
		Shoes shoes = shoesService.getShoesById(id);
		if(shoes == null || shoes.getShoesId() == null) {
			return "redirect:/";
		}
		ObjectMapper mapper = new ObjectMapper();
		model.addAttribute("shoes", shoes);
		model.addAttribute("shoesJson", mapper.writeValueAsString(shoes));
		model.addAttribute("checkShoesSize", shoeSize);
		CommentExample example = new CommentExample();
		example.createCriteria()
				.andShoesIdEqualTo(id)
				.andFlagBitOr(~Comment.Flag.HIDDENT);
		List<Comment> comments = commentMapper.selectByExampleWithBLOBs(example);
		model.addAttribute("comments",  mapper.writeValueAsString(comments));
		boolean canComment = false;
		if(orderDetailId != -1) {
			OrderDetail orderDetail = orderDetailMapper.selectByPrimaryKey(orderDetailId);
			if(orderDetail != null) {
				Integer flag = orderDetail.getFlag();
				canComment = (flag != null && (flag == OrderDetail.Flag.COMPLETE_TRANSACTION || flag == OrderDetail.Flag.ACCEPTED));
			}
		}
		model.addAttribute("canComment", canComment);
		model.addAttribute("orderDetailId", orderDetailId);
		return "shoesDetail";
	}
	@RequestMapping(value="/products/search",method={RequestMethod.GET})
	public String search(@RequestParam(required=true) String keyWord, Model model) throws UnsupportedEncodingException {
		keyWord = URLDecoder.decode(keyWord, "utf-8");
		model.addAttribute("keyWord", keyWord);
		return "shoesList";
	}
	
	@ResponseBody
	@RequestMapping(value="/comment/commit",method=RequestMethod.POST)
	public Msg commitCommnet(Comment comment,
			HttpSession session,
			HttpServletRequest request) {
		User user = UserController.getUser(session);
		comment.setUserId(user.getUserId());
		comment.setUserName(user.getUsername());
		String ip = request.getRemoteHost();
		comment.setIp(ip);
		String res = commnetService.commitComment(comment);
		if(res == null) {
			return Msg.success();
		}
		return Msg.fail().setInfo(res);
	}
	
}

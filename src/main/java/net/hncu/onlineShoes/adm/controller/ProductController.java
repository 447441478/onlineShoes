package net.hncu.onlineShoes.adm.controller;

import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.Arrays;
import java.util.HashMap;
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
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import net.hncu.onlineShoes.comm.SearchField;
import net.hncu.onlineShoes.domain.Comment;
import net.hncu.onlineShoes.domain.CommentExample;
import net.hncu.onlineShoes.domain.CommentExample.Criteria;
import net.hncu.onlineShoes.domain.CommentMapper;
import net.hncu.onlineShoes.domain.Shoes;
import net.hncu.onlineShoes.domain.ShoesSize;
import net.hncu.onlineShoes.domain.User;
import net.hncu.onlineShoes.shoes.service.ShoesService;
import net.hncu.onlineShoes.util.BitUtil;
import net.hncu.onlineShoes.util.DateUtil;
import net.hncu.onlineShoes.util.FileUtil;
import net.hncu.onlineShoes.util.Msg;
import net.hncu.onlineShoes.util.UUIDUtil;

@RequestMapping("/adm/product")
@Controller
public class ProductController {
	private static final String ROOT = "adm/product/";
	private static final Logger logger = Logger.getLogger(ProductController.class);
	@Autowired
	private ShoesService shoesServic;
	
	@Autowired
	private CommentMapper commentMapper;
	
	@RequestMapping(path="/add",method= {RequestMethod.GET})
	public String add() {
		logger.info("进入添加页面");
		return ROOT + "addProduct";
	}
	@RequestMapping(path="/add",method= {RequestMethod.POST})
	@ResponseBody
	public Msg add(String name, Integer brand, Double inPrice, Double outPrice, Double ratio,
			String stock_out, Double[] sizes, Integer[] amounts, MultipartFile img, HttpServletRequest request,HttpSession session) {
		logger.info("添加产品");
		Shoes shoes = getShoes(name, brand, inPrice, outPrice, ratio, stock_out, sizes, amounts, img, request);
		User user = (User) session.getAttribute("user");
		if(shoes == null || user == null) {
			return Msg.fail();
		}
		shoes.setUserId(user.getUserId());
		shoesServic.addShoes(shoes);
		logger.info("产品添加完成");
		return Msg.success();
	}
	private Shoes getShoes(String name, Integer brand, Double inPrice, Double outPrice, Double ratio, String stock_out,
			Double[] sizes, Integer[] amounts, MultipartFile img, HttpServletRequest request) {
		return getShoes(name, brand, inPrice, outPrice, ratio, stock_out, sizes, amounts, null, img, request);
	}
	private Shoes getShoes(String name, Integer brand, Double inPrice, Double outPrice, Double ratio, String stock_out,
			Double[] sizes, Integer[] amounts, Integer[] shoesSizeIds, MultipartFile img, HttpServletRequest request) {
		String imgDir= FileUtil.getProductRootRealPath(request);
		Shoes shoes = new Shoes();
		if(img != null) {
			String imgUuid = UUIDUtil.getImgName();
			String imgName = img.getOriginalFilename();
			String imgSuffix = FileUtil.getImgSuffix(imgName);
			if(imgSuffix == null) {
				return null;
			}
			File file = new File(imgDir,imgUuid+imgSuffix);
			if(file.exists()) {
				return null;
			}
			try {
				img.transferTo(file);
			} catch (IllegalStateException e) {
				e.printStackTrace();
				return null;
			} catch (IOException e) {
				e.printStackTrace();
				return null;
			}
			shoes.setImgUuid(imgUuid);
			shoes.setImgSuffix(imgSuffix);
		}
		
		shoes.setBrandId(brand);
		shoes.setOnlineTime(DateUtil.getCurrentDateTimeString());
		if(inPrice != null)
			shoes.setInPrice(new BigDecimal(inPrice));
		if(outPrice != null)
			shoes.setOutPrice(new BigDecimal(outPrice));
		if(ratio != null)
			shoes.setRatio(new BigDecimal(ratio));
		
		shoes.setStockOut(stock_out);
		shoes.setName(name);
		List<ShoesSize> shoesSizes = shoes.getShoesSizes();
		if(sizes != null && amounts != null) {
			for(int i = 0; i<sizes.length; i++) {
				ShoesSize shoesSize = new ShoesSize();
				if(sizes[i] != null)
					shoesSize.setValue(new BigDecimal(sizes[i]));
				if(amounts[i] != null)
					shoesSize.setAmount(amounts[i]);
				if(shoesSizeIds != null)
					shoesSize.setShoesSizeId(shoesSizeIds[i]);
				shoesSizes.add(shoesSize);
			}
		}
		
		return shoes;
	}
	
	@RequestMapping(path="/manage",method= {RequestMethod.GET})
	public String manege() {
		logger.info("进入管理产品页面");
		return ROOT + "manageProduct";
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
		logger.info("获取产品重要信息");
		User user = (User) session.getAttribute("user");
		if(user == null) {
			return Msg.fail();
		}
		int flag = user.getFlag();
		if( BitUtil.hasBit(flag, User.Flag.SUPER_MANAGER) ) {
			return shoesServic.getAllByCondition(currentPage,pageSize,
					keyWord,orderColum,isDesc,openTime,startTime,endTime)
					.add("keyWord", keyWord)
					.add("openTime", openTime)
					.add("startTime", startTime)
					.add("endTime", endTime);
		}else {
			return shoesServic.getAllByCondition(user.getUserId(),currentPage,pageSize,
					keyWord,orderColum,isDesc,openTime,startTime,endTime)
					.add("keyWord", keyWord)
					.add("openTime", openTime)
					.add("startTime", startTime)
					.add("endTime", endTime);
		}
	}
	
	@RequestMapping(path="/update",method= {RequestMethod.GET})
	public String update(@RequestParam(required=true)Integer shoesId,
			Model model) {
		logger.info("进入修改产品信息页");
		Shoes shoes = shoesServic.getShoesById(shoesId);
		List<ShoesSize> shoesSizes = shoes.getShoesSizes();
		ObjectMapper mapper = new ObjectMapper();
		String sizeAndAmounts = "[]";
		try {
			sizeAndAmounts = mapper.writeValueAsString(shoesSizes);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		model.addAttribute("shoes", shoes);
		model.addAttribute("sizeAndAmounts", sizeAndAmounts);
		model.addAttribute("productImgRoot", FileUtil.PRODUCT_PATH);
		
		return ROOT + "addProduct";
	}
	
	@RequestMapping(path="/update",method=RequestMethod.POST)
	@ResponseBody
	public Msg put(@RequestParam(required=true) Integer shoesId, 
			String name, Integer brand, Double inPrice, Double outPrice, Double ratio,
			String stock_out, Double[] sizes, Integer[] amounts, MultipartFile img,
			@RequestParam(name="shoesSizeId",required=false)Integer[] shoesSizeIds,HttpServletRequest request) {
		logger.info("更新产品信息");
		Shoes shoes = getShoes(name, brand, inPrice, outPrice, ratio, stock_out, sizes, amounts,shoesSizeIds ,img, request);
		shoes.setShoesId(shoesId); //补充id
		shoes.setOnlineTime(null); //录入时间是不能改的
		String res = shoesServic.updateShoes(shoes);
		logger.info("更新产品信息 - 完成");
		return Msg.success().setInfo(res);
	}
	@RequestMapping(path="/del",method=RequestMethod.POST)
	@ResponseBody
	public Msg put(@RequestParam(required=true,name="shoesIds[]") Integer[] shoesIds) {
		logger.info("删除产品");
		String res = shoesServic.deleteShoes(shoesIds);
		return Msg.success().setInfo(res);
	}
	
	@RequestMapping(path="/manegeComment", method=RequestMethod.GET)
	public String manageComment(HttpSession session, Model model) throws IOException {
		User user = (User) session.getAttribute("user");
		
		Integer userId = user.getUserId();
		PageInfo<Comment> pageInfo = getCommentPageInfo(userId, 1, 10, null, null, false, false, 0L, 0L);
		List<Comment> comments = pageInfo.getList();
		ObjectMapper om = new ObjectMapper();
		model.addAttribute("comments", om.writeValueAsString(comments));
		model.addAttribute("total", pageInfo.getTotal());
		return ROOT + "manegeComment";
	}
	
	@ResponseBody
	@RequestMapping(path="/getComment", method=RequestMethod.GET)
	public Msg getComment(@RequestParam(defaultValue="1") Integer currentPage, 
			@RequestParam(defaultValue="10") Integer pageSize, 
			@RequestParam(defaultValue="") String orderColum,
			@RequestParam(defaultValue="false") Boolean isDesc,
			@RequestParam(defaultValue="") String keyWord,
			@RequestParam(defaultValue="false")Boolean openTime,
			@RequestParam(defaultValue="0") Long startTime,
			@RequestParam(defaultValue="0") Long endTime,
			HttpSession session) throws IOException {
		User user = (User) session.getAttribute("user");
		Integer userId = user.getUserId();
		PageInfo<Comment> pageInfo = getCommentPageInfo(userId, currentPage, pageSize, keyWord, orderColum, isDesc, openTime, startTime, endTime);
		return Msg.success()
				.add("keyWord", keyWord)
				.add("openTime", openTime)
				.add("startTime", startTime)
				.add("endTime", endTime)
				.add("total", pageInfo.getTotal())
				.add("comments", pageInfo.getList());
	}
	
	private PageInfo<Comment> getCommentPageInfo(Integer userId,Integer currentPage, Integer pageSize,
			String keyWord, String orderFiled, Boolean isDesc,
			Boolean openTime, Long startTime, Long endTime){
		Map<String, Object> args = new HashMap<String, Object>();
		if(userId != null) {
			args.put("user_id", userId);
		}
		if(currentPage == null) {
			currentPage = 1;
		}
		if(pageSize == null) {
			pageSize = 10;
		}
		if(keyWord != null && !"".equals(keyWord.trim())) {
			args.put("shoes_name", keyWord);
		}
		String orderByField = SearchField.CommentDef.getOrderByField(orderFiled, isDesc);
		args.put("orderByField", orderByField);
		if(openTime && DateUtil.isBefore(startTime, endTime)) {
			args.put("openTime", openTime);
			args.put("startTime", DateUtil.getDayFirstSeconds(startTime));
			args.put("endTime", DateUtil.getDayLastSeconds(endTime));
		}
		PageHelper.startPage(currentPage, pageSize);
		List<Comment> comments = commentMapper.select4Manage(args);
		PageInfo<Comment> pageInfo = new PageInfo<>(comments);
		return pageInfo;
	}
	
	@ResponseBody
	@RequestMapping(path="/updateComment", method=RequestMethod.POST)
	public Msg updateComment(@RequestParam(name="commentIds[]", required=true) Integer[] commentIds, 
			@RequestParam(name="public", defaultValue="false") Boolean isPublic,
			@RequestParam(name="hidden", defaultValue="false") Boolean isHidden,
			HttpSession session) {
		if(commentIds.length < 1) 
			return Msg.fail();
		CommentExample example = new CommentExample();
		Criteria criteria = example.createCriteria();
		Comment comment = new Comment();
		if(isPublic) {
			comment.setFlag(Comment.Flag.PUBLIC);
		}
		if(isHidden) {
			comment.setFlag(Comment.Flag.HIDDENT);
		}
		criteria.andCommentIdIn(Arrays.asList(commentIds));
		commentMapper.updateByExampleSelective(comment, example);
		return Msg.success();
	}
}

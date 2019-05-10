package net.hncu.onlineShoes.shoes.controller;

import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

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
import com.github.pagehelper.PageInfo;

import net.hncu.onlineShoes.domain.Shoes;
import net.hncu.onlineShoes.shoes.service.ShoesService;
import net.hncu.onlineShoes.util.FileUtil;
import net.hncu.onlineShoes.util.Msg;


@Controller
public class ShoesController {
	
	@Autowired
	private ShoesService shoesService;
	
	@RequestMapping("/home")
	public String home() {
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
			System.out.println(keyWord);
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
	public String product(@PathVariable Integer id,@RequestParam(name="size",defaultValue="-1") Integer shoeSize,Model model) throws JsonProcessingException {
		Shoes shoes = shoesService.getShoesById(id);
		ObjectMapper mapper = new ObjectMapper();
		model.addAttribute("shoes", shoes);
		model.addAttribute("shoesJson", mapper.writeValueAsString(shoes));
		model.addAttribute("checkShoesSize", shoeSize);
		return "shoesDetail";
	}
	@RequestMapping(value="/products/search",method={RequestMethod.GET})
	public String search(@RequestParam(required=true) String keyWord, Model model) throws UnsupportedEncodingException {
		keyWord = URLDecoder.decode(keyWord, "utf-8");
		model.addAttribute("keyWord", keyWord);
		return "shoesList";
	}
	
}

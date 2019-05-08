package net.hncu.onlineShoes.shoes.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import net.hncu.onlineShoes.domain.Brand;
import net.hncu.onlineShoes.shoes.service.BrandService;
import net.hncu.onlineShoes.util.Msg;

@Controller
public class BrandController {
	@Autowired
	@Qualifier("brandService")
	BrandService brandService;
	
	@RequestMapping("/brands")
	@ResponseBody
	public Msg getBrands() {
		List<Brand> brands = brandService.getBrands();
		return Msg.success().add("brands", brands);
	}
}

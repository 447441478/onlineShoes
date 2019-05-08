package net.hncu.onlineShoes.adm.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@RequestMapping("/adm")
@Controller
public class AdmController {
	private static final String ROOT = "adm/";
	
	@RequestMapping(method={RequestMethod.GET})
	public String home() {
		return ROOT + "admHome";
	}
	
	
}

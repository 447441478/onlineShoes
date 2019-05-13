package net.hncu.onlineShoes.adm.controller;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@RequestMapping("/adm/setting")
@Controller
public class SettingController {
	private static final String ROOT = "adm/setting/";
	private static final Logger LOG = Logger.getLogger(SettingController.class);
	
	@RequestMapping(path="/homeSetting",method= {RequestMethod.GET})
	public String add() {
		return ROOT + "homeSetting";
	}
}

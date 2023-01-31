package com.spring.green2209S_18;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.green2209S_18.service.AdminService;
import com.spring.green2209S_18.service.StoreService;
@Controller
@RequestMapping("/admin")
public class AdminController {
	
	@Autowired
	AdminService adminService;
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	
	@RequestMapping(value = "adminMain", method = RequestMethod.GET)
	public String adminMain() {
		
		return "admin/adminMain";
	}
}

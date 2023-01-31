package com.spring.green2209S_18;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.green2209S_18.service.StoreService;
@Controller
@RequestMapping("/order")
public class OrderController {
	
	@Autowired
	StoreService storeService;
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	
	@RequestMapping(value = "orderCart", method = RequestMethod.GET)
	public String orderCartGet() {
		
		return "order/orderCart";
	}
	@RequestMapping(value = "orderCheckout", method = RequestMethod.GET)
	public String OrderCheckoutGet() {
		
		return "order/orderCheckout";
	}
}

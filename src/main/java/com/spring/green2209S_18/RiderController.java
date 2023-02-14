package com.spring.green2209S_18;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.green2209S_18.dao.RiderDAO;
import com.spring.green2209S_18.service.OrderService;
import com.spring.green2209S_18.service.RiderService;
import com.spring.green2209S_18.vo.CartVO;
@Controller
@RequestMapping("/rider")
public class RiderController {
	
	@Autowired
	OrderService orderService;
	
	@Autowired 
	RiderDAO riderDAO;
//	
	@Autowired
	RiderService riderService;
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	
	@RequestMapping(value = "memgin", method = RequestMethod.GET)
	public String memberLoginGet() {

		return "member/memberLogin";
	}

	
	// 리스트 가져오기
	@ResponseBody
	@RequestMapping(value = "/orderChatList", method = RequestMethod.POST)
	public List<CartVO> memNickCheckPost() {
		
//		List<CartVO> vos = orderDAO.getOrderChatList();
		List<CartVO> vos = riderDAO.getOrderChatList();
		
		return vos;
	}
	
	@RequestMapping(value = "/orderChat", method = RequestMethod.GET)
	public String orderChatGet() {
		
		return "rider/orderChat";
	}
	
}

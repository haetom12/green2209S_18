package com.spring.green2209S_18;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.green2209S_18.service.OrderService;
import com.spring.green2209S_18.service.StoreService;
import com.spring.green2209S_18.vo.FoodMenuVO;
import com.spring.green2209S_18.vo.wishListVO;
@Controller
@RequestMapping("/order")
public class OrderController {
	
	@Autowired
	StoreService storeService;
	
	@Autowired
	OrderService orderService;
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	
	@RequestMapping(value = "/orderCart", method = RequestMethod.GET)
	public String orderCartGet() {
		
		return "order/orderCart";
	}
	@RequestMapping(value = "/orderCheckout", method = RequestMethod.GET)
	public String OrderCheckoutGet() {
		
		return "order/orderCheckout";
	}
	
	@ResponseBody
	@RequestMapping(value = "/wishListInput", method = RequestMethod.POST)
	public String wishListInputPost(String storeName, int menuIdx, HttpSession session) {
		String mid = (String) session.getAttribute("sMid");
		
		int res = 0;
		
		wishListVO vo = orderService.getCheckWishList(storeName,menuIdx, mid);
		
		if(vo == null) {
			res = orderService.setWishListInput(storeName,menuIdx, mid);
			return res+"";
		}
		else return "0";
	}

	@RequestMapping(value = "/myWishList", method = RequestMethod.GET)
	public String myWishListGet(Model model, HttpSession session) {
		String mid = (String) session.getAttribute("sMid");
		
		// 나의 찜목록 가져오기
		List<wishListVO> vos = orderService.getMyWishList(mid);
		// 나의 찜목록에 있는 자료의 정보를 가져와서 담기
		List<FoodMenuVO> wVos = new ArrayList<FoodMenuVO>();
		
		for(int i=0; i<vos.size(); i++) {
			FoodMenuVO vo = orderService.getWishListInfo(vos.get(i).getMenuIdx());
			wVos.add(vo);
		}
//		System.out.println("wVos : " + wVos);
		model.addAttribute("wVos", wVos);
		
		return "order/myWishList";
	}
	
	@ResponseBody
	@RequestMapping(value = "/myWishListDelete", method = RequestMethod.POST)
	public String myWishListDeletePost(HttpSession session, String delItems) {
		String mid = (String) session.getAttribute("sMid");
		
		int res = 0;
		
		delItems = delItems.substring(0, delItems.length()-1);
//		System.out.println("값 : " + delItems);
		String[] menuIdxs = delItems.split("/");
		
		// 가져온 idx를 찜목록에서 삭제시켜준다
		for(int i=0; i<menuIdxs.length; i++) {
			orderService.setDeleteWishList(Integer.parseInt(menuIdxs[i]));
			res = 1;
		}
		return res+"";
	}
	
	@RequestMapping(value = "/myCart", method = RequestMethod.GET)
	public String myCartGet() {
		
		return "order/myCart";
	}
	
	
}

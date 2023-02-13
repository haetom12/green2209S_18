package com.spring.green2209S_18;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.green2209S_18.service.MemberService;
import com.spring.green2209S_18.service.OrderService;
import com.spring.green2209S_18.service.StoreService;
import com.spring.green2209S_18.vo.CartVO;
import com.spring.green2209S_18.vo.FoodMenuVO;
import com.spring.green2209S_18.vo.MemberVO;
import com.spring.green2209S_18.vo.PayMentVO;
import com.spring.green2209S_18.vo.StoreVO;
import com.spring.green2209S_18.vo.wishListVO;
@Controller
@RequestMapping("/order")
public class OrderController {
	
	@Autowired
	StoreService storeService;
	
	@Autowired
	OrderService orderService;
	
	@Autowired
	MemberService memberService;
	
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

	// 내 찜목록
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
	
	// 내 장바구니 리스트 이동
	@RequestMapping(value = "/myCart", method = RequestMethod.GET)
	public String myCartGet(HttpSession session, Model model) {
		String mid = (String) session.getAttribute("sMid");
		
		MemberVO mVo = memberService.getMemberIdCheck(mid);
		
		List<CartVO> vos = memberService.getMyCartList(mid);
		
		if(vos.size() == 0) {
			return "redirect:/msg/cartEmpty";
		}
		
		String storeName = vos.get(0).getStoreName();
		
		StoreVO sVo = storeService.getstoreInfo(storeName);
		
		model.addAttribute("mVo", mVo);
		model.addAttribute("sVo", sVo);
		model.addAttribute("vos", vos);
		return "order/myCart";
	}
	
	// 장바구니에 추가
	@RequestMapping(value = "/addCart", method = RequestMethod.POST)
	public String addCartPost(CartVO vo ,HttpSession session, String flag) {
		
		String mid = (String) session.getAttribute("sMid");
		List<CartVO> cVos = memberService.getMyCartList(mid);
		
		if(cVos.size() == 0) {
			orderService.setAddCartInput(vo);
			List<CartVO> vos = memberService.getMyCartList(mid);
			int myCartCnt = vos.size();
			
			session.setAttribute("myCartCnt", myCartCnt);
			
			session.setAttribute("cartStore", vo.getStoreName());
			
			if(flag.equals("order")) {
				return "redirect:/msg/cartOrderOk";
			}
			else {
				return "redirect:/msg/cartInputOk?menuIdx="+vo.getMenuIdx();
			}
		}
		else {
			if(!cVos.get(0).getStoreName().equals(vo.getStoreName())) {
				return "redirect:/msg/cartStoreNo?menuIdx="+vo.getMenuIdx();
			}
			else {
				orderService.setAddCartInput(vo);
				List<CartVO> vos = memberService.getMyCartList(mid);
				int myCartCnt = vos.size();
				
				session.setAttribute("myCartCnt", myCartCnt);
				
				session.setAttribute("cartStore", vo.getStoreName());
				
				if(flag.equals("order")) {
					return "redirect:/msg/cartOrderOk";
				}
				else {
					return "redirect:/msg/cartInputOk?menuIdx="+vo.getMenuIdx();
				}
			}
		}
	}
	
	// 장바구니에 선택 목록 삭제
	@ResponseBody
	@RequestMapping(value = "/myCartDelete", method = RequestMethod.POST)
	public String myCartDeletePost(int idx, HttpSession session) {
		
		orderService.myCartDelete(idx);
		
		String mid = (String) session.getAttribute("sMid");
		
		List<CartVO> vos = memberService.getMyCartList(mid);
		int myCartCnt = vos.size();
		
		session.setAttribute("myCartCnt", myCartCnt);
		
		return "";
	}
	
	
	// 카트에 담겨있는 품목들중에서, 주문한 품목들을 읽어와서 세션에 담아준다. 이때 고객의 정보도 함께 처리하며, 주문번호를 만들어서 다음단계인 '결재'로 넘겨준다.
	@RequestMapping(value = "/myCart", method = RequestMethod.POST)
	public String dbCartListPost(HttpServletRequest request, Model model, HttpSession session, CartVO vo,
			@RequestParam(name="baesong", defaultValue = "0", required = false) int baesong) {
		String mid = session.getAttribute("sMid").toString();
		
		
		// 주문한 상품에 대하여 '고유번호'를 만들어준다.
		// 고유주문번호(idx) = 기존에 존재하는 주문테이블의 고유번호 + 1
		CartVO maxIdx = orderService.getOrderMaxIdx();
		int idx = 1;
		if(maxIdx != null) idx = maxIdx.getMaxIdx() + 1;
		
		Date today = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		String orderIdx = sdf.format(today) + idx;
				
		// 장바구니에서 구매를 위해 선택한 모든 항목들은 배열로 넘어온다.
		String[] idxChecked = request.getParameterValues("idxChecked");
		
		CartVO cartVo = new CartVO();
		List<CartVO> orderVos = new ArrayList<CartVO>();
		
		for(String strIdx : idxChecked) {
			cartVo = orderService.getCartIdx(Integer.parseInt(strIdx));
			CartVO orderVo = new CartVO();
			orderVo.setIdx(cartVo.getIdx());
			orderVo.setMenuIdx(cartVo.getMenuIdx());
			orderVo.setFoodName(cartVo.getFoodName());
			orderVo.setMainPrice(cartVo.getMainPrice());
			orderVo.setThumbImg(cartVo.getThumbImg());
			orderVo.setSubMenuName(cartVo.getSubMenuName());
			orderVo.setOptionPrice(cartVo.getOptionPrice());
			orderVo.setOptionNum(cartVo.getOptionNum());
			orderVo.setTotalPrice(cartVo.getTotalPrice());
			orderVo.setCartIdx(cartVo.getIdx());
			orderVo.setBaesong(baesong);
			
			orderVo.setOrderIdx(orderIdx);	// 관리자가 만들어준 '주문고유번호'를 저장
			orderVo.setMid(mid);						// 로그인한 아이디를 저장한다.
			
			orderVos.add(orderVo);
		}
		String orderTotalPrice = vo.getOrderTotalPrice();
		
		String intTotal = orderTotalPrice.replace(",", "");
		
		int su = Integer.parseInt(intTotal);
		
		session.setAttribute("sOrderVos", orderVos);
		
		// 배송처리를 위한 현재 로그인한 아이디에 해당하는 고객의 정보를 member2테이블에서 가져온다.
		MemberVO memberVo = memberService.getMemberIdCheck(mid);
		String[] address = memberVo.getAddress().split("/");
		String address1 = address[0];
		String address2 = address[1];
		
		model.addAttribute("orderVos", orderVos);
		model.addAttribute("orderTotalPrice", orderTotalPrice);
		model.addAttribute("baesong", baesong);
		model.addAttribute("su", su);
		model.addAttribute("memberVo", memberVo);
		model.addAttribute("address1", address1);
		model.addAttribute("address2", address2);
		
		return "order/orderCheck";
	}
	
  // 결제시스템 연습하기(결제창 호출하기) - API이용
	@Transactional
	@RequestMapping(value="/payment", method=RequestMethod.POST)
	public String paymentPost(PayMentVO payMentVo,CartVO orderVO, HttpSession session, Model model) {
		model.addAttribute("payMentVo", payMentVo);
		
		String amount = payMentVo.getAmount().replace(",", "");
		amount = amount.substring(0,amount.length()-1);
		session.setAttribute("sOrderAddress", orderVO.getOrderAddress());
		
		System.out.println(amount);
		
		int price = 0;
		
		price = Integer.parseInt(amount);
		
		session.setAttribute("sPayMentVo", payMentVo);
		session.setAttribute("orderMessage", payMentVo.getOrderMessage());
		model.addAttribute("price", price);
		
		return "order/paymentOk";
	}
	
	@Transactional
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/paymentResult", method=RequestMethod.GET)
	public String paymentResultGet(HttpSession session, PayMentVO receivePayMentVo, Model model) {
		// 주문내역 dbOrder/dbBaesong 테이블에 저장하기(앞에서 저장했던 세션에서 가져왔다.)
		List<CartVO> orderVos = (List<CartVO>) session.getAttribute("sOrderVos");
		PayMentVO payMentVo = (PayMentVO) session.getAttribute("sPayMentVo");
		
		String orderMessage = (String) session.getAttribute("orderMessage");
		String orderTotalPrice2 = payMentVo.getAmount().substring(0,payMentVo.getAmount().length()-1);
		orderTotalPrice2 = orderTotalPrice2.replace(",", "");
		int orderTotalPrice = Integer.parseInt(orderTotalPrice2);
		
//		int orderTotalPrice = Integer.parseInt(payMentVo.getAmount().replace(",", "").substring(0,payMentVo.getAmount().length()-1));
		
//		int orderTotalPrice = Integer.parseInt(payMentVo.getAmount());
		
//		사용된 세션은 반환한다.
//		session.removeAttribute("sOrderVos");
//		session.removeAttribute("sPayMentVo");
		
		String sOrderAddress = (String) session.getAttribute("sOrderAddress");
		
		for(CartVO vo : orderVos) {
			CartVO checkVo = orderService.getCheckOrderIdx(vo.getOrderIdx());
			
			System.out.println("idx : " + vo.getOrderIdx());
			
			if(checkVo==null) {
				vo.setOrderIdx(vo.getOrderIdx());        				// 주문번호를 주문테이블의 주문번호필드에 지정처리한다.
				vo.setMid(vo.getMid());			
				vo.setOrderAddress(sOrderAddress);
				vo.setOrderTotalPrice2(orderTotalPrice);
			  vo.setOrderMessage(orderMessage);
				orderService.setFoodOrderOK(vo);                 	// 주문내용을 주문테이블(dbOrder)에 저장.
			}
			else {
				vo.setOrderIdx(vo.getOrderIdx());        				// 주문번호를 주문테이블의 주문번호필드에 지정처리한다.
				vo.setMid(vo.getMid());			
				vo.setOrderAddress(sOrderAddress);
				vo.setOrderTotalPrice2(orderTotalPrice);
				vo.setOrderMessage(orderMessage);
				orderService.setFoodOrderOk2(vo);
			}
			
//		사용된 세션은 반환한다.
			session.removeAttribute("sOrderVos");
			session.removeAttribute("sPayMentVo");
			session.removeAttribute("orderMessage");
			session.removeAttribute("sOrderAddress");
		
			
			orderService.myCartDelete(vo.getIdx()); // 주문이 완료되었기에 장바구니(dbCart)테이블에서 주문한 내역을 삭체처리한다.
			
			// 장바구니 숫자 다시 최신화
			String mid = (String) session.getAttribute("sMid");
			List<CartVO> vos = memberService.getMyCartList(mid);
			int myCartCnt = vos.size();
			session.setAttribute("myCartCnt", myCartCnt);
			
		}
		
		payMentVo.setImp_uid(receivePayMentVo.getImp_uid());
		payMentVo.setMerchant_uid(receivePayMentVo.getMerchant_uid());
		payMentVo.setPaid_amount(receivePayMentVo.getPaid_amount());
		payMentVo.setApply_num(receivePayMentVo.getApply_num());
		
		// 오늘 주문에 들어간 정보들을 확인해주기위해 다시 session에 담아서 넘겨주고 있다.
//		model.addAttribute("orderVos", orderVos);
//		model.addAttribute("payMentVo", payMentVo);
//		model.addAttribute("orderTotalPrice", baesongVo.getOrderTotalPrice());
//		session.setAttribute("sOrderVos", orderVos);
		session.setAttribute("sPayMentVo", payMentVo);
		
//		return "dbShop/paymentResult";
		return "redirect:/msg/paymentResultOk";
	}
	
	
}
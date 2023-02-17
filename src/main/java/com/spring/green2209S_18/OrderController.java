package com.spring.green2209S_18;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.spring.green2209S_18.pagenation.PageProcess;
import com.spring.green2209S_18.pagenation.PageVO;
import com.spring.green2209S_18.service.MemberService;
import com.spring.green2209S_18.service.OrderService;
import com.spring.green2209S_18.service.StoreService;
import com.spring.green2209S_18.vo.CartVO;
import com.spring.green2209S_18.vo.CouponVO;
import com.spring.green2209S_18.vo.FoodMenuVO;
import com.spring.green2209S_18.vo.MemberVO;
import com.spring.green2209S_18.vo.PayMentVO;
import com.spring.green2209S_18.vo.RatingVO;
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
	
	@Autowired
	PageProcess pageProcess;
	
	@Autowired
	JavaMailSender mailSender;
	
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
			orderVo.setStoreName(cartVo.getStoreName());
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
	@SuppressWarnings("unchecked")
	@Transactional
	@RequestMapping(value="/payment", method=RequestMethod.POST)
	public String paymentPost(PayMentVO payMentVo,CartVO orderVO, HttpSession session, Model model,
		@RequestParam(name="couponName", defaultValue = "", required = false) String couponName) {
		model.addAttribute("payMentVo", payMentVo);
		
		if(!couponName.equals("")) {
			session.setAttribute("sCouponName", couponName);
			System.out.println("넘긴쿠폰 : " + couponName);
		}
		
		
		String amount = payMentVo.getAmount().replace(",", "");
		amount = amount.substring(0,amount.length()-1);
		session.setAttribute("sOrderAddress", orderVO.getOrderAddress());
		
		System.out.println(amount);
		
		int price = 0;
		
		price = Integer.parseInt(amount);
		List<CartVO> orderVos = (List<CartVO>) session.getAttribute("sOrderVos");
		
		
		String food = "";
		
		for(int i=0; i<orderVos.size(); i++) {
			food += orderVos.get(i).getFoodName() + " / ";
		}
		food = orderVos.get(0).getOrderIdx() + "@" + orderVos.get(0).getMid() + "@" + food.substring(0, food.length()-1) + "@" 
					+ orderVos.get(0).getStoreName() + "@" +  price + "@" + orderVos.get(0).getOrderMessage();
		
//		System.out.println("vos : " + orderVos);
		
		session.setAttribute("sPayMentVo", payMentVo);
		session.setAttribute("orderMessage", payMentVo.getOrderMessage());
		model.addAttribute("price", price);
		model.addAttribute("orderVos", orderVos);
		model.addAttribute("food", food);
		
		return "order/paymentOk";
	}
	
	
	@Transactional
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/paymentResult", method=RequestMethod.GET)
	public String paymentResultGet(HttpSession session,HttpServletRequest request, PayMentVO receivePayMentVo, Model model) {
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
				vo.setOrderIdx(vo.getOrderIdx());        				// 남은 메뉴는 처음 메뉴에 / 붙혀서 업데이트
				vo.setMid(vo.getMid());			
				orderService.setFoodOrderOk2(vo);
			}
			
//		사용된 세션은 반환한다.
			session.removeAttribute("sOrderVos");
			session.removeAttribute("sPayMentVo");
			session.removeAttribute("orderMessage");
			session.removeAttribute("sOrderAddress");
			
			orderService.myCartDelete(vo.getIdx()); // 주문이 완료되었기에 장바구니(dbCart)테이블에서 주문한 내역을 삭체처리한다.
		}
		
		// 장바구니 숫자 다시 최신화
		String mid = (String) session.getAttribute("sMid");
		List<CartVO> vos = memberService.getMyCartList(mid);
		int myCartCnt = vos.size();
		session.setAttribute("myCartCnt", myCartCnt);
		
		// 배달횟수 1 증가
		memberService.setOrderCntUpdate(mid);
		
//		// 배달 테이블에 입력한다.
//		String foodMenu = "";
//		for(int i=0; i<orderVos.size(); i++) {
//			foodMenu += orderVos.get(i).getFoodName() + "/";
//		}
//		foodMenu = foodMenu.substring(0,foodMenu.length()-1);
//		
//		WebSocketDbVO orderVo = new WebSocketDbVO();
//		orderVo.setMid(orderVos.get(0).getMid());
//		orderVo.setFoodMenu(foodMenu);
//		orderVo.setAddress(orderVos.get(0).getOrderAddress());
//		orderVo.setPrice(orderTotalPrice);
//		
//		orderService.setRiderOrder(orderVo);
//		session.setAttribute("sOrderVo", orderVo);
		
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
		MemberVO mVo = memberService.getMemberIdCheck(mid);
    
    String sCouponName = (String)session.getAttribute("sCouponName");
    
    System.out.println("세션 쿠폰 : " + sCouponName);
    
    if(sCouponName != null) {
    	orderService.setCouponUsed(sCouponName, mid);
    }
		
		if(mVo.getOrderCnt() % 10 == 0) {
			
			String realPath = request.getSession().getServletContext().getRealPath("/resources/data/qrCode/");
			CouponVO pVo = new CouponVO();
			
			int discount = 0;
			
			int randomVal = (int)(Math.random() * 10) + 1;
			
			if(randomVal < 6) discount = 5000;
			else if(randomVal < 9 && randomVal >= 6) discount = 7000;
			else if(randomVal >= 9) discount = 9000;
			
			
			Calendar cal = Calendar.getInstance();
	    cal.setTime(new Date());
	    DateFormat df = new SimpleDateFormat("yyyy-MM-dd");

	    cal.add(Calendar.MONTH, 1);
	    String expiration = df.format(cal.getTime());
			
	    UUID uid = UUID.randomUUID(); // 기본 32글자
	    
	    String couponName = uid.toString().substring(0,8);
	    
			String qrCode = orderService.qrCreate(mVo.getMemberNickName(),couponName, discount, expiration, realPath);
			
			pVo.setOrderIdx(orderVos.get(0).getOrderIdx());
			pVo.setMid(mid);
			pVo.setQrCode(qrCode);
			pVo.setCouponName(couponName);
			pVo.setDiscount(discount);
			pVo.setExpiration(expiration);
			
			orderService.setCouponInput(pVo);
			
			
			// 메일로 qr 코드 보내기
			
			String toMail = mVo.getEmail();
	    String title = "[저기요] 이벤트 쿠폰 발급";
	    String content = "";
			
	    try {
				// 메일을 전송하기 위한 객체 : MimeMessage() , MimeMessageHelper()
				MimeMessage message = mailSender.createMimeMessage(); // 타입변환
				MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8"); //보관함에 저장하는곳
				
				messageHelper.setTo(toMail);
				messageHelper.setSubject(title);
				messageHelper.setText(content);
				
				content = content.replace("\n", "<br/>");
				content += "<br>메일 인증번호입니다<br/>";
				content += " 이용해주셔서 감사합니다! 첨부파일을 확인해주세요! ";
				content += "<hr>";
				
				// 메일보관함에 회원이 보내온 메세지들을 모두 저장시킨다.
				messageHelper.setText(content);
				
			// file = new FileSystemResource(request.getRealPath("/resources/images/paris.jpg"));
				FileSystemResource file = new FileSystemResource(request.getSession().getServletContext().getRealPath("/resources/data/qrCode/"+qrCode));
				messageHelper.addAttachment(qrCode, file);
				
				// 메일 전송하기
				mailSender.send(message);
			} catch (MessagingException e) {
				e.printStackTrace();
			}
			return "redirect:/msg/paymentResultOkAndCoupon";
		}
		return "redirect:/msg/paymentResultOk";
	}
	
	@RequestMapping(value = "/orderChat", method = RequestMethod.GET)
	public String orderChatGet() {
		
		return "rider/orderChat";
	}
	
	@RequestMapping(value = "/ratingInput", method = RequestMethod.GET)
	public String ratingInputGet(String orderIdx, Model model) {
		CartVO vo = memberService.getMyOrderInfo(orderIdx);
		
		model.addAttribute("vo", vo);
		return "order/ratingInput";
	}
	
  //관리자 상품등록에서 상품 작성시, ckeditor에서 글올릴때 이미지와 함께 올린다면 이곳에서 서버 파일시스템에 저장시켜준다.
	@ResponseBody
	@RequestMapping("/imageUpload")
	public void imageUploadGet(HttpServletRequest request, HttpServletResponse response, @RequestParam MultipartFile upload) throws Exception {
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		String originalFilename = upload.getOriginalFilename();
		
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmss");
		originalFilename = sdf.format(date) + "_" + originalFilename;
		
		byte[] bytes = upload.getBytes();
		
		// ckeditor에서 올린 파일을 서버 파일시스템에 저장시켜준다.
		String uploadPath = request.getSession().getServletContext().getRealPath("/resources/data/ckeditor/");
		OutputStream outStr = new FileOutputStream(new File(uploadPath + originalFilename));
		outStr.write(bytes);		// 서버에 업로드시킨 그림파일이 저장된다.
		
		// 서버 파일시스템에 저장된 파일을 화면(textarea)에 출력하기
		PrintWriter out = response.getWriter();
		String fileUrl = request.getContextPath() + "/data/ckeditor/" + originalFilename;
		out.println("{\"originalFilename\":\""+originalFilename+"\",\"uploaded\":1,\"url\":\""+fileUrl+"\"}");       /* "atom":"12.jpg","uploaded":1,"": */
		
		out.flush();
		outStr.close();
	}
	
	@Transactional
	@RequestMapping(value = "/ratingInput", method = RequestMethod.POST)
	public String ratingInputPost(MultipartFile file, RatingVO vo) {
		// content에 이미지가 저장되어 있다면, 저장된 이미지만 골라서 /resources/data/board/폴더에 저장시켜준다.
		orderService.imgCheck(vo.getContent());
		
		// 이미지 복사작업이 끝나면, board폴더에 실제로 저장된 파일명을 DB에 저장시켜준다. [/resources/data/board/ == >>/resources/data/board/]
		
		System.out.println("vo" + vo);
		
		vo.setContent(vo.getContent().replace("/data/ckeditor/","/data/ckeditor/rating/"));
		int res = orderService.setRatingInput(vo); // 성공하면 1넘어옴
		orderService.setRaingInputOk(vo.getOrderIdx());
		
		if(res == 1) return "redirect:/msg/ratingInputOk";
		else return "redirect:/msg/ratingInputNo";
	}
	
	// 쿠폰 확인 후 적용
	@ResponseBody
	@RequestMapping(value = "/myCouponCheck", method = RequestMethod.POST)
	public String myCouponCheckPost(String couponName, HttpSession session) {
		
		String mid = (String) session.getAttribute("sMid");

		CouponVO vo = orderService.getCheckCoupon(couponName, mid);
		
		System.out.println("쿠폰은 : " + vo);
		
		if(vo==null) return "0";
		
		int sale = vo.getDiscount();
		
		return sale+"";
	}
	
	// 내 쿠폰 리스트 폼으로 이동
	@RequestMapping(value = "/myCouponList", method = RequestMethod.GET)
	public String myCouponListGet(HttpSession session, Model model,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize) {
		
		String mid = (String) session.getAttribute("sMid");
		
		// 해당 가게의 평점 총 갯수 구하기
		PageVO pageVo = pageProcess.totRecCnt(pag, pageSize, "qrCode", mid, "");

		List<CouponVO> vos = memberService.getMyCouponList(pageVo.getStartIndexNo(), pageSize, mid);
		
		model.addAttribute("pageVo",pageVo);
		model.addAttribute("vos",vos);
		
		return "order/myCouponList";
	}
	
}
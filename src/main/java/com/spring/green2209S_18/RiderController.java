package com.spring.green2209S_18;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.green2209S_18.dao.RiderDAO;
import com.spring.green2209S_18.service.OrderService;
import com.spring.green2209S_18.service.RiderService;
import com.spring.green2209S_18.service.StoreService;
import com.spring.green2209S_18.vo.CartVO;
import com.spring.green2209S_18.vo.RiderVO;
import com.spring.green2209S_18.vo.StoreVO;
@Controller
@RequestMapping("/rider")
public class RiderController {
	
	@Autowired
	StoreService storeService;
	
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

	// 라이더 아이디 체크
	@ResponseBody
	@RequestMapping(value = "/riderIdCheck", method = RequestMethod.POST)
	public String riderIdCheckPost(String riderMid) {
		
		int res = 0;
		RiderVO vo = riderService.getRiderMidCheck(riderMid);
		if(vo != null) return "1";
		else return res+"";
	}
	
	@RequestMapping(value = "/orderChat", method = RequestMethod.GET)
	public String orderChatGet() {
		return "rider/orderChat";
	}

	@RequestMapping(value = "/riderJoin", method = RequestMethod.GET)
	public String riderJoinGet() {
		return "rider/riderJoin";
	}

	@RequestMapping(value = "/riderJoin", method = RequestMethod.POST)
	public String riderJoinPost(RiderVO vo) {
		// 아이디 체크
		if(riderService.getRiderMidCheck(vo.getRiderMid()) != null) {
			return "redirect:/msg/memberIdCheckNo";
		}
		// 비밀번호 암호화
		vo.setRiderPwd(passwordEncoder.encode(vo.getRiderPwd())); 
		
		int res = riderService.setRiderJoinOk(vo);
		
		if(res == 1) return "redirect:/msg/memberJoinOk"; // 정상처리가 되면 true == 1이 자동으로 넘어옴
		else return "redirect:/msg/memberJoinNo";
		
	}
	
	// 웹소켓DB에서 라이더 선택하기(라이더 선택시 중복방지처리 포함)
	@ResponseBody
	@RequestMapping(value = "/riderOrderCheck", method = RequestMethod.POST, produces="application/text; charset=utf8")
	public String riderOkPost(String idx, String mid, String store, String food, String riderMid) {
		System.out.println("idx : " + idx);
		System.out.println("mid : " + mid);
		System.out.println("store : " + store);
		System.out.println("food : " + food);
		System.out.println("riderMid : " + riderMid);
		
		
		CartVO vo = riderService.getRiderCheck(idx,"주문완료");
		List<CartVO> vos = riderService.getRiderOrderList(riderMid, "배달채택");
		
		if(vos.size() != 0) return "1";
		else if(vo == null) return "";
		
		riderService.setUpdateRider(idx,riderMid,"배달채택",mid,store);
		
		// 업데이트된 정보 가져가기
		CartVO nVo = orderService.getCheckOrderIdx(idx);
		return idx+"_"+riderMid+"_"+nVo.getCheckStr();
	}
	
	
	@RequestMapping(value = "/riderMain", method = RequestMethod.GET)
	public String riderMainGet(HttpSession session, Model model) {
		String rider = (String) session.getAttribute("sMid");
		
		List<CartVO> vos = riderService.getRiderOrderList(rider, "배달채택");
		
//		System.out.println("vos : " + vos);
		if(vos.size() != 0) {
			StoreVO vo = storeService.getstoreInfo(vos.get(0).getStoreName());
		
			model.addAttribute("vo",vo);
		}
		model.addAttribute("vos",vos);
		model.addAttribute("vSize",vos.size());
		return "rider/riderMain";
	}
	
	// 라이더 배달 확정
	@ResponseBody
	@RequestMapping(value = "/riderOrderConfirm", method = RequestMethod.POST)
	public String riderOrderConfirmPost(String orderIdx) {
		
		int res = 0;
		res = riderDAO.setRiderOrderConfirm(orderIdx);
		return res+"";
	}
	
}

package com.spring.green2209S_18;

import java.util.List;
import java.util.Random;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.PageContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.scheduling.annotation.Async;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.green2209S_18.pagenation.PageProcess;
import com.spring.green2209S_18.pagenation.PageVO;
import com.spring.green2209S_18.service.MemberService;
import com.spring.green2209S_18.service.OrderService;
import com.spring.green2209S_18.service.RiderService;
import com.spring.green2209S_18.service.StoreService;
import com.spring.green2209S_18.vo.CartVO;
import com.spring.green2209S_18.vo.MailVO;
import com.spring.green2209S_18.vo.MemberVO;
import com.spring.green2209S_18.vo.RiderVO;
import com.spring.green2209S_18.vo.StoreVO;
@Controller
@RequestMapping("/member")
public class MemberController {
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	StoreService storeService;
	
	@Autowired
	OrderService orderService;
	
	@Autowired
	RiderService riderService;
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	
	@Autowired
	JavaMailSender mailSender;
	
	@Autowired
	PageProcess pageProcess;
	
	@RequestMapping(value = "memberLogin", method = RequestMethod.GET)
	public String memberLoginGet() {

		return "member/memberLogin";
	}

	@RequestMapping(value = "memberLogin", method = RequestMethod.POST)
	public String memberLoginPost(HttpSession session,String mid, String pwd, String part, Model model) {
		
		// 일반회원 로그인
		if(part.equals("member")) {
			MemberVO vo = memberService.getMemberIdCheck(mid);
			if(vo != null && passwordEncoder.matches(pwd, vo.getPwd()) && vo.getUserDel().equals("NO")) {
				// 회원 인증처리된 경우 수행할 내용? session에 필요한 자료를 저장, 쿠키값처리, 그날 방문자수 1증가(방문포인트도 증가!)
				
				// 장바구니에 있는 리스트, 갯수 가져오기;
				List<CartVO> vos = memberService.getMyCartList(mid);
				int myCartCnt = vos.size();
				
				session.setAttribute("sMid", mid);
				
				session.setAttribute("sNickName", vo.getMemberNickName());
				session.setAttribute("myCartCnt", myCartCnt);
				session.setAttribute("sPart", "member");
				session.setAttribute("sAddress", vo.getAddress());
				session.setAttribute("sNumber", vo.getTel());
				session.setAttribute("sEmail", vo.getEmail());
				model.addAttribute("vo",vo);
				
				return "redirect:/member/memberLoginOk";
			}
			// 로그인 실패
			else {
				return "redirect:/msg/memberLoginNo";
			}
		}
		// 라이더 로그인
		else if(part.equals("rider")) {
			RiderVO vo = riderService.getRiderMidCheck(mid);
			
			if(vo != null && passwordEncoder.matches(pwd, vo.getRiderPwd()) && vo.getDeleteRequest().equals("NO")) {
				// 회원 인증처리된 경우 수행할 내용? session에 필요한 자료를 저장, 쿠키값처리, 그날 방문자수 1증가(방문포인트도 증가!)
				
				session.setAttribute("sMid", mid);
				session.setAttribute("sPart", "rider");
				model.addAttribute("vo",vo);
				
				return "redirect:/rider/riderMain";
			}
			// 로그인 실패
			else {
				return "redirect:/msg/memberLoginNo";
			}
		}
		// 점주 로그인
		else if(part.equals("store")) {
			StoreVO vo = storeService.getStoreIdCheck(mid);
			if(vo != null && passwordEncoder.matches(pwd, vo.getStorePwd()) && vo.getStoreDel().equals("NO")) {
				// 회원 인증처리된 경우 수행할 내용? session에 필요한 자료를 저장, 쿠키값처리, 그날 방문자수 1증가(방문포인트도 증가!)
				
				session.setAttribute("sMid", mid);
				session.setAttribute("sPart", "store");
				session.setAttribute("sbrandName", vo.getStoreName());
				session.setAttribute("sAddress", vo.getStoreAddress());
				session.setAttribute("sNumber", vo.getStoreNumber());
				session.setAttribute("sEmail", vo.getStoreEmail());
				model.addAttribute("vo",vo);
				
				return "redirect:/member/memberLoginOk";
			}
			// 로그인 실패
			else {
				return "redirect:/msg/memberLoginNo";
			}
		}
		
		// 어드민 로그인
		else {
			MemberVO vo = memberService.getMemberIdCheck(mid);
			if(vo != null && passwordEncoder.matches(pwd, vo.getPwd()) && vo.getUserDel().equals("NO")) {
				// 회원 인증처리된 경우 수행할 내용? session에 필요한 자료를 저장, 쿠키값처리, 그날 방문자수 1증가(방문포인트도 증가!)
				
				session.setAttribute("sMid", mid);
				model.addAttribute("vo",vo);
				
				return "redirect:/member/memberLoginOk";
			}
			// 로그인 실패
			else {
				return "redirect:/msg/memberLoginNo";
			}
		}
	}
	
	@RequestMapping(value = "memberLoginOk", method = RequestMethod.GET)
	public String memberLoginOkGet() {
		return "redirect:/h";
	}
	
	@RequestMapping(value = "JoinSelect", method = RequestMethod.GET)
	public String JoinSelectGet() {
		return "member/memberJoinSelect";
	}
	@RequestMapping(value = "memberJoin", method = RequestMethod.GET)
	public String memberJoinGet() {
		return "member/memberJoin";
	}

	// 회원가입처리
	@RequestMapping(value = "memberJoin", method = RequestMethod.POST)
	public String memberJoinPost(MemberVO vo) {
		// 아이디 체크
		if(memberService.getMemberIdCheck(vo.getMid()) != null) {
			return "redirect:/msg/memberIdCheckNo";
		}
		// 비밀번호 암호화
		vo.setPwd(passwordEncoder.encode(vo.getPwd())); 
		
		int res = memberService.setMemberJoinOk(vo);
		
		if(res == 1) return "redirect:/msg/memberJoinOk"; // 정상처리가 되면 true == 1이 자동으로 넘어옴
		else return "redirect:/msg/memberJoinNo";
	}
	
	// 아이디 중복검사
	@ResponseBody
	@RequestMapping(value = "/memIdCheck", method = RequestMethod.POST)
	public String memIdCheckPost(String mid) {
		String res = "1";
		MemberVO vo = memberService.getMemberIdCheck(mid);
		
		if(vo == null) res = "0";
		return res;
	}
	
	// 닉네임 중복검사
	@ResponseBody
	@RequestMapping(value = "/memNickCheck", method = RequestMethod.POST)
	public String memNickCheckPost(String memberNickName) {
		String res = "1";
		MemberVO vo = memberService.getMemberNickCheck(memberNickName);
		
		if(vo == null) res = "0";
		return res;
	}
	
	// 로그아웃
	@RequestMapping(value = "/memberLogout", method = RequestMethod.GET)
	public String adminLogoutGet(HttpSession session) {
//		String mid = (String) session.getAttribute("sMid");
		session.invalidate();
		
		return "redirect:/";
	}
	
	// 내 주문내역 리스트로
	@RequestMapping(value = "myOrderList", method = RequestMethod.GET)
	public String myOrderListGet(HttpSession session, Model model,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "5", required = false) int pageSize) {
		
		String mid = (String) session.getAttribute("sMid");
		
		PageVO pageVo = pageProcess.totRecCnt(pag, pageSize, "memberOderList", mid, "");
		
		
		List<CartVO> vos = orderService.getMyOrderList(mid, pageVo.getStartIndexNo(), pageSize);
		
		
		model.addAttribute("vos",vos);
		model.addAttribute("pageVo",pageVo);
		return "order/myOrderList";
	}
	
	// 내 주문 취소
	@ResponseBody
	@RequestMapping(value = "memberOrderCancle", method = RequestMethod.POST)
	public String memberOrderCancleGet(String orderIdx) {
		
		int res = 0;
		CartVO vo = memberService.getMyOrderInfo(orderIdx);
		
		System.out.println("vo : " + vo);
		
		if(!vo.getProgress().equals("주문완료")) return "0";
		
		res = memberService.setMemberOrderCancle(orderIdx);
		
		return res+"";
	}
	
	// 이메일 인증
	@Async
	@ResponseBody
	@RequestMapping(value = "memberEmailCheck", method = RequestMethod.POST)
	public String memberEmailCheckPost(MailVO vo, String email, HttpSession session) {
		
		int res = 0;
		
		vo.setToMail(email);
		
		Random random = new Random();
    StringBuffer buffer = new StringBuffer();
    int num = 0;

    while(buffer.length() < 10) {
        num = random.nextInt(10);
        buffer.append(num);
    }
    String msg = buffer.toString();
    
    session.setAttribute("sCode", msg);
    
    session.setMaxInactiveInterval(60*5);
    
    String toMail = vo.getToMail();
    String title = "[저기요] 회원가입 메일 인증";
    String content = "";
		
		try {
			// 메일을 전송하기 위한 객체 : MimeMessage() , MimeMessageHelper()
			MimeMessage message = mailSender.createMimeMessage(); // 타입변환
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8"); //보관함에 저장하는곳
			
			// 메일보관함에 회원이 보내온 메세지들을 모두 저장시킨다.
			messageHelper.setTo(toMail);
			messageHelper.setSubject(title);
			messageHelper.setText(content);
			
			content = content.replace("\n", "<br/>");
			content += "<br>메일 인증번호입니다<br/>";
			content += "인증번호 : " + msg;
			content += "<hr>";
			
			// 메일보관함에 회원이 보내온 메세지들을 모두 저장시킨다.
			messageHelper.setText(content);
			
			// 메일 전송하기
			mailSender.send(message);
			res = 1;			
		} catch (MessagingException e) {
			e.printStackTrace();
		}
		return res+"";
	}
	
	// 내 주문내역 리스트로
	@ResponseBody
	@RequestMapping(value = "memberEmailCheckOk", method = RequestMethod.POST)
	public String memberEmailCheckPost(String emailCode, HttpSession session) {
		String res = "1";
		
		String code = (String)session.getAttribute("sCode");
		
		if(!code.equals(emailCode)) return "0";
		
		else return res;
	}
	
	
}

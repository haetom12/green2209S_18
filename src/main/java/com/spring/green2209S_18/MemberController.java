package com.spring.green2209S_18;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Random;
import java.util.UUID;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
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
import com.spring.green2209S_18.vo.CouponVO;
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
	
	@RequestMapping(value = "/memberLogin", method = RequestMethod.GET)
	public String memberLoginGet(HttpServletRequest request) {
		
	// 쿠키 처리
			Cookie[] cookies = request.getCookies();
			for(int i=0; i<cookies.length; i++) {
				if(cookies[i].getName().equals("cMid")) {
					request.setAttribute("mid", cookies[i].getValue());
				}
				if(cookies[i].getName().equals("cPart")) {
					request.setAttribute("part", cookies[i].getValue());
					break;
				}
			}
		
		return "member/memberLogin";
	}

	@RequestMapping(value = "/memberLogin", method = RequestMethod.POST)
	public String memberLoginPost(HttpSession session, HttpServletRequest request, HttpServletResponse response, 
			String mid, String pwd, String part, Model model,
			@RequestParam(name="idCheck", defaultValue = "", required = false) String idCheck) {
		
		System.out.println("id" + idCheck);
		
		// 일반회원 로그인
		if(part.equals("member")) {
			MemberVO vo = memberService.getMemberIdCheck(mid);
			if(vo != null && passwordEncoder.matches(pwd, vo.getPwd()) && vo.getUserDel().equals("NO")) {
				// 회원 인증처리된 경우 수행할 내용?  쿠키값처리 
				
				 if(mid.equals("admin")) {
					 return "redirect:/msg/notAuthorize";
				 }
				
				 else if(idCheck.equals("on")) {
					 	Cookie cookieMid = new Cookie("cMid", mid);
					 	Cookie cookiePart = new Cookie("cPart", part);
						cookieMid.setMaxAge(60*60*24*7);  // 쿠키 만료시간을 7일..
						response.addCookie(cookieMid);
						cookiePart.setMaxAge(60*60*24*7);  // 쿠키 만료시간을 7일..
						response.addCookie(cookiePart);
				 }
				 else {
						Cookie[] cookies = request.getCookies();
						for(int i=0; i<cookies.length; i++) {
							if(cookies[i].getName().equals("cMid")) {
								cookies[i].setMaxAge(0);
								response.addCookie(cookies[i]);
								break;
							}
							if(cookies[i].getName().equals("cPart")) {
								cookies[i].setMaxAge(0);
								response.addCookie(cookies[i]);
								break;
							}
						}
				 }
				 
				
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
				
				 if(idCheck.equals("on")) {
					 	Cookie cookieMid = new Cookie("cMid", mid);
					 	Cookie cookiePart = new Cookie("cPart", part);
						cookieMid.setMaxAge(60*60*24*7);  
						response.addCookie(cookieMid);
						cookiePart.setMaxAge(60*60*24*7);  
						response.addCookie(cookiePart);
				 }
				 else {
						Cookie[] cookies = request.getCookies();
						for(int i=0; i<cookies.length; i++) {
							if(cookies[i].getName().equals("cMid")) {
								cookies[i].setMaxAge(0);
								response.addCookie(cookies[i]);
								break;
							}
							if(cookies[i].getName().equals("cPart")) {
								cookies[i].setMaxAge(0);
								response.addCookie(cookies[i]);
								break;
							}
						}
				 }
				
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
				
				 if(idCheck.equals("on")) {
					 	Cookie cookieMid = new Cookie("cMid", mid);
					 	Cookie cookiePart = new Cookie("cPart", part);
						cookieMid.setMaxAge(60*60*24*7);  // 쿠키 만료시간을 7일..
						response.addCookie(cookieMid);
						cookiePart.setMaxAge(60*60*24*7);  // 쿠키 만료시간을 7일..
						response.addCookie(cookiePart);
				 }
				 else {
						Cookie[] cookies = request.getCookies();
						for(int i=0; i<cookies.length; i++) {
							if(cookies[i].getName().equals("cMid")) {
								cookies[i].setMaxAge(0);
								response.addCookie(cookies[i]);
								break;
							}
							if(cookies[i].getName().equals("cPart")) {
								cookies[i].setMaxAge(0);
								response.addCookie(cookies[i]);
								break;
							}
						}
				 }
				
				session.setAttribute("sMid", mid);
				session.setAttribute("sPart", "store");
				session.setAttribute("sbrandName", vo.getStoreName());
				session.setAttribute("sAddress", vo.getStoreAddress());
				session.setAttribute("sNumber", vo.getStoreNumber());
				session.setAttribute("sEmail", vo.getStoreEmail());
				model.addAttribute("vo",vo);
				
				return "redirect:/h";
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
				
				 if(idCheck.equals("on")) {
					 	Cookie cookieMid = new Cookie("cMid", mid);
						cookieMid.setMaxAge(60*60*24*7);  // 쿠키 만료시간을 7일..
						response.addCookie(cookieMid);
				 }
				 else {
						Cookie[] cookies = request.getCookies();
						for(int i=0; i<cookies.length; i++) {
							if(cookies[i].getName().equals("cMid")) {
								cookies[i].setMaxAge(0);
								response.addCookie(cookies[i]);
								break;
							}
						}
				 }
				
				session.setAttribute("sMid", mid);
				session.setAttribute("sPart", "admin");
				model.addAttribute("vo",vo);
				
				return "redirect:/msg/adminLoginOk";
			}
			// 로그인 실패
			else {
				return "redirect:/msg/memberLoginNo";
			}
		}
	}
	
	@RequestMapping(value = "/memberLoginOk", method = RequestMethod.GET)
	public String memberLoginOkGet() {
		return "redirect:/h";
	}
	
	@RequestMapping(value = "/JoinSelect", method = RequestMethod.GET)
	public String JoinSelectGet() {
		return "member/memberJoinSelect";
	}
	@RequestMapping(value = "/memberJoin", method = RequestMethod.GET)
	public String memberJoinGet() {
		return "member/memberJoin";
	}

	// 회원가입처리
	@RequestMapping(value = "/memberJoin", method = RequestMethod.POST)
	public String memberJoinPost(MemberVO vo, HttpServletRequest request) {
		// 아이디 체크
		if(memberService.getMemberIdCheck(vo.getMid()) != null) {
			return "redirect:/msg/memberIdCheckNo";
		}
		// 비밀번호 암호화
		vo.setPwd(passwordEncoder.encode(vo.getPwd())); 
		int res = memberService.setMemberJoinOk(vo);
		
		// 처음 회원가입 이벤트로 할인 쿠폰 증정
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/qrCode/");
		CouponVO pVo = new CouponVO();
		
		int discount = 3000;
		
		Calendar cal = Calendar.getInstance();
    cal.setTime(new Date());
    DateFormat df = new SimpleDateFormat("yyyy-MM-dd");

    cal.add(Calendar.MONTH, 1);
    String expiration = df.format(cal.getTime());
		
    UUID uid = UUID.randomUUID(); // 기본 32글자
    
    String couponName = uid.toString().substring(0,8);
    
		String qrCode = orderService.qrCreate(vo.getMemberNickName(),couponName, discount, expiration, realPath);
		
		pVo.setOrderIdx(vo.getMid());
		pVo.setMid(vo.getMid());
		pVo.setQrCode(qrCode);
		pVo.setCouponName(couponName);
		pVo.setDiscount(discount);
		pVo.setExpiration(expiration);
		
		orderService.setCouponInput(pVo);
		
		
		// 메일로 qr 코드 보내기
		
		String toMail = vo.getEmail();
    String title = "[저기요] 회원가입을 축하드립니다!";
    String content = "";
		
    try {
			// 메일을 전송하기 위한 객체 : MimeMessage() , MimeMessageHelper()
			MimeMessage message = mailSender.createMimeMessage(); // 타입변환
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8"); //보관함에 저장하는곳
			
			messageHelper.setTo(toMail);
			messageHelper.setSubject(title);
			messageHelper.setText(content);
			
			content = content.replace("\n", "<br/>");
			content += "[이벤트 쿠폰] \n ";
			content += "저기요 회원가입을 진심으로 축하드립니다! \n쿠폰이 발급되었으니 첨부파일을 확인해주세요! ";
			
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
		
		if(res == 1) return "redirect:/msg/memberJoinOk2"; // 정상처리가 되면 true == 1이 자동으로 넘어옴
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
	@RequestMapping(value = "/myOrderList", method = RequestMethod.GET)
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
	@RequestMapping(value = "/memberOrderCancle", method = RequestMethod.POST)
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
	@RequestMapping(value = "/memberEmailCheck", method = RequestMethod.POST)
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
			content += "메일 인증번호입니다<\n>";
			content += "인증번호 : " + msg;
			
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
	
	// 이메일 인증 체크
	@ResponseBody
	@RequestMapping(value = "/memberEmailCheckOk", method = RequestMethod.POST)
	public String memberEmailCheckPost(String emailCode, HttpSession session) {
		String res = "1";
		
		String code = (String)session.getAttribute("sCode");
		
		if(!code.equals(emailCode)) return "0";
		
		else return res;
	}
	
	@RequestMapping(value = "/myPage", method = RequestMethod.GET)
	public String myPageGet(HttpSession session, Model model) {
		String mid = (String)session.getAttribute("sMid");
		
		MemberVO vo = memberService.getMemberIdCheck(mid);
		
		model.addAttribute("vo", vo);
		
		return "member/myPage";
	}
	
	@RequestMapping(value = "/memberUpdate", method = RequestMethod.GET)
	public String memberUpdateGet(HttpSession session, Model model) {
		String mid = (String)session.getAttribute("sMid");
		
		MemberVO vo = memberService.getMemberIdCheck(mid);
		
		String[] address = vo.getAddress().split("/");
		String address1 = address[0];
		String address2 = address[1];
		
		String[] tel = vo.getTel().split("-");
		String tel1 = tel[0];
		String tel2 = tel[1];
		String tel3 = tel[2];
		
		String[] email = vo.getEmail().split("@");
		String email1 = email[0];
		String email2 = email[1];

		model.addAttribute("vo", vo);
		model.addAttribute("address1", address1);
		model.addAttribute("address2", address2);
		model.addAttribute("tel1", tel1);
		model.addAttribute("tel2", tel2);
		model.addAttribute("tel3", tel3);
		model.addAttribute("email1", email1);
		model.addAttribute("email2", email2);
		
		return "member/memberUpdate";
	}
	
	@RequestMapping(value = "/memberUpdate", method = RequestMethod.POST)
	public String memberUpdatePost(MemberVO vo) {
		int res = memberService.setMemberUpdate(vo);
		
		if(res == 1) return "redirect:/msg/memberUpdateOk"; // 정상처리가 되면 true == 1이 자동으로 넘어옴
		else return "redirect:/msg/memberUpdateNo";
	}
	
	@RequestMapping(value = "/memberPwdUpdate", method = RequestMethod.GET)
	public String memberPwdUpdateGet(HttpSession session, Model model) {
		String mid = (String)session.getAttribute("sMid");
		
		MemberVO vo = memberService.getMemberIdCheck(mid);
		
		model.addAttribute("vo", vo);
		
		return "member/memberPwdUpdate";
	}
	
	@RequestMapping(value = "/memberUpdateOk", method = RequestMethod.POST)
	public String memberUpdateOkPost(String pwd, String options, HttpSession session) {
		String mid = (String)session.getAttribute("sMid");
		
		MemberVO vo = memberService.getMemberIdCheck(mid);
		
		if(passwordEncoder.matches(pwd, vo.getPwd())) {
			if(options.equals("mid")) {
				
				return "redirect:/msg/memberPwdCheckOk";
			}
			else {
				return "redirect:/msg/memberPwdCheckOk2";
			}
		}
		else {
			return "redirect:/msg/memberPwdCheckNo";
		}
	}
	
	// 비밀번호 업데이트
	@RequestMapping(value = "/memberPwdUpdate", method = RequestMethod.POST)
	public String memberPwdUpdateGet(String oldPwd, String newPwd, HttpSession session) {
		String mid = (String)session.getAttribute("sMid");
		
		MemberVO vo = memberService.getMemberIdCheck(mid);
		
		if(passwordEncoder.matches(oldPwd, vo.getPwd())) {
			
			newPwd = passwordEncoder.encode(newPwd);
			
			int res = memberService.setMemberPwdUpdate(newPwd , mid);
			
			if(res==1) return "redirect:/msg/memberUpdatePwdOk";
			else return "redirect:/msg/memberUpdatePwdNo";
		}
		else {
			return "redirect:/msg/memberPwdCheckNo2";
		}
	}

	// 회원탈퇴 폼 이동
	@RequestMapping(value = "/memberDelete", method = RequestMethod.GET)
	public String memberDeleteGet(HttpSession session, Model model) {
		String mid = (String)session.getAttribute("sMid");
		
		MemberVO vo = memberService.getMemberIdCheck(mid);
		model.addAttribute("vo", vo);
		
		return "member/memberDelete";
	}
	
	
	// 삭제 전 이메일 인증
	@ResponseBody
	@RequestMapping(value = "/memberDeleteCheck", method = RequestMethod.POST)
	public String memberDeleteCheckPost(String mid, String pwd, HttpSession session) {
		int res = 0;
		
		MemberVO vo = memberService.getMemberIdCheck(mid);
		
		if(vo==null || !passwordEncoder.matches(pwd, vo.getPwd())) {
			return "2";
		}
		
		Random random = new Random();
    StringBuffer buffer = new StringBuffer();
    int num = 0;

    while(buffer.length() < 10) {
        num = random.nextInt(10);
        buffer.append(num);
    }
    String msg = buffer.toString();
    
    session.setAttribute("sCode", msg);
    
    System.out.println("==============================");
    System.out.println("코드는 : " + msg);
    System.out.println("==============================");
    
    session.setMaxInactiveInterval(60*5);
    
    String toMail = vo.getEmail();
    String title = "[저기요] 회원 탈퇴 인증";
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
			content += "메일 인증번호입니다<\n>";
			content += "인증번호 : " + msg;
			
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
	
	// 이메일 인증
	@ResponseBody
	@RequestMapping(value = "/memberDeleteCodeCheck", method = RequestMethod.POST)
	public String memberDeleteCodeCheckPost(String code, HttpSession session) {
		String sCode = (String) session.getAttribute("sCode");
		
		if(sCode.equals(code)) return "1";
		
		else return "2";
	}
	
	// 계정 삭제 처리
	@RequestMapping(value = "/memberDeleteOk", method = RequestMethod.GET)
	public String memberDeleteOkGet(HttpSession session) {
		
		String mid = (String)session.getAttribute("sMid");
		int res = memberService.setMemberDelete(mid);
		
		if(res==1) return "redirect:/msg/riderDeleteOk";
		else return "redirect:/msg/memberDeleteNo";
	}
	
	// 아이디 찾기
	@RequestMapping(value = "midFind", method = RequestMethod.POST)
	public String midFindPost(String options, String name, String email) {
		
		String mail = "";
		String findMid = "";
		
		if(options.equals("member")) {
			MemberVO vo = memberService.getMidFind(name, email);

			if(vo==null) return "redirect:/msg/memberLoginNo";
			
			findMid = vo.getMid().replace(vo.getMid().substring(2,4), "**");
			mail = vo.getEmail();
		}
		else if(options.equals("rider")) {
			RiderVO vo = riderService.getMidFind(name, email);
			
			if(vo==null) return "redirect:/msg/memberLoginNo";
			
			findMid = vo.getRiderMid().replace(vo.getRiderMid().substring(2,4), "**");
			mail = vo.getRiderEmail();
		}
		else {
			StoreVO vo = storeService.getMidFind(name, email);
			
			if(vo==null) return "redirect:/msg/memberLoginNo";
			
			findMid = vo.getStoreMid().replace(vo.getStoreMid().substring(2,4), "**");
			mail = vo.getStoreEmail();
		}
		
		String toMail = mail;
    String title = "[저기요] 회원 아이디 찾기";
    String content = "";
		
		try {
			// 메일을 전송하기 위한 객체 : MimeMessage() , MimeMessageHelper()
			MimeMessage message = mailSender.createMimeMessage(); // 타입변환
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8"); //보관함에 저장하는곳
			
			// 메일보관함에 회원이 보내온 메세지들을 모두 저장시킨다.
			messageHelper.setTo(toMail);
			messageHelper.setSubject(title);
			
			content = content.replace("\n", "<br/>");
			content += "회원 아이디입니다.\n";
			content += "아이디 : " + findMid;
			
			// 메일보관함에 회원이 보내온 메세지들을 모두 저장시킨다.
			messageHelper.setText(content);
			
			// 메일 전송하기
			mailSender.send(message);
			
		} catch (MessagingException e) {
			e.printStackTrace();
		}
		
		return "redirect:/msg/midEmailSend";
	}
	
	// 아이디 찾기
	@RequestMapping(value = "pwdFind", method = RequestMethod.POST)
	public String pwdFindPost(String options, String mid, String email) {
		
		String mail = "";
		String newPwd = "";
		
		if(options.equals("member")) {
			MemberVO vo = memberService.getPwdFind(mid, email);
			if(vo==null) return "redirect:/msg/memberLoginNo";
			
			UUID uid = UUID.randomUUID();
			newPwd = uid.toString().substring(0,8);
			
			String sPwd = passwordEncoder.encode(newPwd); 
			memberService.setMemberPwdUpdate(sPwd, mid);
			
			mail = vo.getEmail();
		}
		else if(options.equals("rider")) {
			RiderVO vo = riderService.getPwdFind(mid, email);
			if(vo==null) return "redirect:/msg/memberLoginNo";
			
			UUID uid = UUID.randomUUID();
			newPwd = uid.toString().substring(0,8);
			
			String sPwd = passwordEncoder.encode(newPwd); 
			riderService.setMemberPwdUpdate(sPwd, mid);
			
			mail = vo.getRiderEmail();
		}
		else {
			StoreVO vo = storeService.getPwdFind(mid, email);
			if(vo==null) return "redirect:/msg/memberLoginNo";
			
			UUID uid = UUID.randomUUID();
			newPwd = uid.toString().substring(0,8);
			
			String sPwd = passwordEncoder.encode(newPwd);
			storeService.setStorePwdUpdate(sPwd, mid);
			
			mail = vo.getStoreEmail();
		}
		
		String toMail = mail;
		String title = "[저기요] 회원 임시비밀번호 발급";
		String content = "";
		
		try {
			// 메일을 전송하기 위한 객체 : MimeMessage() , MimeMessageHelper()
			MimeMessage message = mailSender.createMimeMessage(); // 타입변환
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8"); //보관함에 저장하는곳
			
			// 메일보관함에 회원이 보내온 메세지들을 모두 저장시킨다.
			messageHelper.setTo(toMail);
			messageHelper.setSubject(title);
			
			content = content.replace("\n", "<br/>");
			content += "임시비밀번호 입니다.\n";
			content += "임시비밀번호 : " + newPwd;
			
			// 메일보관함에 회원이 보내온 메세지들을 모두 저장시킨다.
			messageHelper.setText(content);
			
			// 메일 전송하기
			mailSender.send(message);
			
		} catch (MessagingException e) {
			e.printStackTrace();
		}
		
		return "redirect:/msg/pwdEmailSend";
	}
	
	
	
	
}

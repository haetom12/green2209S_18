package com.spring.green2209S_18;

import java.util.List;
import java.util.Random;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpSession;

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

import com.spring.green2209S_18.dao.RiderDAO;
import com.spring.green2209S_18.pagenation.PageProcess;
import com.spring.green2209S_18.pagenation.PageVO;
import com.spring.green2209S_18.service.OrderService;
import com.spring.green2209S_18.service.RiderService;
import com.spring.green2209S_18.service.StoreService;
import com.spring.green2209S_18.vo.CartVO;
import com.spring.green2209S_18.vo.MailVO;
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
	
	@Autowired
	JavaMailSender mailSender;
	
	@Autowired
	PageProcess pageProcess;
	
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
	
	
	// 내 주문내역 리스트로
	@Async
	@ResponseBody
	@RequestMapping(value = "riderEmailCheck", method = RequestMethod.POST)
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
			
			content = content.replace("\n", "<br/>");
			content += "메일 인증번호입니다</n>";
			content += "===============================";
			content += "인증번호 : " + msg;
			
			// 메일보관함에 회원이 보내온 메세지들을 모두 저장시킨다.
			messageHelper.setTo(toMail);
			messageHelper.setSubject(title);
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
	@RequestMapping(value = "riderEmailCheckOk", method = RequestMethod.POST)
	public String memberEmailCheckPost(String emailCode, HttpSession session) {
		String res = "1";
		
		String code = (String)session.getAttribute("sCode");
		
		if(!code.equals(emailCode)) return "0";
		
		else return res;
	}
	
	// 라이더 정보 수정 폼으로
	@RequestMapping(value = "riderUpdate", method = RequestMethod.GET)
	public String riderUpdateGet(Model model ,HttpSession session) {
		
		String mid = (String) session.getAttribute("sMid");
		RiderVO vo = riderService.getRiderMidCheck(mid);
		
		String[] email = vo.getRiderEmail().split("@");
		String email1 = email[0];
		String email2 = email[1];
		
		String[] tel = vo.getRiderPhone().split("-");
		String tel1 = tel[0];
		String tel2 = tel[1];
		String tel3 = tel[2];
		
		
		model.addAttribute("email1", email1);
		model.addAttribute("email2", email2);
		model.addAttribute("tel1", tel1);
		model.addAttribute("tel2", tel2);
		model.addAttribute("tel3", tel3);
		
		model.addAttribute("vo", vo);
		return "rider/riderUpdate";
	}
	
	// 라이더 정보 수정 작업
	@RequestMapping(value = "riderUpdate", method = RequestMethod.POST)
	public String riderUpdatePost(RiderVO vo) {
		
		int res = riderService.setRiderUpdate(vo);
		
		if(res==1) return "redirect:/msg/riderUpdateOk";
		else return "redirect:/msg/riderUpdateNo";
	}
	
//이메일 인증
	@ResponseBody
	@RequestMapping(value = "/riderUpdateEmailCheck", method = RequestMethod.POST)
	public String riderEmailCheckPost(MailVO vo, String riderEmail, HttpSession session) {
		
	 int res = 0;
		
	 vo.setToMail(riderEmail);
		
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
	@RequestMapping(value = "/riderUpdateEmailCheckOk", method = RequestMethod.POST)
	public String riderEmailCheckOkPost(String emailCode, HttpSession session) {
		String res = "1";
		
		String code = (String)session.getAttribute("sCode");
		
		if(!code.equals(emailCode)) return "0";
		
		else return res;
	}

	// 라이더 비밀번호 수정 폼으로
	@RequestMapping(value = "/riderPwdUpdate", method = RequestMethod.GET)
	public String riderPwdUpdateGet(HttpSession session, Model model) {
		String mid = (String) session.getAttribute("sMid");
		RiderVO vo = riderService.getRiderMidCheck(mid);
		
		model.addAttribute("vo", vo);
		return "rider/riderPwdUpdate";
	}
	
	// 비밀번호 업데이트
	@RequestMapping(value = "/riderPwdUpdate", method = RequestMethod.POST)
	public String riderPwdUpdatePost(String oldPwd, String newPwd, HttpSession session) {
		String mid = (String)session.getAttribute("sMid");
		
		System.out.println("비번 : " + oldPwd);
		System.out.println("새비번 : " + newPwd);
		
		RiderVO vo = riderService.getRiderMidCheck(mid);
		
		if(passwordEncoder.matches(oldPwd, vo.getRiderPwd())) {
			
			newPwd = passwordEncoder.encode(newPwd);
			
			int res = riderService.setMemberPwdUpdate(newPwd , mid);
			
			if(res==1) return "redirect:/msg/riderUpdatePwdOk";
			else return "redirect:/msg/riderUpdatePwdNo";
		}
		else {
			return "redirect:/msg/riderPwdCheckNo";
		}
	}
	
	// 라이더 배달 목록 리스트로
	@RequestMapping(value = "/riderDeliverList", method = RequestMethod.GET)
	public String riderDeliverListGet(HttpSession session, Model model,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize) {
		String mid = (String)session.getAttribute("sMid");
		
		RiderVO vo = riderService.getRiderMidCheck(mid);
		
		PageVO pageVo = pageProcess.totRecCnt(pag, pageSize, "riderOrderList", mid, "");
		
		List<CartVO> vos = riderService.getRiderOrderListPage(pageVo.getStartIndexNo(), pageSize, mid);
		
		model.addAttribute("vo",vo);
		model.addAttribute("pageVo",pageVo);
		model.addAttribute("vos",vos);
		
		return "rider/riderDeliverList";
	}
	
	// 라이더 탈퇴 신청 폼으로
	@RequestMapping(value = "/riderDelete", method = RequestMethod.GET)
	public String riderDeliverListGet(HttpSession session, Model model) {
		
		String mid = (String)session.getAttribute("sMid");
		RiderVO vo = riderService.getRiderMidCheck(mid);
		
		model.addAttribute("vo", vo);
		
		return "rider/riderDelete";
	}
	
	
	
//삭제 전 이메일 인증
	@ResponseBody
	@RequestMapping(value = "/riderDeleteCheck", method = RequestMethod.POST)
	public String memberDeleteCheckPost(String riderMid, String riderPwd, HttpSession session) {
		int res = 0;
		
		RiderVO vo = riderService.getRiderMidCheck(riderMid);
		
		if(vo==null || !passwordEncoder.matches(riderPwd, vo.getRiderPwd())) {
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
   
   String toMail = vo.getRiderEmail();
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
			
			content = content.replace("<br/>", "\n");
			content += "<br>메일 인증번호입니다<br/>";
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
	@RequestMapping(value = "/riderDeleteCodeCheck", method = RequestMethod.POST)
	public String memberDeleteCodeCheckPost(String code, HttpSession session) {
		String sCode = (String) session.getAttribute("sCode");
		
		if(sCode.equals(code)) return "1";
		
		else return "2";
	}
	
	// 계정 삭제 처리
	@RequestMapping(value = "/riderDeleteOk", method = RequestMethod.GET)
	public String riderDeleteOkGet(HttpSession session) {
		
		String mid = (String)session.getAttribute("sMid");
		int res = riderService.setRiderDelete(mid);
		
		if(res==1) return "redirect:/msg/riderDeleteOk";
		else return "redirect:/msg/riderDeleteNo";
	}
	
	
}

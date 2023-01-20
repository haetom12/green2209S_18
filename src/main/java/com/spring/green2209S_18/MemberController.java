package com.spring.green2209S_18;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.green2209S_18.service.MemberService;
import com.spring.green2209S_18.vo.MemberVO;
@Controller
@RequestMapping("/member")
public class MemberController {
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	
	@RequestMapping(value = "memberLogin", method = RequestMethod.GET)
	public String memberLoginGet() {

		return "member/memberLogin";
	}

	@RequestMapping(value = "memberLogin", method = RequestMethod.POST)
	public String memberLoginPost(HttpSession session,String mid, String pwd) {
		
		MemberVO vo = memberService.getMemberIdCheck(mid);
		if(vo != null && passwordEncoder.matches(pwd, vo.getPwd()) && vo.getUserDel().equals("NO")) {
			// 회원 인증처리된 경우 수행할 내용? session에 필요한 자료를 저장, 쿠키값처리, 그날 방문자수 1증가(방문포인트도 증가!)
			
			session.setAttribute("sMid", mid);

			return "redirect:/member/memberLoginOk";
		}
		// 로그인 실패
		else {
			return "redirect:/msg/memberLoginNo";
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
	
	// 로그아웃
	@RequestMapping(value = "/memberLogout", method = RequestMethod.GET)
	public String adminLogoutGet(HttpSession session) {
		String mid = (String) session.getAttribute("sMid");
		session.invalidate();
		
		return "redirect:/";
	}
	
	
	
}

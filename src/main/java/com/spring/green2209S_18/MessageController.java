package com.spring.green2209S_18;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class MessageController {
	
	@RequestMapping(value="/msg/{msgFlag}", method=RequestMethod.GET)
	public String msgGet(@PathVariable String msgFlag, Model model,
			@RequestParam(value="mid", defaultValue = "", required = false) String mid,
			@RequestParam(value="flag", defaultValue = "", required = false) String flag,
			@RequestParam(value="brandName", defaultValue = "", required = false) String brandName) {
		System.out.println("brandName : "+brandName);
		
		if(msgFlag.equals("memberLoginNo")) {
			model.addAttribute("msg", "로그인 실패~~~");
			model.addAttribute("url", "member/memberLogin");
		}
		else if(msgFlag.equals("memberJoinOk")) {
			model.addAttribute("msg", "회원가입 완료되었습니다!");
			model.addAttribute("url", "member/memberLogin");
		}
		else if(msgFlag.equals("memberJoinNo")) {
			model.addAttribute("msg", "회원가입 실패!!!");
			model.addAttribute("url", "member/memberJoin");
		}
		else if(msgFlag.equals("memberIdCheckNo")) {
			model.addAttribute("msg", "중복된 아이디 입니다!");
			model.addAttribute("url", "member/memberJoin");
		}
		else if(msgFlag.equals("memberNickNameCheckNo")) {
			model.addAttribute("msg", "중복된 닉네임입니다!");
			model.addAttribute("url", "member/memberJoin");
		}
		else if(msgFlag.equals("adminNo")) {
			model.addAttribute("msg", "관리자가 아닙니다!");
			model.addAttribute("url", "member/memberLogin");
		}
		else if(msgFlag.equals("memberNo")) {
			model.addAttribute("msg", "로그인후 사용하세요");
			model.addAttribute("url", "member/memberLogin");
		}
		else if(msgFlag.equals("levelCheckNo")) {
			model.addAttribute("msg", "등급을 확인하세요");
			model.addAttribute("url", "member/memberMain");
		}
		else if(msgFlag.equals("mailSendOk")) {
			model.addAttribute("msg", "메일 전송이 완료되었습니다!");
			model.addAttribute("url", "study/mail/mailForm");
		}
		else if(msgFlag.equals("mailSendOk")) {
			model.addAttribute("msg", "메일 전송이 완료되었습니다!");
			model.addAttribute("url", "study/mail/mailForm");
		}
		else if(msgFlag.equals("memberDelNo")) {
			model.addAttribute("msg", "비밀번호가 틀립니다!");
			model.addAttribute("url", "member/memberDelete");
		}
		else if(msgFlag.equals("memberDelOk")) {
			model.addAttribute("msg", "회원탈퇴 처리 되었습니다!");
			model.addAttribute("url", "member/memberLogout");
		}
		else if(msgFlag.equals("memberImsiPwdOk")) {
			model.addAttribute("msg", "임시비밀번호가 전송되었습니다!");
			model.addAttribute("url", "member/memberLogin");
		}
		else if(msgFlag.equals("memberImsiPwdNo")) {
			model.addAttribute("msg", "아이디와 이메일 주소를 확인해주세요!");
			model.addAttribute("url", "member/memberPwdSearch");
		}
		else if(msgFlag.equals("memberUpdatePwdOk")) {
			model.addAttribute("msg", "비밀번호 변경이 성공하였습니다");
			model.addAttribute("url", "member/memberMain");
		}
		else if(msgFlag.equals("memberUpdatePwdNo")) {
			model.addAttribute("msg", "비밀번호 변경 실패!!");
			model.addAttribute("url", "member/memUpdatePwd");
		}
		else if(msgFlag.equals("memberPwdCheckOk")) {
			model.addAttribute("msg", "비밀번호가 확인되었습니다!");
			model.addAttribute("url", "member/memberUpdate");
		}
		else if(msgFlag.equals("memberPwdCheckNo")) {
			model.addAttribute("msg", "비밀번호가 틀립니다!");
			model.addAttribute("url", "member/memberPwdCheck");
		}
		else if(msgFlag.equals("memberUpdateNickNameCheckNo")) {
			model.addAttribute("msg", "이미 존재하는 닉네임입니다!!");
			model.addAttribute("url", "member/memberUpdate");
		}
		else if(msgFlag.equals("memberUpdateOk")) {
			model.addAttribute("msg", "회원수정이 완료되었습니다!");
			model.addAttribute("url", "member/memberMain");
		}
		else if(msgFlag.equals("memberUpdateNo")) {
			model.addAttribute("msg", "회원수정 실패!!");
			model.addAttribute("url", "member/memberUpdate");
		}
		else if(msgFlag.equals("storeJoinOk")) {
			model.addAttribute("msg", "가게가 등록되었습니다!");
			model.addAttribute("url", "member/memberLogin");
		}
		else if(msgFlag.equals("storeJoinNo")) {
			model.addAttribute("msg", "가게 등록이 실패하였습니다! 다시 시도해주세요.");
			model.addAttribute("url", "store/storeJoin");
		}
		else if(msgFlag.equals("CategoryInputOk")) {
			model.addAttribute("msg", "카테고리가 등록되었습니다!");
			model.addAttribute("url", "admin/adminShopCategory");
		}
		else if(msgFlag.equals("CategoryInputNo")) {
			model.addAttribute("msg", "카테고리 등록이 실패하였습니다! 다시 시도해주세요.");
			model.addAttribute("url", "admin/adminCategoryInput");
		}
		else if(msgFlag.equals("CategoryAlready")) {
			model.addAttribute("msg", "이미 등록되어있는 카테고리 입니다! 다시 확인해주세요.");
			model.addAttribute("url", "admin/adminCategoryInput");
		}
		else if(msgFlag.equals("CategoryUpdateOk")) {
			model.addAttribute("msg", "카테고리가 수정되었습니다!");
			model.addAttribute("url", "admin/adminShopCategory");
		}
		else if(msgFlag.equals("CategoryUpdateNo")) {
			model.addAttribute("msg", "카테고리 수정이 실패하였습니다! 다시 시도해주세요.");
			model.addAttribute("url", "admin/adminShopCategory");
		}
		else if(msgFlag.equals("brandInputOk")) {
			model.addAttribute("msg", "프랜차이즈 등록이 완료되었습니다!");
			model.addAttribute("url", "admin/storeBrandList");
		}
		else if(msgFlag.equals("brandInputNo")) {
			model.addAttribute("msg", "프랜차이즈 등록에 실패하였습니다. 다시 시도해주세요.");
			model.addAttribute("url", "admin/adminStoreBrandInput");
		}
		else if(msgFlag.equals("brandUpdateOk")) {
			model.addAttribute("msg", "프랜차이즈 수정이 완료되었습니다!");
			model.addAttribute("url", "admin/StoreBrandList");
		}
		else if(msgFlag.equals("brandUpdateOk")) {
			model.addAttribute("msg", "프랜차이즈 수정에 실패하였습니다. 다시 시도해주세요.");
			model.addAttribute("url", "admin/StoreBrandList");
		}
		else if(msgFlag.equals("tagInputOk")) {
			model.addAttribute("msg", "태그가 추가되었습니다!.");
			model.addAttribute("url", "admin/storeTagList?brandName="+brandName);
		}
		else if(msgFlag.equals("tagInputNo")) {
			model.addAttribute("msg", "태그 추가에 실패하였습니다. 다시 시도해주세요.");
			model.addAttribute("url", "admin/storeTagList?brandName="+brandName);
		}
		else if(msgFlag.equals("tagupdateOk")) {
			model.addAttribute("msg", "태그를 성공적으로 수정하였습니다!");
			model.addAttribute("url", "admin/storeTagList?brandName="+brandName);
		}
		else if(msgFlag.equals("tagupdateNo")) {
			model.addAttribute("msg", "태그 수정에 실패하였습니다. 다시 시도해주세요.");
			model.addAttribute("url", "admin/storeTagList?brandName="+brandName);
		}
		
		
		return "include/message";
	}
}

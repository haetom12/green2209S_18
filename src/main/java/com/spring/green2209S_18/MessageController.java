package com.spring.green2209S_18;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.spring.green2209S_18.vo.WebSocketDbVO;

@Controller
public class MessageController {
	
	@RequestMapping(value="/msg/{msgFlag}", method=RequestMethod.GET)
	public String msgGet(@PathVariable String msgFlag, Model model, WebSocketDbVO vo, HttpSession session,
			@RequestParam(value="mid", defaultValue = "", required = false) String mid,
			@RequestParam(value="flag", defaultValue = "", required = false) String flag,
			@RequestParam(value="foodTag", defaultValue = "", required = false) String foodTag,
			@RequestParam(value="menuIdx", defaultValue = "1", required = false) int menuIdx,
			@RequestParam(value="storeName", defaultValue = "", required = false) String storeName,
			@RequestParam(value="brandName", defaultValue = "", required = false) String brandName) {
		
		if(msgFlag.equals("memberLoginNo")) {
			model.addAttribute("msg", "존재하지 않는 회원입니다!");
			model.addAttribute("url", "member/memberLogin");
		}
		else if(msgFlag.equals("memberJoinOk")) {
			model.addAttribute("msg", "회원가입 완료되었습니다! 회원가입 축하 쿠폰이 발급되었으니 이메일 또는 홈페이지를 확인하세요!");
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
			model.addAttribute("url", "member/myPage");
		}
		else if(msgFlag.equals("memberUpdatePwdNo")) {
			model.addAttribute("msg", "비밀번호 변경 실패!!");
			model.addAttribute("url", "member/memberPwdUpdate");
		}
		
		else if(msgFlag.equals("memberPwdCheckOk")) {
			model.addAttribute("msg", "비밀번호가 확인되었습니다!");
			model.addAttribute("url", "member/memberUpdate");
		}
		else if(msgFlag.equals("memberPwdCheckOk2")) {
			model.addAttribute("msg", "비밀번호가 확인되었습니다!");
			model.addAttribute("url", "member/memberPwdUpdate");
		}
		
		else if(msgFlag.equals("memberPwdCheckNo")) {
			model.addAttribute("msg", "비밀번호가 틀립니다!");
			model.addAttribute("url", "member/myPage");
		}
		else if(msgFlag.equals("memberPwdCheckNo2")) {
			model.addAttribute("msg", "기존 비밀번호가 틀립니다!");
			model.addAttribute("url", "member/memberPwdUpdate");
		}
		else if(msgFlag.equals("memberUpdateNickNameCheckNo")) {
			model.addAttribute("msg", "이미 존재하는 닉네임입니다!!");
			model.addAttribute("url", "member/memberUpdate");
		}
		else if(msgFlag.equals("memberUpdateOk")) {
			model.addAttribute("msg", "회원수정이 완료되었습니다!");
			model.addAttribute("url", "member/myPage");
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
			model.addAttribute("url", "admin/storeBrandList");
		}
		else if(msgFlag.equals("brandUpdateOk")) {
			model.addAttribute("msg", "프랜차이즈 수정에 실패하였습니다. 다시 시도해주세요.");
			model.addAttribute("url", "admin/storeBrandList");
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
		else if(msgFlag.equals("adminStoreMenuInputOk")) {
			model.addAttribute("msg", "메뉴를 성공적으로 등록하였습니다!");
			model.addAttribute("url", "admin/storeMenuList?brandName="+brandName);
		}
		else if(msgFlag.equals("adminStoreMenuInputNo")) {
			model.addAttribute("msg", "메뉴 등록에 실패하였습니다. 다시 시도해주세요.");
			model.addAttribute("url", "admin/storeMenuList?brandName="+brandName);
		}
		else if(msgFlag.equals("adminMenuUpdateOk")) {
			model.addAttribute("msg", "메뉴를 성공적으로 수정하였습니다!");
			model.addAttribute("url", "admin/storeMenuList?brandName="+brandName);
		}
		else if(msgFlag.equals("adminMenuUpdateNo")) {
			model.addAttribute("msg", "메뉴 수정에 실패하였습니다. 다시 시도해주세요.");
			model.addAttribute("url", "admin/storeMenuList?brandName="+brandName);
		}
		else if(msgFlag.equals("adminMenuInputOk")) {
			model.addAttribute("msg", "선택된 메뉴를 저장 하였습니다.");
			model.addAttribute("url", "store/myStoreMenu");
		}
		else if(msgFlag.equals("storeMenuInputOk")) {
			model.addAttribute("msg", "메뉴를 성공적으로 등록하였습니다.");
			model.addAttribute("url", "store/myStoreMenu");
		}
		else if(msgFlag.equals("storeMenuInputNo")) {
			model.addAttribute("msg", "메뉴 등록에 실패하였습니다. 다시 시도해주세요.");
			model.addAttribute("url", "store/myStoreMenu");
		}
		else if(msgFlag.equals("storeMenuUpdateOk")) {
			model.addAttribute("msg", "메뉴를 성공적으로 수정하였습니다!");
			model.addAttribute("url", "store/myStoreMenu");
		}
		else if(msgFlag.equals("storeMenuUpdateNo")) {
			model.addAttribute("msg", "메뉴 수정에 실패하였습니다. 다시 시도해주세요.");
			model.addAttribute("url", "store/myStoreMenu");
		}
		else if(msgFlag.equals("storeTagInputOk")) {
			model.addAttribute("msg", "태그를 성공적으로 등록하였습니다!");
			model.addAttribute("url", "store/myStoreTag");
		}
		else if(msgFlag.equals("storeTagInputNo")) {
			model.addAttribute("msg", "태그 등록에 실패하였습니다. 다시 시도해주세요.");
			model.addAttribute("url", "store/myStoreTag");
		}
		else if(msgFlag.equals("storeTagUpdateOk")) {
			model.addAttribute("msg", "태그를 성공적으로 수정하였습니다!");
			model.addAttribute("url", "store/myStoreTag");
		}
		else if(msgFlag.equals("storeTagUpdateNo")) {
			model.addAttribute("msg", "태그 수정에 실패하였습니다. 다시 시도해주세요.");
			model.addAttribute("url", "store/myStoreTag");
		}
		else if(msgFlag.equals("subMenuInputOk")) {
			model.addAttribute("msg", "추가메뉴를 성공적으로 등록하였습니다!");
			model.addAttribute("url", "store/myStoreSubMenu?foodTag="+foodTag);
		}
		else if(msgFlag.equals("subMenuInputNo")) {
			model.addAttribute("msg", "추가메뉴 등록에 실패하였습니다. 다시 시도해주세요.");
			model.addAttribute("url", "store/myStoreSubMenu?foodTag="+foodTag);
		}
		else if(msgFlag.equals("subMenuUpdateOk")) {
			model.addAttribute("msg", "추가메뉴를 성공적으로 수정하였습니다!");
			model.addAttribute("url", "store/myStoreSubMenu?foodTag="+foodTag);
		}
		else if(msgFlag.equals("subMenuUpdateNo")) {
			model.addAttribute("msg", "추가메뉴 수정에 실패하였습니다. 다시 시도해주세요.");
			model.addAttribute("url", "store/myStoreSubMenu?foodTag="+foodTag);
		}
		else if(msgFlag.equals("cartOrderOk")) {
			model.addAttribute("msg", "장바구니에 상품이 등록되었습니다.\\n주문창으로 이동합니다.");
			model.addAttribute("url", "order/myCart");
		}
		else if(msgFlag.equals("cartInputOk")) {
			model.addAttribute("msg", "장바구니에 상품이 등록되었습니다.");
			model.addAttribute("url", "/store/storeMenuInfo?menuIdx="+menuIdx);
		}
		else if(msgFlag.equals("cartEmpty")) {
			model.addAttribute("msg", "장바구니가 비어있습니다.");
			model.addAttribute("url", "/h");
		}
		else if(msgFlag.equals("cartStoreNo")) {
			model.addAttribute("msg", "같은 가게의 음식만 장바구니에 담을 수 있습니다.");
			model.addAttribute("url", "/store/storeMenuInfo?menuIdx="+menuIdx);
		}
		
		else if(msgFlag.equals("paymentResultOk")) {
			model.addAttribute("msg", "결제가 완료되었습니다!");
			model.addAttribute("url", "/member/myOrderList");
		}

		else if(msgFlag.equals("paymentResultOkAndCoupon")) {
			model.addAttribute("msg", "결제가 완료되었습니다!");
			model.addAttribute("url", "/msg/couponGo");
		}
		else if(msgFlag.equals("couponGo")) {
			model.addAttribute("msg", "10회 주문 이벤트로 쿠폰이 발급되었습니다! 이메일을 확인하세요!");
			model.addAttribute("url", "/member/myOrderList");
		}
		
		else if(msgFlag.equals("ratingInputOk")) {
			model.addAttribute("msg", "별점이 등록되었습니다!");
			model.addAttribute("url", "/member/myOrderList");
		}
		
		else if(msgFlag.equals("ratingInputNo")) {
			model.addAttribute("msg", "별점 등록에 실패하였습니다. 다시 시도해주세요.");
			model.addAttribute("url", "/member/myOrderList");
		}
		
		else if(msgFlag.equals("ratingUpdateNo")) {
			model.addAttribute("msg", "해당 별점을 수정할 권한이 없습니다.");
			model.addAttribute("url", "/store/storeRatingList?storeName="+storeName);
		}
		
		else if(msgFlag.equals("ratingUpdateOk")) {
			model.addAttribute("msg", "별점을 수정하였습니다!");
			model.addAttribute("url", "/store/storeRatingList?storeName="+storeName);
		}
		
		else if(msgFlag.equals("ratingUpdateFail")) {
			model.addAttribute("msg", "별점 수정에 실패하였습니다. 다시 시도해주세요.");
			model.addAttribute("url", "/store/storeRatingList?storeName="+storeName);
		}
		
		else if(msgFlag.equals("riderUpdateOk")) {
			model.addAttribute("msg", "라이더 정보를 성공적으로 수정하였습니다!");
			model.addAttribute("url", "/rider/riderMain");
		}
		
		else if(msgFlag.equals("riderUpdateNo")) {
			model.addAttribute("msg", "라이더 정보 수정에 실패했습니다. 다시 시도해주세요.");
			model.addAttribute("url", "/rider/riderUpdate");
		}
		
		else if(msgFlag.equals("riderUpdatePwdOk")) {
			model.addAttribute("msg", "비밀번호 변경이 완료되었습니다!");
			model.addAttribute("url", "/rider/riderMain");
		}

		else if(msgFlag.equals("riderUpdatePwdNo")) {
			model.addAttribute("msg", "비밀번호 수정에 실패했습니다. 다시 시도해주세요.");
			model.addAttribute("url", "/rider/riderPwdUpdate");
		}
		
		else if(msgFlag.equals("riderPwdCheckNo")) {
			model.addAttribute("msg", "비밀번호가 일치하지 않습니다!");
			model.addAttribute("url", "/rider/riderPwdUpdate");
		}
		
		else if(msgFlag.equals("storePwdCheckOk")) {
			model.addAttribute("msg", "비밀번호가 확인되었습니다!");
			model.addAttribute("url", "/store/storeUpdateOk");
		}
		
		else if(msgFlag.equals("storePwdCheckOk2")) {
			model.addAttribute("msg", "비밀번호가 확인되었습니다!");
			model.addAttribute("url", "/store/storePwdUpdateOk");
		}
		
		else if(msgFlag.equals("storePwdCheckNo")) {
			model.addAttribute("msg", "비밀번호가 일치하지않습니다!");
			model.addAttribute("url", "/store/myStorePage");
		}
		else if(msgFlag.equals("storeUpdateOk")) {
			model.addAttribute("msg", "가게 정보를 수정하였습니다!");
			model.addAttribute("url", "/store/myStorePage");
		}
		else if(msgFlag.equals("storeUpdateNo")) {
			model.addAttribute("msg", "가게 수정에 실패했습니다. 다시 시도해주세요.");
			model.addAttribute("url", "/store/storeUpdateOk");
		}
		else if(msgFlag.equals("storeUpdatePwdOk")) {
			model.addAttribute("msg", "비밀번호를 수정하였습니다!");
			model.addAttribute("url", "/store/myStorePage");
		}
		else if(msgFlag.equals("storeUpdatePwdNo")) {
			model.addAttribute("msg", "비밀번호 수정에 실패했습니다. 다시 시도해주세요.");
			model.addAttribute("url", "/store/storePwdUpdateOk");
		}
		else if(msgFlag.equals("storeUpdatePwdNo2")) {
			model.addAttribute("msg", "비밀번호가 일치하지 않습니다!");
			model.addAttribute("url", "/store/storePwdUpdateOk");
		}
		else if(msgFlag.equals("riderDeleteOk")) {
			model.addAttribute("msg", "회원탈퇴에 성공했습니다. 로그아웃됩니다.");
			model.addAttribute("url", "/member/memberLogout");
		}
		else if(msgFlag.equals("riderDeleteNo")) {
			model.addAttribute("msg", "회원탈퇴에 실패하였습니다. 다시 시도해주세요.");
			model.addAttribute("url", "/rider/riderMain");
		}
		else if(msgFlag.equals("memberDeleteNo")) {
			model.addAttribute("msg", "회원탈퇴에 실패하였습니다. 다시 시도해주세요.");
			model.addAttribute("url", "/member/myPage");
		}
		else if(msgFlag.equals("storeDeleteNo")) {
			model.addAttribute("msg", "회원탈퇴에 실패하였습니다. 다시 시도해주세요.");
			model.addAttribute("url", "/store/myStorePage");
		}
		else if(msgFlag.equals("midEmailSend")) {
			model.addAttribute("msg", "아이디를 이메일로 전송하였습니다! 이메일을 확인하세요.");
			model.addAttribute("url", "/member/memberLogin");
		}
		
		return "include/message";
	}
}

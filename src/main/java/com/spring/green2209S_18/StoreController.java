package com.spring.green2209S_18;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.spring.green2209S_18.service.StoreService;
import com.spring.green2209S_18.vo.StoreVO;
@Controller
@RequestMapping("/store")
public class StoreController {
	
	@Autowired
	StoreService storeService;
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	
	// 가게 등록 폼 이동
	@RequestMapping(value = "storeJoin", method = RequestMethod.GET)
	public String memberLoginGet() {

		return "store/storeJoin";
	}
	
//아이디 중복검사
	@ResponseBody
	@RequestMapping(value = "/storeIdCheck", method = RequestMethod.POST)
	public String memIdCheckPost(String storeMid) {
		String res = "1";
		StoreVO vo = storeService.getStoreIdCheck(storeMid);
		
		if(vo == null) res = "0";
		return res;
	}
	
	// 가게 등록
	@RequestMapping(value = "storeJoin", method = RequestMethod.POST)
	public String memberLoginPost(StoreVO vo, MultipartFile fName) {
		// 아이디 체크
		if(storeService.getStoreIdCheck(vo.getStoreMid()) != null) {
			return "redirect:/msg/memberIdCheckNo";
		}
		
		// 비밀번호 암호화
		vo.setStorePwd(passwordEncoder.encode(vo.getStorePwd()));
		
		// 체크가 완료되면 사진파일 업로드후, vo에 담긴 자료를 DB에 저장시켜준다. (회원 가입) - 서비스객체에서 수행처리했다.
		int res = storeService.setStoreJoinOk(vo, fName);
		if(res == 1) return "redirect:/msg/storeJoinOk"; // 정상처리가 되면 true == 1이 자동으로 넘어옴
		else return "redirect:/msg/storeJoinNo";
	}
	
	// 가게 리스트 이동
	@RequestMapping(value = "shopCategory", method = RequestMethod.GET)
	public String storeMenuInfoGet(Model model) {
		
		
		
		// 음식 카테고리 가져오기
		List<StoreVO> vos = storeService.getStoreCategory();
		
		model.addAttribute("vos", vos);
		return "store/shopCategory";
	}
	
}

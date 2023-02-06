package com.spring.green2209S_18;

import java.util.Arrays;
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
import org.springframework.web.multipart.MultipartFile;

import com.spring.green2209S_18.service.AdminService;
import com.spring.green2209S_18.service.MemberService;
import com.spring.green2209S_18.service.StoreService;
import com.spring.green2209S_18.vo.FoodMenuVO;
import com.spring.green2209S_18.vo.MemberVO;
import com.spring.green2209S_18.vo.StoreVO;
@Controller
@RequestMapping("/store")
public class StoreController {
	
	@Autowired
	StoreService storeService;
	
	@Autowired
	AdminService adminService;
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	
	// 가게 등록 폼 이동
	@RequestMapping(value = "storeJoin", method = RequestMethod.GET)
	public String memberLoginGet(Model model) {
		
		// 음식 카테고리 가져오기
		List<StoreVO> vos = storeService.getStoreCategory();
		
		model.addAttribute("vos", vos);

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
	
	// 카테고리 리스트 이동
	@RequestMapping(value = "shopCategory", method = RequestMethod.GET)
	public String shopCategoryGet(Model model) {
		// 음식 카테고리 가져오기
		List<StoreVO> vos = storeService.getStoreCategory();
		
		model.addAttribute("vos", vos);
		return "store/shopCategory";
	}
	
	// 해당 카테고리 가게 리스트 이동
	@RequestMapping(value = "storeList", method = RequestMethod.GET)
	public String storeListGet(Model model, String storePart,
			@RequestParam(name = "ordered" , defaultValue = "", required = false) String ordered) {
		
		// 가게 리스트 가져오기
		List<StoreVO> vos = storeService.getStoreList(storePart, ordered);
		
		
		model.addAttribute("vos", vos);
		model.addAttribute("storePart", storePart);
		return "store/storeList";
	}
	
	// 지도에 내 주변 가게 리스트 불러오기
	@RequestMapping(value = "shopNear", method = RequestMethod.GET)
	public String shopNearGet(Model model, HttpSession session, 
			@RequestParam(name = "storePart" , defaultValue = "", required = false) String storePart) {
		
		String mid = (String)session.getAttribute("sMid");
		
		MemberVO mVo = memberService.getMemberIdCheck(mid);
		
		// 가게 리스트 가져오기
		List<StoreVO> vos = storeService.getNearMapStoreList(storePart);
		
		
		model.addAttribute("mVo", mVo);
		model.addAttribute("vos", vos);
		model.addAttribute("storePart", storePart);
		return "store/shopNear";
	}
	
	// 해당 카테고리 가게 리스트 이동
	@RequestMapping(value = "storeMenu", method = RequestMethod.GET)
	public String storeMenuGet(int idx, Model model) {
		
		StoreVO vo = storeService.getStoreMenu(idx);
		
		model.addAttribute("vo", vo);
		
		return "store/storeMenu";
	}
	
	
	// 내 가게 관리로 이동
	@RequestMapping(value = "myStorePage", method = RequestMethod.GET)
	public String MyStorePageGet(HttpSession session, Model model) {
		String storeMid = (String) session.getAttribute("sMid"); 
		StoreVO vo = storeService.getStoreIdCheck(storeMid);
		
		model.addAttribute("vo",vo);
		return "store/myStorePage";
	}
	
	
	// 내 가게 메뉴 리스트 폼 이동
	@RequestMapping(value = "myStoreMenu", method = RequestMethod.GET)
	public String myStoreMenuGet(HttpSession session, Model model) {
		String storeMid = (String) session.getAttribute("sMid"); 
		StoreVO vo = storeService.getStoreIdCheck(storeMid);
		List<FoodMenuVO> vos = storeService.getStoreFoodMenu(vo.getStoreName());
		
		model.addAttribute("vo",vo);
		model.addAttribute("vos",vos);
		return "store/myStoreMenu";
	}

	// 가게 메뉴 등록 폼으로 이동
	@RequestMapping(value = "storeMenuInputSelect", method = RequestMethod.GET)
	public String storeMenuInputSelectGet(HttpSession session, Model model) {
		String storeMid = (String) session.getAttribute("sMid"); 
		StoreVO vo = storeService.getStoreIdCheck(storeMid);
		
		model.addAttribute("vo",vo);
		return "store/storeMenuInputSelect";
	}
	
	// 가게 메뉴 등록 폼으로 이동
	@RequestMapping(value = "storeMenuInput", method = RequestMethod.GET)
	public String storeMenuInputGet(HttpSession session, Model model) {
		String storeMid = (String) session.getAttribute("sMid"); 
		StoreVO vo = storeService.getStoreIdCheck(storeMid);
		
		model.addAttribute("vo",vo);
		return "store/storeMenuInput";
	}

	// 가게 메뉴 등록 폼으로 이동
	@RequestMapping(value = "storeMenuInput2", method = RequestMethod.GET)
	public String storeMenuInput2Get(HttpSession session, Model model) {
		String storeMid = (String) session.getAttribute("sMid"); 
		StoreVO vo = storeService.getStoreIdCheck(storeMid);
		
		List<StoreVO> vos = storeService.getAdminStoreBrand(vo.getStorePart());
		
		model.addAttribute("vo",vo);
		model.addAttribute("vos",vos);
		return "store/storeMenuInput2";
	}
	
	// ajax로 선택한 메뉴리스트 가져오기
	@ResponseBody
	@RequestMapping(value = "adminBrandMenu", method = RequestMethod.POST)
	public List<FoodMenuVO> adminBrandMenuPost(String brandName) {
		
		List<FoodMenuVO> vos = storeService.getstoreMenuList(brandName);
		
		return vos;
//		JSONObject jsonObject = new JSONObject();
//		
//		JSONObject data = new JSONObject();
//		
//		for(int i=0; i<vos.size(); i++) {
//			data.put("foodTag", vos.get(i).getFoodTag());
//			data.put("foodPhoto", vos.get(i).getFoodPhoto());
//			data.put("price", vos.get(i).getPrice()+"");
//			data.put("foodName", vos.get(i).getFoodName());
//			
//			System.out.println("data" + data);
//			
//			JSONArray req_array = new JSONArray();
//			req_array.add(data);
//			jsonObject.put("vos"+i, req_array);
//		}
//		
//		String str = jsonObject.toJSONString();
//		System.out.println("=====================================");
//		System.out.println("str : " + str);
		
//		return str;
	}
	
	// 프랜차이즈 태그 중복 확인
	@Transactional
	@ResponseBody
	@RequestMapping(value = "adminMenuInputOk", method = RequestMethod.POST)
	public String adminMenuInputOkPost(HttpServletRequest request, String delItems) {
		delItems = delItems.substring(0, delItems.length()-1);
		
		String[] menuIdxs = delItems.split("/");
//		System.out.println("menuIdxs :" + Arrays.toString(menuIdxs));
//		System.out.println("menuIdxs :" + menuIdxs.length);
		
		for(int i=0; i<menuIdxs.length; i++) {
			
		}
		
		return "";
	}
	
}

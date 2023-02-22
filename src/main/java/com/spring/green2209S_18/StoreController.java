package com.spring.green2209S_18;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.scheduling.annotation.Async;
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
import com.spring.green2209S_18.service.AdminService;
import com.spring.green2209S_18.service.MemberService;
import com.spring.green2209S_18.service.OrderService;
import com.spring.green2209S_18.service.StoreService;
import com.spring.green2209S_18.vo.FoodMenuVO;
import com.spring.green2209S_18.vo.MailVO;
import com.spring.green2209S_18.vo.MemberVO;
import com.spring.green2209S_18.vo.RatingVO;
import com.spring.green2209S_18.vo.StoreVO;
import com.spring.green2209S_18.vo.SubFoodMenuVO;
import com.spring.green2209S_18.vo.ratingReplyVO;
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
	OrderService orderService;
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	
	@Autowired
	PageProcess pageProcess;
	
	@Autowired
	JavaMailSender mailSender;
	
	// 가게 등록 폼 이동
	@RequestMapping(value = "/storeJoin", method = RequestMethod.GET)
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
	@RequestMapping(value = "/storeJoin", method = RequestMethod.POST)
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
	@RequestMapping(value = "/shopCategory", method = RequestMethod.GET)
	public String shopCategoryGet(Model model) {
		// 음식 카테고리 가져오기
		List<StoreVO> vos = storeService.getStoreCategory();
		
		model.addAttribute("vos", vos);
		return "store/shopCategory";
	}
	
	// 해당 카테고리 가게 리스트 이동
	@RequestMapping(value = "/storeList", method = RequestMethod.GET)
	public String storeListGet(Model model, String storePart,
			@RequestParam(name = "ordered" , defaultValue = "", required = false) String ordered ,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "12", required = false) int pageSize) {
		
		PageVO pageVo = pageProcess.totRecCnt(pag, pageSize, "store", storePart, "");
		
		// 가게 리스트 가져오기
		List<StoreVO> vos = storeService.getStoreList(storePart, ordered, pageVo.getStartIndexNo(), pageSize);
		
		model.addAttribute("vos", vos);
		model.addAttribute("pageVo", pageVo);
		model.addAttribute("storePart", storePart);
		return "store/storeList";
	}
	
	// 지도에 내 주변 가게 리스트 불러오기
	@RequestMapping(value = "/shopNear", method = RequestMethod.GET)
	public String shopNearGet(Model model, HttpSession session, 
			@RequestParam(name = "storePart" , defaultValue = "", required = false) String storePart,
			@RequestParam(name = "distance" , defaultValue = "1000", required = false) int distance) {
		
//		System.out.println("거리 : " + distance);
		
		String mid = (String)session.getAttribute("sMid");
		
		MemberVO mVo = memberService.getMemberIdCheck(mid);
		
		// 가게 리스트 가져오기
		List<StoreVO> vos = storeService.getNearMapStoreList(storePart);
		
		// 음식 카테고리 가져오기
		List<StoreVO> Cvos = storeService.getStoreCategory();
		
		// 거리 계산해서 가져오기
		List<StoreVO> Mvos = storeService.getStoreDistance(vos,mVo,distance);
		
		model.addAttribute("storePart", storePart);
		model.addAttribute("distance", distance);
		model.addAttribute("mVo", mVo);
		model.addAttribute("Mvos", Mvos);
		model.addAttribute("Cvos", Cvos);
		model.addAttribute("storePart", storePart);
		return "store/shopNear";
	}
	
	// 해당 카테고리 가게 리스트 이동
	@RequestMapping(value = "/storeMenu", method = RequestMethod.GET)
	public String storeMenuGet(Model model, 
			@RequestParam(name = "idx" , defaultValue = "1", required = false) int idx,
			@RequestParam(name = "foodTag" , defaultValue = "", required = false) String foodTag,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "5", required = false) int pageSize) {
		
		StoreVO vo = storeService.getStoreMenu(idx);

		// 해당 가게의 평점 총 갯수 구하기
		PageVO ratingPageVo = pageProcess.totRecCnt(pag, pageSize, "rating", vo.getStoreName(), "");
		PageVO pageVo = pageProcess.totRecCnt(pag, pageSize, "storeMenu", vo.getStoreName(), "");
		
		// 평점 가져오기
		List<RatingVO> rVos = storeService.getRatingList(ratingPageVo.getStartIndexNo(), pageSize, vo.getStoreName());
		
		// 메뉴 리스트
		List<FoodMenuVO> vos = storeService.getStoreFoodMenu2(vo.getStoreName(),foodTag, pageVo.getStartIndexNo(), pageSize);
		
		// 음식 태그 리스트
		List<FoodMenuVO> tVos = storeService.getstoreTagList(vo.getStoreName());
		
		model.addAttribute("vo", vo);
		model.addAttribute("idx", idx);
		model.addAttribute("foodTag", foodTag);
		model.addAttribute("pageVo", pageVo);
		model.addAttribute("vos",vos);
		model.addAttribute("vSize",vos.size());
		model.addAttribute("tVos",tVos);
		model.addAttribute("rVos",rVos);
		
		return "store/storeMenu";
	}
	
	
	// 내 가게 관리로 이동
	@RequestMapping(value = "/myStorePage", method = RequestMethod.GET)
	public String MyStorePageGet(HttpSession session, Model model) {
		String storeMid = (String) session.getAttribute("sMid"); 
		StoreVO vo = storeService.getStoreIdCheck(storeMid);
		
		model.addAttribute("vo",vo);
		return "store/myStorePage";
	}
	
	
	// 내 가게 메뉴 리스트 폼 이동
	@RequestMapping(value = "/myStoreMenu", method = RequestMethod.GET)
	public String myStoreMenuGet(HttpSession session, Model model) {
		String storeMid = (String) session.getAttribute("sMid"); 
		StoreVO vo = storeService.getStoreIdCheck(storeMid);
		List<FoodMenuVO> vos = storeService.getStoreFoodMenu(vo.getStoreName());
		
		model.addAttribute("vo",vo);
		model.addAttribute("vos",vos);
		
		return "store/myStoreMenu";
	}

	// 가게 메뉴 등록 폼으로 이동
	@RequestMapping(value = "/storeMenuInputSelect", method = RequestMethod.GET)
	public String storeMenuInputSelectGet(HttpSession session, Model model) {
		String storeMid = (String) session.getAttribute("sMid"); 
		StoreVO vo = storeService.getStoreIdCheck(storeMid);
		
		model.addAttribute("vo",vo);
		return "store/storeMenuInputSelect";
	}
	
	// 가게 메뉴 등록 폼으로 이동
	@RequestMapping(value = "/storeMenuInput", method = RequestMethod.GET)
	public String storeMenuInputGet(HttpSession session, Model model) {
		String storeMid = (String) session.getAttribute("sMid"); 
		StoreVO vo = storeService.getStoreIdCheck(storeMid);
		
		List<FoodMenuVO> vos = storeService.getstoreTagList(vo.getStoreName());
		
		model.addAttribute("vo",vo);
		model.addAttribute("vos",vos);
		model.addAttribute("storeName",vo.getStoreName());
		return "store/storeMenuInput";
	}
	
	// 가게 메뉴 등록 절차
	@RequestMapping(value = "/storeMenuInput", method = RequestMethod.POST)
	public String storeMenuInputPost(HttpSession session, FoodMenuVO vo, MultipartFile fName) {
		String storeMid = (String) session.getAttribute("sMid"); 
		StoreVO sVo = storeService.getStoreIdCheck(storeMid);
		
		vo.setStoreName(sVo.getStoreName());
		vo.setAdmintag("X");
		
		int res = storeService.setStoreMenuInput(vo, fName);
		
		if(res == 1) return "redirect:/msg/storeMenuInputOk"; // 정상처리가 되면 true == 1이 자동으로 넘어옴
		else return "redirect:/msg/storeMenuInputNo";
	}

	// 가게 메뉴 등록 폼으로 이동
	@RequestMapping(value = "/storeMenuInput2", method = RequestMethod.GET)
	public String storeMenuInput2Get(HttpSession session, Model model, 
			@RequestParam(name = "brandName" , defaultValue = "", required = false)	String brandName, 
			@RequestParam(name = "storeName" , defaultValue = "", required = false)	String storeName) {
		String storeMid = (String) session.getAttribute("sMid"); 
		StoreVO vo = storeService.getStoreIdCheck(storeMid);
		
		List<StoreVO> vos = storeService.getAdminStoreBrand(vo.getStorePart());
		
		List<FoodMenuVO> mVos = storeService.getstoreMenuList(brandName, storeName);
		List<FoodMenuVO> fVos = storeService.getStoreFoodMenu(storeName);
		if(fVos != null) {
			for(int i =0; i < mVos.size(); i++) {
				for(int j = 0; j < fVos.size(); j++) {
					if(mVos.get(i).getFoodName().equals((fVos.get(j).getFoodName()))){
						mVos.remove(i);
						if(mVos.size()==0) {
							model.addAttribute("brandName",brandName);
							model.addAttribute("vo",vo);
							model.addAttribute("vos",vos);
							return "store/storeMenuInput2";
						}
					};
				}
			}
		}
		model.addAttribute("mVos",mVos);
		
		model.addAttribute("brandName",brandName);
		model.addAttribute("vo",vo);
		model.addAttribute("vos",vos);
		return "store/storeMenuInput2";
	}
	
//	
//	// get방식으로 선택한 메뉴리스트 가져오기
//	@RequestMapping(value = "adminBrandMenu", method = RequestMethod.GET)
//	public String adminBrandMenuPost(String brandName, String storeName, Model model) {
//		
//		List<FoodMenuVO> mVos = storeService.getstoreMenuList(brandName, storeName);
//		
//		List<FoodMenuVO> fVos = storeService.getStoreFoodMenu(storeName);
//		
//		if(fVos != null) {
//			for(int i =0; i < mVos.size(); i++) {
//				for(int j = 0; j < fVos.size(); j++) {
//					if(mVos.get(i).getFoodName().equals((fVos.get(j).getFoodName()))){
//						mVos.remove(i);
//					};
//				}
//			}
//		}
//		
//		model.addAttribute("mVos",mVos);
//		return "store/storeMenuInput2";
//	}
//	
	
	
/*	
	// ajax로 선택한 메뉴리스트 가져오기
	@ResponseBody
	@RequestMapping(value = "adminBrandMenu", method = RequestMethod.POST)
	public List<FoodMenuVO> adminBrandMenuPost(String brandName, String storeName) {
		
		List<FoodMenuVO> vos = storeService.getstoreMenuList(brandName, storeName);
		
		List<FoodMenuVO> fVos = storeService.getStoreFoodMenu(storeName);
		
		if(fVos != null) {
			for(int i =0; i < vos.size(); i++) {
				for(int j = 0; j < fVos.size(); j++) {
					if(vos.get(i).getFoodName().equals((fVos.get(j).getFoodName()))){
						vos.remove(i);
					};
				}
			}
		}
		System.out.println("현우킹 : " + vos);
		
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
	*/
	
//선택한 프랜차이즈 메뉴 입력
	@Transactional
	@RequestMapping(value = "/adminMenuInputOk", method = RequestMethod.GET)
	public String adminMenuInputOkPost(HttpServletRequest request, String delItems, String storeName) {
		int res = 0;
		
//		FoodMenuVO tagVo = new FoodMenuVO();
		FoodMenuVO foodVo = new FoodMenuVO();
		SubFoodMenuVO subFoodVo = new SubFoodMenuVO();
		
//		System.out.println("storeName :" + storeName);
		delItems = delItems.substring(0, delItems.length()-1);
		
		String[] menuIdxs = delItems.split("/");
//		System.out.println("menuIdxs :" + menuIdxs[0]);
//		System.out.println("menuIdxs :" + Arrays.toString(menuIdxs));
//		System.out.println("menuIdxs :" + menuIdxs.length);
		
		for(int i=0; i<menuIdxs.length; i++) {
			foodVo = storeService.getAdminStoreMenu(Integer.parseInt(menuIdxs[i]));
//			tagVo = storeService.getAdminStoreTag(foodVo.getFoodName());
			
			FoodMenuVO checkTagVo = storeService.getCheckStoreTagList(foodVo.getFoodTag(), storeName);
			
			// 태그가 없으면 가게 테이블에 생성
			if(checkTagVo == null) {
				storeService.setAdminStoreTag(foodVo.getFoodTag(), storeName);
			}
			// 음식 생성
			storeService.setAdminStoreMenu(foodVo, storeName);
		}
		res = 1;
		
		return "redirect:/msg/adminMenuInputOk";
	}
	
	
	
	
	/*
	// 선택한 프랜차이즈 메뉴 입력
	@Transactional
	@ResponseBody
	@RequestMapping(value = "adminMenuInputOk", method = RequestMethod.POST)
	public String adminMenuInputOkPost(HttpServletRequest request, String delItems, String storeName) {
		int res = 0;
		
		FoodMenuVO tagVo = new FoodMenuVO();
		FoodMenuVO foodVo = new FoodMenuVO();
		SubFoodMenuVO subFoodVo = new SubFoodMenuVO();
		
//		System.out.println("storeName :" + storeName);
		delItems = delItems.substring(0, delItems.length()-1);
		
		String[] menuIdxs = delItems.split("/");
//		System.out.println("menuIdxs :" + menuIdxs[0]);
//		System.out.println("menuIdxs :" + Arrays.toString(menuIdxs));
//		System.out.println("menuIdxs :" + menuIdxs.length);
		
		for(int i=0; i<menuIdxs.length; i++) {
			foodVo = storeService.getAdminStoreMenu(Integer.parseInt(menuIdxs[i]));
			tagVo = storeService.getAdminStoreTag(foodVo.getBrandName());
			subFoodVo = storeService.getAdminStoreSubMenu(foodVo.getBrandName());
			
			FoodMenuVO checkTagVo = storeService.getCheckStoreTagList(tagVo.getFoodTag(), storeName);
			
			// 태그가 없으면 가게 테이블에 생성
			if(checkTagVo == null) {
				storeService.setAdminStoreTag(tagVo, storeName);
			}
			// 음식 생성
			storeService.setAdminStoreMenu(foodVo, storeName);
			
			// 추가 옵션이 있으면 생성
			if(subFoodVo != null) {
				storeService.setAdminStoreSubMenu(subFoodVo, storeName);
			}
		}
		res = 1;
		return res+"";
	}
	*/
	
// 선택한 메뉴 삭제
	@ResponseBody
	@RequestMapping(value = "/storeMenuDeleteOk", method = RequestMethod.POST)
	public String storeMenuDeleteOkPost(String foodName) {
		int res = 0;
		res = storeService.setStoreMenuDeleteOk(foodName);
		
		return res+"";
	}
	
// 음식 이름 중복 체크
	@ResponseBody
	@RequestMapping(value = "/foodNameCheck", method = RequestMethod.POST)
	public String foodNameCheckPost(String foodName, String storeName) {
		int res = 0;
		FoodMenuVO vo = storeService.storeFoodNameCheck(foodName, storeName);
		
		if(vo != null) return "1";
		else return res+"";
	}
	
	// 음식 수정폼으로 이동
	@RequestMapping(value = "/storeMenuUpdate", method = RequestMethod.GET)
	public String storeMenuUpdateGet(Model model, HttpSession session, String foodName) {
		
//		System.out.println("음식이름 :" + foodName);
		
		String storeMid = (String) session.getAttribute("sMid"); 
		StoreVO vo = storeService.getStoreIdCheck(storeMid);
		
//		System.out.println("가게이름 :" + vo.getStoreName());
		
		List<FoodMenuVO> vos = storeService.getstoreTagList(vo.getStoreName());
		
		FoodMenuVO fVo = storeService.storeFoodNameCheck(vo.getStoreName(), foodName);
		
		model.addAttribute("vos", vos);
		model.addAttribute("fVo", fVo);
		model.addAttribute("vo", vo);
		
		return "store/storeMenuUpdate";
	}
	
	// 음식 수정 작업
	@RequestMapping(value = "/storeMenuUpdate", method = RequestMethod.POST)
	public String storeMenuUpdatePost(FoodMenuVO vo, String pastPhoto, String pastFoodName, MultipartFile fName) {
		
		int res = storeService.setStoreMenuUpdate(vo, fName, pastPhoto, pastFoodName);
		
		if(res == 1) return "redirect:/msg/storeMenuUpdateOk";
		else return "redirect:/msg/storeMenuUpdateNo";
	}
	
	// 내 가게 음식 태그 리스트 폼으로
	@RequestMapping(value = "/myStoreTag", method = RequestMethod.GET)
	public String myStoreTagGet(Model model, HttpSession session) {
		String storeMid = (String) session.getAttribute("sMid"); 
		StoreVO vo = storeService.getStoreIdCheck(storeMid);
		
		// 음식 태그 리스트
		List<FoodMenuVO> vos = storeService.getstoreTagList(vo.getStoreName());
		
		model.addAttribute("vos", vos);
		model.addAttribute("vo", vo);
		
		return "store/myStoreTag";
	}
	
	// 내 가게 음식 태그 입력 폼으로
	@RequestMapping(value = "/storeTagInput", method = RequestMethod.GET)
	public String storeTagInputGet(Model model, HttpSession session) {
		String storeMid = (String) session.getAttribute("sMid"); 
		StoreVO vo = storeService.getStoreIdCheck(storeMid);
		
		model.addAttribute("vo", vo);
		return "store/storeTagInput";
	}
	
	// 내 가게 음식 태그 입력
	@RequestMapping(value = "/storeTagInput", method = RequestMethod.POST)
	public String storeTagInputPost(FoodMenuVO vo, HttpSession session) {
		int res = 0;
		
		String storeMid = (String) session.getAttribute("sMid"); 
		StoreVO sVo = storeService.getStoreIdCheck(storeMid);
		
		vo.setStoreName(sVo.getStoreName());
		
		res = storeService.setStoreTagInput(vo);
		
		if(res == 1) return "redirect:/msg/storeTagInputOk";
		else return "redirect:/msg/storeTagInputNo";
	}
	
	//음식 이름 중복 체크
	@ResponseBody
	@RequestMapping(value = "/foodTagCheck", method = RequestMethod.POST)
	public String foodTagCheckPost(String foodTag, String storeName) {
		int res = 0;
		FoodMenuVO vo = storeService.storefoodTagCheck(foodTag, storeName);
		
		if(vo != null) return "1";
		else return res+"";
	}
	
  // 선택한 태그 삭제 
	@ResponseBody
	@RequestMapping(value = "/storeTagDeleteOk", method = RequestMethod.POST)
	public String storeTagDeleteOkPost(String foodTag, String storeName) {
		int res = 0;
		
		List<FoodMenuVO> vos = storeService.getStoreFoodMenuByTag(storeName, foodTag);
		
		if(vos.size() != 0) {
			return "0";
		}
		
		res = storeService.storefoodTagDelete(foodTag);
		if(res == 1) return "1";
		else return res+"";
	}
	
	// 선택한 태그 수정 
	@RequestMapping(value = "/storeTagUpdate", method = RequestMethod.GET)
	public String storeTagUpdateGet(String foodTag, Model model, HttpSession session) {
		String storeMid = (String) session.getAttribute("sMid"); 
		StoreVO vo = storeService.getStoreIdCheck(storeMid);
		
		FoodMenuVO sVo = storeService.getCheckStoreTagList(foodTag, vo.getStoreName());
		
		model.addAttribute("vo", vo);
		model.addAttribute("sVo", sVo);
		
		return "store/storeTagUpdate";
	}
	
	// 선택한 태그 수정 
	@RequestMapping(value = "/storeTagUpdate", method = RequestMethod.POST)
	public String storeTagUpdatePost(FoodMenuVO vo, String oldTag, HttpSession session) {
		String storeMid = (String) session.getAttribute("sMid"); 
		StoreVO sVo = storeService.getStoreIdCheck(storeMid);
		
		int res = 0;
		res = storeService.setStoreTagUpdate(vo, oldTag, sVo.getStoreName());
		
		
		if(res == 1) return "redirect:/msg/storeTagUpdateOk";
		else return "redirect:/msg/storeTagUpdateNo";
	}

	// 해당 가게의 태그 리스트 
	@RequestMapping(value = "/myStoreSubOption", method = RequestMethod.GET)
	public String myStoreSubOptionGet(HttpSession session, Model model) {
		String storeMid = (String) session.getAttribute("sMid"); 
		StoreVO vo = storeService.getStoreIdCheck(storeMid);
		
		// 음식 태그 리스트
		List<FoodMenuVO> vos = storeService.getstoreTagList(vo.getStoreName());
		
		model.addAttribute("vos", vos);
		model.addAttribute("vo", vo);
		
		return "store/myStoreSubOption";
	}
	
	// 해당 태그의 서브 메뉴 리스트 
	@RequestMapping(value = "/myStoreSubMenu", method = RequestMethod.GET)
	public String myStoreSubMenuGet(HttpSession session, Model model, String foodTag) {
		String storeMid = (String) session.getAttribute("sMid"); 
		StoreVO vo = storeService.getStoreIdCheck(storeMid);
		
		// 서브 메뉴 리스트 
		List<SubFoodMenuVO> vos = storeService.getstoreSubMenuList(vo.getStoreName(),foodTag);
		
		model.addAttribute("foodTag", foodTag);
		model.addAttribute("cVos", vos);
		model.addAttribute("vo", vo);
		
		return "store/myStoreSubMenu";
	}

	// 서브 메뉴 추가 폼 이동 
	@RequestMapping(value = "/myStoreSubMenuInput", method = RequestMethod.GET)
	public String storeSubMenuInputGet(HttpSession session, Model model, String foodTag) {
		String storeMid = (String) session.getAttribute("sMid"); 
		StoreVO vo = storeService.getStoreIdCheck(storeMid);
		
		model.addAttribute("foodTag", foodTag);
		model.addAttribute("vo", vo);
		
		return "store/myStoreSubMenuInput";
	}
	
	//추가 메뉴 이름 중복 체크
	@ResponseBody
	@RequestMapping(value = "/subMenuNameCheck", method = RequestMethod.POST)
	public String subMenuNameCheckPost(String subMenuName, String storeName, String foodTag) {
		int res = 0;
		SubFoodMenuVO vo = storeService.storeSubMenuNameCheck(subMenuName, storeName, foodTag);
		
		if(vo != null) return "1";
		else return res+"";
	}

	//추가 메뉴 삭제
	@ResponseBody
	@RequestMapping(value = "/storeSubMenuDeleteOk", method = RequestMethod.POST)
	public String storeSubMenuDeleteOkPost(int subMenuIdx) {
		int res = 0;
		
		res = storeService.setStoreSubMenuDelete(subMenuIdx);
		
		if(res == 1) return "1";
		else return res+"";
	}
	
	// 서브 메뉴 추가 작업
	@RequestMapping(value = "/myStoreSubMenuInput", method = RequestMethod.POST)
	public String storeSubMenuInputPost(SubFoodMenuVO vo) throws UnsupportedEncodingException {
		int res = 0;
		
		res = storeService.setStoreSubMenuInput(vo);
		
		if(res == 1) return "redirect:/msg/subMenuInputOk?foodTag="+URLEncoder.encode(vo.getFoodTag(), "UTF-8");
		else return "store/subMenuInputNo?foodTag="+URLEncoder.encode(vo.getFoodTag(), "UTF-8");
	}
	
	// 서브 메뉴 수정 폼 이동
	@RequestMapping(value = "/myStoreSubMenuUpdate", method = RequestMethod.GET)
	public String myStoreSubMenuUpdateGet(HttpSession session, int subMenuIdx, Model model) {
		String storeMid = (String) session.getAttribute("sMid"); 
		StoreVO vo = storeService.getStoreIdCheck(storeMid);
		SubFoodMenuVO sVo = storeService.getSubMenuInfo(subMenuIdx);
		
		model.addAttribute("vo",vo);
		model.addAttribute("sVo",sVo);
		
		return "store/myStoreSubMenuUpdate";
	}
	
	// 서브 메뉴 수정 작업
	@RequestMapping(value = "/myStoreSubMenuUpdate", method = RequestMethod.POST)
	public String myStoreSubMenuUpdatePost(SubFoodMenuVO vo) throws UnsupportedEncodingException {
		int res = 0;
		
		res = storeService.setSubMenuUpdateOk(vo);
		
		if(res == 1) return "redirect:/msg/subMenuUpdateOk?foodTag="+URLEncoder.encode(vo.getFoodTag(), "UTF-8");
		else return "redirect:/msg/subMenuUpdateNo?foodTag="+URLEncoder.encode(vo.getFoodTag(), "UTF-8");
	}
	
	// 선택한 메뉴 상세 정보 창으로
	@RequestMapping(value = "/storeMenuInfo", method = RequestMethod.GET)
	public String storeMenuInfoGet(int menuIdx, Model model)  {
		
		FoodMenuVO fVo = storeService.getfoodInfo(menuIdx);
		StoreVO vo = storeService.getstoreInfo(fVo.getStoreName());
		
		List<FoodMenuVO> rVos = storeService.getStoreFoodMenuByTag(fVo.getStoreName(), fVo.getFoodTag());
		List<SubFoodMenuVO> vos = storeService.getstoreSubMenuList(fVo.getStoreName(), fVo.getFoodTag());
		
		model.addAttribute("vo", vo);
		model.addAttribute("rVos", rVos);
		model.addAttribute("fVo", fVo);
		model.addAttribute("vos", vos);
		
		return "store/storeMenuInfo";
	}
	
	// 해당 가게의 평점 리스트로
	@RequestMapping(value = "/storeRatingList", method = RequestMethod.GET)
	public String storeRatingListGet(Model model, HttpSession sesstion,
			@RequestParam(name="storeName", defaultValue = "", required = false) String storeName,
		@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
		@RequestParam(name="pageSize", defaultValue = "5", required = false) int pageSize) {

		if(storeName.equals("")) {
			storeName = (String)sesstion.getAttribute("sbrandName");
		}
		
		// 해당 가게의 평점 총 갯수 구하기
		PageVO pageVo = pageProcess.totRecCnt(pag, pageSize, "rating", storeName, "");
	
		StoreVO vo = storeService.getstoreInfo(storeName);
		
		List<RatingVO> rVos = storeService.getRatingList(pageVo.getStartIndexNo(), pageSize, storeName);
		
//		if(rVos.size() != 0) {
//			List<ratingReplyVO> rrVos = new ArrayList<ratingReplyVO>();
//			for(int i=0; i<rVos.size(); i++) {
//				
//				List<ratingReplyVO> rrvo = storeService.getRatingReply(rVos.get(i).getIdx());
//				rrVos.addAll(rrvo);
//			}
//			
//			model.addAttribute("rrVos", rrVos);
//			System.out.println("rrvos : " + rrVos);
//		}
		
		
		model.addAttribute("vo", vo);
		model.addAttribute("pageVo", pageVo);
		model.addAttribute("rVos", rVos);
			
		
		return "store/storeRatingList";
	}
	
//선택한 별점 삭제
	@ResponseBody
	@RequestMapping(value = "/ratingDelete", method = RequestMethod.POST)
	public String ratingDeletePost(int idx) {
		
		
		RatingVO vo = storeService.getRatingInfo(idx);
		if(vo.getContent().indexOf("src=\"/") != -1) orderService.imgDelete(vo.getContent());
		
		int res = 0;
		storeService.setRatingReplyDeleteAll(idx);
		res = storeService.setRatingDeleteOk(idx);
		
		return res+"";
	}

	//선택한 별점 수정 폼 이동
	@RequestMapping(value = "/ratingUpdate", method = RequestMethod.GET)
	public String ratingUpdateGet(int idx, HttpSession session, Model model) throws UnsupportedEncodingException {
		
		RatingVO vo = storeService.getRatingInfo(idx);
		
		String mid = (String) session.getAttribute("sMid");
		
		if(!vo.getMid().equals(mid)) return "redirect:/msg/ratingUpdateNo?storeName="+URLEncoder.encode(vo.getStoreName(), "UTF-8");
		
		model.addAttribute("vo", vo);
		
		return "order/ratingUpdate";
	}
	
	//선택한 별점 수정 작업
	@RequestMapping(value = "/ratingUpdate", method = RequestMethod.POST)
	public String ratingUpdateGet(RatingVO vo) throws UnsupportedEncodingException {
		
	// 수정된 자료가 원본자료와 완전히 동일하다면 수정할 필요가 없기에, DB에 저장된 원본 자료를 불러와서 비교해준다.
		RatingVO origVo = storeService.getRatingInfo(vo.getIdx());
		
	// content의 내용이 조금이라도 변경된것이 있다면 아래 내용을 수행처리시킨다.
			if(!origVo.getContent().equals(vo.getContent())) {
				// 실제로 수정하기버튼을 클릭하게되면 기존의 board폴더에 저장된 현재 content의 그림파일 모두를 삭제 시킨다.
				if(origVo.getContent().indexOf("src=\"/") != -1) orderService.imgDelete(origVo.getContent());
				
				// vo.GetContent()에 들어있는 파일의 경로는 'ckeditor/board'경로를 'ckeditor'변경시켜줘야한다.
				vo.setContent(vo.getContent().replace("/data/ckeditor/rating/", "/data/ckeditor/"));
				
				// 앞의 모든준비가 끝나면, 파일을 처음 업로드한것과 같은 작업을 처리한다.
				// 이 작업은 처음 게시글을 올릴때의 파일복사 작업과 동일한 작업이다.
				orderService.imgCheck(vo.getContent());
				
				// 파일 업로드가 끝나면 다시 경로를 수정한다.'ckeditor'경로를 'ckeditor/board'변경시켜줘야한다.(즉, 변경된 vo.getContent()를 vo.setContent() 처리한다.)
				vo.setContent(vo.getContent().replace("/data/ckeditor/", "/data/ckeditor/rating/"));
			}
		
		// 잘 정비된 vo를 DB에 Update시켜준다.
			int res = storeService.setRatingUpdateOk(vo);
			
			if(res == 1) return "redirect:/msg/ratingUpdateOk?storeName="+URLEncoder.encode(vo.getStoreName(), "UTF-8");
			
			else return "redirect:/msg/ratingUpdateFail?storeName="+URLEncoder.encode(vo.getStoreName(), "UTF-8");
	}
	
	
//내 주문내역 리스트로
	@Async
	@ResponseBody
	@RequestMapping(value = "storeEmailCheck", method = RequestMethod.POST)
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
   String title = "[저기요] 메일 인증";
   String content = "";
		
		try {
			// 메일을 전송하기 위한 객체 : MimeMessage() , MimeMessageHelper()
			MimeMessage message = mailSender.createMimeMessage(); // 타입변환
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8"); //보관함에 저장하는곳
			
			
			content = content.replace("\n", "<br/>");
			content += "메일 인증번호입니다</n>";
			content += "===================";
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
	@RequestMapping(value = "storeEmailCheckOk", method = RequestMethod.POST)
	public String memberEmailCheckPost(String emailCode, HttpSession session) {
		String res = "1";
		
		String code = (String)session.getAttribute("sCode");
		
		if(!code.equals(emailCode)) return "0";
		
		else return res;
	}
	
	
	// 평점 댓글 달기
	@ResponseBody
	@RequestMapping(value = "storeReplyInput", method = RequestMethod.POST)
	public String storeReplyInputPost(ratingReplyVO vo) {
		int res = 0;
		
		res = storeService.setRatingReplyInput(vo);
		
		if(res == 1) return "1";
		
		else return res+"";
	}
	
	// 평점 댓글 불러오기
	@ResponseBody
	@RequestMapping(value = "getCommentList", method = RequestMethod.POST)
	public List<ratingReplyVO> getCommentListPost(int idx) {
		int res = 0;
		
		List<ratingReplyVO> vos = storeService.getRatingCommentList(idx);
		
		System.out.println("vos : " + vos );
		
		return vos;
	}
	
	// 평점 대댓글 불러오기
	@ResponseBody
	@RequestMapping(value = "getCommentList2", method = RequestMethod.POST)
	public List<ratingReplyVO> getCommentListPost2(int ratingIdx, int idx) {
		int res = 0;
		
		List<ratingReplyVO> vos = storeService.getRatingCommentList2(ratingIdx, idx);
		
		return vos;
	}
	
	
	// 평점 댓글 달기
	@ResponseBody
	@RequestMapping(value = "storeReReplyInput", method = RequestMethod.POST)
	public String storeReReplyInputPost(ratingReplyVO vo) {
		int res = 0;
		
		res = storeService.setRatingReReplyInput(vo);
		
		if(res == 1) return "1";
		
		else return res+"";
	}
	
	// 댓글 수정
	@ResponseBody
	@RequestMapping(value = "storeReplyUpdate", method = RequestMethod.POST)
	public String storeReplyUpdatePost(ratingReplyVO vo) {
		int res = 0;
		
		res = storeService.setRatingReplyUpdate(vo);
		
		if(res == 1) return "1";
		
		else return res+"";
	}
	
	// 댓글 삭제 처리
	@ResponseBody
	@RequestMapping(value = "storeReplydelete", method = RequestMethod.POST)
	public String storeReplydeletePost(int idx) {
		int res = 0;
		
		ratingReplyVO vo = storeService.getReplyComment(idx);
		
		if(vo.getReplylevel()==0) {
			List<ratingReplyVO> vos = storeService.getReplyParent(idx);
			if(vos.size() == 0) {
				res = storeService.setReplyDelete(idx);
			}
			else {
				res = storeService.setReplyDeleteUpdate(idx);
			}
			
		}
		else {
			res = storeService.setReplyDelete(idx);
			List<ratingReplyVO> vos = storeService.getReplyParent(vo.getReplyIdx());
			ratingReplyVO vo2 = storeService.getReplyComment(vo.getReplyIdx());
			
			if(vos.size()==0 && vo2.getReplylevel()==3) {
				res = storeService.setReplyDelete(vo.getReplyIdx());
				return "1";
			}
		}
		
		if(res == 1) return "1";
		
		else return res+"";
	}
	
	// 평점 신고
	@ResponseBody
	@RequestMapping(value = "reportRating", method = RequestMethod.POST)
	public String reportRatingPost(int idx, HttpSession session) {
		int res = 0;
		String mid = (String)session.getAttribute("sMid");
		
		RatingVO vo = storeService.getRatingInfo(idx);
		
		if(vo.getReportRatingMid()!=null) {
			
			String[] report = vo.getReportRatingMid().split("/");
			
			for(int i = 0; i<report.length; i++) {
				if(report[i].equals(mid)) {
					
					return "3";
				}
			}
			
		}
		
		String rMid = vo.getMid();
		res = storeService.setReportRating(idx, mid);
		res = memberService.setReportRating(rMid);
		
		if(res == 1) return "1";
		
		else return res+"";
	}
	
	// 댓글 수정
	@ResponseBody
	@RequestMapping(value = "storeNameCheckOk", method = RequestMethod.POST)
	public String storeNameCheckOkPost(String storeName) {
		int res = 0;
		
		StoreVO vo = storeService.getCheckStoreName(storeName);
		
		if(vo == null) return "1";
		else return res+"";
	}
	
	// 가게 수정
	@RequestMapping(value = "storeUpdate", method = RequestMethod.POST)
	public String storeUpdatePost(HttpSession session ,String options, String pwd) {
		
		String storeMid = (String) session.getAttribute("sMid"); 
		StoreVO vo = storeService.getStoreIdCheck(storeMid);
		
		if(passwordEncoder.matches(pwd, vo.getStorePwd())) {
			if(options.equals("mid")) {
				
				return "redirect:/msg/storePwdCheckOk";
			}
			else {
				return "redirect:/msg/storePwdCheckOk2";
			}
		}
		else {
			return "redirect:/msg/storePwdCheckNo";
		}
	}
	
	@RequestMapping(value = "/storeUpdateOk", method = RequestMethod.GET)
	public String memberUpdateGet(HttpSession session, Model model) {
		String mid = (String)session.getAttribute("sMid");
		
		StoreVO vo = storeService.getStoreIdCheck(mid);
		
		System.out.println("vo : " + vo);
		
		String[] address = vo.getStoreAddress().split("/");
		String address1 = address[0];
		String address2 = address[1];
		
		String[] tel = vo.getStoreNumber().split("-");
		String tel1 = tel[0];
		String tel2 = tel[1];
		String tel3 = tel[2];
		
		String[] email = vo.getStoreEmail().split("@");
		String email1 = email[0];
		String email2 = email[1];
		
		String[] storeTime = vo.getStoreTime().split("~");
		String storeTime1 = storeTime[0];
		String storeTime2 = storeTime[1];
		
		String hostname = vo.getHostName();
		
		// 음식 카테고리 가져오기
		List<StoreVO> vos = storeService.getStoreCategory();
		
		model.addAttribute("vo", vo);
		model.addAttribute("hostname", hostname);
		model.addAttribute("vos", vos);
		model.addAttribute("address1", address1);
		model.addAttribute("address2", address2);
		model.addAttribute("storeTime1", storeTime1);
		model.addAttribute("storeTime2", storeTime2);
		model.addAttribute("tel1", tel1);
		model.addAttribute("tel2", tel2);
		model.addAttribute("tel3", tel3);
		model.addAttribute("email1", email1);
		model.addAttribute("email2", email2);
		
		return "store/storeUpdate";
	}
	
	@RequestMapping(value = "/storeUpdateOk", method = RequestMethod.POST)
	public String memberUpdatePost(StoreVO vo, MultipartFile fName, String pastPhoto) {
		
		int res = storeService.setStoreUpdate(vo, fName, pastPhoto);
		
		if(res == 1) return "redirect:/msg/storeUpdateOk";
		
		else return "redirect:/msg/storeUpdateNo";
	}
	
	@RequestMapping(value = "/storePwdUpdateOk", method = RequestMethod.GET)
	public String storePwdUpdateGet(HttpSession session, Model model) {
		String mid = (String)session.getAttribute("sMid");
		
		StoreVO vo = storeService.getStoreIdCheck(mid);
		
		model.addAttribute("vo", vo);
		return "store/storePwdUpdate";
	}
	
	
	// 비밀번호 업데이트
	@RequestMapping(value = "/storePwdUpdateOk", method = RequestMethod.POST)
	public String memberPwdUpdateGet(String oldPwd, String newPwd, HttpSession session) {
		String mid = (String)session.getAttribute("sMid");
		
		StoreVO vo = storeService.getStoreIdCheck(mid);
		
		if(passwordEncoder.matches(oldPwd, vo.getStorePwd())) {
			
			newPwd = passwordEncoder.encode(newPwd);
			
			int res = storeService.setStorePwdUpdate(newPwd , mid);
			
			if(res==1) return "redirect:/msg/storeUpdatePwdOk";
			else return "redirect:/msg/storeUpdatePwdNo";
		}
		else {
			return "redirect:/msg/storeUpdatePwdNo2";
		}
	}
	
	// 회원탈퇴 폼 이동
	@RequestMapping(value = "/storeDelete", method = RequestMethod.GET)
	public String memberDeleteGet(HttpSession session, Model model) {
		String mid = (String)session.getAttribute("sMid");
		
		StoreVO vo = storeService.getStoreIdCheck(mid);
		model.addAttribute("vo", vo);
		
		return "store/storeDelete";
	}
	
	
//삭제 전 이메일 인증
	@ResponseBody
	@RequestMapping(value = "/storeDeleteCheck", method = RequestMethod.POST)
	public String memberDeleteCheckPost(String storeMid, String storePwd, HttpSession session) {
		int res = 0;
		
		StoreVO vo = storeService.getStoreIdCheck(storeMid);
		
		if(vo==null || !passwordEncoder.matches(storePwd, vo.getStorePwd())) {
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
   
   String toMail = vo.getStoreEmail();
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
	@RequestMapping(value = "/storeDeleteCodeCheck", method = RequestMethod.POST)
	public String memberDeleteCodeCheckPost(String code, HttpSession session) {
		String sCode = (String) session.getAttribute("sCode");
		
		if(sCode.equals(code)) return "1";
		
		else return "2";
	}
	
	// 계정 삭제 처리
	@RequestMapping(value = "/storeDeleteOk", method = RequestMethod.GET)
	public String memberDeleteOkGet(HttpSession session) {
		
		String mid = (String)session.getAttribute("sMid");
		
		int res = storeService.setStoreDelete(mid);
		
		if(res==1) return "redirect:/msg/riderDeleteOk";
		else return "redirect:/msg/storeDeleteNo";
	}
	
}

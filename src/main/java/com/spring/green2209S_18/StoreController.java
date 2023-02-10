package com.spring.green2209S_18;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
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
import com.spring.green2209S_18.vo.SubFoodMenuVO;
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
			@RequestParam(name = "ordered" , defaultValue = "", required = false) String ordered) {
		
		// 가게 리스트 가져오기
		List<StoreVO> vos = storeService.getStoreList(storePart, ordered);
		
		model.addAttribute("vos", vos);
		model.addAttribute("storePart", storePart);
		return "store/storeList";
	}
	
	// 지도에 내 주변 가게 리스트 불러오기
	@RequestMapping(value = "/shopNear", method = RequestMethod.GET)
	public String shopNearGet(Model model, HttpSession session, 
			@RequestParam(name = "storePart" , defaultValue = "", required = false) String storePart,
			@RequestParam(name = "distance" , defaultValue = "1000", required = false) int distance) {
		
		System.out.println("거리 : " + distance);
		
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
			@RequestParam(name = "foodTag" , defaultValue = "", required = false) String foodTag) {
		
		StoreVO vo = storeService.getStoreMenu(idx);
		// 메뉴 리스트
		List<FoodMenuVO> vos = storeService.getStoreFoodMenuByTag(vo.getStoreName(),foodTag);
		// 음식 태그 리스트
		List<FoodMenuVO> tVos = storeService.getstoreTagList(vo.getStoreName());
		model.addAttribute("vo", vo);
		model.addAttribute("vos",vos);
		model.addAttribute("vSize",vos.size());
		model.addAttribute("tVos",tVos);
		
		System.out.println("vSize : " + vos.size());
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
		
		System.out.println("값 : " + delItems);
		
		String[] menuIdxs = delItems.split("/");
//		System.out.println("menuIdxs :" + menuIdxs[0]);
//		System.out.println("menuIdxs :" + Arrays.toString(menuIdxs));
//		System.out.println("menuIdxs :" + menuIdxs.length);
		
		for(int i=0; i<menuIdxs.length; i++) {
			foodVo = storeService.getAdminStoreMenu(Integer.parseInt(menuIdxs[i]));
//			tagVo = storeService.getAdminStoreTag(foodVo.getFoodName());
			
			subFoodVo = storeService.getAdminStoreSubMenu(foodVo.getBrandName());
			
			FoodMenuVO checkTagVo = storeService.getCheckStoreTagList(foodVo.getFoodTag(), storeName);
			
			System.out.println("vo : " + foodVo);
			
			// 태그가 없으면 가게 테이블에 생성
			if(checkTagVo == null) {
				storeService.setAdminStoreTag(foodVo.getFoodTag(), storeName);
			}
			// 음식 생성
			storeService.setAdminStoreMenu(foodVo, storeName);
			
			// 추가 옵션이 있으면 생성
			if(subFoodVo != null) {
				storeService.setAdminStoreSubMenu(subFoodVo, storeName);
			}
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
		
		System.out.println("fVo : " + fVo);
		
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
	
}

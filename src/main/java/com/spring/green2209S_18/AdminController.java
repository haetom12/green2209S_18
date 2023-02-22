package com.spring.green2209S_18;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.List;

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

import com.spring.green2209S_18.pagenation.PageProcess;
import com.spring.green2209S_18.pagenation.PageVO;
import com.spring.green2209S_18.service.AdminService;
import com.spring.green2209S_18.service.StoreService;
import com.spring.green2209S_18.vo.FoodMenuVO;
import com.spring.green2209S_18.vo.MemberVO;
import com.spring.green2209S_18.vo.StoreVO;
@Controller
@RequestMapping("/admin")
public class AdminController {
	
	@Autowired
	AdminService adminService;
	
	@Autowired
	StoreService storeService;
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	
	@Autowired
	PageProcess pageProcess;
	
	//어드민 페이지로
	@RequestMapping(value = "adminMain", method = RequestMethod.GET)
	public String adminMain() {
		
		return "admin/adminMain2";
	}
	
	//음식 카테고리 설정
	@RequestMapping(value = "adminShopCategory", method = RequestMethod.GET)
	public String shopCategoryMainGet(Model model) {
		
		// 음식 카테고리 가져오기
		List<StoreVO> vos = storeService.getStoreCategory();
		
		model.addAttribute("vos", vos);
		return "admin/category/adminShopCategory";
	}
	//음식 카테고리 추가 폼 이동
	@RequestMapping(value = "adminCategoryInput", method = RequestMethod.GET)
	public String adminCategoryInputGet() {
		
		return "admin/category/adminCategoryInput";
	}
	
	// 카테고리 중복 체크
	@ResponseBody
	@RequestMapping(value = "categoryCodeCheck", method = RequestMethod.POST)
	public String categoryCodeCheckPost(String categoryStoreCode) {
		
		String res = "1";
		StoreVO vo = adminService.getcategoryCodeCheck(categoryStoreCode);
		
		if(vo == null) res = "0";
		return res;
	}
	
	// 카테고리 중복 체크2
	@ResponseBody
	@RequestMapping(value = "categoryCodeCheck2", method = RequestMethod.POST)
	public String categoryCodeCheck2Post(String storePart) {
		
		String res = "1";
		StoreVO vo = adminService.getcategoryCodeCheck2(storePart);
		
		if(vo == null) res = "0";
		return res;
	}

	
	//음식 카테고리 등록
	@RequestMapping(value = "adminCategoryInput", method = RequestMethod.POST)
	public String adminCategoryInputPost(StoreVO vo, MultipartFile fName) {
		
		StoreVO vo1 = adminService.getcategoryCodeCheck(vo.getCategoryStoreCode());
		StoreVO vo2 = adminService.getcategoryCodeCheck2(vo.getStorePart());
		
		if(vo1 != null || vo2 != null) return "redirect:/msg/CategoryAlready";
		
		int res = adminService.setCategoryInput(vo,fName);
		if(res == 1) return "redirect:/msg/CategoryInputOk"; // 정상처리가 되면 true == 1이 자동으로 넘어옴
		else return "redirect:/msg/CategoryInputNo";
	}
	
	// 카테고리 삭제
	@ResponseBody
	@RequestMapping(value = "adminCategoryDelete", method = RequestMethod.POST)
	public String adminCategoryDelete(StoreVO vo) {
		int res = 0;
		
		List<StoreVO> vos = adminService.getCategoryList(vo);
		if(vos.size() != 0) return "0";
		
		StoreVO vo2 = adminService.getcategoryCodeCheck2(vo.getStorePart());
		
		res = adminService.setCategoryDelete(vo2);
		
		return res+"";
	}
	
	// 카테고리 수정 폼
	@RequestMapping(value = "adminUpdateCategory", method = RequestMethod.GET)
	public String adminUpdateCategoryGet(String storePart, Model model) {
		
		StoreVO vo = adminService.getcategoryCodeCheck2(storePart);
		model.addAttribute("vo", vo);
		
		return "admin/category/adminUpdateCategory";
	}
	
	// 카테고리 수정 절차
	@RequestMapping(value = "adminUpdateCategoryOk", method = RequestMethod.POST)
	public String adminUpdateCategoryPost(StoreVO vo, MultipartFile fName, String pastPhoto, String pastCode) {
		
		System.out.println("vo : " + vo);
		System.out.println("fname" + fName);
		
		int res = adminService.setCategoryUpdate(fName,vo,pastPhoto,pastCode);
		
		if(res == 1) return "redirect:/msg/CategoryUpdateOk"; // 정상처리가 되면 true == 1이 자동으로 넘어옴
		else return "redirect:/msg/CategoryUpdateNo";
	}
	
	// 어드민이 기본으로 넣어둔 메뉴
	@RequestMapping(value = "adminStoreMain", method = RequestMethod.GET)
	public String adminStoreMenuGet() {
		
		return "admin/menu/adminStoreMain";
	}

	// 어드민이 음식 프랜차이즈 리스트 폼 이동
	@RequestMapping(value = "storeBrandList", method = RequestMethod.GET)
	public String addStoreBrandGet(Model model) {
		
		// 음식 프렌차이즈 가져오기
		List<StoreVO> vos = adminService.getStoreBrandList();
		
		model.addAttribute("vos", vos);
		
		return "admin/menu/storeBrandList";
	}
	
	// 음식 프렌차이즈 리스트 추가 폼 이동
	@RequestMapping(value = "adminStoreBrandInput", method = RequestMethod.GET)
	public String adminStoreBrandInputGet(Model model) {
		
		// 음식 카테고리 가져오기
		List<StoreVO> vos = storeService.getStoreCategory();
		
		model.addAttribute("vos", vos);
		
		return "admin/menu/adminStoreBrandInput";
	}
	
	// 프랜차이즈 이름 중복 체크
	@ResponseBody
	@RequestMapping(value = "storebrandNameCheck", method = RequestMethod.POST)
	public String storebrandNameCheckPost(String storePart,String brandName) {
		int res = 1;
		StoreVO vo = adminService.getBrandNameCheck(storePart,brandName);
		
		if(vo == null) res = 0;
		return res+"";
	}
	
	// 음식 프렌차이즈 리스트 추가 폼 이동
	@RequestMapping(value = "adminStoreBrandInput", method = RequestMethod.POST)
	public String adminStoreBrandInputPost(StoreVO vo) {
		
		int res = adminService.setStoreBrandInputOk(vo);
		
		if(res == 1) return "redirect:/msg/brandInputOk"; // 정상처리가 되면 true == 1이 자동으로 넘어옴
		else return "redirect:/msg/brandInputNo";
	}
	
	// 음식 프렌차이즈 리스트 수정 폼 이동
	@RequestMapping(value = "adminStoreBrandUpdate", method = RequestMethod.GET)
	public String adminStoreBrandUpdateGet(String brandName, Model model) {
		
		StoreVO vo = adminService.getstoreBrand(brandName);

		// 음식 카테고리 가져오기
		List<StoreVO> vos = storeService.getStoreCategory();
		
		model.addAttribute("vos", vos);
		model.addAttribute("vo", vo);
		
		return "admin/menu/adminStoreBrandUpdate";
	}
	
	// 음식 프렌차이즈 리스트 수정
	@RequestMapping(value = "adminStoreBrandUpdate2", method = RequestMethod.GET)
	public String adminStoreBrandUpdatePost(StoreVO vo, String oldBrandName) {
		
		int res = adminService.StoreBrandUpdateOk(vo, oldBrandName);
		
		if(res == 1) return "redirect:/msg/brandUpdateOk"; // 정상처리가 되면 true == 1이 자동으로 넘어옴
		else return "redirect:/msg/brandUpdateNo";
	}
	
	//프랜차이즈 삭제
	@ResponseBody
	@RequestMapping(value = "adminBrandDelete", method = RequestMethod.POST)
	public String adminBrandDeleteGet(String brandName) {
		int res = 0;
		
		List<FoodMenuVO> vos = adminService.getstoreMenuList(brandName);
		
		if(vos.size() != 0) return "0";
		
		res = adminService.setadminBrandDelete(brandName);
		return res+"";
	}
	
	// 수정및 추가 할 프랜차이즈 리스트 폼 이동
	@RequestMapping(value = "storeBrandOptionList", method = RequestMethod.GET)
	public String storeBrandOptionListGet(Model model) {
		
		// 음식 프렌차이즈 가져오기
		List<StoreVO> vos = adminService.getStoreBrandList();
		
		model.addAttribute("vos", vos);
		
		return "admin/menu/storeBrandOptionList";
	}
	
	// 선택한 프랜차이즈 음식메뉴 리스트 폼 이동
	@RequestMapping(value = "storeMenuList", method = RequestMethod.GET)
	public String storeMenuListGet(Model model, String brandName) {
		
		// 음식 프렌차이즈 가져오기
		List<FoodMenuVO> vos = adminService.getstoreMenuList(brandName);
		
		model.addAttribute("brandName", brandName);
		model.addAttribute("vos", vos);
		
		return "admin/menu/storeMenuList";
	}
	
	// 선택한 프랜차이즈의 메뉴 태그 리스트 폼 이동
	@RequestMapping(value = "storeTagList", method = RequestMethod.GET)
	public String storeUpdateTagListGet(Model model, String brandName) {
		
		// 음식 태그 가져오기
		List<FoodMenuVO> vos = adminService.getstoreTagList(brandName);
		
		model.addAttribute("brandName", brandName);
		model.addAttribute("vos", vos);
		
		return "admin/menu/storeTagList";
	}

	// 프랜차이즈 메뉴 입력 폼 이동
	@RequestMapping(value = "adminStoreMenuInput", method = RequestMethod.GET)
	public String adminStoreMenuInputGet(String brandName, Model model) {
		
		StoreVO vo = adminService.getstoreBrand(brandName);
		List<FoodMenuVO> vos = adminService.getstoreTagList(brandName);
		
		model.addAttribute("vo",vo);
		model.addAttribute("vos",vos);
		
		return "admin/menu/adminStoreMenuInput";
	}

	// 프랜차이즈 메뉴 등록
	@RequestMapping(value = "adminStoreMenuInput", method = RequestMethod.POST)
	public String adminStoreMenuInputPost(FoodMenuVO vo, MultipartFile fName) throws UnsupportedEncodingException {
		
		int res = adminService.setAdminMenuInput(vo,fName);
		
		if(res == 1) return "redirect:/msg/adminStoreMenuInputOk?brandName="+URLEncoder.encode(vo.getBrandName(), "UTF-8"); // 정상처리가 되면 true == 1이 자동으로 넘어옴
		else return "redirect:/msg/adminStoreMenuInputNo?brandName="+URLEncoder.encode(vo.getBrandName(), "UTF-8"); // 정상처리가 되면 true == 1이 자동으로 넘어옴
	}
	
	// 프랜차이즈 메뉴 태그 입력 폼 이동
	@RequestMapping(value = "adminStoreTagInput", method = RequestMethod.GET)
	public String adminStoreTagInputGet(String brandName, Model model) {
		StoreVO vo = adminService.getstoreBrand(brandName);
		
		model.addAttribute("vo",vo);
		
		return "admin/menu/adminStoreTagInput";
	}

//	// 프랜차이즈 태그 중복 확인
//	@ResponseBody
//	@RequestMapping(value = "adminFoodTagCheck", method = RequestMethod.POST)
//	public String adminFoodTagCheckPost(String brandName, 
//		@RequestParam(name = "foodTag", defaultValue = "", required = false) String foodTag) {
//		int res = 1;
//		
//		FoodMenuVO vo = adminService.getFoodTagCheck(brandName, foodTag);
//		
//		if(vo == null) res = 0;
//		return res+"";
//	}
	
	// 프랜차이즈 태그 중복 확인
	@ResponseBody
	@RequestMapping(value = "adminFoodTagCheck", method = RequestMethod.POST)
	public String adminFoodTagCheckPost(String brandName, 
			@RequestParam(name = "foodTag", defaultValue = "", required = false) String foodTag) {
		int res = 1;
		
		List<FoodMenuVO> vos = adminService.getFoodTagCheck(brandName, foodTag);
		
		if(vos.size()==0) res = 0;
		return res+"";
	}
	
	// 프랜차이즈 메뉴 태그 입력
	@RequestMapping(value = "adminStoreTagInput2", method = RequestMethod.GET)
	public String adminStoreTagInputPost(FoodMenuVO vo) throws UnsupportedEncodingException {
		
		int res = adminService.storeTagInputOk(vo);
		
		String brandName = vo.getBrandName();
		
		if(res == 1) return "redirect:/msg/tagInputOk?brandName="+URLEncoder.encode(brandName, "UTF-8"); // 정상처리가 되면 true == 1이 자동으로 넘어옴
		else return "redirect:/msg/tagInputNo?brandName="+URLEncoder.encode(brandName, "UTF-8");
	}
	
	// 프랜차이즈 메뉴 태그 수정 폼 이동
	@RequestMapping(value = "adminStoreTagUpdate", method = RequestMethod.GET)
	public String adminstoreUpdateTagListGet(String brandName, String foodTag, Model model) {
		
		model.addAttribute("brandName",brandName);
		model.addAttribute("foodTag",foodTag);
		
		return "admin/menu/adminStoreTagUpdate";
	}
	
	// 프랜차이즈 메뉴 태그 수정
	@RequestMapping(value = "storeUpdateTagListOk", method = RequestMethod.GET)
	public String adminstoreUpdateTagListOkGet(String brandName, String foodTag, String oldTag) throws UnsupportedEncodingException {
		
		int res = adminService.storeTagUpdateOk(brandName,foodTag, oldTag);
		
		if(res == 1) return "redirect:/msg/tagupdateOk?brandName="+URLEncoder.encode(brandName, "UTF-8"); // 정상처리가 되면 true == 1이 자동으로 넘어옴
		else return "redirect:/msg/tagupdateNo?brandName="+URLEncoder.encode(brandName, "UTF-8");
	}
	
	// 태그 삭제
	@Transactional
	@ResponseBody
	@RequestMapping(value = "adminTagDelete", method = RequestMethod.POST)
	public String adminTagDeletePost(String foodTag, String brandName) {
		int res = 0;
		
		// 태그에 속해있는 음식이 있는지 확인
		List<FoodMenuVO> vos = adminService.getCheckTagList(foodTag,brandName);
		// 태그에 속해있는 추가옵션이 있는지 확인
//		List<SubFoodMenuVO> sVos = adminService.getChecksubTagList(foodTag,brandName);
		// (음식점)태그에 속해있는 음식이 있는지 확인
		List<FoodMenuVO> storevos = storeService.getCheckTagList(foodTag,brandName);
		// (음식점)태그에 속해있는 추가옵션이 있는지 확인
//		List<SubFoodMenuVO> storeSubVos = storeService.getChecksubTagList(foodTag,brandName);
		
		/*
		 * if(vos.size() != 0) return "0";
		 * 
		 * res = adminService.setStoreTagDelete(foodTag, brandName);
		 * 
		 * return res+"";
		 */
		
		if(vos.size() == 0 && storevos.size() == 0) {
			res = adminService.setStoreTagDelete(foodTag, brandName);
			return "1"; 
		}
		return res+"";
	}
	
	// 프랜차이즈 태그 중복 확인
	@ResponseBody
	@RequestMapping(value = "foodNameCheck", method = RequestMethod.POST)
	public String foodNameCheckPost(String brandName, String foodName) {
		int res = 1;
		
		FoodMenuVO vo = adminService.getFoodNameCheck(brandName, foodName);
		
		if(vo == null) res = 0;
		return res+"";
	}

	
	// 관리자에서 음식 메뉴 삭제
	@Transactional
	@ResponseBody
	@RequestMapping(value = "adminMenuDelete", method= RequestMethod.POST)
	public String adminMenuDeletePost(String foodName, String brandName) {
		int res1 = 0; int res2 = 0; int res3 = 0; int res4 = 0;
		
//		// 해당음식의 추가옵션 테이블을 어드민/사장 둘다 삭제
//		res1 = adminService.setAdminSubMenuDeletePost(foodName);
//		res2 = storeService.setStoreSubMenuDeletePost(foodName);
		
		// 메뉴를 어드민 음식 테이블과 가게 음식 테이블에 둘다 삭제
		FoodMenuVO aVo =  adminService.getFoodNameCheck(brandName, foodName);
		List<FoodMenuVO> vos =  storeService.getStoreFood(foodName);
		if(aVo != null) res3 = adminService.setAdminMenuDeletePost(aVo);
		if(vos.size() != 0) res4 = storeService.setStoreMenuDeletePost(foodName);
		
		if(res3 != 1||res4 != 1) {
			return "2";
		}
		else {
			return "1";
		}
	}
	
	
	
	// 프랜차이즈 메뉴 수정 폼으로 이동
	@RequestMapping(value = "adminStoreMenuUpdate", method = RequestMethod.GET)
	public String adminStoreMenuUpdateGet(String brandName, String foodName, Model model) {

		FoodMenuVO vo = adminService.getFoodNameCheck(brandName, foodName);
		
		// 음식 태그 가져오기
		List<FoodMenuVO> vos = adminService.getstoreTagList(brandName);
		
		model.addAttribute("vo", vo);
		model.addAttribute("vos", vos);
		
		
		return "admin/menu/adminStoreMenuUpdate";
	}
	
	// 프랜차이즈 메뉴 수정 작업
	@RequestMapping(value = "adminStoreMenuUpdate", method = RequestMethod.POST)
	public String adminStoreMenuUpdatePost(FoodMenuVO vo, String pastPhoto, String pastFoodName, MultipartFile fName) throws UnsupportedEncodingException {
		
		int res = adminService.setStoreMenuUpdate(vo, fName, pastPhoto, pastFoodName);
		
		if(res == 1) return "redirect:/msg/adminMenuUpdateOk?brandName="+URLEncoder.encode(vo.getBrandName(), "UTF-8");
		else return "redirect:/msg/adminMenuUpdateNo?brandName="+URLEncoder.encode(vo.getBrandName(), "UTF-8");
	}
	
	// 어드민 회원 관리 폼 이동
	@RequestMapping(value = "memberList", method = RequestMethod.GET)
	public String adminmemberListGet(Model model,
			@RequestParam(name="order", defaultValue = "idx", required = false) String order,
			@RequestParam(name="search", defaultValue = "", required = false) String search,
			@RequestParam(name="searchString", defaultValue = "", required = false) String searchString,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "5", required = false) int pageSize) {
		
		System.out.println("정렬 : " + order);
		
		PageVO pageVo = pageProcess.totRecCnt(pag, pageSize, "adminMemberList", search, searchString);		
		
		List<MemberVO> vos = adminService.getMemberList(pageVo.getStartIndexNo(), pageSize, search, searchString, order);
		
		model.addAttribute("order",order);
		model.addAttribute("search",search);
		model.addAttribute("searchString",searchString);
		model.addAttribute("pageVo",pageVo);
		model.addAttribute("vos",vos);
		
		return "admin/member/memberList";
	}
	// 탈퇴요청 회원 관리 폼 이동
	@RequestMapping(value = "memberDeleteList", method = RequestMethod.GET)
	public String memberDeleteListGet(Model model,
			@RequestParam(name="order", defaultValue = "idx", required = false) String order,
			@RequestParam(name="search", defaultValue = "", required = false) String search,
			@RequestParam(name="searchString", defaultValue = "", required = false) String searchString,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "5", required = false) int pageSize) {
		
		System.out.println("정렬 : " + order);
		
		PageVO pageVo = pageProcess.totRecCnt(pag, pageSize, "adminMemberDeleteList", search, searchString);		
		
		List<MemberVO> vos = adminService.getDeleteMemberList(pageVo.getStartIndexNo(), pageSize, search, searchString, order);
		
		model.addAttribute("order",order);
		model.addAttribute("search",search);
		model.addAttribute("searchString",searchString);
		model.addAttribute("pageVo",pageVo);
		model.addAttribute("vos",vos);
		
		return "admin/member/memberDeleteList";
	}
	
	// 회원 삭제
	@Transactional
	@RequestMapping(value = "adminMemberDeleteOk", method = RequestMethod.GET)
	public String adminMemberDeleteOkPost(String mid) {
		
		
		
		
		int res = adminService.setMemberDelete(mid);
		
		if(res == 1) return "1"; // 정상처리가 되면 true == 1이 자동으로 넘어옴
		else return "0";
	}
	
}


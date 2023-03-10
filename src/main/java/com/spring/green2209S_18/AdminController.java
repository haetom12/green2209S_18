package com.spring.green2209S_18;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.mail.Store;
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

import com.spring.green2209S_18.dao.AdminDAO;
import com.spring.green2209S_18.pagenation.PageProcess;
import com.spring.green2209S_18.pagenation.PageVO;
import com.spring.green2209S_18.service.AdminService;
import com.spring.green2209S_18.service.MemberService;
import com.spring.green2209S_18.service.OrderService;
import com.spring.green2209S_18.service.StoreService;
import com.spring.green2209S_18.vo.CartVO;
import com.spring.green2209S_18.vo.FoodMenuVO;
import com.spring.green2209S_18.vo.MemberVO;
import com.spring.green2209S_18.vo.QnaVO;
import com.spring.green2209S_18.vo.RatingVO;
import com.spring.green2209S_18.vo.RiderVO;
import com.spring.green2209S_18.vo.StoreVO;
@Controller
@RequestMapping("/admin")
public class AdminController {
	
	@Autowired
	AdminService adminService;
	
	@Autowired
	AdminDAO adminDAO;
	
	@Autowired
	StoreService storeService;
	
	@Autowired
	OrderService orderService;
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	
	@Autowired
	PageProcess pageProcess;
	
	//어드민 페이지로
	@RequestMapping(value = "adminMain", method = RequestMethod.GET)
	public String adminMain(Model model, @RequestParam(name="foodTag", defaultValue = "", required = false) String foodTag) {
		
		// 가장 많이 팔린 음식
		List<CartVO> fVos = orderService.getMostSellFood(foodTag);

		String[] foodName = new String[4];
		int[] orderCnt = new int[4];
		
		if(fVos.size() != 0) {
			for(int i=0; i<fVos.size(); i++) {
				foodName[i] = fVos.get(i).getFoodName();
				orderCnt[i] = fVos.get(i).getOrderCnt();
			}
		}
		
		model.addAttribute("foodName",foodName);
		model.addAttribute("orderCnt",orderCnt);
		
		
		// 가장 많이 판매한 가게
		List<CartVO> sVos = orderService.getMostOrderStore(foodTag);
		
		String[] storeName = new String[4];
		int[] storeOrderCnt = new int[4];
		
		if(sVos.size() != 0) {
			for(int i=0; i<sVos.size(); i++) {
				storeName[i] = sVos.get(i).getStoreName();
				storeOrderCnt[i] = sVos.get(i).getOrderCnt();
			}
		}
		
		model.addAttribute("storeName", storeName);
		model.addAttribute("storeOrderCnt", storeOrderCnt);
		
		
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM");
		Date now = new Date();
		String thisMonth = format.format(now);
		/*
		// 이번달 자료
		
		List<CartVO> oVos = orderService.getThisMonthOrderList(thisMonth);
		*/
		
		// 이번달 최고 VIP 회원
		List<CartVO> VIPMemberVos = adminDAO.getThisMonthMember(thisMonth);
		
		// 이번달 최고 거래량 지점
		List<CartVO> bestStoreVos = adminDAO.getThisMonthStore(thisMonth);
		
		// 이번달 최고 베스트 드라이버
		List<CartVO> bestRiderVos = adminDAO.getThisMonthRider(thisMonth);
		
		
		// 음식 카테고리별 갯수
		List<StoreVO> kVos = orderService.getkategoryCnt();
		
		String[] storePart = new String[4];
		int[] partCnt = new int[4];
		
		if(kVos.size() != 0) {
			for(int i=0; i<sVos.size(); i++) {
				storePart[i] = kVos.get(i).getStorePart();
				partCnt[i] = kVos.get(i).getCnt();
			}
		}
		
		// 총 회원수 / 총 거래량
		int totMember = adminService.getToTMember();
		int totStore = adminDAO.getToTStore();
		int totRider = adminDAO.getTotRider();
		int totOrder = adminDAO.getToTOrder();
		
		model.addAttribute("totMember" , totMember);
		model.addAttribute("totStore" , totStore);
		model.addAttribute("totRider" , totRider);
		model.addAttribute("totOrder" , totOrder);
		
		model.addAttribute("bestStoreVos" , bestStoreVos);
		model.addAttribute("VIPMemberVos" , VIPMemberVos);
		model.addAttribute("bestRiderVos" , bestRiderVos);
		
		model.addAttribute("storePart" , storePart);
		model.addAttribute("partCnt" , partCnt);
		model.addAttribute("kVos" , kVos);
		
		return "admin/adminMain";
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
	public String adminBrandDeleteGet(int startIndexNo, int pageSize, String search, String searchString, String brandName) {
		int res = 0;
		
		List<FoodMenuVO> vos = adminService.getstoreMenuList(startIndexNo, pageSize, search, searchString, brandName);
		
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
	public String storeMenuListGet(Model model, String brandName,
			@RequestParam(name="search", defaultValue = "", required = false) String search,
			@RequestParam(name="searchString", defaultValue = "", required = false) String searchString,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize) {
		
		PageVO pageVo = pageProcess.totRecCnt2(pag, pageSize, "adminMenuList", search, searchString, brandName);	
		
		// 음식 프렌차이즈 가져오기
		List<FoodMenuVO> vos = adminService.getstoreMenuList(pageVo.getStartIndexNo(), pageSize, search, searchString, brandName);
		List<FoodMenuVO> tVos = adminService.getstoreTagList(brandName);
		
		
		model.addAttribute("brandName", brandName);
		model.addAttribute("search", search);
		model.addAttribute("searchString", searchString);
		model.addAttribute("pag", pag);
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("vos", vos);
		model.addAttribute("tVos", tVos);
		model.addAttribute("pageVo", pageVo);
		
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
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize) {
		
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
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize) {
		
		PageVO pageVo = pageProcess.totRecCnt(pag, pageSize, "adminMemberDeleteList", search, searchString);		
		
		List<MemberVO> vos = adminService.getDeleteMemberList(pageVo.getStartIndexNo(), pageSize, search, searchString, order);
		
		model.addAttribute("order",order);
		model.addAttribute("search",search);
		model.addAttribute("searchString",searchString);
		model.addAttribute("pageVo",pageVo);
		model.addAttribute("vos",vos);
		
		return "admin/member/memberDeleteList";
	}
	
	// 커뮤니티 밴 회원 관리 폼 이동
	@RequestMapping(value = "memberBanList", method = RequestMethod.GET)
	public String memberBanListGet(Model model,
			@RequestParam(name="order", defaultValue = "idx", required = false) String order,
			@RequestParam(name="search", defaultValue = "", required = false) String search,
			@RequestParam(name="searchString", defaultValue = "", required = false) String searchString,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize) {
		
		PageVO pageVo = pageProcess.totRecCnt(pag, pageSize, "adminMemberBanList", search, searchString);		
		
		List<MemberVO> vos = adminService.getBanMemberList(pageVo.getStartIndexNo(), pageSize, search, searchString, order);
		
		model.addAttribute("order",order);
		model.addAttribute("search",search);
		model.addAttribute("searchString",searchString);
		model.addAttribute("pageVo",pageVo);
		model.addAttribute("vos",vos);
		
		return "admin/member/memberBanList";
	}
	
	// 회원 삭제
	@Transactional
	@ResponseBody
	@RequestMapping(value = "adminMemberDeleteOk", method = RequestMethod.POST)
	public String adminMemberDeleteOkPost(String mid) {
		
		//
		int res2 = orderService.setDeleteMember(mid);

		int res = adminService.setMemberDelete(mid);
		
		if(res == 1 || res2 == 1) return "1"; // 정상처리가 되면 true == 1이 자동으로 넘어옴
		else return "0";
	}
	
	// 회원 활동 정상 수정
	@ResponseBody
	@RequestMapping(value = "adminMemberBanListOk", method = RequestMethod.POST)
	public String adminMemberBanListOkPost(String mid) {
		
		int res = adminService.setUnLockMember(mid);
		
		if(res == 1) return "1"; // 정상처리가 되면 true == 1이 자동으로 넘어옴
		else return "0";
	}
	
	// 회원 활동 탈퇴로 수정
	@ResponseBody
	@RequestMapping(value = "adminMemberDeleteCheck", method = RequestMethod.POST)
	public String adminMemberDeleteCheckPost(String mid) {
		
		int res = adminService.setAdminMemberDeleteCheck(mid);
		
		if(res == 1) return "1"; // 정상처리가 되면 true == 1이 자동으로 넘어옴
		else return "0";
	}
	
	// 회원 탈퇴에서 활동으로 수정
	@ResponseBody
	@RequestMapping(value = "adminMemberRestore", method = RequestMethod.POST)
	public String adminMemberRestorePost(String mid) {
		
		int res = adminService.setadminMemberRestore(mid);
		
		if(res == 1) return "1"; // 정상처리가 되면 true == 1이 자동으로 넘어옴
		else return "0";
	}
	
	
	// 어드민 라이더 폼 이동
	@RequestMapping(value = "riderList", method = RequestMethod.GET)
	public String adminRiderListListGet(Model model,
			@RequestParam(name="order", defaultValue = "riderIdx", required = false) String order,
			@RequestParam(name="search", defaultValue = "", required = false) String search,
			@RequestParam(name="searchString", defaultValue = "", required = false) String searchString,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize) {
		
		PageVO pageVo = pageProcess.totRecCnt(pag, pageSize, "adminRiderList", search, searchString);		
		
		List<RiderVO> vos = adminService.getRiderList(pageVo.getStartIndexNo(), pageSize, search, searchString, order);
		
		model.addAttribute("order",order);
		model.addAttribute("search",search);
		model.addAttribute("searchString",searchString);
		model.addAttribute("pageVo",pageVo);
		model.addAttribute("vos",vos);
		
		return "admin/rider/riderList";
	}
	
	// 어드민 라이더 탈퇴신청 폼 이동
	@RequestMapping(value = "riderDeleteList", method = RequestMethod.GET)
	public String adminRiderDeleteListGet(Model model,
			@RequestParam(name="order", defaultValue = "riderIdx", required = false) String order,
			@RequestParam(name="search", defaultValue = "", required = false) String search,
			@RequestParam(name="searchString", defaultValue = "", required = false) String searchString,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize) {
		
		PageVO pageVo = pageProcess.totRecCnt(pag, pageSize, "adminRiderDeleteList", search, searchString);		
		
		List<RiderVO> vos = adminService.getRiderDeleteList(pageVo.getStartIndexNo(), pageSize, search, searchString, order);
		
		model.addAttribute("order",order);
		model.addAttribute("search",search);
		model.addAttribute("searchString",searchString);
		model.addAttribute("pageVo",pageVo);
		model.addAttribute("vos",vos);
		
		return "admin/rider/riderDeleteList";
	}
	
	
	// 라이더 탈퇴 처리
	@ResponseBody
	@RequestMapping(value = "adminRiderDeleteOk", method = RequestMethod.POST)
	public String adminRiderDeleteOkPost(String riderMid) {
		
		int res = adminService.setAdminRiderDeleteOk(riderMid);
		
		if(res == 1) return "1"; // 정상처리가 되면 true == 1이 자동으로 넘어옴
		else return "0";
	}
	
	// 라이더 상태를 탈퇴신청으로
	@ResponseBody
	@RequestMapping(value = "adminRiderDelete", method = RequestMethod.POST)
	public String adminRiderDeletePost(String riderMid) {
		
		int res = adminService.setAdminRiderDelete(riderMid);
		
		if(res == 1) return "1"; // 정상처리가 되면 true == 1이 자동으로 넘어옴
		else return "0";
	}
	
	// 라이더 상태를 활동중으로
	@ResponseBody
	@RequestMapping(value = "adminRiderRestore", method = RequestMethod.POST)
	public String adminRiderRestorePost(String riderMid) {
		
		int res = adminService.setAdminRiderRestore(riderMid);
		
		if(res == 1) return "1"; // 정상처리가 되면 true == 1이 자동으로 넘어옴
		else return "0";
	}
	
	
	// 어드민 가게리스트 폼 이동
	@RequestMapping(value = "storeList", method = RequestMethod.GET)
	public String adminStoreListGet(Model model,
			@RequestParam(name="order", defaultValue = "idx", required = false) String order,
			@RequestParam(name="search", defaultValue = "", required = false) String search,
			@RequestParam(name="searchString", defaultValue = "", required = false) String searchString,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize) {
		
		PageVO pageVo = pageProcess.totRecCnt(pag, pageSize, "adminStoreList", search, searchString);		
		
		List<StoreVO> vos = adminService.getStoreList(pageVo.getStartIndexNo(), pageSize, search, searchString, order);
		
		model.addAttribute("order",order);
		model.addAttribute("search",search);
		model.addAttribute("searchString",searchString);
		model.addAttribute("pageVo",pageVo);
		model.addAttribute("vos",vos);
		
		return "admin/store/storeList";
	}
	
	// 가게 상태를 탈퇴신청으로
	@ResponseBody
	@RequestMapping(value = "adminStoreDelete", method = RequestMethod.POST)
	public String adminStoreDeletePost(String storeMid) {
		
		int res = adminService.setAdminStoreDelete(storeMid);
		
		if(res == 1) return "1"; // 정상처리가 되면 true == 1이 자동으로 넘어옴
		else return "0";
	}
	
	
	// 어드민 가게 탈퇴 신청리스트 폼 이동
	@RequestMapping(value = "storeDeleteList", method = RequestMethod.GET)
	public String adminStoreDeleteListGet(Model model,
			@RequestParam(name="order", defaultValue = "idx", required = false) String order,
			@RequestParam(name="search", defaultValue = "", required = false) String search,
			@RequestParam(name="searchString", defaultValue = "", required = false) String searchString,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize) {
		
		PageVO pageVo = pageProcess.totRecCnt(pag, pageSize, "adminStoreDeleteList", search, searchString);		
		
		List<StoreVO> vos = adminService.getStoreDeleteList(pageVo.getStartIndexNo(), pageSize, search, searchString, order);
		
		model.addAttribute("order",order);
		model.addAttribute("search",search);
		model.addAttribute("searchString",searchString);
		model.addAttribute("pageVo",pageVo);
		model.addAttribute("vos",vos);
		
		return "admin/store/storeDeleteList";
	}
	
	
	// 가게 상태를 탈퇴신청으로
	@ResponseBody
	@RequestMapping(value = "adminStoreRestore", method = RequestMethod.POST)
	public String adminStoreRestorePost(String storeMid) {
		
		int res = adminService.setAdminStoreRestore(storeMid);
		
		if(res == 1) return "1"; // 정상처리가 되면 true == 1이 자동으로 넘어옴
		else return "0";
	}
	
	// 가게 탈퇴 처리
	@ResponseBody
	@RequestMapping(value = "adminStoreDeleteOk", method = RequestMethod.POST)
	public String adminStoreDeleteOkPost(String storeMid) {
		
		int res = adminService.setAdminStoreDeleteOk(storeMid);
		
		if(res == 1) return "1"; // 정상처리가 되면 true == 1이 자동으로 넘어옴
		else return "0";
	}
	
	
	// 어드민 별점 리스트 폼 이동
	@RequestMapping(value = "ratingList", method = RequestMethod.GET)
	public String adminRatingListGet(Model model,
			@RequestParam(name="order", defaultValue = "idx", required = false) String order,
			@RequestParam(name="search", defaultValue = "", required = false) String search,
			@RequestParam(name="searchString", defaultValue = "", required = false) String searchString,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize) {
		
		PageVO pageVo = pageProcess.totRecCnt(pag, pageSize, "adminRatingList", search, searchString);		
		
		List<StoreVO> vos = adminService.getRatingList(pageVo.getStartIndexNo(), pageSize, search, searchString, order);
		
		model.addAttribute("order",order);
		model.addAttribute("search",search);
		model.addAttribute("searchString",searchString);
		model.addAttribute("pageVo",pageVo);
		model.addAttribute("vos",vos);
		
		return "admin/rating/ratingList";
	}
	
	// 평점리뷰 삭제 처리
	@ResponseBody
	@RequestMapping(value = "adminRatingDeleteCheck", method = RequestMethod.POST)
	public String adminRatingDeleteCheckPost(int idx) {
		
		int res = storeService.setRatingDeleteOk(idx);
		
		if(res == 1) return "1"; // 정상처리가 되면 true == 1이 자동으로 넘어옴
		else return "0";
	}
	
	// 평점리뷰 복구 처리
	@ResponseBody
	@RequestMapping(value = "adminRatingRestore", method = RequestMethod.POST)
	public String adminRatingRestorePost(int idx) {
		
		int res = adminDAO.setRatingRestore(idx);
		
		if(res == 1) return "1"; // 정상처리가 되면 true == 1이 자동으로 넘어옴
		else return "0";
	}
	
	
	// 신고된 평점리뷰 폼 이동
	@RequestMapping(value = "ratingReportList", method = RequestMethod.GET)
	public String adminratingReportListGet(Model model,
			@RequestParam(name="order", defaultValue = "idx", required = false) String order,
			@RequestParam(name="search", defaultValue = "", required = false) String search,
			@RequestParam(name="searchString", defaultValue = "", required = false) String searchString,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize) {
		
		PageVO pageVo = pageProcess.totRecCnt(pag, pageSize, "ratingReportList", search, searchString);		
		
		List<StoreVO> vos = adminService.getRatingReportList(pageVo.getStartIndexNo(), pageSize, search, searchString, order);
		
		model.addAttribute("order",order);
		model.addAttribute("search",search);
		model.addAttribute("searchString",searchString);
		model.addAttribute("pageVo",pageVo);
		model.addAttribute("vos",vos);
		
		return "admin/rating/ratingReportList";
	}
	
	// 댓글 리스트 폼 이동
	@RequestMapping(value = "ratingReplyList", method = RequestMethod.GET)
	public String adminRatingReplyListGet(Model model,
			@RequestParam(name="order", defaultValue = "idx", required = false) String order,
			@RequestParam(name="search", defaultValue = "", required = false) String search,
			@RequestParam(name="searchString", defaultValue = "", required = false) String searchString,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize) {
		
		PageVO pageVo = pageProcess.totRecCnt(pag, pageSize, "ratingReplyList", search, searchString);		
		
		List<StoreVO> vos = adminService.getRatingReplyList(pageVo.getStartIndexNo(), pageSize, search, searchString, order);
		
		model.addAttribute("order",order);
		model.addAttribute("search",search);
		model.addAttribute("searchString",searchString);
		model.addAttribute("pageVo",pageVo);
		model.addAttribute("vos",vos);
		
		return "admin/rating/ratingReplyList";
	}
	
	// 신고된 댓글 리스트 폼 이동
	@RequestMapping(value = "ratingReplyReportList", method = RequestMethod.GET)
	public String ratingReplyReportList(Model model,
			@RequestParam(name="order", defaultValue = "idx", required = false) String order,
			@RequestParam(name="search", defaultValue = "", required = false) String search,
			@RequestParam(name="searchString", defaultValue = "", required = false) String searchString,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize) {
		
		PageVO pageVo = pageProcess.totRecCnt(pag, pageSize, "ratingReplyReportList", search, searchString);		
		
		List<StoreVO> vos = adminService.getReplyReportList(pageVo.getStartIndexNo(), pageSize, search, searchString, order);
		
		model.addAttribute("order",order);
		model.addAttribute("search",search);
		model.addAttribute("searchString",searchString);
		model.addAttribute("pageVo",pageVo);
		model.addAttribute("vos",vos);
		
		return "admin/rating/ratingReplyReportList";
	}
	
	
	// QnA 리스트 폼 이동
	@RequestMapping(value = "QnAList", method = RequestMethod.GET)
	public String QnAList(Model model,
			@RequestParam(name="search", defaultValue = "", required = false) String search,
			@RequestParam(name="searchString", defaultValue = "", required = false) String searchString,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize) {
		
		PageVO pageVo = pageProcess.totRecCnt(pag, pageSize, "adminQnAList", search, searchString);		
		
		List<StoreVO> vos = adminService.getQnAList(pageVo.getStartIndexNo(), pageSize, search, searchString);
		
		model.addAttribute("search",search);
		model.addAttribute("searchString",searchString);
		model.addAttribute("pageVo",pageVo);
		model.addAttribute("vos",vos);
		
		return "admin/QnA/adminQnAList";
	}
	
	//별점 내용 확인
	@RequestMapping(value = "ratingContent", method = RequestMethod.GET)
	public String QnAListGet(Model model, int idx) {
		
		RatingVO vo = storeService.getRatingInfo(idx);
		
		model.addAttribute("vo",vo);
		
		return "admin/rating/ratingContent";
	}
	
	//별점 내용 확인
	@RequestMapping(value = "QnAContent", method = RequestMethod.GET)
	public String QnAContentGet(Model model, int idx) {
		
		QnaVO vo = memberService.getQnAContent(idx);
		
		List<QnaVO> vos = memberService.getQnAComment(idx);
		
		model.addAttribute("vo",vo);
		model.addAttribute("vos",vos);
		
		return "admin/QnA/QnAContent";
	}
	
	//별점 내용 확인
	@ResponseBody
	@RequestMapping(value = "QnAnwerDelete", method = RequestMethod.POST)
	public String QnAnwerDeletePost(int idx) {
		
		int res = adminService.setQnAnwerDelete(idx);
		
		if(res == 1) return "1"; // 정상처리가 되면 true == 1이 자동으로 넘어옴
		else return "0";
	}
	
	// 평점리뷰 삭제 처리
	@Transactional
	@ResponseBody
	@RequestMapping(value = "adminQnAInput", method = RequestMethod.POST)
	public String adminQnAInputPost(int idx, String content, String part, String title, HttpSession session) {
		
		QnaVO vo = new QnaVO();
		String mid = (String) session.getAttribute("sMid");
		String nickName = (String) session.getAttribute("sNickName");
		if(nickName==null) nickName = "어드민";
		
		vo.setQnaIdx(idx);
		vo.setMid(mid);
		vo.setNickName(nickName);
		vo.setPart(part);
		vo.setTitle(title);
		vo.setQnaSw("a");
		vo.setContent(content);
		
		// 답변 등록
		int res = adminService.setAdminQnAInput(idx, vo);
		// 해당 문의 답변 상황 바꾸기
		//adminService.setQnASituation(idx);
		
		if(res == 1) return "1"; // 정상처리가 되면 true == 1이 자동으로 넘어옴
		else return "0";
	}
	
	
	// 문의 삭제
	@ResponseBody
	@RequestMapping(value = "adminDeleteQnA", method = RequestMethod.POST)
	public String adminDeleteQnAPost(int idx) {
		
		int res = adminService.setAdminDeleteQnA(idx);
		
		if(res == 1) return "1"; // 정상처리가 되면 true == 1이 자동으로 넘어옴
		else return "0";
	}
	
	
	// QnA 답변 대기중인 폼 이동
	@RequestMapping(value = "QnAListYet", method = RequestMethod.GET)
	public String QnAListYet(Model model,
			@RequestParam(name="search", defaultValue = "", required = false) String search,
			@RequestParam(name="searchString", defaultValue = "", required = false) String searchString,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize) {
		
		PageVO pageVo = pageProcess.totRecCnt(pag, pageSize, "adminQnAListYet", search, searchString);		
		
		List<StoreVO> vos = adminService.getQnAListYet(pageVo.getStartIndexNo(), pageSize, search, searchString);
		
		model.addAttribute("search",search);
		model.addAttribute("searchString",searchString);
		model.addAttribute("pageVo",pageVo);
		model.addAttribute("vos",vos);
		
		return "admin/QnA/adminQnAListYet";
	}
	
	// QnA 답변완료된 리스트
	@RequestMapping(value = "QnAListDone", method = RequestMethod.GET)
	public String QnAListDone(Model model,
			@RequestParam(name="search", defaultValue = "", required = false) String search,
			@RequestParam(name="searchString", defaultValue = "", required = false) String searchString,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize) {
		
		PageVO pageVo = pageProcess.totRecCnt(pag, pageSize, "QnAListDone", search, searchString);		
		
		List<StoreVO> vos = adminService.getQnAListDone(pageVo.getStartIndexNo(), pageSize, search, searchString);
		
		model.addAttribute("search",search);
		model.addAttribute("searchString",searchString);
		model.addAttribute("pageVo",pageVo);
		model.addAttribute("vos",vos);
		
		return "admin/QnA/adminQnAListDone";
	}
	
}


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
import com.spring.green2209S_18.vo.CartVO;
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
	
	// ?????? ?????? ??? ??????
	@RequestMapping(value = "/storeJoin", method = RequestMethod.GET)
	public String memberLoginGet(Model model) {
		
		// ?????? ???????????? ????????????
		List<StoreVO> vos = storeService.getStoreCategory();
		
		model.addAttribute("vos", vos);

		return "store/storeJoin";
	}
	
  //????????? ????????????
	@ResponseBody
	@RequestMapping(value = "/storeIdCheck", method = RequestMethod.POST)
	public String memIdCheckPost(String storeMid) {
		String res = "1";
		StoreVO vo = storeService.getStoreIdCheck(storeMid);
		
		if(vo == null) res = "0";
		return res;
	}
	
	// ?????? ??????
	@RequestMapping(value = "/storeJoin", method = RequestMethod.POST)
	public String memberLoginPost(StoreVO vo, MultipartFile fName) {
		// ????????? ??????
		if(storeService.getStoreIdCheck(vo.getStoreMid()) != null) {
			return "redirect:/msg/memberIdCheckNo";
		}
		
		// ???????????? ?????????
		vo.setStorePwd(passwordEncoder.encode(vo.getStorePwd()));
		
		// ????????? ???????????? ???????????? ????????????, vo??? ?????? ????????? DB??? ??????????????????. (?????? ??????) - ????????????????????? ??????????????????.
		int res = storeService.setStoreJoinOk(vo, fName);
		
		
		if(res == 1) return "redirect:/msg/storeJoinOk"; // ??????????????? ?????? true == 1??? ???????????? ?????????
		else return "redirect:/msg/storeJoinNo";
	}
	
	// ???????????? ????????? ??????
	@RequestMapping(value = "/shopCategory", method = RequestMethod.GET)
	public String shopCategoryGet(Model model) {
		// ?????? ???????????? ????????????
		List<StoreVO> vos = storeService.getStoreCategory();
		
		model.addAttribute("vos", vos);
		return "store/shopCategory";
	}
	
	// ?????? ???????????? ?????? ????????? ??????
	@RequestMapping(value = "/storeList", method = RequestMethod.GET)
	public String storeListGet(Model model, String storePart,
			@RequestParam(name = "ordered" , defaultValue = "", required = false) String ordered ,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "12", required = false) int pageSize) {
		
		PageVO pageVo = pageProcess.totRecCnt(pag, pageSize, "store", storePart, "");
		
		// ?????? ????????? ????????????
		List<StoreVO> vos = storeService.getStoreList(storePart, ordered, pageVo.getStartIndexNo(), pageSize);
		
		model.addAttribute("vos", vos);
		model.addAttribute("pageVo", pageVo);
		model.addAttribute("storePart", storePart);
		return "store/storeList";
	}
	
	// ????????? ??? ?????? ?????? ????????? ????????????
	@RequestMapping(value = "/shopNear", method = RequestMethod.GET)
	public String shopNearGet(Model model, HttpSession session, 
			@RequestParam(name = "storePart" , defaultValue = "", required = false) String storePart,
			@RequestParam(name = "distance" , defaultValue = "1000", required = false) int distance) {
		
//		System.out.println("?????? : " + distance);
		
		String mid = (String)session.getAttribute("sMid");
		
		MemberVO mVo = memberService.getMemberIdCheck(mid);
		
		// ?????? ????????? ????????????
		List<StoreVO> vos = storeService.getNearMapStoreList(storePart);
		
		// ?????? ???????????? ????????????
		List<StoreVO> Cvos = storeService.getStoreCategory();
		
		// ?????? ???????????? ????????????
		List<StoreVO> Mvos = storeService.getStoreDistance(vos,mVo,distance);
		
		model.addAttribute("storePart", storePart);
		model.addAttribute("distance", distance);
		model.addAttribute("mVo", mVo);
		model.addAttribute("Mvos", Mvos);
		model.addAttribute("Cvos", Cvos);
		model.addAttribute("storePart", storePart);
		return "store/shopNear";
	}
	
	// ?????? ???????????? ?????? ????????? ??????
	@RequestMapping(value = "/storeMenu", method = RequestMethod.GET)
	public String storeMenuGet(Model model, 
			@RequestParam(name = "idx" , defaultValue = "1", required = false) int idx,
			@RequestParam(name = "foodTag" , defaultValue = "", required = false) String foodTag,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "5", required = false) int pageSize) {
		
		StoreVO vo = storeService.getStoreMenu(idx);

		// ?????? ????????? ?????? ??? ?????? ?????????
		PageVO ratingPageVo = pageProcess.totRecCnt(pag, pageSize, "rating", vo.getStoreName(), "");
		
		PageVO pageVo = pageProcess.totRecCnt(pag, pageSize, "storeMenu", vo.getStoreName(), foodTag);
		
		// ?????? ????????????
		List<RatingVO> rVos = storeService.getRatingList(ratingPageVo.getStartIndexNo(), pageSize, vo.getStoreName());
		
		// ?????? ?????????
		List<FoodMenuVO> vos = storeService.getStoreFoodMenu2(vo.getStoreName(),foodTag, pageVo.getStartIndexNo(), pageSize);
		
		// ?????? ?????? ?????????
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
	
	
	// ??? ?????? ????????? ??????
	@RequestMapping(value = "/myStorePage", method = RequestMethod.GET)
	public String MyStorePageGet(HttpSession session, Model model) {
		String storeMid = (String) session.getAttribute("sMid"); 
		StoreVO vo = storeService.getStoreIdCheck(storeMid);
		
		model.addAttribute("vo",vo);
		return "store/myStorePage";
	}
	
	
	// ??? ?????? ?????? ????????? ??? ??????
	@RequestMapping(value = "/myStoreMenu", method = RequestMethod.GET)
	public String myStoreMenuGet(HttpSession session, Model model) {
		String storeMid = (String) session.getAttribute("sMid"); 
		StoreVO vo = storeService.getStoreIdCheck(storeMid);
		List<FoodMenuVO> vos = storeService.getStoreFoodMenu(vo.getStoreName());
		
		model.addAttribute("vo",vo);
		model.addAttribute("vos",vos);
		
		return "store/myStoreMenu";
	}

	// ?????? ?????? ?????? ????????? ??????
	@RequestMapping(value = "/storeMenuInputSelect", method = RequestMethod.GET)
	public String storeMenuInputSelectGet(HttpSession session, Model model) {
		String storeMid = (String) session.getAttribute("sMid"); 
		StoreVO vo = storeService.getStoreIdCheck(storeMid);
		
		model.addAttribute("vo",vo);
		return "store/storeMenuInputSelect";
	}
	
	// ?????? ?????? ?????? ????????? ??????
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
	
	// ?????? ?????? ?????? ??????
	@RequestMapping(value = "/storeMenuInput", method = RequestMethod.POST)
	public String storeMenuInputPost(HttpSession session, FoodMenuVO vo, MultipartFile fName) {
		String storeMid = (String) session.getAttribute("sMid"); 
		StoreVO sVo = storeService.getStoreIdCheck(storeMid);
		
		vo.setStoreName(sVo.getStoreName());
		vo.setAdmintag("X");
		
		int res = storeService.setStoreMenuInput(vo, fName);
		
		if(res == 1) return "redirect:/msg/storeMenuInputOk"; // ??????????????? ?????? true == 1??? ???????????? ?????????
		else return "redirect:/msg/storeMenuInputNo";
	}

	// ?????? ?????? ?????? ????????? ??????
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
//	// get???????????? ????????? ??????????????? ????????????
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
	// ajax??? ????????? ??????????????? ????????????
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
		System.out.println("????????? : " + vos);
		
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
	
//????????? ??????????????? ?????? ??????
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
			
			// ????????? ????????? ?????? ???????????? ??????
			if(checkTagVo == null) {
				storeService.setAdminStoreTag(foodVo.getFoodTag(), storeName);
			}
			// ?????? ??????
			storeService.setAdminStoreMenu(foodVo, storeName);
		}
		res = 1;
		
		return "redirect:/msg/adminMenuInputOk";
	}
	
	
	
	
	/*
	// ????????? ??????????????? ?????? ??????
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
			
			// ????????? ????????? ?????? ???????????? ??????
			if(checkTagVo == null) {
				storeService.setAdminStoreTag(tagVo, storeName);
			}
			// ?????? ??????
			storeService.setAdminStoreMenu(foodVo, storeName);
			
			// ?????? ????????? ????????? ??????
			if(subFoodVo != null) {
				storeService.setAdminStoreSubMenu(subFoodVo, storeName);
			}
		}
		res = 1;
		return res+"";
	}
	*/
	
// ????????? ?????? ??????
	@ResponseBody
	@RequestMapping(value = "/storeMenuDeleteOk", method = RequestMethod.POST)
	public String storeMenuDeleteOkPost(int menuIdx) {
		FoodMenuVO vo = storeService.getFoodInfo(menuIdx);
		
		int res = storeService.setStoreMenuDeleteOk(menuIdx);
		
		return "1";
	}
	
// ?????? ?????? ?????? ??????
	@ResponseBody
	@RequestMapping(value = "/foodNameCheck", method = RequestMethod.POST)
	public String foodNameCheckPost(String foodName, String storeName) {
		int res = 0;
		FoodMenuVO vo = storeService.storeFoodNameCheck(foodName, storeName);
		
		if(vo != null) return "1";
		else return res+"";
	}
	
	// ?????? ??????????????? ??????
	@RequestMapping(value = "/storeMenuUpdate", method = RequestMethod.GET)
	public String storeMenuUpdateGet(Model model, HttpSession session, String foodName) {
		
//		System.out.println("???????????? :" + foodName);
		
		String storeMid = (String) session.getAttribute("sMid"); 
		StoreVO vo = storeService.getStoreIdCheck(storeMid);
		
//		System.out.println("???????????? :" + vo.getStoreName());
		
		List<FoodMenuVO> vos = storeService.getstoreTagList(vo.getStoreName());
		
		FoodMenuVO fVo = storeService.storeFoodNameCheck(vo.getStoreName(), foodName);
		
		model.addAttribute("vos", vos);
		model.addAttribute("fVo", fVo);
		model.addAttribute("vo", vo);
		
		return "store/storeMenuUpdate";
	}
	
	// ?????? ?????? ??????
	@Transactional
	@RequestMapping(value = "/storeMenuUpdate", method = RequestMethod.POST)
	public String storeMenuUpdatePost(FoodMenuVO vo, String pastPhoto, String pastFoodName, MultipartFile fName) {
		
		int res = storeService.setStoreMenuUpdate(vo, fName, pastPhoto, pastFoodName);
		
		orderService.setDeleteUpdateMenu(vo.getMenuIdx());
		
		if(res == 1) return "redirect:/msg/storeMenuUpdateOk";
		else return "redirect:/msg/storeMenuUpdateNo";
	}
	
	// ??? ?????? ?????? ?????? ????????? ?????????
	@RequestMapping(value = "/myStoreTag", method = RequestMethod.GET)
	public String myStoreTagGet(Model model, HttpSession session) {
		String storeMid = (String) session.getAttribute("sMid"); 
		StoreVO vo = storeService.getStoreIdCheck(storeMid);
		
		// ?????? ?????? ?????????
		List<FoodMenuVO> vos = storeService.getstoreTagList(vo.getStoreName());
		
		model.addAttribute("vos", vos);
		model.addAttribute("vo", vo);
		
		return "store/myStoreTag";
	}
	
	// ??? ?????? ?????? ?????? ?????? ?????????
	@RequestMapping(value = "/storeTagInput", method = RequestMethod.GET)
	public String storeTagInputGet(Model model, HttpSession session) {
		String storeMid = (String) session.getAttribute("sMid"); 
		StoreVO vo = storeService.getStoreIdCheck(storeMid);
		
		model.addAttribute("vo", vo);
		return "store/storeTagInput";
	}
	
	// ??? ?????? ?????? ?????? ??????
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
	
	//?????? ?????? ?????? ??????
	@ResponseBody
	@RequestMapping(value = "/foodTagCheck", method = RequestMethod.POST)
	public String foodTagCheckPost(String foodTag, String storeName) {
		int res = 0;
		FoodMenuVO vo = storeService.storefoodTagCheck(foodTag, storeName);
		
		if(vo != null) return "1";
		else return res+"";
	}
	
  // ????????? ?????? ?????? 
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
	
	// ????????? ?????? ?????? 
	@RequestMapping(value = "/storeTagUpdate", method = RequestMethod.GET)
	public String storeTagUpdateGet(String foodTag, Model model, HttpSession session) {
		String storeMid = (String) session.getAttribute("sMid"); 
		StoreVO vo = storeService.getStoreIdCheck(storeMid);
		
		FoodMenuVO sVo = storeService.getCheckStoreTagList(foodTag, vo.getStoreName());
		
		model.addAttribute("vo", vo);
		model.addAttribute("sVo", sVo);
		
		return "store/storeTagUpdate";
	}
	
	// ????????? ?????? ?????? 
	@RequestMapping(value = "/storeTagUpdate", method = RequestMethod.POST)
	public String storeTagUpdatePost(FoodMenuVO vo, String oldTag, HttpSession session) {
		String storeMid = (String) session.getAttribute("sMid"); 
		StoreVO sVo = storeService.getStoreIdCheck(storeMid);
		
		int res = 0;
		res = storeService.setStoreTagUpdate(vo, oldTag, sVo.getStoreName());
		
		
		if(res == 1) return "redirect:/msg/storeTagUpdateOk";
		else return "redirect:/msg/storeTagUpdateNo";
	}

	// ?????? ????????? ?????? ????????? 
	@RequestMapping(value = "/myStoreSubOption", method = RequestMethod.GET)
	public String myStoreSubOptionGet(HttpSession session, Model model) {
		String storeMid = (String) session.getAttribute("sMid"); 
		StoreVO vo = storeService.getStoreIdCheck(storeMid);
		
		// ?????? ?????? ?????????
		List<FoodMenuVO> vos = storeService.getstoreTagList(vo.getStoreName());
		
		model.addAttribute("vos", vos);
		model.addAttribute("vo", vo);
		
		return "store/myStoreSubOption";
	}
	
	// ?????? ????????? ?????? ?????? ????????? 
	@RequestMapping(value = "/myStoreSubMenu", method = RequestMethod.GET)
	public String myStoreSubMenuGet(HttpSession session, Model model, String foodTag) {
		String storeMid = (String) session.getAttribute("sMid"); 
		StoreVO vo = storeService.getStoreIdCheck(storeMid);
		
		// ?????? ?????? ????????? 
		List<SubFoodMenuVO> vos = storeService.getstoreSubMenuList(vo.getStoreName(),foodTag);
		
		model.addAttribute("foodTag", foodTag);
		model.addAttribute("cVos", vos);
		model.addAttribute("vo", vo);
		
		return "store/myStoreSubMenu";
	}

	// ?????? ?????? ?????? ??? ?????? 
	@RequestMapping(value = "/myStoreSubMenuInput", method = RequestMethod.GET)
	public String storeSubMenuInputGet(HttpSession session, Model model, String foodTag) {
		String storeMid = (String) session.getAttribute("sMid"); 
		StoreVO vo = storeService.getStoreIdCheck(storeMid);
		
		model.addAttribute("foodTag", foodTag);
		model.addAttribute("vo", vo);
		
		return "store/myStoreSubMenuInput";
	}
	
	//?????? ?????? ?????? ?????? ??????
	@ResponseBody
	@RequestMapping(value = "/subMenuNameCheck", method = RequestMethod.POST)
	public String subMenuNameCheckPost(String subMenuName, String storeName, String foodTag) {
		int res = 0;
		SubFoodMenuVO vo = storeService.storeSubMenuNameCheck(subMenuName, storeName, foodTag);
		
		if(vo != null) return "1";
		else return res+"";
	}

	//?????? ?????? ??????
	@ResponseBody
	@RequestMapping(value = "/storeSubMenuDeleteOk", method = RequestMethod.POST)
	public String storeSubMenuDeleteOkPost(int subMenuIdx) {
		int res = 0;
		
		res = storeService.setStoreSubMenuDelete(subMenuIdx);
		
		if(res == 1) return "1";
		else return res+"";
	}
	
	// ?????? ?????? ?????? ??????
	@RequestMapping(value = "/myStoreSubMenuInput", method = RequestMethod.POST)
	public String storeSubMenuInputPost(SubFoodMenuVO vo) throws UnsupportedEncodingException {
		int res = 0;
		
		res = storeService.setStoreSubMenuInput(vo);
		
		if(res == 1) return "redirect:/msg/subMenuInputOk?foodTag="+URLEncoder.encode(vo.getFoodTag(), "UTF-8");
		else return "store/subMenuInputNo?foodTag="+URLEncoder.encode(vo.getFoodTag(), "UTF-8");
	}
	
	// ?????? ?????? ?????? ??? ??????
	@RequestMapping(value = "/myStoreSubMenuUpdate", method = RequestMethod.GET)
	public String myStoreSubMenuUpdateGet(HttpSession session, int subMenuIdx, Model model) {
		String storeMid = (String) session.getAttribute("sMid"); 
		StoreVO vo = storeService.getStoreIdCheck(storeMid);
		SubFoodMenuVO sVo = storeService.getSubMenuInfo(subMenuIdx);
		
		model.addAttribute("vo",vo);
		model.addAttribute("sVo",sVo);
		
		return "store/myStoreSubMenuUpdate";
	}
	
	// ?????? ?????? ?????? ??????
	@RequestMapping(value = "/myStoreSubMenuUpdate", method = RequestMethod.POST)
	public String myStoreSubMenuUpdatePost(SubFoodMenuVO vo) throws UnsupportedEncodingException {
		int res = 0;
		
		res = storeService.setSubMenuUpdateOk(vo);
		
		if(res == 1) return "redirect:/msg/subMenuUpdateOk?foodTag="+URLEncoder.encode(vo.getFoodTag(), "UTF-8");
		else return "redirect:/msg/subMenuUpdateNo?foodTag="+URLEncoder.encode(vo.getFoodTag(), "UTF-8");
	}
	
	// ????????? ?????? ?????? ?????? ?????????
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
	
	// ?????? ????????? ?????? ????????????
	@RequestMapping(value = "/storeRatingList", method = RequestMethod.GET)
	public String storeRatingListGet(Model model, HttpSession sesstion,
			@RequestParam(name="storeName", defaultValue = "", required = false) String storeName,
		@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
		@RequestParam(name="pageSize", defaultValue = "5", required = false) int pageSize) {

		if(storeName.equals("")) {
			storeName = (String)sesstion.getAttribute("sbrandName");
		}
		
		// ?????? ????????? ?????? ??? ?????? ?????????
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
	
//????????? ?????? ??????
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

	//????????? ?????? ?????? ??? ??????
	@RequestMapping(value = "/ratingUpdate", method = RequestMethod.GET)
	public String ratingUpdateGet(int idx, HttpSession session, Model model) throws UnsupportedEncodingException {
		
		RatingVO vo = storeService.getRatingInfo(idx);
		
		String mid = (String) session.getAttribute("sMid");
		
		if(!vo.getMid().equals(mid)) return "redirect:/msg/ratingUpdateNo?storeName="+URLEncoder.encode(vo.getStoreName(), "UTF-8");
		
		model.addAttribute("vo", vo);
		
		return "order/ratingUpdate";
	}
	
	//????????? ?????? ?????? ??????
	@RequestMapping(value = "/ratingUpdate", method = RequestMethod.POST)
	public String ratingUpdateGet(RatingVO vo) throws UnsupportedEncodingException {
		
	// ????????? ????????? ??????????????? ????????? ??????????????? ????????? ????????? ?????????, DB??? ????????? ?????? ????????? ???????????? ???????????????.
		RatingVO origVo = storeService.getRatingInfo(vo.getIdx());
		
	// content??? ????????? ??????????????? ??????????????? ????????? ?????? ????????? ?????????????????????.
			if(!origVo.getContent().equals(vo.getContent())) {
				// ????????? ????????????????????? ?????????????????? ????????? board????????? ????????? ?????? content??? ???????????? ????????? ?????? ?????????.
				if(origVo.getContent().indexOf("src=\"/") != -1) orderService.imgDelete(origVo.getContent());
				
				// vo.GetContent()??? ???????????? ????????? ????????? 'ckeditor/board'????????? 'ckeditor'????????????????????????.
				vo.setContent(vo.getContent().replace("/data/ckeditor/rating/", "/data/ckeditor/"));
				
				// ?????? ??????????????? ?????????, ????????? ?????? ?????????????????? ?????? ????????? ????????????.
				// ??? ????????? ?????? ???????????? ???????????? ???????????? ????????? ????????? ????????????.
				orderService.imgCheck(vo.getContent());
				
				// ?????? ???????????? ????????? ?????? ????????? ????????????.'ckeditor'????????? 'ckeditor/board'????????????????????????.(???, ????????? vo.getContent()??? vo.setContent() ????????????.)
				vo.setContent(vo.getContent().replace("/data/ckeditor/", "/data/ckeditor/rating/"));
			}
		
		// ??? ????????? vo??? DB??? Update????????????.
			int res = storeService.setRatingUpdateOk(vo);
			
			if(res == 1) return "redirect:/msg/ratingUpdateOk?storeName="+URLEncoder.encode(vo.getStoreName(), "UTF-8");
			
			else return "redirect:/msg/ratingUpdateFail?storeName="+URLEncoder.encode(vo.getStoreName(), "UTF-8");
	}
	
	
//?????? ????????? ??????
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
   String title = "[?????????] ?????? ??????";
   String content = "";
		
		try {
			// ????????? ???????????? ?????? ?????? : MimeMessage() , MimeMessageHelper()
			MimeMessage message = mailSender.createMimeMessage(); // ????????????
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8"); //???????????? ???????????????
			
			
			content = content.replace("\n", "<br/>");
			content += "?????? ?????????????????????</n>";
			content += "===================";
			content += "???????????? : " + msg;
			
			// ?????????????????? ????????? ????????? ??????????????? ?????? ???????????????.
			messageHelper.setTo(toMail);
			messageHelper.setSubject(title);
			messageHelper.setText(content);
			
			// ?????? ????????????
			mailSender.send(message);
			res = 1;			
		} catch (MessagingException e) {
			e.printStackTrace();
		}
		return res+"";
	}
	
	// ??? ???????????? ????????????
	@ResponseBody
	@RequestMapping(value = "storeEmailCheckOk", method = RequestMethod.POST)
	public String memberEmailCheckPost(String emailCode, HttpSession session) {
		String res = "1";
		
		String code = (String)session.getAttribute("sCode");
		
		if(!code.equals(emailCode)) return "0";
		
		else return res;
	}
	
	
	// ?????? ?????? ??????
	@ResponseBody
	@RequestMapping(value = "storeReplyInput", method = RequestMethod.POST)
	public String storeReplyInputPost(ratingReplyVO vo) {
		int res = 0;
		
		res = storeService.setRatingReplyInput(vo);
		
		if(res == 1) return "1";
		
		else return res+"";
	}
	
	// ?????? ?????? ????????????
	@ResponseBody
	@RequestMapping(value = "getCommentList", method = RequestMethod.POST)
	public List<ratingReplyVO> getCommentListPost(int idx) {
		int res = 0;
		
		List<ratingReplyVO> vos = storeService.getRatingCommentList(idx);
		
		System.out.println("vos : " + vos );
		
		return vos;
	}
	
	// ?????? ????????? ????????????
	@ResponseBody
	@RequestMapping(value = "getCommentList2", method = RequestMethod.POST)
	public List<ratingReplyVO> getCommentListPost2(int ratingIdx, int idx) {
		int res = 0;
		
		List<ratingReplyVO> vos = storeService.getRatingCommentList2(ratingIdx, idx);
		
		return vos;
	}
	
	
	// ?????? ?????? ??????
	@ResponseBody
	@RequestMapping(value = "storeReReplyInput", method = RequestMethod.POST)
	public String storeReReplyInputPost(ratingReplyVO vo, HttpSession session) {
		String mid = (String) session.getAttribute("sMid");
		
		MemberVO mVo = memberService.getMemberIdCheck(mid);
		
		if(mVo.getUserBan().equals("OK")) return "3";
		
		int res = 0;
		
		res = storeService.setRatingReReplyInput(vo);
		
		if(res == 1) return "1";
		
		else return res+"";
	}
	
	// ?????? ??????
	@ResponseBody
	@RequestMapping(value = "storeReplyUpdate", method = RequestMethod.POST)
	public String storeReplyUpdatePost(ratingReplyVO vo) {
		int res = 0;
		
		res = storeService.setRatingReplyUpdate(vo);
		
		if(res == 1) return "1";
		
		else return res+"";
	}
	
	// ?????? ?????? ??????
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
	
	// ?????? ??????
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
		// ?????? ??????
		@ResponseBody
		@RequestMapping(value = "storeReplyReport", method = RequestMethod.POST)
		public String storeReplyReportPost(int idx, HttpSession session) {
			int res = 0;
			String mid = (String)session.getAttribute("sMid");
			
			ratingReplyVO vo = storeService.getReplyComment(idx);
			
			if(vo.getReportMid() != null) {
				
				String[] report = vo.getReportMid().split("/");
				
				for(int i = 0; i<report.length; i++) {
					if(report[i].equals(mid)) {
						
						return "3";
					}
				}
			}
			
		
		String rMid = vo.getMid();
		res = storeService.setReportReply(idx, mid);
		
		if(res == 1) return "1";
		
		else return res+"";
	}
	
	// ?????? ??????
	@ResponseBody
	@RequestMapping(value = "storeNameCheckOk", method = RequestMethod.POST)
	public String storeNameCheckOkPost(String storeName) {
		int res = 0;
		
		StoreVO vo = storeService.getCheckStoreName(storeName);
		
		if(vo == null) return "1";
		else return res+"";
	}
	
	// ?????? ??????
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
		
		// ?????? ???????????? ????????????
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
	
	
	// ???????????? ????????????
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
	
	// ???????????? ??? ??????
	@RequestMapping(value = "/storeDelete", method = RequestMethod.GET)
	public String memberDeleteGet(HttpSession session, Model model) {
		String mid = (String)session.getAttribute("sMid");
		
		StoreVO vo = storeService.getStoreIdCheck(mid);
		model.addAttribute("vo", vo);
		
		return "store/storeDelete";
	}
	
	
//?????? ??? ????????? ??????
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
   System.out.println("????????? : " + msg);
   System.out.println("==============================");
   
   session.setMaxInactiveInterval(60*5);
   
   String toMail = vo.getStoreEmail();
   String title = "[?????????] ?????? ?????? ??????";
   String content = "";
		
		try {
			// ????????? ???????????? ?????? ?????? : MimeMessage() , MimeMessageHelper()
			MimeMessage message = mailSender.createMimeMessage(); // ????????????
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8"); //???????????? ???????????????
			
			// ?????????????????? ????????? ????????? ??????????????? ?????? ???????????????.
			messageHelper.setTo(toMail);
			messageHelper.setSubject(title);
			messageHelper.setText(content);
			
			content = content.replace("<br/>", "\n");
			content += "<br>?????? ?????????????????????<br/>";
			content += "???????????? : " + msg;
			
			// ?????????????????? ????????? ????????? ??????????????? ?????? ???????????????.
			messageHelper.setText(content);
			
			// ?????? ????????????
			mailSender.send(message);
			res = 1;			
		} catch (MessagingException e) {
			e.printStackTrace();
		}
		return res+"";
	}
	
	// ????????? ??????
	@ResponseBody
	@RequestMapping(value = "/storeDeleteCodeCheck", method = RequestMethod.POST)
	public String memberDeleteCodeCheckPost(String code, HttpSession session) {
		String sCode = (String) session.getAttribute("sCode");
		
		if(sCode.equals(code)) return "1";
		
		else return "2";
	}
	
	// ?????? ?????? ??????
	@RequestMapping(value = "/storeDeleteOk", method = RequestMethod.GET)
	public String memberDeleteOkGet(HttpSession session) {
		
		String mid = (String)session.getAttribute("sMid");
		
		int res = storeService.setStoreDelete(mid);
		
		if(res==1) return "redirect:/msg/riderDeleteOk";
		else return "redirect:/msg/storeDeleteNo";
	}
	
	// ?????? ?????? ????????? ?????????
	@RequestMapping(value = "/shopOrderList", method = RequestMethod.GET)
	public String shopOrderListGet(Model model, HttpSession sesstion,
		@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
		@RequestParam(name="pageSize", defaultValue = "5", required = false) int pageSize) {

		String storeName = (String)sesstion.getAttribute("sbrandName");
		StoreVO vo = storeService.getstoreInfo(storeName);
		
		// ?????? ????????? ?????? ??? ?????? ?????????
		PageVO pageVo = pageProcess.totRecCnt(pag, pageSize, "storeOrderList", storeName, "");
	
		List<CartVO> vos = storeService.getShopOrderListList(pageVo.getStartIndexNo(), pageSize, storeName);
		
		model.addAttribute("pageVo", pageVo);
		model.addAttribute("vos", vos);
		model.addAttribute("vo", vo);
			
		
		return "store/shopOrderList";
	}
	
}

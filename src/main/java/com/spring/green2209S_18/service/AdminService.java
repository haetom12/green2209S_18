package com.spring.green2209S_18.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.spring.green2209S_18.vo.FoodMenuVO;
import com.spring.green2209S_18.vo.MemberVO;
import com.spring.green2209S_18.vo.StoreVO;
import com.spring.green2209S_18.vo.SubFoodMenuVO;

public interface AdminService {

	public StoreVO getcategoryCodeCheck(String categoryStoreCode);

	public StoreVO getcategoryCodeCheck2(String storePart);

	public int setCategoryInput(StoreVO vo, MultipartFile fName);

	public List<StoreVO> getCategoryList(StoreVO vo);

	public int setCategoryDelete(StoreVO vo);

	public int setCategoryUpdate(MultipartFile fName, StoreVO vo, String pastPhoto, String pastCode);

	public StoreVO getBrandNameCheck(String storePart, String brandName);

	public int setStoreBrandInputOk(StoreVO vo);

	public List<StoreVO> getStoreBrandList();

	public int setadminBrandDelete(String brandName);

	public StoreVO getstoreBrand(String brandName);

	public int StoreBrandUpdateOk(StoreVO vo, String oldBrandName);

	public List<FoodMenuVO> getstoreTagList(String brandName);

	public List<FoodMenuVO> getFoodTagCheck(String brandName, String foodTag);

	public int storeTagInputOk(FoodMenuVO vo);

	public int storeTagUpdateOk(String brandName, String foodTag, String oldTag);

	public int setStoreTagDelete(String foodTag, String brandName);

	public List<FoodMenuVO> getCheckTagList(String foodTag, String brandName);

	public FoodMenuVO getFoodNameCheck(String brandName, String foodName);

	public int setAdminMenuInput(FoodMenuVO vo, MultipartFile fName);

	public List<SubFoodMenuVO> getCheckAdminSubMenu(String foodName);

	public int setAdminSubMenuDeletePost(String foodName);

	public int setAdminMenuDeletePost(FoodMenuVO aVo);

	public int setStoreMenuUpdate(FoodMenuVO vo, MultipartFile fName, String pastPhoto, String pastFoodName);

	public List<SubFoodMenuVO> getChecksubTagList(String foodTag, String brandName);

	public List<FoodMenuVO> getstoreMenuList(String brandName);

	public List<MemberVO> getMemberList(int startIndexNo, int pageSize, String search, String searchString, String order);

	public List<MemberVO> getDeleteMemberList(int startIndexNo, int pageSize, String search, String searchString, String order);

	public int setMemberDelete(String mid);


}

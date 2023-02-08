package com.spring.green2209S_18.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.spring.green2209S_18.vo.FoodMenuVO;
import com.spring.green2209S_18.vo.MemberVO;
import com.spring.green2209S_18.vo.StoreVO;
import com.spring.green2209S_18.vo.SubFoodMenuVO;

public interface StoreService {

	public StoreVO getStoreIdCheck(String storeMid);

	public int setStoreJoinOk(StoreVO vo, MultipartFile fName);

	public List<StoreVO> getStoreCategory();

	public List<StoreVO> getStoreList(String storePart, String ordered);

	public List<StoreVO> getNearMapStoreList(String storePart);

	public StoreVO getStoreMenu(int idx);

	public List<FoodMenuVO> getStoreFoodMenu(String storeName);

	public int setStoreSubMenuDeletePost(String foodName);

	public int setStoreMenuDeletePost(FoodMenuVO sVo);

	public FoodMenuVO getStoreFood(String brandName, String foodName);

	public List<FoodMenuVO> getCheckTagList(String foodTag, String brandName);

	public List<SubFoodMenuVO> getChecksubTagList(String foodTag, String brandName);

	public List<StoreVO> getAdminStoreBrand(String storePart);

	public List<FoodMenuVO> getstoreMenuList(String brandName, String storeName);

	public FoodMenuVO getAdminStoreMenu(int menuIdx);

	public FoodMenuVO getAdminStoreTag(String foodName);

	public SubFoodMenuVO getAdminStoreSubMenu(String brandName);

	public void setAdminStoreMenu(FoodMenuVO foodVo, String storeName);

	public void setAdminStoreSubMenu(SubFoodMenuVO subFoodVo, String storeName);

	public FoodMenuVO getCheckStoreTagList(String foodTag, String storeName);

	public void setAdminStoreTag(String foodTag, String storeName);

	public List<FoodMenuVO> getstoreTagList(String storeName);

	public List<FoodMenuVO> getStoreFoodMenuByTag(String storeName, String foodTag);

	public int setStoreMenuDeleteOk(String foodName);

	public FoodMenuVO storeFoodNameCheck(String storeName, String foodName);

	public int setStoreMenuInput(FoodMenuVO vo, MultipartFile fName);

	public int setStoreMenuUpdate(FoodMenuVO vo, MultipartFile fName, String pastPhoto, String pastFoodName);

	public List<StoreVO> getStoreDistance(List<StoreVO> vos, MemberVO mVo, int distance);


}

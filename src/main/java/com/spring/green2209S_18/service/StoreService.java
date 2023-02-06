package com.spring.green2209S_18.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.spring.green2209S_18.vo.FoodMenuVO;
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

	public List<FoodMenuVO> getstoreMenuList(String brandName);



}

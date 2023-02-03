package com.spring.green2209S_18.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.spring.green2209S_18.vo.FoodMenuVO;
import com.spring.green2209S_18.vo.StoreVO;

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



}

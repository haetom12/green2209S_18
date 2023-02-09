package com.spring.green2209S_18.service;

import java.util.List;

import com.spring.green2209S_18.vo.FoodMenuVO;
import com.spring.green2209S_18.vo.wishListVO;

public interface OrderService {

	public int setWishListInput(String storeName, int menuIdx, String mid);

	public wishListVO getCheckWishList(String storeName, int menuIdx, String mid);

	public List<wishListVO> getMyWishList(String mid);

	public FoodMenuVO getWishListInfo(int menuIdx);

	public void setDeleteWishList(int menuIdx);


}

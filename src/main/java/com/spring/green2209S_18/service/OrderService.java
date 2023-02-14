package com.spring.green2209S_18.service;

import java.util.List;

import com.spring.green2209S_18.vo.CartVO;
import com.spring.green2209S_18.vo.FoodMenuVO;
import com.spring.green2209S_18.vo.PayMentVO;
import com.spring.green2209S_18.vo.WebSocketDbVO;
import com.spring.green2209S_18.vo.wishListVO;

public interface OrderService {

	public int setWishListInput(String storeName, int menuIdx, String mid);

	public wishListVO getCheckWishList(String storeName, int menuIdx, String mid);

	public List<wishListVO> getMyWishList(String mid);

	public FoodMenuVO getWishListInfo(int menuIdx);

	public void setDeleteWishList(int menuIdx);

	public void setAddCartInput(CartVO vo);

	public void myCartDelete(int idx);

	public CartVO getOrderMaxIdx();

	public CartVO getCartIdx(int idx);

	public void setFoodOrderOK(CartVO vo);

	public CartVO getCheckOrderIdx(String orderIdx);

	public void setFoodOrderOk2(CartVO vo);

	public List<CartVO> getMyOrderList(String mid);

	public void setRiderOrder(WebSocketDbVO orderVo);



}

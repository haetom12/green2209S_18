package com.spring.green2209S_18.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.spring.green2209S_18.vo.CartVO;
import com.spring.green2209S_18.vo.CouponVO;
import com.spring.green2209S_18.vo.FoodMenuVO;
import com.spring.green2209S_18.vo.PayMentVO;
import com.spring.green2209S_18.vo.RatingVO;
import com.spring.green2209S_18.vo.StoreVO;
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

	public List<CartVO> getMyOrderList(String mid, int startIndexNo, int pageSize);

	public void setRiderOrder(WebSocketDbVO orderVo);

	public void imgCheck(String content);

	public int setRatingInput(RatingVO vo);

	public void setRaingInputOk(String orderIdx);

	public void imgDelete(String content);

	public String qrCreate(String memberNickName, String couponName, int discount, String expiration, String realPath);

	public void setCouponInput(CouponVO pVo);

	public CouponVO getCheckCoupon(String couponName, String mid);

	public void setCouponUsed(String sCouponName, String mid);

	public List<StoreVO> getMostSellStore();

	public int setDeleteMember(String mid);

	public List<CartVO> getMostSellFood(String foodTag);

	public List<CartVO> getThisMonthOrderList(String now_date);

	public List<CartVO> getMostOrderStore(String foodTag);

	public void setDeleteUpdateMenu(int menuIdx);

	public List<StoreVO> getkategoryCnt();



}

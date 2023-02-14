package com.spring.green2209S_18.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.green2209S_18.vo.CartVO;
import com.spring.green2209S_18.vo.FoodMenuVO;
import com.spring.green2209S_18.vo.PayMentVO;
import com.spring.green2209S_18.vo.WebSocketDbVO;
import com.spring.green2209S_18.vo.wishListVO;

public interface OrderDAO {

	public int setWishListInput(@Param("storeName") String storeName,@Param("menuIdx") int menuIdx,@Param("mid") String mid);

	public wishListVO getCheckWishList(@Param("storeName") String storeName,@Param("menuIdx") int menuIdx,@Param("mid") String mid);

	public List<wishListVO> getMyWishList(@Param("mid") String mid);

	public FoodMenuVO getWishListInfo(@Param("menuIdx") int menuIdx);

	public void setDeleteWishList(@Param("menuIdx") int menuIdx);

	public void setAddCartInput(@Param("vo") CartVO vo);

	public void myCartDelete(@Param("idx") int idx);

	public CartVO getOrderMaxIdx();

	public CartVO getCartIdx(@Param("idx") int idx);

	public CartVO getCheckOrderIdx(@Param("orderIdx") String orderIdx);

	public void setFoodOrderOK(@Param("vo") CartVO vo);

	public void setFoodOrderOk2(@Param("vo") CartVO vo);

	public List<CartVO> getMyOrderList(@Param("mid") String mid);

	public void setRiderOrder(@Param("vo") WebSocketDbVO orderVo);

	public List<CartVO> getOrderChatList();

}

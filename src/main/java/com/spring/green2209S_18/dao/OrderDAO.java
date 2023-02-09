package com.spring.green2209S_18.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.green2209S_18.vo.FoodMenuVO;
import com.spring.green2209S_18.vo.wishListVO;

public interface OrderDAO {

	public int setWishListInput(@Param("storeName") String storeName,@Param("menuIdx") int menuIdx,@Param("mid") String mid);

	public wishListVO getCheckWishList(@Param("storeName") String storeName,@Param("menuIdx") int menuIdx,@Param("mid") String mid);

	public List<wishListVO> getMyWishList(@Param("mid") String mid);

	public FoodMenuVO getWishListInfo(@Param("menuIdx") int menuIdx);

	public void setDeleteWishList(@Param("menuIdx") int menuIdx);

}

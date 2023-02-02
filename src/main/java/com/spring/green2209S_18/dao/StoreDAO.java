package com.spring.green2209S_18.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.green2209S_18.vo.FoodMenuVO;
import com.spring.green2209S_18.vo.StoreVO;

public interface StoreDAO {

	public StoreVO getStoreIdCheck(@Param("storeMid") String storeMid);

	public void setStoreJoinOk(@Param("vo") StoreVO vo);

	public List<StoreVO> getStoreCategory();

	public List<StoreVO> getStoreList(@Param("storePart") String storePart, @Param("ordered") String ordered);

	public List<StoreVO> getNearMapStoreList(@Param("storePart") String storePart);

	public StoreVO getStoreMenu(@Param("idx") int idx);

	public FoodMenuVO getStoreFoodMenu(@Param("storeIdx") int idx);


}

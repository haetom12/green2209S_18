package com.spring.green2209S_18.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.green2209S_18.vo.StoreVO;

public interface StoreDAO {

	public StoreVO getStoreIdCheck(@Param("storeMid") String storeMid);

	public void setStoreJoinOk(@Param("vo") StoreVO vo);

	public List<StoreVO> getStoreCategory();

}

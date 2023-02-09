package com.spring.green2209S_18.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.green2209S_18.vo.FoodMenuVO;
import com.spring.green2209S_18.vo.StoreVO;
import com.spring.green2209S_18.vo.SubFoodMenuVO;

public interface StoreDAO {

	public StoreVO getStoreIdCheck(@Param("storeMid") String storeMid);

	public void setStoreJoinOk(@Param("vo") StoreVO vo);

	public List<StoreVO> getStoreCategory();

	public List<StoreVO> getStoreList(@Param("storePart") String storePart, @Param("ordered") String ordered);

	public List<StoreVO> getNearMapStoreList(@Param("storePart") String storePart);

	public StoreVO getStoreMenu(@Param("idx") int idx);

	public List<FoodMenuVO> getStoreFoodMenu(@Param("storeName") String storeName);

	public int setStoreSubMenuDeletePost(@Param("foodName") String foodName);

	public int setStoreMenuDeletePost(@Param("foodName") String foodName);

	public List<FoodMenuVO> getStoreFood(@Param("foodName") String foodName);

	public void setStoreMenuUpdate(@Param("vo") FoodMenuVO vo, @Param("pastFoodName") String pastFoodName);

	public List<FoodMenuVO> getCheckTagList(@Param("foodTag") String foodTag,@Param("storeName") String brandName);

	public List<SubFoodMenuVO> getChecksubTagList(@Param("foodTag") String foodTag,@Param("storeName")  String brandName);

	public List<StoreVO> getAdminStoreBrand(@Param("storePart") String storePart);

	public List<FoodMenuVO> getstoreMenuList(@Param("brandName") String brandName,@Param("storeName") String storeName);

	public FoodMenuVO getAdminStoreMenu(@Param("menuIdx") int menuIdx);

	public FoodMenuVO getAdminStoreTag(@Param("foodName") String foodName);

	public SubFoodMenuVO getAdminStoreSubMenu(@Param("brandName") String brandName);

	public void setAdminStoreMenu(@Param("vo") FoodMenuVO foodVo,@Param("storeName")  String storeName);

	public void setAdminStoreSubMenu(@Param("vo") SubFoodMenuVO subFoodVo,@Param("storeName")  String storeName);

	public FoodMenuVO getCheckStoreTagList(@Param("foodTag") String foodTag,@Param("storeName") String storeName);

	public void setAdminStoreTag(@Param("foodTag") String foodTag, @Param("storeName") String storeName);

	public List<FoodMenuVO> getstoreTagList(@Param("storeName") String storeName);

	public List<FoodMenuVO> getStoreFoodMenuByTag(@Param("storeName") String storeName,@Param("foodTag") String foodTag);

	public int setStoreMenuDeleteOk(@Param("foodName") String foodName);

	public FoodMenuVO storeFoodNameCheck(@Param("storeName") String storeName, @Param("foodName") String foodName);

	public void setStoreMenuInput(@Param("vo") FoodMenuVO vo);

	public void setfoodMenuUpdate(@Param("vo") FoodMenuVO vo);

	public FoodMenuVO storefoodTagCheck(@Param("foodTag") String foodTag,@Param("storeName") String storeName);

	public int setStoreTagInput(@Param("vo") FoodMenuVO vo);

	public int storefoodTagDelete(@Param("foodTag") String foodTag);

	public int setStoreTagUpdate(@Param("vo") FoodMenuVO vo, @Param("oldTag") String oldTag, @Param("storeName") String storeName);

	public List<SubFoodMenuVO> getstoreSubMenuList(@Param("storeName") String storeName,@Param("foodTag") String foodTag);

	public SubFoodMenuVO storeSubMenuNameCheck(@Param("subMenuName") String subMenuName, @Param("storeName") String storeName, @Param("foodTag") String foodTag);

	public int setStoreSubMenuInput(@Param("vo") SubFoodMenuVO vo);

	public int setStoreSubMenuDelete(@Param("subMenuIdx") int subMenuIdx);

	public SubFoodMenuVO getSubMenuInfo(@Param("subMenuIdx") int subMenuIdx);

	public int setSubMenuUpdateOk(@Param("vo") SubFoodMenuVO vo);


}

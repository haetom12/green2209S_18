package com.spring.green2209S_18.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.green2209S_18.vo.FoodMenuVO;
import com.spring.green2209S_18.vo.MemberVO;
import com.spring.green2209S_18.vo.StoreVO;
import com.spring.green2209S_18.vo.SubFoodMenuVO;

public interface AdminDAO {

	public StoreVO getcategoryCodeCheck(@Param("categoryStoreCode") String categoryStoreCode);

	public StoreVO getcategoryCodeCheck2(@Param("storePart") String storePart);

	public void setCategoryInput(@Param("vo") StoreVO vo);

	public List<StoreVO> getCategoryList(@Param("vo") StoreVO vo);

	public void setCategoryDelete(@Param("vo") StoreVO vo);

	public void setCategoryUpdate(@Param("vo") StoreVO vo, @Param("pastCode") String pastCode);

	public StoreVO getBrandNameCheck(@Param("storePart") String storePart,@Param("brandName")  String brandName);

	public int setStoreBrandInputOk(@Param("vo") StoreVO vo);

	public List<StoreVO> getStoreBrandList();

	public int setadminBrandDelete(@Param("brandName") String brandName);

	public StoreVO getstoreBrand(@Param("brandName") String brandName);

	public int StoreBrandUpdateOk(@Param("vo") StoreVO vo,@Param("oldBrandName") String oldBrandName);

	public List<FoodMenuVO> getstoreMenuList(@Param("brandName") String brandName);

	public List<FoodMenuVO> getstoreTagList(@Param("brandName") String brandName);

	public List<FoodMenuVO> getFoodTagCheck(@Param("brandName") String brandName,@Param("foodTag") String foodTag);

	public int storeTagInputOk(@Param("vo") FoodMenuVO vo);

	public int storeTagUpdateOk(@Param("brandName") String brandName,@Param("foodTag") String foodTag,@Param("oldTag") String oldTag);

	public int setStoreTagDelete(@Param("foodTag") String foodTag, @Param("brandName") String brandName);

	public List<FoodMenuVO> getCheckTagList(@Param("foodTag") String foodTag,@Param("brandName")  String brandName);

	public FoodMenuVO getFoodNameCheck(@Param("brandName") String brandName, @Param("foodName")  String foodName);

	public void setFoodInput(@Param("vo") FoodMenuVO vo);

	public List<SubFoodMenuVO> getCheckAdminSubMenu(@Param("foodName") String foodName);

	public int setAdminSubMenuDeletePost(@Param("foodName") String foodName);

	public int setAdminMenuDeletePost(@Param("foodName") String foodName);

	public void setfoodMenuUpdate(@Param("vo") FoodMenuVO vo);

	public List<SubFoodMenuVO> getChecksubTagList(@Param("foodTag") String foodTag,@Param("brandName") String brandName);

	public List<FoodMenuVO> getAdminFoodList(@Param("brandName") String brandName);

	public List<MemberVO> getMemberList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("search") String search, @Param("searchString") String searchString, @Param("order") String order);

	public int totMemberListCnt(@Param("search") String search, @Param("searchString") String searchString);

	public int totMemberDeleteListCnt(@Param("search") String search, @Param("searchString") String searchString);

	public List<MemberVO> getDeleteMemberList(@Param("startIndexNo") int startIndexNo,@Param("pageSize")  int pageSize,@Param("search")  String search,
			@Param("searchString") String searchString, @Param("order") String order);

	public int setMemberDelete(@Param("mid") String mid);


}

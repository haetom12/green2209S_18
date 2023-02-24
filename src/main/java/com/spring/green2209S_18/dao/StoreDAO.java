package com.spring.green2209S_18.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.green2209S_18.vo.FoodMenuVO;
import com.spring.green2209S_18.vo.RatingVO;
import com.spring.green2209S_18.vo.StoreVO;
import com.spring.green2209S_18.vo.SubFoodMenuVO;
import com.spring.green2209S_18.vo.ratingReplyVO;

public interface StoreDAO {

	public StoreVO getStoreIdCheck(@Param("storeMid") String storeMid);

	public void setStoreJoinOk(@Param("vo") StoreVO vo);

	public List<StoreVO> getStoreCategory();

	public List<StoreVO> getStoreList(@Param("storePart") String storePart, @Param("ordered") String ordered,@Param("startIndexNo") int startIndexNo,@Param("pageSize") int pageSize);

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

	public int setStoreMenuDeleteOk(@Param("menuIdx") int menuIdx);

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

	public FoodMenuVO getfoodInfo(@Param("menuIdx") int menuIdx);

	public StoreVO getstoreInfo(@Param("storeName") String storeName);

	public List<RatingVO> getRatingList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("storeName") String storeName);

	public int totRatingCnt(@Param("storePart") String search);

	public int setRatingDeleteOk(@Param("idx") int idx);

	public RatingVO getRatingInfo(@Param("idx") int idx);

	public int setRatingUpdateOk(@Param("vo") RatingVO vo);

	public int totStoreMenuCnt(@Param("storeName") String search);

	public List<FoodMenuVO> getStoreFoodMenu2(@Param("storeName") String storeName, @Param("foodTag") String foodTag, @Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);

	public int setRatingReplyInput(@Param("vo") ratingReplyVO vo);

	public List<ratingReplyVO> getRatingReply(@Param("idx") int idx);

	public List<ratingReplyVO> getRatingCommentList(@Param("idx") int idx);

	public List<ratingReplyVO> getRatingCommentList2(@Param("ratingIdx") int ratingIdx, @Param("idx")  int idx);

	public int setRatingReReplyInput(@Param("vo") ratingReplyVO vo);

	public ratingReplyVO getReplyComment(@Param("idx") int idx);

	public int setReplyDeleteUpdate(@Param("idx") int idx);

	public int setReplyDelete(@Param("idx") int idx);

	public List<ratingReplyVO> getReplyParent(@Param("idx") int idx);

	public int setRatingReplyUpdate(@Param("vo") ratingReplyVO vo);

	public void setRatingReplyDeleteAll(@Param("idx") int idx);

	public int setReportRating(@Param("idx") int idx, @Param("mid") String mid);

	public StoreVO getCheckStoreName(@Param("storeName") String storeName);

	public void setStoreUpdate(@Param("vo") StoreVO vo);

	public int setStorePwdUpdate(@Param("storePwd") String newPwd, @Param("storeMid") String mid);

	public int setStoreDelete(@Param("storeMid") String mid);

	public List<FoodMenuVO> getSaleFoodList();

	public StoreVO getMidFind(@Param("HostName") String name, @Param("storeEmail") String email);

	public StoreVO getPwdFind(@Param("storeMid") String mid,@Param("storeEmail") String email);

	public FoodMenuVO getFoodInfo(@Param("menuIdx") int menuIdx);

	public int setReportReply(@Param("idx") int idx, @Param("mid") String mid);


}

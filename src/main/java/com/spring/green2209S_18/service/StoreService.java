package com.spring.green2209S_18.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.spring.green2209S_18.vo.FoodMenuVO;
import com.spring.green2209S_18.vo.MemberVO;
import com.spring.green2209S_18.vo.RatingVO;
import com.spring.green2209S_18.vo.StoreVO;
import com.spring.green2209S_18.vo.SubFoodMenuVO;
import com.spring.green2209S_18.vo.ratingReplyVO;

public interface StoreService {

	public StoreVO getStoreIdCheck(String storeMid);

	public int setStoreJoinOk(StoreVO vo, MultipartFile fName);

	public List<StoreVO> getStoreCategory();

	public List<StoreVO> getStoreList(String storePart, String ordered, int startIndexNo, int pageSize);

	public List<StoreVO> getNearMapStoreList(String storePart);

	public StoreVO getStoreMenu(int idx);

	public List<FoodMenuVO> getStoreFoodMenu(String storeName);

	public int setStoreSubMenuDeletePost(String foodName);

	public int setStoreMenuDeletePost(String foodName);

	public List<FoodMenuVO> getStoreFood(String foodName);

	public List<FoodMenuVO> getCheckTagList(String foodTag, String brandName);

	public List<SubFoodMenuVO> getChecksubTagList(String foodTag, String brandName);

	public List<StoreVO> getAdminStoreBrand(String storePart);

	public List<FoodMenuVO> getstoreMenuList(String brandName, String storeName);

	public FoodMenuVO getAdminStoreMenu(int menuIdx);

	public FoodMenuVO getAdminStoreTag(String foodName);

	public void setAdminStoreMenu(FoodMenuVO foodVo, String storeName);

	public void setAdminStoreSubMenu(SubFoodMenuVO subFoodVo, String storeName);

	public FoodMenuVO getCheckStoreTagList(String foodTag, String storeName);

	public void setAdminStoreTag(String foodTag, String storeName);

	public List<FoodMenuVO> getstoreTagList(String storeName);

	public List<FoodMenuVO> getStoreFoodMenuByTag(String storeName, String foodTag);

	public int setStoreMenuDeleteOk(int menuIdx);

	public FoodMenuVO storeFoodNameCheck(String storeName, String foodName);

	public int setStoreMenuInput(FoodMenuVO vo, MultipartFile fName);

	public int setStoreMenuUpdate(FoodMenuVO vo, MultipartFile fName, String pastPhoto, String pastFoodName);

	public List<StoreVO> getStoreDistance(List<StoreVO> vos, MemberVO mVo, int distance);

	public FoodMenuVO storefoodTagCheck(String foodTag, String storeName);

	public int setStoreTagInput(FoodMenuVO vo);

	public int storefoodTagDelete(String foodTag);

	public int setStoreTagUpdate(FoodMenuVO vo, String oldTag, String storeName);

	public List<SubFoodMenuVO> getstoreSubMenuList(String storeName, String foodTag);

	public SubFoodMenuVO storeSubMenuNameCheck(String subMenuName, String storeName, String foodTag);

	public int setStoreSubMenuInput(SubFoodMenuVO vo);

	public int setStoreSubMenuDelete(int subMenuIdx);

	public SubFoodMenuVO getSubMenuInfo(int subMenuIdx);

	public int setSubMenuUpdateOk(SubFoodMenuVO vo);

	public FoodMenuVO getfoodInfo(int menuIdx);

	public StoreVO getstoreInfo(String storeName);

	public List<RatingVO> getRatingList(int startIndexNo, int pageSize, String storeName);

	public int setRatingDeleteOk(int idx);

	public RatingVO getRatingInfo(int idx);

	public int setRatingUpdateOk(RatingVO vo);

	public List<FoodMenuVO> getStoreFoodMenu2(String storeName, String foodTag, int startIndexNo, int pageSize);

	public int setRatingReplyInput(ratingReplyVO vo);

	public List<ratingReplyVO> getRatingReply(int idx);

	public List<ratingReplyVO> getRatingCommentList(int idx);

	public List<ratingReplyVO> getRatingCommentList2(int ratingIdx, int idx);

	public int setRatingReReplyInput(ratingReplyVO vo);

	public ratingReplyVO getReplyComment(int idx);

	public int setReplyDeleteUpdate(int idx);

	public int setReplyDelete(int idx);

	public List<ratingReplyVO> getReplyParent(int idx);

	public int setRatingReplyUpdate(ratingReplyVO vo);

	public void setRatingReplyDeleteAll(int idx);

	public int setReportRating(int idx, String mid);

	public StoreVO getCheckStoreName(String storeName);

	public int setStoreUpdate(StoreVO vo, MultipartFile fName, String pastPhoto);

	public int setStorePwdUpdate(String newPwd, String mid);

	public int setStoreDelete(String mid);

	public List<FoodMenuVO> getSaleFoodList();

	public StoreVO getMidFind(String name, String email);

	public StoreVO getPwdFind(String mid, String email);

	public FoodMenuVO getFoodInfo(int menuIdx);


}

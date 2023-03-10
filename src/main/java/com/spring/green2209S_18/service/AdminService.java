package com.spring.green2209S_18.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.spring.green2209S_18.vo.CartVO;
import com.spring.green2209S_18.vo.FoodMenuVO;
import com.spring.green2209S_18.vo.MemberVO;
import com.spring.green2209S_18.vo.QnaVO;
import com.spring.green2209S_18.vo.RiderVO;
import com.spring.green2209S_18.vo.StoreVO;
import com.spring.green2209S_18.vo.SubFoodMenuVO;

public interface AdminService {

	public StoreVO getcategoryCodeCheck(String categoryStoreCode);

	public StoreVO getcategoryCodeCheck2(String storePart);

	public int setCategoryInput(StoreVO vo, MultipartFile fName);

	public List<StoreVO> getCategoryList(StoreVO vo);

	public int setCategoryDelete(StoreVO vo);

	public int setCategoryUpdate(MultipartFile fName, StoreVO vo, String pastPhoto, String pastCode);

	public StoreVO getBrandNameCheck(String storePart, String brandName);

	public int setStoreBrandInputOk(StoreVO vo);

	public List<StoreVO> getStoreBrandList();

	public int setadminBrandDelete(String brandName);

	public StoreVO getstoreBrand(String brandName);

	public int StoreBrandUpdateOk(StoreVO vo, String oldBrandName);

	public List<FoodMenuVO> getstoreTagList(String brandName);

	public List<FoodMenuVO> getFoodTagCheck(String brandName, String foodTag);

	public int storeTagInputOk(FoodMenuVO vo);

	public int storeTagUpdateOk(String brandName, String foodTag, String oldTag);

	public int setStoreTagDelete(String foodTag, String brandName);

	public List<FoodMenuVO> getCheckTagList(String foodTag, String brandName);

	public FoodMenuVO getFoodNameCheck(String brandName, String foodName);

	public int setAdminMenuInput(FoodMenuVO vo, MultipartFile fName);

	public List<SubFoodMenuVO> getCheckAdminSubMenu(String foodName);

	public int setAdminSubMenuDeletePost(String foodName);

	public int setAdminMenuDeletePost(FoodMenuVO aVo);

	public int setStoreMenuUpdate(FoodMenuVO vo, MultipartFile fName, String pastPhoto, String pastFoodName);

	public List<SubFoodMenuVO> getChecksubTagList(String foodTag, String brandName);

	public List<FoodMenuVO> getstoreMenuList(int startIndexNo, int pageSize, String search, String searchString, String brandName);

	public List<MemberVO> getMemberList(int startIndexNo, int pageSize, String search, String searchString, String order);

	public List<MemberVO> getDeleteMemberList(int startIndexNo, int pageSize, String search, String searchString, String order);

	public int setMemberDelete(String mid);

	public List<MemberVO> getBanMemberList(int startIndexNo, int pageSize, String search, String searchString, String order);

	public int setUnLockMember(String mid);

	public int setAdminMemberDeleteCheck(String mid);

	public int setadminMemberRestore(String mid);

	public List<RiderVO> getRiderList(int startIndexNo, int pageSize, String search, String searchString, String order);

	public List<RiderVO> getRiderDeleteList(int startIndexNo, int pageSize, String search, String searchString, String order);

	public int setAdminRiderDeleteOk(String riderMid);

	public int setAdminRiderDelete(String riderMid);

	public int setAdminRiderRestore(String riderMid);

	public int getToTMember();

	public List<StoreVO> getStoreList(int startIndexNo, int pageSize, String search, String searchString, String order);

	public int setAdminStoreDelete(String storeMid);

	public List<StoreVO> getStoreDeleteList(int startIndexNo, int pageSize, String search, String searchString, String order);

	public int setAdminStoreRestore(String storeMid);

	public int setAdminStoreDeleteOk(String storeMid);

	public List<StoreVO> getRatingList(int startIndexNo, int pageSize, String search, String searchString, String order);

	public List<StoreVO> getRatingReportList(int startIndexNo, int pageSize, String search, String searchString, String order);

	public List<StoreVO> getRatingReplyList(int startIndexNo, int pageSize, String search, String searchString, String order);

	public List<StoreVO> getReplyReportList(int startIndexNo, int pageSize, String search, String searchString, String order);

	public List<StoreVO> getQnAList(int startIndexNo, int pageSize, String search, String searchString);

	public int setAdminQnAInput(int idx, QnaVO vo);

	public int setQnAnwerDelete(int idx);

	public int setAdminDeleteQnA(int idx);

	public List<StoreVO> getQnAListYet(int startIndexNo, int pageSize, String search, String searchString);

	public List<StoreVO> getQnAListDone(int startIndexNo, int pageSize, String search, String searchString);


}

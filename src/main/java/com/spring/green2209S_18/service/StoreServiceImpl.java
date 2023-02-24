package com.spring.green2209S_18.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.spring.green2209S_18.common.DistanceCal;
import com.spring.green2209S_18.common.JavaspringProvide;
import com.spring.green2209S_18.dao.StoreDAO;
import com.spring.green2209S_18.vo.FoodMenuVO;
import com.spring.green2209S_18.vo.MemberVO;
import com.spring.green2209S_18.vo.RatingVO;
import com.spring.green2209S_18.vo.StoreVO;
import com.spring.green2209S_18.vo.SubFoodMenuVO;
import com.spring.green2209S_18.vo.ratingReplyVO;

@Service
public class StoreServiceImpl implements StoreService {
	@Autowired
	StoreDAO storeDAO;

	@Override
	public StoreVO getStoreIdCheck(String storeMid) {
		return storeDAO.getStoreIdCheck(storeMid);
	}

	@Transactional
	@Override
	public int setStoreJoinOk(StoreVO vo, MultipartFile fName) {
	// 업로드 된 사진을 서버 파일시스템에 저장시켜준다.
			int res = 0;
			try {
				String oFileName = fName.getOriginalFilename();
				UUID uid = UUID.randomUUID();
				String saveFileName = uid + "_" + oFileName;
				
				JavaspringProvide ps = new JavaspringProvide();
				ps.writeFile(fName,saveFileName, "store");
				vo.setLogoPhoto(saveFileName);
				storeDAO.setStoreJoinOk(vo);
				res = 1;
			} catch (IOException e)	 {
				e.printStackTrace();
			}
			return res;
	}

	@Override
	public List<StoreVO> getStoreCategory() {
		return storeDAO.getStoreCategory();
	}

	@Override
	public List<StoreVO> getStoreList(String storePart, String ordered, int startIndexNo, int pageSize) {
		return storeDAO.getStoreList(storePart, ordered, startIndexNo, pageSize);
	}

	@Override
	public List<StoreVO> getNearMapStoreList(String storePart) {
		return storeDAO.getNearMapStoreList(storePart);
	}

	@Override
	public StoreVO getStoreMenu(int idx) {
		return storeDAO.getStoreMenu(idx);
	}

	@Override
	public List<FoodMenuVO> getStoreFoodMenu(String storeName) {
		return storeDAO.getStoreFoodMenu(storeName);
	}

	@Override
	public int setStoreSubMenuDeletePost(String foodName) {
		return storeDAO.setStoreSubMenuDeletePost(foodName);
	}

	@Override
	public int setStoreMenuDeletePost(String foodName) {
		int res = 0;
		JavaspringProvide ps = new JavaspringProvide();
		
		try {
			ps.deletePhoto(foodName, "storeFoodPhoto");
			storeDAO.setStoreMenuDeletePost(foodName);
			res= 1;
		} catch (IOException e) {
			e.printStackTrace();
		}
		return res;
	}

	@Override
	public List<FoodMenuVO> getStoreFood(String foodName) {
		return storeDAO.getStoreFood(foodName);
	}

	@Override
	public List<FoodMenuVO> getCheckTagList(String foodTag, String brandName) {
		return storeDAO.getCheckTagList(foodTag, brandName);
	}

	@Override
	public List<SubFoodMenuVO> getChecksubTagList(String foodTag, String brandName) {
		return storeDAO.getChecksubTagList(foodTag, brandName);
	}

	@Override
	public List<StoreVO> getAdminStoreBrand(String storePart) {
		return storeDAO.getAdminStoreBrand(storePart);
	}

	@Override
	public List<FoodMenuVO> getstoreMenuList(String brandName, String storeName) {
		return storeDAO.getstoreMenuList(brandName, storeName);
	}

	@Override
	public FoodMenuVO getAdminStoreMenu(int menuIdx) {
		return storeDAO.getAdminStoreMenu(menuIdx);
	}

	@Override
	public FoodMenuVO getAdminStoreTag(String foodName) {
		return storeDAO.getAdminStoreTag(foodName);
	}

	@Override
	public void setAdminStoreMenu(FoodMenuVO foodVo, String storeName) {
		
		String imgFile = foodVo.getFoodPhoto();
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String uploadPath = request.getSession().getServletContext().getRealPath("/resources/data/");
		
		String origFilePath = uploadPath + "adminFoodPhoto/" +imgFile;
		String copyFilePath = uploadPath + "storeFoodPhoto/" + imgFile;
		
		JavaspringProvide ps = new JavaspringProvide();
		
		ps.fileCopyCheck(origFilePath,copyFilePath); // board 폴더에 파일을 복사하고자 한다.
		
		
		storeDAO.setAdminStoreMenu(foodVo, storeName);
	}

	@Override
	public void setAdminStoreSubMenu(SubFoodMenuVO subFoodVo, String storeName) {
		storeDAO.setAdminStoreSubMenu(subFoodVo, storeName);
	}

	@Override
	public FoodMenuVO getCheckStoreTagList(String foodTag, String storeName) {
		return storeDAO.getCheckStoreTagList(foodTag, storeName);
	}

	@Override
	public void setAdminStoreTag(String foodTag, String storeName) {
		storeDAO.setAdminStoreTag(foodTag, storeName);
	}

	@Override
	public List<FoodMenuVO> getstoreTagList(String storeName) {
		return storeDAO.getstoreTagList(storeName);
	}

	@Override
	public List<FoodMenuVO> getStoreFoodMenuByTag(String storeName, String foodTag) {
		return storeDAO.getStoreFoodMenuByTag(storeName, foodTag);
	}

	@Override
	public int setStoreMenuDeleteOk(int menuIdx) {
		return storeDAO.setStoreMenuDeleteOk(menuIdx);
	}

	@Override
	public FoodMenuVO storeFoodNameCheck(String storeName, String foodName) {
		return storeDAO.storeFoodNameCheck(storeName, foodName);
	}
	
	@Transactional
	@Override
	public int setStoreMenuInput(FoodMenuVO vo, MultipartFile fName) {
	// 업로드 된 사진을 서버 파일시스템에 저장시켜준다.
			int res = 0;
			try {
				String oFileName = fName.getOriginalFilename();
				UUID uid = UUID.randomUUID();
				String saveFileName = uid + "_" + oFileName;
				
				JavaspringProvide ps = new JavaspringProvide();
				ps.writeFile(fName, saveFileName, "storeFoodPhoto");
				vo.setFoodPhoto(saveFileName);
				storeDAO.setStoreMenuInput(vo);
				res = 1;
			} catch (IOException e)	 {
				e.printStackTrace();
			}
			return res;
	}

	@Override
	public int setStoreMenuUpdate(FoodMenuVO vo, MultipartFile fName, String pastPhoto, String pastFoodName) {
		int res = 0;
		String oFileName = fName.getOriginalFilename();
		UUID uid = UUID.randomUUID();
		String saveFileName = "";
		
		if(oFileName.equals("")) {
			vo.setFoodPhoto(pastPhoto);
			saveFileName = pastPhoto;
			storeDAO.setfoodMenuUpdate(vo);
			
			res = 1;
			return res;
		}
		else {
			saveFileName = uid + "_" + oFileName;
		}
		JavaspringProvide ps = new JavaspringProvide();
		try {
			ps.deleteAndUpdateFile(fName,saveFileName,pastPhoto, "storeFoodPhoto");
			vo.setFoodPhoto(saveFileName);
			storeDAO.setfoodMenuUpdate(vo);
			
			res= 1;
		} catch (IOException e) {
			e.printStackTrace();
		}
		return res;
	}

	@Override
	public List<StoreVO> getStoreDistance(List<StoreVO> vos, MemberVO mVo, int distanceCal) {
	// 자기 위치를 변수로 담아서 밑에 변수로 받기
			double centerLat = mVo.getMemberLatitude();
			double centerLongi = mVo.getMemberLongitude();
			
			List<StoreVO> mVos = new ArrayList<StoreVO>();
			
			for(int i=0; i<vos.size(); i++) {
				double distance = DistanceCal.distance(centerLat, centerLongi, vos.get(i).getStoreLatitude(), vos.get(i).getStoreLongitude(), "kilometer");
				if(distance < distanceCal) {
					System.out.println("계산된 거리  : " + distance);
					mVos.add(vos.get(i));
				}
			}
			return mVos;
	}

	@Override
	public FoodMenuVO storefoodTagCheck(String foodTag, String storeName) {
		return storeDAO.storefoodTagCheck(foodTag, storeName);
	}

	@Override
	public int setStoreTagInput(FoodMenuVO vo) {
		return storeDAO.setStoreTagInput(vo);
	}

	@Override
	public int storefoodTagDelete(String foodTag) {
		return storeDAO.storefoodTagDelete(foodTag);
	}

	@Override
	public int setStoreTagUpdate(FoodMenuVO vo, String oldTag, String storeName) {
		return storeDAO.setStoreTagUpdate(vo, oldTag, storeName);
	}

	@Override
	public List<SubFoodMenuVO> getstoreSubMenuList(String storeName, String foodTag) {
		return storeDAO.getstoreSubMenuList(storeName, foodTag);
	}

	@Override
	public SubFoodMenuVO storeSubMenuNameCheck(String subMenuName, String storeName, String foodTag) {
		return storeDAO.storeSubMenuNameCheck(subMenuName, storeName, foodTag);
	}

	@Override
	public int setStoreSubMenuInput(SubFoodMenuVO vo) {
		return storeDAO.setStoreSubMenuInput(vo);
	}

	@Override
	public int setStoreSubMenuDelete(int subMenuIdx) {
		return storeDAO.setStoreSubMenuDelete(subMenuIdx);
	}

	@Override
	public SubFoodMenuVO getSubMenuInfo(int subMenuIdx) {
		return storeDAO.getSubMenuInfo(subMenuIdx);
	}

	@Override
	public int setSubMenuUpdateOk(SubFoodMenuVO vo) {
		return storeDAO.setSubMenuUpdateOk(vo);
	}

	@Override
	public FoodMenuVO getfoodInfo(int menuIdx) {
		return storeDAO.getfoodInfo(menuIdx);
	}

	@Override
	public StoreVO getstoreInfo(String storeName) {
		return storeDAO.getstoreInfo(storeName);
	}

	@Override
	public List<RatingVO> getRatingList(int startIndexNo, int pageSize, String storeName) {
		return storeDAO.getRatingList(startIndexNo, pageSize, storeName);
	}

	@Override
	public int setRatingDeleteOk(int idx) {
		return storeDAO.setRatingDeleteOk(idx);
	}

	@Override
	public RatingVO getRatingInfo(int idx) {
		return storeDAO.getRatingInfo(idx);
	}

	@Override
	public int setRatingUpdateOk(RatingVO vo) {
		return storeDAO.setRatingUpdateOk(vo);
	}

	@Override
	public List<FoodMenuVO> getStoreFoodMenu2(String storeName, String foodTag, int startIndexNo, int pageSize) {
		return storeDAO.getStoreFoodMenu2(storeName, foodTag, startIndexNo, pageSize);
	}

	@Override
	public int setRatingReplyInput(ratingReplyVO vo) {
		return storeDAO.setRatingReplyInput(vo);
	}

	@Override
	public List<ratingReplyVO> getRatingReply(int idx) {
		return storeDAO.getRatingReply(idx);
	}

	@Override
	public List<ratingReplyVO> getRatingCommentList(int idx) {
		return storeDAO.getRatingCommentList(idx);
	}

	@Override
	public List<ratingReplyVO> getRatingCommentList2(int ratingIdx,int idx) {
		return storeDAO.getRatingCommentList2(ratingIdx, idx);
	}

	@Override
	public int setRatingReReplyInput(ratingReplyVO vo) {
		return storeDAO.setRatingReReplyInput(vo);
	}

	@Override
	public ratingReplyVO getReplyComment(int idx) {
		return storeDAO.getReplyComment(idx);
	}

	@Override
	public int setReplyDeleteUpdate(int idx) {
		return storeDAO.setReplyDeleteUpdate(idx);
	}

	@Override
	public int setReplyDelete(int idx) {
		return storeDAO.setReplyDelete(idx);
	}

	@Override
	public List<ratingReplyVO> getReplyParent(int idx) {
		return storeDAO.getReplyParent(idx);
	}

	@Override
	public int setRatingReplyUpdate(ratingReplyVO vo) {
		return storeDAO.setRatingReplyUpdate(vo);
	}

	@Override
	public void setRatingReplyDeleteAll(int idx) {
		storeDAO.setRatingReplyDeleteAll(idx);
	}

	@Override
	public int setReportRating(int idx, String mid) {
		return storeDAO.setReportRating(idx, mid);
	}

	@Override
	public StoreVO getCheckStoreName(String storeName) {
		return storeDAO.getCheckStoreName(storeName);
	}

	@Override
	public int setStoreUpdate(StoreVO vo, MultipartFile fName, String pastPhoto) {
		int res = 0;
		String oFileName = fName.getOriginalFilename();
		UUID uid = UUID.randomUUID();
		String saveFileName = "";
		
		if(oFileName.equals("")) {
			vo.setLogoPhoto(pastPhoto);
			saveFileName = pastPhoto;
			storeDAO.setStoreUpdate(vo);
			
			res = 1;
			return res;
		}
		else {
			saveFileName = uid + "_" + oFileName;
		}
		JavaspringProvide ps = new JavaspringProvide();
		try {
			ps.deleteAndUpdateFile(fName,saveFileName,pastPhoto, "store");
			vo.setLogoPhoto(saveFileName);
			storeDAO.setStoreUpdate(vo);
			
			res= 1;
		} catch (IOException e) {
			e.printStackTrace();
		}
		return res;
	}

	@Override
	public int setStorePwdUpdate(String newPwd, String mid) {
		return storeDAO.setStorePwdUpdate(newPwd, mid);
	}

	@Override
	public int setStoreDelete(String mid) {
		return storeDAO.setStoreDelete(mid);
	}

	@Override
	public List<FoodMenuVO> getSaleFoodList() {
		return storeDAO.getSaleFoodList();
	}

	@Override
	public StoreVO getMidFind(String name, String email) {
		return storeDAO.getMidFind(name, email);
	}

	@Override
	public StoreVO getPwdFind(String mid, String email) {
		return storeDAO.getPwdFind(mid, email);
	}

	@Override
	public FoodMenuVO getFoodInfo(int menuIdx) {
		return storeDAO.getFoodInfo(menuIdx);
	}

	@Override
	public int setReportReply(int idx, String mid) {
		return storeDAO.setReportReply(idx, mid);
	}



}
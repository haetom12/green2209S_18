package com.spring.green2209S_18.service;

import java.io.IOException;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.spring.green2209S_18.common.JavaspringProvide;
import com.spring.green2209S_18.dao.StoreDAO;
import com.spring.green2209S_18.vo.FoodMenuVO;
import com.spring.green2209S_18.vo.StoreVO;
import com.spring.green2209S_18.vo.SubFoodMenuVO;

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
	public List<StoreVO> getStoreList(String storePart, String ordered) {
		return storeDAO.getStoreList(storePart, ordered);
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
	public int setStoreMenuDeletePost(FoodMenuVO sVo) {
		int res = 0;
		JavaspringProvide ps = new JavaspringProvide();
		
		try {
			ps.deletePhoto(sVo.getFoodPhoto(), "storeFoodPhoto");
			storeDAO.setStoreMenuDeletePost(sVo.getFoodName());
			res= 1;
		} catch (IOException e) {
			e.printStackTrace();
		}
		return res;
	}

	@Override
	public FoodMenuVO getStoreFood(String brandName, String foodName) {
		return storeDAO.getStoreFood(brandName, foodName);
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
	public List<FoodMenuVO> getstoreMenuList(String brandName) {
		System.out.println("들어왓음");
		return storeDAO.getstoreMenuList(brandName);
	}


}
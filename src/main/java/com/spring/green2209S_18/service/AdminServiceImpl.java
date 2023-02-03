package com.spring.green2209S_18.service;

import java.io.IOException;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.spring.green2209S_18.common.JavaspringProvide;
import com.spring.green2209S_18.dao.AdminDAO;
import com.spring.green2209S_18.vo.FoodMenuVO;
import com.spring.green2209S_18.vo.StoreVO;
import com.spring.green2209S_18.vo.SubFoodMenuVO;

@Service
public class AdminServiceImpl implements AdminService {
	
	@Autowired
	AdminDAO adminDAO;

	@Override
	public StoreVO getcategoryCodeCheck(String categoryStoreCode) {
		return adminDAO.getcategoryCodeCheck(categoryStoreCode);
	}

	@Override
	public StoreVO getcategoryCodeCheck2(String storePart) {
		return adminDAO.getcategoryCodeCheck2(storePart);
	}

	@Override
	public int setCategoryInput(StoreVO vo, MultipartFile fName) {
		
	// 업로드 된 사진을 서버 파일시스템에 저장시켜준다.
				int res = 0;
				try {
					String oFileName = fName.getOriginalFilename();
					UUID uid = UUID.randomUUID();
					String saveFileName = uid + "_" + oFileName;
					
					JavaspringProvide ps = new JavaspringProvide();
					ps.writeFile(fName,saveFileName, "categoryPhoto");
					vo.setCategoryPhoto(saveFileName);
					adminDAO.setCategoryInput(vo);
					res = 1;
				} catch (IOException e)	 {
					e.printStackTrace();
				}
				return res;
	}


	@Override
	public List<StoreVO> getCategoryList(StoreVO vo) {
		return adminDAO.getCategoryList(vo);
	}

	
	// 카테고리 삭제
	@Override
	public int setCategoryDelete(StoreVO vo) {
		int res = 0;
		JavaspringProvide ps = new JavaspringProvide();
		
		try {
			ps.deletePhoto(vo.getCategoryPhoto(), "categoryPhoto");
			adminDAO.setCategoryDelete(vo);
			res= 1;
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return res;
	}

	//로고 사진 업데이트
	@Override
	public int setCategoryUpdate(MultipartFile fName, StoreVO vo, String pastPhoto, String pastCode) {
		int res = 0;
		String oFileName = fName.getOriginalFilename();
		UUID uid = UUID.randomUUID();
		String saveFileName = "";
		if(oFileName.equals("")) {
			vo.setCategoryPhoto(pastPhoto);
			saveFileName = pastPhoto;
			adminDAO.setCategoryUpdate(vo, pastCode);
			res = 1;
			return res;
		}
		else {
			saveFileName = uid + "_" + oFileName;
		}
		JavaspringProvide ps = new JavaspringProvide();
		try {
			ps.deleteFile(fName,saveFileName,pastPhoto, "categoryPhoto");
			vo.setCategoryPhoto(saveFileName);
			adminDAO.setCategoryUpdate(vo, pastCode);
			res= 1;
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return res;
	}

	@Override
	public StoreVO getBrandNameCheck(String storePart, String brandName) {
		return adminDAO.getBrandNameCheck(storePart, brandName);
	}

	@Override
	public int setStoreBrandInputOk(StoreVO vo) {
		return adminDAO.setStoreBrandInputOk(vo);
	}

	@Override
	public List<StoreVO> getStoreBrandList() {
		return adminDAO.getStoreBrandList();
	}

	@Override
	public int setadminBrandDelete(String brandName) {
		return adminDAO.setadminBrandDelete(brandName);
	}

	@Override
	public StoreVO getstoreBrand(String brandName) {
		return adminDAO.getstoreBrand(brandName);
	}

	@Override
	public int StoreBrandUpdateOk(StoreVO vo) {
		return adminDAO.StoreBrandUpdateOk(vo);
	}

	@Override
	public List<StoreVO> getstoreMenuList(String brandName) {
		return adminDAO.getstoreMenuList(brandName);
	}

	@Override
	public List<FoodMenuVO> getstoreTagList(String brandName) {
		return adminDAO.getstoreTagList(brandName);
	}

	@Override
	public List<FoodMenuVO> getFoodTagCheck(String brandName, String foodTag) {
		return adminDAO.getFoodTagCheck(brandName, foodTag);
	}

	@Override
	public int storeTagInputOk(FoodMenuVO vo) {
		return adminDAO.storeTagInputOk(vo);
	}

	@Override
	public int storeTagUpdateOk(String brandName, String foodTag, String oldTag) {
		return adminDAO.storeTagUpdateOk(brandName, foodTag, oldTag);
	}

	@Override
	public int setStoreTagDelete(String foodTag, String brandName) {
		return adminDAO.setStoreTagDelete(foodTag, brandName);
	}

	@Override
	public List<FoodMenuVO> getCheckTagList(String foodTag, String brandName) {
		return adminDAO.getCheckTagList(foodTag,brandName);
	}

	@Override
	public FoodMenuVO getFoodNameCheck(String brandName, String foodName) {
		return adminDAO.getFoodNameCheck(brandName, foodName);
	}

	@Override
	public int setAdminMenuInput(FoodMenuVO vo, MultipartFile fName) {
		// 업로드 된 사진을 서버 파일시스템에 저장시켜준다.
		int res = 0;
		try {
			String oFileName = fName.getOriginalFilename();
			UUID uid = UUID.randomUUID();
			String saveFileName = uid + "_" + oFileName;
			
			JavaspringProvide ps = new JavaspringProvide();
			ps.writeFile(fName,saveFileName, "adminFoodPhoto");
			vo.setFoodPhoto(saveFileName);
			adminDAO.setFoodInput(vo);
			res = 1;
		} catch (IOException e)	 {
			e.printStackTrace();
		}
		return res;
}

	@Override
	public List<SubFoodMenuVO> getCheckAdminSubMenu(String foodName) {
		return adminDAO.getCheckAdminSubMenu(foodName);
	}

	@Override
	public int setAdminSubMenuDeletePost(String foodName) {
		return adminDAO.setAdminSubMenuDeletePost(foodName);
	}

	@Override
	public int setAdminMenuDeletePost(FoodMenuVO aVo) {
		int res = 0;
		JavaspringProvide ps = new JavaspringProvide();
		
		try {
			ps.deletePhoto(aVo.getFoodPhoto(), "adminFoodPhoto");
			adminDAO.setAdminMenuDeletePost(aVo.getFoodName());
			res= 1;
		} catch (IOException e) {
			e.printStackTrace();
		}
		return res;
	}

}

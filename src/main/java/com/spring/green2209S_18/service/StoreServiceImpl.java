package com.spring.green2209S_18.service;

import java.io.IOException;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.spring.green2209S_18.common.JavaspringProvide;
import com.spring.green2209S_18.dao.StoreDAO;
import com.spring.green2209S_18.vo.StoreVO;

@Service
public class StoreServiceImpl implements StoreService {
	@Autowired
	StoreDAO storeDAO;

	@Override
	public StoreVO getStoreIdCheck(String storeMid) {
		return storeDAO.getStoreIdCheck(storeMid);
	}

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
}
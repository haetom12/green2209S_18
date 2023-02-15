package com.spring.green2209S_18.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.spring.green2209S_18.common.JavaspringProvide;
import com.spring.green2209S_18.dao.OrderDAO;
import com.spring.green2209S_18.vo.CartVO;
import com.spring.green2209S_18.vo.FoodMenuVO;
import com.spring.green2209S_18.vo.RatingVO;
import com.spring.green2209S_18.vo.WebSocketDbVO;
import com.spring.green2209S_18.vo.wishListVO;

@Service
public class OrderServiceImpl implements OrderService {
	
	@Autowired
	OrderDAO orderDAO;

	@Override
	public int setWishListInput(String storeName, int menuIdx, String mid) {
		return orderDAO.setWishListInput(storeName, menuIdx, mid);
	}

	@Override
	public wishListVO getCheckWishList(String storeName, int menuIdx, String mid) {
		return orderDAO.getCheckWishList(storeName, menuIdx, mid);
	}

	@Override
	public List<wishListVO> getMyWishList(String mid) {
		return orderDAO.getMyWishList(mid);
	}

	@Override
	public FoodMenuVO getWishListInfo(int menuIdx) {
		return orderDAO.getWishListInfo(menuIdx);
	}

	@Override
	public void setDeleteWishList(int menuIdx) {
		orderDAO.setDeleteWishList(menuIdx);
	}

	@Override
	public void setAddCartInput(CartVO vo) {
		orderDAO.setAddCartInput(vo);
	}

	@Override
	public void myCartDelete(int idx) {
		orderDAO.myCartDelete(idx);
	}

	@Override
	public CartVO getOrderMaxIdx() {
		return orderDAO.getOrderMaxIdx();
	}

	@Override
	public CartVO getCartIdx(int idx) {
		return orderDAO.getCartIdx(idx);
	}

	@Override
	public void setFoodOrderOK(CartVO vo) {
		String imgFile = vo.getThumbImg();
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String uploadPath = request.getSession().getServletContext().getRealPath("/resources/data/");
		
		String origFilePath = uploadPath + "storeFoodPhoto/" +imgFile;
		String copyFilePath = uploadPath + "orderFoodPhoto/" + imgFile;
		
		JavaspringProvide ps = new JavaspringProvide();
		
		ps.fileCopyCheck(origFilePath,copyFilePath); // board 폴더에 파일을 복사하고자 한다.
		
		orderDAO.setFoodOrderOK(vo);
	}

	@Override
	public CartVO getCheckOrderIdx(String orderIdx) {
		return orderDAO.getCheckOrderIdx(orderIdx);
	}

	@Override
	public void setFoodOrderOk2(CartVO vo) {
		
		String imgFile = vo.getThumbImg();
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String uploadPath = request.getSession().getServletContext().getRealPath("/resources/data/");
		
		String origFilePath = uploadPath + "storeFoodPhoto/" +imgFile;
		String copyFilePath = uploadPath + "orderFoodPhoto/" + imgFile;
		
		JavaspringProvide ps = new JavaspringProvide();
		
		ps.fileCopyCheck(origFilePath,copyFilePath); // board 폴더에 파일을 복사하고자 한다.
		
		orderDAO.setFoodOrderOk2(vo);
	}

	@Override
	public List<CartVO> getMyOrderList(String mid) {
		return orderDAO.getMyOrderList(mid);
	}

	@Override
	public void setRiderOrder(WebSocketDbVO orderVo) {
		orderDAO.setRiderOrder(orderVo);
	}

	@Override
	public void imgCheck(String content) {
			//	 0         1         2         3         4         5         6         7         8         
		//     012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
		//<img src="/green2209S_18/data/ckeditor/230111121412_4.jpg" style="height:183px; width:275px" />
		
		// content안에 그림파일이 존재할때만 작업을 수행 할 수 있도록 한다.
		if(content.indexOf("src=\"/") == -1) return;
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String uploadPath = request.getSession().getServletContext().getRealPath("/resources/data/ckeditor/");
		
		int position = 34;
		String nextImg = content.substring(content.indexOf("src=\"/") + position);
		boolean sw =true;
		
		while(sw) {
			String imgFile = nextImg.substring(0,nextImg.indexOf("\""));
			
			System.out.println("사진이름 : " + imgFile);
			
			String origFilePath = uploadPath + imgFile;
			System.out.println("오리지날 : " + origFilePath);
			String copyFilePath = uploadPath + "rating/" + imgFile;
			
			fileCopyCheck(origFilePath,copyFilePath); // board 폴더에 파일을 복사하고자 한다.
			
			if(nextImg.indexOf("src=\"/") == -1) {
				sw = false;
			}
			else {
				nextImg = nextImg.substring(nextImg.indexOf("src=\"/") + position);
			}
		}
	}
	
	private void fileCopyCheck(String originalFilePath, String copyFilePath) {
		File origFile = new File(originalFilePath);
		File copyFile = new File(copyFilePath);
		
		try {
			FileInputStream fis = new FileInputStream(origFile);
			FileOutputStream fos = new FileOutputStream(copyFile);
			
			byte[] buffer = new byte[2048];
			int cnt = 0;
			while((cnt = fis.read(buffer)) != -1) {
				fos.write(buffer, 0, cnt);
			}
			fos.flush();
			fos.close();
			fis.close();
			
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}

	@Override
	public int setRatingInput(RatingVO vo) {
		return orderDAO.setRatingInput(vo);
	}

	@Override
	public void setRaingInputOk(String orderIdx) {
		orderDAO.setRaingInputOk(orderIdx);
	}

	
}

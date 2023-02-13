package com.spring.green2209S_18.service;

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
import com.spring.green2209S_18.vo.PayMentVO;
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

	
}

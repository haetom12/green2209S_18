package com.spring.green2209S_18.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.green2209S_18.dao.OrderDAO;
import com.spring.green2209S_18.vo.CartVO;
import com.spring.green2209S_18.vo.FoodMenuVO;
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

	
}

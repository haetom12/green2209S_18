package com.spring.green2209S_18.service;

import java.util.List;

import com.spring.green2209S_18.vo.CartVO;
import com.spring.green2209S_18.vo.CouponVO;
import com.spring.green2209S_18.vo.MemberVO;

public interface MemberService {

	public MemberVO getMemberIdCheck(String mid);

	public int setMemberJoinOk(MemberVO vo);

	public MemberVO getMemberNickCheck(String memberNickName);

	public List<CartVO> getMyCartList(String mid);

	public void setOrderCntUpdate(String mid);

	public CartVO getMyOrderInfo(String orderIdx);

	public int setMemberOrderCancle(String orderIdx);

	public List<CouponVO> getMyCouponList(int startIndexNo, int pageSize, String mid);

}

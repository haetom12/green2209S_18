package com.spring.green2209S_18.service;

import java.util.List;

import com.spring.green2209S_18.vo.CartVO;
import com.spring.green2209S_18.vo.CouponVO;
import com.spring.green2209S_18.vo.MemberVO;
import com.spring.green2209S_18.vo.QnaVO;
import com.spring.green2209S_18.vo.RatingVO;

public interface MemberService {

	public MemberVO getMemberIdCheck(String mid);

	public int setMemberJoinOk(MemberVO vo);

	public MemberVO getMemberNickCheck(String memberNickName);

	public List<CartVO> getMyCartList(String mid);

	public void setOrderCntUpdate(String mid);

	public CartVO getMyOrderInfo(String orderIdx);

	public int setMemberOrderCancle(String orderIdx);

	public List<CouponVO> getMyCouponList(int startIndexNo, int pageSize, String mid);

	public int setReportRating(String rMid);

	public int setMemberUpdate(MemberVO vo);

	public int setMemberPwdUpdate(String newPwd, String mid);

	public int setMemberDelete(String mid);

	public MemberVO getMidFind(String name, String email);

	public MemberVO getPwdFind(String mid, String email);

	public QnaVO getQnAContent(int idx);

	public List<QnaVO> getQnAComment(int idx);


}

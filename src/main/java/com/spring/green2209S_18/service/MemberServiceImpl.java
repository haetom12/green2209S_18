package com.spring.green2209S_18.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.green2209S_18.dao.MemberDAO;
import com.spring.green2209S_18.vo.CartVO;
import com.spring.green2209S_18.vo.CouponVO;
import com.spring.green2209S_18.vo.MemberVO;
import com.spring.green2209S_18.vo.QnaVO;
import com.spring.green2209S_18.vo.RatingVO;

@Service
public class MemberServiceImpl implements MemberService {
	@Autowired
	MemberDAO memberDAO;

	@Override
	public MemberVO getMemberIdCheck(String mid) {
		return memberDAO.getMemberIdCheck(mid);
	}

	@Override
	public int setMemberJoinOk(MemberVO vo) {
		int res = 0;
		memberDAO.setMemberJoinOk(vo);
		res = 1;
		
		return res;
	}

	@Override
	public MemberVO getMemberNickCheck(String memberNickName) {
		return memberDAO.getMemberNickCheck(memberNickName);
	}

	@Override
	public List<CartVO> getMyCartList(String mid) {
		return memberDAO.getMyCartList(mid);
	}

	@Override
	public void setOrderCntUpdate(String mid) {
		memberDAO.setOrderCntUpdate(mid);
	}

	@Override
	public CartVO getMyOrderInfo(String orderIdx) {
		return memberDAO.getMyOrderInfo(orderIdx);
	}

	@Override
	public int setMemberOrderCancle(String orderIdx) {
		return memberDAO.setMemberOrderCancle(orderIdx);
	}

	@Override
	public List<CouponVO> getMyCouponList(int startIndexNo, int pageSize, String mid) {
		return memberDAO.getMyCouponList(startIndexNo, pageSize, mid);
	}

	@Override
	public int setReportRating(String rMid) {
		return memberDAO.setReportRating(rMid);
	}

	@Override
	public int setMemberUpdate(MemberVO vo) {
		return memberDAO.setMemberUpdate(vo);
	}

	@Override
	public int setMemberPwdUpdate(String newPwd, String mid) {
		return memberDAO.setMemberPwdUpdate(newPwd, mid);
	}

	@Override
	public int setMemberDelete(String mid) {
		return memberDAO.setMemberDelete(mid);
	}

	@Override
	public MemberVO getMidFind(String name, String email) {
		return memberDAO.getMidFind(name, email);
	}

	@Override
	public MemberVO getPwdFind(String mid, String email) {
		return memberDAO.getPwdFind(mid, email);
	}

	@Override
	public QnaVO getQnAContent(int idx) {
		return memberDAO.getQnAContent(idx);
	}

	@Override
	public List<QnaVO> getQnAComment(int idx) {
		return memberDAO.getQnAComment(idx);
	}
	


}

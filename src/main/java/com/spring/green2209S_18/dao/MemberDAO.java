package com.spring.green2209S_18.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.green2209S_18.vo.CartVO;
import com.spring.green2209S_18.vo.CouponVO;
import com.spring.green2209S_18.vo.MemberVO;

public interface MemberDAO {

	public MemberVO getMemberIdCheck(@Param("mid") String mid);

	public void setMemberJoinOk(@Param("vo") MemberVO vo);

	public MemberVO getMemberNickCheck(@Param("memberNickName") String memberNickName);

	public List<CartVO> getMyCartList(@Param("mid") String mid);

	public void setOrderCntUpdate(@Param("mid") String mid);

	public CartVO getMyOrderInfo(@Param("orderIdx") String orderIdx);

	public int setMemberOrderCancle(@Param("orderIdx") String orderIdx);

	public List<CouponVO> getMyCouponList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("mid") String mid);

	public int totCouponCnt(@Param("mid") String search);

	public int totOderListCnt(@Param("mid") String search);


}

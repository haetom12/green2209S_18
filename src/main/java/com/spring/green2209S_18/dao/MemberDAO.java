package com.spring.green2209S_18.dao;

import org.apache.ibatis.annotations.Param;

import com.spring.green2209S_18.vo.MemberVO;

public interface MemberDAO {

	public MemberVO getMemberIdCheck(@Param("mid") String mid);

	public void setMemberJoinOk(@Param("vo") MemberVO vo);

	public MemberVO getMemberNickCheck(@Param("memberNickName") String memberNickName);


}

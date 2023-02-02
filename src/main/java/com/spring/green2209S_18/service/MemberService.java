package com.spring.green2209S_18.service;

import com.spring.green2209S_18.vo.MemberVO;

public interface MemberService {

	public MemberVO getMemberIdCheck(String mid);

	public int setMemberJoinOk(MemberVO vo);

	public MemberVO getMemberNickCheck(String memberNickName);

}

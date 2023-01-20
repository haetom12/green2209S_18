package com.spring.green2209S_18.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.green2209S_18.dao.MemberDAO;
import com.spring.green2209S_18.vo.MemberVO;

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
	


}

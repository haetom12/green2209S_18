package com.spring.green2209S_18.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.green2209S_18.common.DistanceCal;
import com.spring.green2209S_18.dao.MemberDAO;
import com.spring.green2209S_18.dao.RiderDAO;
import com.spring.green2209S_18.dao.StoreDAO;
import com.spring.green2209S_18.vo.CartVO;
import com.spring.green2209S_18.vo.MemberVO;
import com.spring.green2209S_18.vo.RiderVO;
import com.spring.green2209S_18.vo.StoreVO;

@Service
public class RiderServiceImpl implements RiderService {

	@Autowired
	RiderDAO riderDAO;
	
	@Autowired
	MemberDAO memberDAO;
	
	@Autowired
	StoreDAO storeDAO;

	@Override
	public RiderVO getRiderMidCheck(String riderMid) {
		return riderDAO.getRiderMidCheck(riderMid);
	}

	@Override
	public int setRiderJoinOk(RiderVO vo) {
		return riderDAO.setRiderJoinOk(vo);
	}

	@Override
	public CartVO getRiderCheck(String idx, String string) {
		return riderDAO.getRiderCheck(idx, string);
	}

	@Override
	public void setUpdateRider(String idx, String riderMid, String progress, String mid, String store) {
		MemberVO mVo = memberDAO.getMemberIdCheck(mid);
		StoreVO sVo = storeDAO.getstoreInfo(store);
		
		double distance = DistanceCal.distance(mVo.getMemberLatitude(), mVo.getMemberLongitude(), sVo.getStoreLatitude(), sVo.getStoreLongitude(), "kilometer");
//		distance = Math.round(distance);
		
		System.out.println("거리" + distance);
		
//		int time = (int) (distance/60)*60;

		double time2 = (distance/60)*60;
		
		System.out.println("time2" + time2);
		
		int time = (int) Math.round(time2);
		
		
		System.out.println("time거리" + time);
		
		riderDAO.setUpdateRider(idx, riderMid, progress, time+40);
	}

	@Override
	public List<CartVO> getRiderOrderList(String riderMid, String string) {
		return riderDAO.getRiderOrderList(riderMid, string);
	}
	
	
}

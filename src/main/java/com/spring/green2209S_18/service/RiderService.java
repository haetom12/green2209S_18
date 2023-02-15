package com.spring.green2209S_18.service;

import java.util.List;

import com.spring.green2209S_18.vo.CartVO;
import com.spring.green2209S_18.vo.RiderVO;

public interface RiderService {

	public RiderVO getRiderMidCheck(String riderMid);

	public int setRiderJoinOk(RiderVO vo);

	public CartVO getRiderCheck(String idx, String string);

	public void setUpdateRider(String idx, String riderMid, String string, String mid, String store);

	public List<CartVO> getRiderOrderList(String riderMid, String string);

}

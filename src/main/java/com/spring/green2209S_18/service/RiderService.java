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

	public int setRiderUpdate(RiderVO vo);

	public int setMemberPwdUpdate(String newPwd, String mid);

	public List<CartVO> getRiderOrderListPage(int startIndexNo, int pageSize, String mid);

	public int setRiderDelete(String mid);

	public RiderVO getMidFind(String name, String email);

	public RiderVO getPwdFind(String mid, String email);

}

package com.spring.green2209S_18.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.green2209S_18.vo.CartVO;
import com.spring.green2209S_18.vo.RiderVO;

public interface RiderDAO {

	public List<CartVO> getOrderChatList();

	public RiderVO getRiderMidCheck(@Param("riderMid") String riderMid);

	public int setRiderJoinOk(@Param("vo") RiderVO vo);

	public CartVO getRiderCheck(@Param("orderIdx") String idx, @Param("progress") String string);

	public void setUpdateRider(@Param("orderIdx") String idx, @Param("rider") String riderMid, @Param("progress")  String progress,@Param("checkStr")  int time);

	public List<CartVO> getRiderOrderList(@Param("rider") String riderMid,@Param("progress") String string);

	public int setRiderOrderConfirm(@Param("orderIdx") String orderIdx);

}

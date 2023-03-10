package com.spring.green2209S_18.vo;

import lombok.Data;

@Data
public class MemberVO {
	private int idx;
	private String mid;
	private String pwd;
	private String memberName;
	private String memberNickName;
	private String birthday;
	private String tel;
	private String address;
	private String email;
	private String userDel;
	private String userBan;
	private int reportCnt;
	private int orderCnt;
	private double memberLatitude;
	private double memberLongitude;
	private String joinDate;
}

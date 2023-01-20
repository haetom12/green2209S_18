package com.spring.green2209S_18.vo;

import lombok.Data;

@Data
public class MemberVO {
	private int idx;
	private String mid;
	private String pwd;
	private String memberName;
	private String birthday;
	private String tel;
	private String address;
	private String email;
	private String userDel;
	private int point;
	private int orderCnt;
}

package com.spring.green2209S_18.vo;

import lombok.Data;

@Data
public class CouponVO {
	private int idx;
	private String orderIdx;
	private String mid;
	private String qrCode;
	private String couponName;
	private int discount;
	private String useIdx;
	private String receiveDate;
	private String useDate;
	private String used;
	private String expiration;
	
}

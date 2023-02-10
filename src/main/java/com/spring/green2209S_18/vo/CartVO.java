package com.spring.green2209S_18.vo;

import lombok.Data;

@Data
public class CartVO {
	private int idx;
	private String cartDate;
	private String mid;
	private int menuIdx;
	private String storeName;
	private String foodName;
	private int mainPrice;
	private String sale;
	private int salePrice;
	private String thumbImg;
	private String optionIdx;
	private String subMenuName;
	private String optionPrice;
	private String optionNum;
	private int totalPrice;
	
	private int cartCnt;
	
}

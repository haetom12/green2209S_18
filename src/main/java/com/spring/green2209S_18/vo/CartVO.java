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
	
	private int baesong;
	private String orderDate;
	private String orderIdx;
	private String orderTotalPrice;
	private String orderAddress;
	private String orderMessage;
  private int cartIdx;  // 장바구니 고유번호.
  private int maxIdx;   // 주문번호를 구하기위한 기존 최대 비밀번호필드
  private int orderTotalPrice2;
  
  
  // 배달 vo
	private String rider;
	private String progress;
	private String assignDate;
	private String completeDate;
	private String checkStr;
	private String ratingOk;
  
  
}

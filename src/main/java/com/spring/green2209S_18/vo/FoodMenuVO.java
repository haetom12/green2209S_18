package com.spring.green2209S_18.vo;

import lombok.Data;

@Data
public class FoodMenuVO {
	private int menuIdx;
	private int storeIdx;
	private String foodName;
	private String foodPart;
	private int price;
	private String runOut;
	private String sale;
	private int salePrice;
	private String foodPhoto;
	private String subMenu;
	private String foodInfo;
	
	private String brandName;
	private String foodTag;
	
}

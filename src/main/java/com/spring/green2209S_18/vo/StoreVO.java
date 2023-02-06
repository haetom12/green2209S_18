package com.spring.green2209S_18.vo;

import lombok.Data;

@Data
public class StoreVO {
	private int idx;
	private String storeName;
	private String storePart;
	private String storeNumber;
	private String storeMid;
	private String storePwd;
	private String HostName;
	private String storeAddress;
	private String logoPhoto;
	private String storeEmail;
	private double storeLatitude;
	private double storeLongitude;
	private String storeDel;
	private String storeTime;
	
	private String categoryStoreCode;
	private String categoryPhoto;
	
	private double rateAvg;
	
	private String brandName;
	private String foodTag;
	
}

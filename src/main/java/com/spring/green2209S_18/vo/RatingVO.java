package com.spring.green2209S_18.vo;

import lombok.Data;

@Data
public class RatingVO {
	private int idx;
	private String orderIdx;
	private String mid;
	private String storeName;
	private int reviewStar;
	private String content;
	private int reportRating;
	private String memberNickName;
	private String ratingDate;
	private String title;
}

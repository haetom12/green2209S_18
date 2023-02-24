package com.spring.green2209S_18.vo;

import lombok.Data;

@Data
public class ratingReplyVO {
	private int idx;
	private int ratingIdx;
	private String mid;
	private String nickName;
	private String writeDate;
	private String content;
	private String update;
	private String reportMid;
	
	private int replylevel;
	private int replyIdx;
	private int replyCnt;
	private int reportCnt;
	
}

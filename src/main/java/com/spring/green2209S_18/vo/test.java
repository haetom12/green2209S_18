package com.spring.green2209S_18.vo;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class test {
	public static void main(String[] args) {
		
		Calendar cal = Calendar.getInstance();
    cal.setTime(new Date());
    DateFormat df = new SimpleDateFormat("yyyy-MM-dd");

    cal.add(Calendar.MONTH, 1);
		
		String expiration = df.format(cal.getTime());
		
    
		
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM");
		Date now = new Date();
		String now_dt = format.format(now);
		System.out.println(now_dt);
		
		
		
	}


}

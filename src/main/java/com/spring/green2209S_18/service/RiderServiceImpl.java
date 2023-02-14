package com.spring.green2209S_18.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.green2209S_18.dao.RiderDAO;

@Service
public class RiderServiceImpl implements RiderService {

	@Autowired
	RiderDAO riderDAO;
	
	
}

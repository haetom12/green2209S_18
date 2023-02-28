package com.spring.green2209S_18.interceptor;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class StoreInterceptor extends HandlerInterceptorAdapter {
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		HttpSession session = request.getSession();
		String sPart = session.getAttribute("sPart") == null ? "" : (String) session.getAttribute("sPart");
		if(sPart != "store") {
			RequestDispatcher dispatcher = request.getRequestDispatcher("/msg/memberNo");
			dispatcher.forward(request, response);
			return false;
		}
		
		return true;
	}
}

package com.spring.green2209S_18.interceptor;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class AdminInterceptor extends HandlerInterceptorAdapter {
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		HttpSession session = request.getSession();
		String sPart = session.getAttribute("sPart") == null ? "" : (String) session.getAttribute("sPart");
		if(sPart != "admin") {	// 관리자가 아닌경우는 메세지를 통해서 무조건 초기화면창으로 보내준다.
			RequestDispatcher dispatcher = request.getRequestDispatcher("/msg/adminNo");
			dispatcher.forward(request, response);
			return false;
		}
		
		return true;
	}
}

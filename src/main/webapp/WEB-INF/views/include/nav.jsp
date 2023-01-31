<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<script src="https://kit.fontawesome.com/yourcode.js" crossorigin="anonymous"></script>

<link href="https://fonts.googleapis.com/css?family=Poppins:200,300,400,500,600,700,800&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Lora:400,400i,700,700i&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Amatic+SC:400,700&display=swap" rel="stylesheet">

<link rel="stylesheet" href="${ctp}/css/open-iconic-bootstrap.min.css">
<link rel="stylesheet" href="${ctp}/css/animate.css">

<link rel="stylesheet" href="${ctp}/css/owl.carousel.min.css">
<link rel="stylesheet" href="${ctp}/css/owl.theme.default.min.css">
<link rel="stylesheet" href="${ctp}/css/magnific-popup.css">

<link rel="stylesheet" href="${ctp}/css/aos.css">

<link rel="stylesheet" href="${ctp}/css/ionicons.min.css">

<link rel="stylesheet" href="${ctp}/css/bootstrap-datepicker.css">
<link rel="stylesheet" href="${ctp}/css/jquery.timepicker.css">


<link rel="stylesheet" href="${ctp}/css/flaticon.css">
<link rel="stylesheet" href="${ctp}/css/icomoon.css">
<link rel="stylesheet" href="${ctp}/css/style.css">

<div class="py-1 bg-primary">
    	<div class="container">
    		<div class="row no-gutters d-flex align-items-start align-items-center px-md-0">
	    		<div class="col-lg-12 d-block">
		    		<div class="row d-flex">
		    			<div class="col-md pr-4 d-flex topper align-items-center">
					    	<div class="icon mr-2 d-flex justify-content-center align-items-center"><span class="icon-phone2"></span></div>
						    <span class="text">
						    	<c:if test="${sNumber != null}">${sNumber}</c:if>
						    </span>
					    </div>
					    <div class="col-md pr-4 d-flex topper align-items-center">
					    	<div class="icon mr-2 d-flex justify-content-center align-items-center"><span class="icon-paper-plane"></span></div>
						    <span class="text">
						    	<c:if test="${sEmail != null}">${sEmail}</c:if>
						    </span>
					    </div>
					    <div class="col-md-5 pr-4 d-flex topper align-items-center text-lg-right">
						    <span class="text">현재 위치 : 
							    <c:if test="${sAddress != null}">${sAddress}</c:if>
						    </span>
					    </div>
				    </div>
			    </div>
		    </div>
		  </div>
    </div>

	<nav class="navbar navbar-expand-lg navbar-dark ftco_navbar bg-dark ftco-navbar-light" id="ftco-navbar">
	    <div class="container">
	      <a class="navbar-brand" href="${ctp}/">해 찬 들</a>
	      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#ftco-nav" aria-controls="ftco-nav" aria-expanded="false" aria-label="Toggle navigation">
	        <span class="oi oi-menu"></span> Menu
	      </button>

	      <div class="collapse navbar-collapse" id="ftco-nav">
	        <ul class="navbar-nav ml-auto">
	          <li class="nav-item"><a href="${ctp}/store/shopCategory" class="nav-link">주문하기</a></li>
	          <li class="nav-item"><a href="about.html" class="nav-link">About</a></li>
	          <li class="nav-item"><a href="blog.html" class="nav-link">Blog</a></li>
	          <li class="nav-item"><a href="contact.html" class="nav-link">고객문의</a></li>
	          <c:if test="${sMid==null}">
		          <li class="nav-item"><a href="${ctp}/member/memberLogin" class="nav-link">로그인</a></li>
		          <li class="nav-item"><a href="${ctp}/member/JoinSelect" class="nav-link">회원가입</a></li>
	          </c:if>
	          <c:if test="${sMid!=null}">
		          <li class="nav-item active dropdown">
	              <a class="nav-link dropdown-toggle" href="#" id="dropdown04" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">마이페이지</a>
	              <div class="dropdown-menu" aria-labelledby="dropdown04">
	              	<a class="dropdown-item" href="shop.html">주문내역</a>
	              	<a class="dropdown-item" href="wishlist.html">찜목록</a>
	                <a class="dropdown-item" href="product-single.html">선물함</a>
	                <a class="dropdown-item" href="cart.html">쿠폰함</a>
	                <a class="dropdown-item" href="checkout.html">리뷰관리</a>
	              </div>
	            </li>
		          <li class="nav-item cta cta-colored"><a href="${ctp}/member/memberWishlist" class="nav-link"><span class="icon-shopping_cart"></span>[0]</a></li>
							<li class="nav-item"><a href="${ctp}/member/memberLogout" class="nav-link">로그아웃</a></li>
						</c:if>
	        </ul>
	      </div>
	    </div>
	  </nav>
    <!-- END nav -->
    
  <script src="${ctp}/js/jquery.min.js"></script>
  <script src="${ctp}/js/jquery-migrate-3.0.1.min.js"></script>
  <script src="${ctp}/js/popper.min.js"></script>
  <script src="${ctp}/js/bootstrap.min.js"></script>
  <script src="${ctp}/js/jquery.easing.1.3.js"></script>
  <script src="${ctp}/js/jquery.waypoints.min.js"></script>
  <script src="${ctp}/js/jquery.stellar.min.js"></script>
  <script src="${ctp}/js/owl.carousel.min.js"></script>
  <script src="${ctp}/js/jquery.magnific-popup.min.js"></script>
  <script src="${ctp}/js/aos.js"></script>
  <script src="${ctp}/js/jquery.animateNumber.min.js"></script>
  <script src="${ctp}/js/bootstrap-datepicker.js"></script>
  <script src="${ctp}/js/scrollax.min.js"></script>
  <script src="${ctp}/js/main.js"></script>
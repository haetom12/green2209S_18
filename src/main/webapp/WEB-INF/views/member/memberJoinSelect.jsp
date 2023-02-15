<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<html>

  <head>
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
		
		<style>
			body {
				margin: 0px;
				padding: 0px;
			}
			.choose1 {
				height: 100%;
				background-color: #f4e285;
			}
			.choose2 {
				height: 100%;
				background-color: #8cb369;
			}
			.choose3 {
				height: 100%;
				background-color: #f4a259;
			}
			.ftco-section {
				margin: 0px;
				padding: 0px;
				width: 100%;
				height: 100%;
			}
			.container2 {
				margin-top: -5%;
				padding: 0px;
				height: 115%;
			}
			.sectbox {
				height: 100%;
			}
			
		</style>
		
  </head>

  <body class="goto-here">
		<jsp:include page="/WEB-INF/views/include/nav.jsp"></jsp:include>	
			<section class="ftco-section">
				<div class="container2 bg-primary">
					<div class="row no-gutters ftco-services sectbox">
	          <div class="col-md-4 text-center d-flex align-self-stretch ftco-animate choose1" style="padding-top: 16%;">
	            <div class="media block-6 services mb-md-0 mb-4">
	            	<a href="${ctp}/member/memberJoin">
		              <div class="icon bg-color-1 active d-flex justify-content-center align-items-center mb-2">
		            		<span class="flaticon-diet"></span>
		              </div>
	              </a>
	              <div class="media-body">
	                <font size="6pt" color="#4c956c">주문 회원 가입</font>
	              </div>
	            </div>      
	          </div>
	          <div class="col-md-4 text-center d-flex align-self-stretch ftco-animate choose2" style="padding-top: 16%;">
	            <div class="media block-6 services mb-md-0 mb-4">
	              <a href="${ctp}/rider/riderJoin">
		              <div class="icon bg-color-2 d-flex justify-content-center align-items-center mb-2">
		            		<span class="flaticon-shipped"></span>
		              </div>
	              </a>
	              <div class="media-body">
	                <font size="6pt" color="#bc4749">라이더 가입</font>
	              </div>
	            </div>    
	          </div>
	          <div class="col-md-4 text-center d-flex align-self-stretch ftco-animate choose3" style="padding-top: 16%;">
	            <div class="media block-6 services mb-md-0 mb-4">
	            	<a href="${ctp}/store/storeJoin">
		              <div class="icon bg-color-3 d-flex justify-content-center align-items-center mb-2">
		            		<span class="flaticon-award"></span>
		              </div>
	              </a>
	              <div class="media-body">
	              	<font size="6pt" color="#00a5cf">가게 등록</font>
	                <!-- <h3 class="heading text-white">가게 등록</h3>
	                <span>Quality Products</span> -->
	              </div>
	            </div>      
	          </div>
	        </div>
				</div>
			</section>
    
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
	  <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBVWaKrjvy3MaE7SQ74_uJiULgl1JY0H2s&sensor=false"></script>
	  <script src="${ctp}/js/google-map.js"></script>
	  <script src="${ctp}/js/main.js"></script>
  </body>
</html>

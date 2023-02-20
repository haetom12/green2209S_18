<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>title</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"></jsp:include>
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway">
	<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
	<link rel="stylesheet" href="https://www.w3schools.com/lib/w3-theme-blue.css">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.3.0/css/font-awesome.min.css">
	<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
	<style>
		body,h1,h2,h3,h4,h5,h6 {font-family: "Raleway", sans-serif}
	</style>
</head>
<body>
	<!-- Header -->
	<header class="w3-container w3-padding" id="myHeader" style="background-color: #f4a259">
	  <i onclick="location.href='${ctp}/h';" class="fa fa-home w3-xlarge w3-button w3-green"></i> 
	  <div class="w3-center">
		  <h4>내 가게 정보</h4>
		  <h1 class="w3-xxxlarge w3-animate-bottom w3-text-white">${vo.storeName}</h1>
		    <div class="w3-padding-32">
		      <button class="w3-btn w3-xlarge w3-dark-grey w3-hover-light-grey" onclick="location.href='${ctp}/homePage.ad';" style="font-weight:900;">주문확인</button>
		    </div>
	  </div>
	</header>
	
	<div class="w3-row-padding w3-center w3-margin-top">
		<div class="w3-third">
		  <div class="w3-card w3-container" style="min-height:460px">	
			  <br><h2>회원 정보 관리</h2><br>
			  <i class="material-icons w3-margin-bottom w3-text-theme" style="font-size:120px;" >person</i>
			  <h4><a href="">가게정보 수정하기<i class="fa fa-wrench" aria-hidden="true"></i></a></h4>
			  <h4><a href="${ctp}/store/myStoreMenu">메뉴 추가/수정<i class="fa fa-hospital-o" aria-hidden="true"></i></a></h4>
			  <h4><a href="">가게 삭제 신청<i class="fa fa-trash"></i></a></h4>
		  </div>
		</div>
		
		<div class="w3-third">
		  <div class="w3-card w3-container" style="min-height:460px">
			  <br><h2>거래 관리</h2><br>
			  <i class="material-icons w3-margin-bottom w3-text-theme" style="font-size:120px;" >local_shipping</i>
			  <h4><a href="${ctp}/MyOrderPage.mem">최근 거래 내역 <i class="fa fa-search"></i></a></h4>
			  <h4><a href="${ctp}/MyOrderCancel.mem">거래 취소 <i class="fa fa-close"></i></a></h4>
		  </div>
		</div>
		
		<div class="w3-third">
		  <div class="w3-card w3-container" style="min-height:460px">
			  <br/><h2>내 문의</h2><br>
			  <i class="fa fa-question w3-margin-bottom w3-text-theme" style="font-size:120px"></i>
			  <h4><a href="${ctp}/MyBoardPage.mem">가게리뷰 조회<i class="fa fa-search"></i></a></h4>
			  <h4><a href="${ctp}/boInput.bo">문의 등록 하기 <i class="fa fa-pencil-square" aria-hidden="true"></i></a></h4>
		  </div>
		</div>
	</div>
	
	<footer class="w3-container w3-dark-grey" style="text-align: center; margin-top: 5.5%; padding: 0px;">
	  <h5>주소:충청북도 청주시 서원구 49(성화동, 자운빌딩 3층 301-2호)</h5>
		<h5>문의:043-237-9977 FAX: 043-239-4477 (주)현준약품</h5>
		<h5>Mobile:010-5228-7680 / E-mail: cjk7289@naver.com</h5>
	</footer>	

</body>
</html>
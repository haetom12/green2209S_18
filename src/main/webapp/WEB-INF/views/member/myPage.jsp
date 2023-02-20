<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <title>Vegefoods - Free Bootstrap 4 Template by Colorlib</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    
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
    
		<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
		<link rel="stylesheet" href="https://www.w3schools.com/lib/w3-theme-blue.css">
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.3.0/css/font-awesome.min.css">
		
		<link rel="stylesheet" type="text/css" href="${ctp}/vendors/styles/core.css">
		<link rel="stylesheet" type="text/css" href="${ctp}/vendors/styles/icon-font.min.css">
		<link rel="stylesheet" type="text/css" href="${ctp}/vendors/styles/style.css">

		<script>
			'use strict';
			function pwdCheck() {
				let pwd = myform.pwd.value;
				let options = myform.options.value;
/* 				let pwd = $(".login-modal #pwd").val();
				let options = $(".login-modal #options").val(); */
				
				if(pwd == "") {
					alert("비밀번호를 입력하세요.");
					myform.pwd.focus();
					return false;
				}
				else if(options == "") {
					alert("수정메뉴을 선택하세요.");
					return false;
				}
				myform.submit();
			}
			
		</script>

		
  </head>
  <body class="goto-here">
  
		<jsp:include page="/WEB-INF/views/include/nav.jsp"></jsp:include>		

	<!-- Header -->
	<header class="w3-container w3-padding bg-primary" id="myHeader">
	  <div class="w3-center mt-3">
		  <h4>환영합니다!</h4>
		  <h1 class="w3-xxxlarge w3-animate-bottom w3-text-white">${vo.memberNickName} 님</h1>
		    <div class="w3-padding-32">
		      <button class="w3-btn w3-xlarge w3-dark-grey w3-hover-light-grey" onclick="location.href='${ctp}/store/shopCategory';" style="font-weight:900;">주문하러가기</button>
		    </div>
	  </div>
	</header>

    <section class="ftco-section testimony-section">
      <div class="container">
      	<div class="row">
      		<!-- <div class="mouse">
						<a href="#" class="mouse-icon">
							<div class="mouse-wheel"><span class="ion-ios-arrow-up"></span></div>
						</a>
					</div> -->
      	</div>
        <div class="row mb-5">
          <div class="col-md">
            <div class="ftco-footer-widget mb-4 ml-md-5">
              <h2 class="ftco-heading-2">내 정보</h2>
              <ul class="list-unstyled mb-1">
                <%-- <li><a href="${ctp}/member/memberUpdate" class="py-2 d-block">개인정보 수정하기</a></li> --%>
                <li><a href="#" class="btn-block" data-backdrop="static" data-toggle="modal" data-target="#login-modal" type="button">
                			개인정보 및 비밀번호 변경	</a></li>
                <li><a href="${ctp}/member/memberDelete" class="py-2 d-block">회원 탈퇴 신청</a></li>
              </ul>
            </div>
          </div>
          <div class="col-md">
            <div class="ftco-footer-widget mb-4 ml-md-5">
              <h2 class="ftco-heading-2">거래관리</h2>
              <ul class="list-unstyled">
                <li><a href="${ctp}/member/myOrderList" class="py-2 d-block">최근 주문 내역</a></li>
                <li><a href="${ctp}/order/myWishList" class="py-2 d-block">찜목록</a></li>
                <li><a href="${ctp}/order/myCouponList" class="py-2 d-block">쿠폰함</a></li>
                <li><a href="#" class="py-2 d-block">내 리뷰 관리</a></li>
              </ul>
            </div>
          </div>
          <div class="col-md">
            <div class="ftco-footer-widget mb-4 ml-md-5">
              <h2 class="ftco-heading-2">서비스 관리</h2>
              <ul class="list-unstyled">
                <li><a href="#" class="py-2 d-block">내 문의 조회</a></li>
                <li><a href="#" class="py-2 d-block">문의 등록 하기</a></li>
              </ul>
            </div>
          </div>
        </div>
      </div>
    </section>

		<!-- Login modal -->
				<div class="modal fade" id="login-modal" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
					<div class="modal-dialog modal-dialog-centered">
						<div class="modal-content">
							<div class="login-box bg-white box-shadow border-radius-10">
								<div class="login-title">
									<h2 class="text-center text-primary">비밀번호 확인</h2>
								</div>
								<form name="myform" method="post" action="${ctp}/member/memberUpdateOk">
									<div class="select-role">
										<div class="btn-group btn-group-toggle" data-toggle="buttons">
											<label class="btn active">
												<input type="radio" name="options" value="mid">
												회원정보<span>변경</span>
											</label>
											<label class="btn">
												<input type="radio" name="options" value="pwd">
												비밀번호<span>변경</span>
											</label>
										</div>
									</div>
									<div class="input-group custom">
										<input type="password" id="pwd" name="pwd" class="form-control form-control-lg" placeholder="비밀번호를 입력하세요">
										<div class="input-group-append custom">
											<span class="input-group-text"><i class="dw dw-padlock1"></i></span>
										</div>
									</div>
									<div class="row">
										<div class="col-sm-12">
											<div class="input-group mb-0">
												<!--
													use code for form submit
													<input class="btn btn-primary btn-lg btn-block" type="submit" value="Sign In">
												-->
												<input class="btn btn-primary btn-lg btn-block" type="button" onclick="pwdCheck()" value="비밀번호 확인">
												<input type="button" value="닫기" class="close btn btn-secondary btn-lg btn-block" data-dismiss="modal" aria-hidden="true">
											</div>
										</div>
									</div>
								</form>
							</div>
						</div>
					</div>
				</div>



		<jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>

  <!-- loader -->
  <div id="ftco-loader" class="show fullscreen"><svg class="circular" width="48px" height="48px"><circle class="path-bg" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke="#eeeeee"/><circle class="path" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke-miterlimit="10" stroke="#F96D00"/></svg></div>


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

  <script>
		$(document).ready(function(){

		var quantitiy=0;
		   $('.quantity-right-plus').click(function(e){
		        
		        // Stop acting like a button
		        e.preventDefault();
		        // Get the field name
		        var quantity = parseInt($('#quantity').val());
		        
		        // If is not undefined
		            
		            $('#quantity').val(quantity + 1);
		            // Increment
		    });
		     $('.quantity-left-minus').click(function(e){
		        // Stop acting like a button
		        e.preventDefault();
		        // Get the field name
		        var quantity = parseInt($('#quantity').val());
		        
		        // If is not undefined
		      
		            // Increment
            if(quantity>0){
            $('#quantity').val(quantity - 1);
            }
		    });
		});
	</script>
		<!-- js -->
	<script src="${ctp}/vendors/scripts/core.js"></script>
	<script src="${ctp}/vendors/scripts/script.min.js"></script>
	<script src="${ctp}/vendors/scripts/process.js"></script>
	<script src="${ctp}/vendors/scripts/layout-settings.js"></script>
    
  </body>
</html>
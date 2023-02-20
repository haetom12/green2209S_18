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
				let oldPwd = myform.oldPwd.value;
				let newPwd = myform.newPwd.value;
				let rePwd = myform.rePwd.value;
				
				let regPwd = /(?=.*[0-9a-zA-Z]).{4,20}$/;
				
				if(oldPwd == "") {
					alert("기본 비밀번호를 입력하세요.");
					myform.oldPwd.focus();
					return false;
				}
				else if(newPwd == "") {
					alert("새 비밀번호를 입력하세요.");
					myform.newPwd.focus();
					return false;
				}
	      else if(!regPwd.test(newPwd)) {
	        alert("비밀번호는 1개이상의 문자와 특수문자 조합의 6~24 자리로 작성해주세요.");
	        JoinForm.pwd.focus();
	        return false;
		    }
				else if(rePwd == "") {
					alert("새 비밀번호를 다시 입력하세요.");
					myform.rePwd.focus();
					return false;
				}
				else if(rePwd != newPwd) {
					alert("새 비밀번호와 동일하지 않습니다!");
					myform.rePwd.focus();
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

    <section class="ftco-section testimony-section" >
    	<div class="container">
				<div class="pd-20 card-box mb-30">
					<div class="clearfix">
						<h3 class="text-blue h3" style="text-align: center;">비밀번호 변경</h3>
					</div>
					<form name="myform" method="post">
						<div class="form-group">
							<label>기존 비밀번호</label>
							<input class="form-control" id="oldPwd" name="oldPwd" placeholder="기존 비밀번호를 입력하세요" type="password">
						</div>
						<div class="form-group">
							<label>새 비밀번호</label>
							<input class="form-control" id="newPwd" name="newPwd" placeholder="새 비밀번호를 입력하세요" type="password">
						</div>
						<div class="form-group">
							<label>새 비밀번호 다시 입력</label>
							<input class="form-control" id="rePwd" name="rePwd" placeholder="새 비밀번호를 다시 입력하세요" type="password">
						</div>
						<input type="button" value="비밀번호 수정" onclick="pwdCheck()" style="float: right;" class="btn btn-success ml-2" />
						<input type="button" value="돌아가기" onclick="location.href='${ctp}/member/myPage';" style="float: right;" class="btn btn-secondary mr-2" />
					</form>
  	    </div>
      </div>
    </section>


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
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
			function memberCheck() {
				let mid = myform.mid.value;
				let pwd = myform.pwd.value;
				let sMid = '${sMid}';
				
				if(mid == "") {
					alert("아이디를 입력하세요.");
					myform.mid.focus();
					return false;
				}
				else if(mid != sMid) {
					alert("아이디가 일치하지 않습니다.");
					myform.mid.focus();
					return false;
				}
				else if(pwd == "") {
					alert("비밀번호를 입력하세요.");
					myform.pwd.focus();
					return false;
				}
				
				$.ajax({
				  	type   : "post",
				  	url    : "${ctp}/store/storeDeleteCheck",
				  	data   : {
				  		storeMid : mid,
				  		storePwd : pwd
				  		} ,
				  	success:function(res) {
				  		if(res == "1") {
				  			alert("인증코드를 이메일로 전송하였습니다. 5분안에 인증하세요!");
								document.getElementById("checkBtn").style.display = 'none';
				       	document.getElementById("deleteBtn").style.display = 'block'; 	
				       	document.getElementById("codeForm").style.display = 'block'; 	
				  		}
				  		else {
				  			alert("아이디 또는 비밀번호가 틀립니다!");
				  		}
				  	},
				  	error : function() {
				  		alert("전송 오류~~");
				  	}
				  });	
				
			}
			
			function codeCheck() {
				let code = myform.code.value;
				
				if(code == "") {
					alert("코드를 입력하세요.");
					myform.code.focus();
					return false;
				}
				
				$.ajax({
				  	type   : "post",
				  	url    : "${ctp}/store/storeDeleteCodeCheck",
				  	data   : {
				  		code : code
				  		},
				  	success:function(res) {
				  		if(res == "1") {
				  			alert("탈퇴 인증에 성공하였습니다!");
				  			let ans = confirm("회원탈퇴시 모든 정보가 삭제됩니다. 계속 진행하시겠습니까?");
								if(!ans) return false;
								
								location.href="${ctp}/store/storeDeleteOk";
								
				  		}
				  		else {
				  			alert("코드가 틀립니다!");
				  		}
				  	},
				  	error : function() {
				  		alert("전송 오류~~");
				  	}
			  });	
			}
			
		</script>

		
  </head>
  <body class="goto-here">
  
		<jsp:include page="/WEB-INF/views/include/nav.jsp"></jsp:include>		

    <div class="hero-wrap hero-bread" style="background-image: url('${ctp}/data/store/${vo.logoPhoto}'); width:40%; margin: 0 auto;">
      <div class="container">
        <div class="row no-gutters slider-text align-items-center justify-content-center">
          <div class="col-md-9 ftco-animate text-center">
          	<!-- <p class="breadcrumbs"><span class="mr-2"><a href="index.html">Home</a></span> <span>Blog</span></p> -->
            <h1 class="mb-0 bread">${vo.storeName}</h1>
          </div>
        </div>
      </div>
    </div>

    <section class="ftco-section testimony-section" >
    	<div class="container">
				<div class="pd-20 card-box mb-30">
					<div class="clearfix">
						<h3 class="text-blue h3" style="text-align: center;">회원 탈퇴</h3>
						<p class="mb-30" style="text-align: center;"><b>탈퇴를 진행하시려면 아이디와 비밀번호를 입력하세요</b></p>
					</div>
					<form name="myform" method="post">
						<div class="form-group">
							<label>아이디</label>
							<input class="form-control" id="mid" name="mid" placeholder="아이디 입력하세요" type="text">
						</div>
						<div class="form-group">
							<label> 비밀번호</label>
							<input class="form-control" id="pwd" name="pwd" placeholder="비밀번호를 입력하세요" type="password">
						</div>
						<div class="form-group" id="codeForm" style="display: none;">
							<label>인증코드 입력</label>
							<input class="form-control" id="code" name="code" placeholder="인증코드를 입력하세요" type="password">
						</div>
						<input type="button" value="회원인증"  id="checkBtn" name="checkBtn" onclick="memberCheck()" style="float: right;" class="btn btn-success ml-2" />
						<input type="button" value="탈퇴신청" id="deleteBtn" name="deleteBtn" onclick="codeCheck()" style="display: none; float: right;" class="btn btn-success ml-2" />
						<input type="button" value="돌아가기" onclick="location.href='${ctp}/store/myStorePage';" style="float: right;" class="btn btn-secondary mr-2" />
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
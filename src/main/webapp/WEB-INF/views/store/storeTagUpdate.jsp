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
  	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
  	
  	<style>
			.login-container {
			    position: relative;
			    margin: 5% auto;
			    max-width: 800px;
			}
			.login-container .loginbox {
			    position: relative;
			    width: 800px !important;
			    height: 220% !important;
			    padding: 20px 0 20px 0;
			    -webkit-box-shadow: 0 0 14px rgba(0,0,0,.1);
			    -moz-box-shadow: 0 0 14px rgba(0,0,0,.1);
			    box-shadow: 0 0 14px rgba(0,0,0,.1);
			}
			.bg-white {
			    background-color: #fff !important;
			}
			.login-container .loginbox .loginbox-title {
			    position: relative;
			    text-align: center;
			    width: 100%;
			    padding-top: 10px;
			    font-family: 'Lucida Sans','trebuchet MS',Arial,Helvetica;
			    font-size: 20px;
			    font-weight: normal;
			    color: #444;
			}
			.login-container .loginbox .loginbox-social {
			    padding: 0 10px 10px;
			    text-align: center;
			}
			.login-container .loginbox .loginbox-social .social-title {
			    font-size: 14px;
			    font-weight: 500;
			    color: #a9a9a9;
			    margin-top: 10px;
			}
			.login-container .loginbox .loginbox-social .social-buttons {
			    height: 80px;
			    padding: 15px 35px;
			    text-align: center;
			}
			.login-container .loginbox .loginbox-social .social-buttons .button-facebook {
			    float: left;
			    border: 2px solid #3b5998;
			    color: #3b5998;
			    border-radius: 50%;
			    width: 50px;
			    height: 50px;
			    margin-right: 30px;
			    background-color: #fff;
			}
			
			.login-container .loginbox .loginbox-social .social-buttons .button-twitter {
			    float: left;
			    border: 2px solid #29c1f6;
			    color: #29c1f6;
			    border-radius: 50%;
			    width: 50px;
			    height: 50px;
			    margin-right: 30px;
			    background-color: #fff;
			}
			
			.login-container .loginbox .loginbox-social .social-buttons .button-google  {
			    float: left;
			    border: 2px solid #ef4f1d;
			    color: #ef4f1d;
			    border-radius: 50%;
			    width: 50px;
			    height: 50px;
			    margin-right: 30px;
			    background-color: #fff;
			}
			
			.login-container .loginbox .loginbox-social .social-buttons .button-facebook i {
			    font-size: 26px;
			    line-height: 50px;
			}
			
			.login-container .loginbox .loginbox-social .social-buttons .button-twitter i {
			    font-size: 26px;
			    line-height: 50px;
			}
			
			.login-container .loginbox .loginbox-social .social-buttons .button-google i {
			    font-size: 26px;
			    line-height: 50px;
			}
			
			.login-container .loginbox .loginbox-or {
			    position: relative;
			    text-align: center;
			    height: 20px;
			}
			
			.login-container .loginbox .loginbox-or .or-line {
			    position: absolute;
			    height: 1px;
			    top: 10px;
			    left: 40px;
			    right: 40px;
			    background-color: #ccc;
			}
			
			.login-container .loginbox .loginbox-or .or {
			    position: absolute;
			    top: 0;
			    -lh-property: 0;
			    left: -webkit-calc(50% - 25px);
			    left: -moz-calc(50% - 25px);
			    left: calc(50% - 25px);
			    width: 50px;
			    height: 20px;
			    background-color: #fff;
			    color: #999;
			    margin: 0 auto;
			}
			
			.login-container .loginbox .loginbox-textbox {
			    padding: 10px;
			}
			
			.login-container .loginbox .loginbox-textbox .form-control {
			    -webkit-border-radius: 3px !important;
			    -webkit-background-clip: padding-box !important;
			    -moz-border-radius: 3px !important;
			    -moz-background-clip: padding !important;
			    border-radius: 3px !important;
			    background-clip: padding-box !important;
			}
			
			.login-container .loginbox .loginbox-forgot {
			    padding-left: 40px;
			}
			
			.login-container .loginbox .loginbox-forgot a {
			    font-size: 11px;
			    color: #666;
			}
			
			.login-container .loginbox .loginbox-submit {
			    padding: 10px 40px;
			}
			
			.login-container .loginbox .loginbox-signup {
			    text-align: center;
			    padding-top: 10px;
			}
			
			.login-container .loginbox .loginbox-signup a {
			    font-size: 13px;
			    color: #666;
			}
			
			.login-container .logobox {
			    width: 340px !important;
			    height: 50px !important;
			    padding: 5px;
			    margin-top: 15px;
			    -webkit-box-shadow: 0 0 14px rgba(0,0,0,.1);
			    -moz-box-shadow: 0 0 14px rgba(0,0,0,.1);
			    box-shadow: 0 0 14px rgba(0,0,0,.1);
			    background-color: #fff;
			    text-align: left;
			}
		</style>
  
  
  <script>
	  'use strict';
	  let tagCheckSw = 0;
		
	  //  체크후 서버로 전송(submit)
	  function fCheck() {
		  let foodTag = myform.foodTag.value;
			let oldTag = '${sVo.foodTag}';
		  
			if(foodTag.trim() == "") {
				alert("태그명을 입력하세요");
				myform.foodTag.focus();
				return false;
			}
			
			if(foodTag.trim() != oldTag){
				if(tagCheckSw == 0) {
					alert("메뉴명 중복체크는 필수입니다!");
					myform.foodTag.focus();
					return false;
				}
				else {
					myform.submit();
			  }
			}
	
			else {
				myform.submit();
			}
	  }
	  
		//카테코리 이름 중복체크
	  function foodTagCheck() {
		  let foodTag = myform.foodTag.value;
		  let storeName = '${sVo.storeName}';
		  
	  	if(foodTag.trim() == "") {
	  		alert("태그명을 입력하세요!");
	  		myform.foodTag.focus();
	  		return false;
	  	}
	  	else if(foodTag.trim() == '${sVo.foodTag}') {
	  		alert("기존 태그명과 동일합니다!");
	  		myform.foodTag.focus();
	  		return false;
	  	}
	  	else {
		  	$.ajax({
			  	type   : "post",
			  	url    : "${ctp}/store/foodTagCheck",
			  	data   : {
			  		foodTag : foodTag,
			  		storeName : storeName
			  		} ,
			  	success:function(res) {
			  		if(res == "1") {
			  			document.getElementById("demo2").innerHTML = "<font color = 'red'> 존재하는 태그입니다! </font>"; 
			  			
			  		}
			  		else {
			  			document.getElementById("demo2").innerHTML = "<font color = 'blue'><b>사용가능한 태그입니다!</b> </font>";  
			  			$("#foodTag").attr("readonly","readonly");
			  			tagCheckSw = 1;
			  		}
			  	},
			  	error : function() {
			  		alert("전송 오류~~");
			  	}
			  });	
	    }
	  }
	</script>
  
  </head>
  <body class="goto-here" >
  
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

			<div class="container" >
				<section class="py-5 overflow-hidden" >
					<div class="login-container animated fadeInDown bootstrap snippets bootdeys">
						<form name="myform" method="post" enctype="multipart/form-data">
			        <div class="loginbox bg-light">
			            <div class="fw-bold text-danger fs-3 fs-lg-5 lh-sm my-2 mt-2 text-center"><font size="20pt">태그 수정</font></div>
			            <div class="loginbox-or">
			                <div class="or-line"></div>
			            </div>
			            <div class="loginbox-textbox fw-bold text-danger fs-3 fs-lg-1 lh-sm" style="margin-left: 7%;">태그명</div>
			            <div class="loginbox-textbox input-group" style="width: 85.5%; margin: 0 auto;">
			                <input type="text" class="form-control" id="foodTag" name="foodTag" value="${sVo.foodTag}" style="width: 100px;" required>&nbsp;
			                <input type="button" class="btn btn-primary" id="midBtn" onclick="foodTagCheck()" style="width: 20%; text-align: center;"  value="중복체크">
			            </div>
			            <div style="font-size: 10px; margin-left: 9%;" id="demo2"></div>
			            <p></p>
			            <div class="loginbox-submit text-center input-group">
		                <input type="button" onclick="fCheck()" class="btn btn-success" value="태그 수정" style="width: 20%; margin-left: 15%;">
		                <input type="button" onclick="location.href='${ctp}/store/myStoreTag';" class="btn btn-secondary" value="돌아가기" style="width: 20%; margin-left: 15%;">
			            	<input type="hidden" name="idx" value="${sVo.idx}" />
			            	<input type="hidden" name="oldTag" value="${sVo.foodTag}" />
			            </div>
			        </div>
		        </form>
		    </div>
			</section>
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
    
  </body>
</html>
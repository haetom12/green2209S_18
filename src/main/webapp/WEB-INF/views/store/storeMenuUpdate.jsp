<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<% pageContext.setAttribute("newLine", "\n"); %>
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
	  let foodCheckSw = 0;
		
	  //  체크후 서버로 전송(submit)
	  function fCheck() {
		  let foodName = myform.foodName.value;
		  let price = myform.price.value;
		  
			let fName = myform.fName.value;
			let ext = fName.substring(fName.lastIndexOf(".")+1); // 확장자 발췌
			let uExt = ext.toUpperCase();
			let maxSize = 1024 * 1024 * 2;   // 업로드 가능한 최대파일의 용량은 2MByte로 한다.
	
			
			if(foodName.trim() == "") {
				alert("메뉴명을 입력하세요");
				myform.foodName.focus();
				return false;
			}
			else if(price.trim() == "") {
				alert("가격을 입력하세요");
				myform.price.focus();
				return false;
			}
			
			else if(foodName != '${fVo.foodName}') {
			  if(foodCheckSw == 0) {
					alert("메뉴명 중복체크는 필수입니다!");
					myform.foodName.focus();
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
	  
		//메뉴 이름 중복체크
	  function foodNameCheck() {
		  let foodName = myform.foodName.value;
		  let storeName = '${storeName}';
		  let oldName = '${fVo.foodName}';
		  
	  	if(foodName.trim() == "") {
	  		alert("메뉴명을 입력하세요!");
	  		myform.foodName.focus();
	  		return false;
	  	}
	  	else if(foodName.trim() == oldName) {
	  		alert("수정전과 동일한 메뉴명입니다!");
	  		myform.foodName.focus();
	  		return false;
	  	}
	  	else {
		  	$.ajax({
			  	type   : "post",
			  	url    : "${ctp}/store/foodNameCheck",
			  	data   : {
			  		foodName : foodName,
			  		storeName : storeName
			  		} ,
			  	success:function(res) {
			  		if(res == "1") {
			  			document.getElementById("demo2").innerHTML = "<font color = 'red'> 존재하는 메뉴입니다! </font>"; 
			  			
			  		}
			  		else {
			  			document.getElementById("demo2").innerHTML = "<font color = 'blue'><b>사용가능한 메뉴입니다!</b> </font>";  
			  			$("#foodName").attr("readonly","readonly");
			  			foodCheckSw = 1;
			  		}
			  	},
			  	error : function() {
			  		alert("전송 오류~~");
			  	}
			  });	
	    }
	  }
		
	  function saleCheck(check) {
			let saleOk = $(sale).val();
			
			if(saleOk == "O") {
				document.getElementById('salePrice').readOnly = false;
			}
			else {
				document.getElementById('salePrice').value = 0;
				document.getElementById('salePrice').readOnly = true;
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
			            <div class="fw-bold text-danger fs-3 fs-lg-5 lh-sm my-2 mt-2 text-center"><font size="20pt">메뉴 등록</font></div>
			            <div class="loginbox-or">
			                <div class="or-line"></div>
			            </div>
			            <div class="loginbox-textbox fw-bold text-danger fs-3 fs-lg-1 lh-sm" style="margin-left: 7%;">메뉴 이름</div>
			            <div class="loginbox-textbox input-group" style="width: 85.5%; margin: 0 auto;">
			                <input type="text" class="form-control" id="foodName" name="foodName" value="${fVo.foodName}" style="width: 100px;" required>&nbsp;
			                <input type="button" class="btn btn-primary" id="midBtn" onclick="foodNameCheck()" style="width: 20%; text-align: center;"  value="중복체크">
			            </div>
			            <div style="font-size: 10px; margin-left: 9%;" id="demo2"></div>
			            <div class="loginbox-textbox fw-bold text-danger fs-3 fs-lg-1 lh-sm" style="margin-left: 7%;">음식 태그</div>
			            <div class="loginbox-textbox" style="width: 70%; margin-left: 7%;">
			             	<div class="input-group mb-3">
										  <div class="input-group-append">
										    <select name="foodTag" class="form-control" style="width: 120px;">
										    	<c:forEach var="vo" items="${vos}">
											    	<option value="${vo.foodTag}"  ${fVo.foodTag==vo.foodTag  ? "selected" : ""}  >${vo.foodTag}</option>
											    </c:forEach>
											  </select>
										  </div>
										</div>
			            </div>
			            <div style="font-size: 10px; margin-left: 9%;" id="demo"></div>
			            <div class="loginbox-textbox fw-bold text-danger fs-3 fs-lg-1 lh-sm" style="margin-left: 7%;">가격</div>
			            <div class="loginbox-textbox">
			                <input type="number" class="form-control" id="price" name="price" value="${fVo.price}" style="width: 85%; margin: 0 auto;" required>
			            </div>
			            
			            <div class="loginbox-textbox fw-bold text-danger fs-3 fs-lg-1 lh-sm" style="margin-left: 7%;">품절 여부</div>
			            <div class="loginbox-textbox" style="width: 85%; margin: 0 auto;">
										<input type="radio" name="runOut" value="X" ${fVo.runOut == "X"  ? "checked" : ""} >
										<label>품절X</label>&nbsp;
										<input type="radio" name="runOut" value="O" ${fVo.runOut == "O"  ? "checked" : ""}  >
										<label>품절O</label>
									</div>
									
									<div class="loginbox-textbox fw-bold text-danger fs-3 fs-lg-1 lh-sm" style="margin-left: 7%;">세일 여부</div>
			            <div class="loginbox-textbox" style="width: 70%; margin-left: 7%;">
			             	<div class="input-group mb-3">
										  <div class="input-group-append">
										    <select name="sale" id="sale" onchange="saleCheck(this)" class="form-control" style="width: 120px;">
											    	<option value="X"  ${fVo.sale == "X"  ? "selected" : ""}  >X</option>
											    	<option value="O"  ${fVo.sale == "O"  ? "selected" : ""}  >O</option>
											  </select>
										  </div>
										</div>
			            </div>
			            
			            <div class="loginbox-textbox fw-bold text-danger fs-3 fs-lg-1 lh-sm" style="margin-left: 7%;">세일 가격</div>
			            <div class="loginbox-textbox">
			                <input type="number" class="form-control" id="salePrice" name="salePrice" value="${fVo.salePrice}"  min="0"  style="width: 85%; margin: 0 auto;" required>
			            </div>
									
			            <div class="loginbox-textbox fw-bold text-danger fs-3 fs-lg-1 lh-sm" style="margin-left: 7%;">추가 메뉴</div>
			            <div class="loginbox-textbox" style="width: 85%; margin: 0 auto;">
										<input type="radio" name="subMenu" value="X" ${fVo.subMenu == "X"  ? "checked" : ""} >
										<label>없음</label>&nbsp;
										<input type="radio" name="subMenu" value="O" ${fVo.subMenu == "O"  ? "checked" : ""}  >
										<label>있음</label>
									</div>
									
									<div class="loginbox-textbox fw-bold text-danger fs-3 fs-lg-1 lh-sm" style="margin-left: 7%;">메뉴 설명</div>
									<div class="loginbox-textbox" style="width: 85%; margin: 0 auto;">
										<textarea rows="6" name="foodInfo" id="foodInfo" class="form-control mb-2">${fn:replace(fVo.foodInfo, newLine, '<br/>')}</textarea>
									</div>
			            <div class="loginbox-textbox fw-bold text-danger fs-3 fs-lg-1 lh-sm" style="margin-left: 7%;">메뉴 사진</div>
			            <div class="loginbox-textbox" style="width: 70%; margin-left: 7%;">
			              <div  class="form-group">
								      메뉴 사진(파일용량:2MByte이내) :
								      <input type="file" name="fName" id="fName" class="form-control-file border"/>
								    </div>
							    </div>
			            <div class="loginbox-submit text-center input-group">
		                <input type="button" onclick="fCheck()" class="btn btn-success" value="메뉴 수정" style="width: 40%;">
		                <input type="button" onclick="location.href='${ctp}/member/JoinSelect';" class="btn btn-primary" value="돌아가기" style="width: 40%; ">
			            </div>
			        </div>
			       	<input type="hidden" name="menuIdx" value="${fVo.menuIdx}" />
						  <input type="hidden" name="pastPhoto" value="${fVo.foodPhoto}" />
						  <input type="hidden" name="pastFoodName" value="${fVo.foodName}" />
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
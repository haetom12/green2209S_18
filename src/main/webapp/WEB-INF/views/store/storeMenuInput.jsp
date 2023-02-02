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
						<form name="JoinForm" method="post" enctype="multipart/form-data">
			        <div class="loginbox bg-light">
			            <div class="fw-bold text-danger fs-3 fs-lg-5 lh-sm my-2 mt-2 text-center"><font size="20pt">메뉴 등록</font></div>
			            <div class="loginbox-or">
			                <div class="or-line"></div>
			            </div>
			            <div class="loginbox-textbox fw-bold text-danger fs-3 fs-lg-1 lh-sm" style="margin-left: 7%;">메뉴 이름</div>
			            <div class="loginbox-textbox">
			                <input type="text" class="form-control" id="foodName" name="foodName" placeholder="메뉴 이름을 입력하세요"  style="width: 85%; margin: 0 auto;" required>
			            </div>
			            <div class="loginbox-textbox fw-bold text-danger fs-3 fs-lg-1 lh-sm" style="margin-left: 7%;">메뉴 분류</div>
			            <div class="loginbox-textbox" style="width: 70%; margin-left: 7%;">
			             	<div class="input-group mb-3">
										  <div class="input-group-append">
										    <select name="foodPart" class="form-control">
										    	<c:forEach var="vo" items="${vos}">
											    	<option value="${vo.storePart}" selected>${vo.storePart}</option>
											    </c:forEach>
											  </select>
										  </div>
										</div>
			            </div>
			            
			            <div class="loginbox-textbox fw-bold text-danger fs-3 fs-lg-1 lh-sm" style="margin-left: 7%;">영업시간</div>
			            <div class="loginbox-textbox input-group" style="width: 85.5%; margin: 0 auto;">
									  OPEN &nbsp; <input type="time" name="storeTime1" id="storeTime1" value="09:00" class="form-control" />&nbsp;&nbsp;
										CLOSE &nbsp; <input type="time" name="storeTime2" id="storeTime2" value="00:00" class="form-control"/>
			            </div>
			            
			            <div class="loginbox-textbox fw-bold text-danger fs-3 fs-lg-1 lh-sm" style="margin-left: 7%;">등록자 아이디</div>
			            <div class="loginbox-textbox input-group" style="width: 85.5%; margin: 0 auto;">
			                <input type="text" class="form-control" id="storeMid" name="storeMid" placeholder="아이디를 입력하세요" style="width: 100px;" required>&nbsp;
			                <input type="button" class="btn btn-primary" id="midBtn" onclick="idCheck()" style="width: 20%; text-align: center;"  value="중복체크">
			            </div>
			            <div style="font-size: 10px; margin-left: 9%;" id="demo"></div>
			            <div class="loginbox-textbox fw-bold text-danger fs-3 fs-lg-1 lh-sm" style="margin-left: 7%;">비밀번호</div>
			            <div class="loginbox-textbox">
			                <input type="password" class="form-control" id="storePwd" name="storePwd" placeholder="비밀번호를 입력하세요"  style="width: 85%; margin: 0 auto;" required>
			            </div>
			            <div class="loginbox-textbox fw-bold text-danger fs-3 fs-lg-1 lh-sm" style="margin-left: 7%;">성명</div>
			            <div class="loginbox-textbox">
			                <input type="text" class="form-control" id="HostName" name="HostName" placeholder="성명을 입력하세요"  style="width: 85%; margin: 0 auto;" required>
			            </div>
			            <div class="loginbox-textbox fw-bold text-danger fs-3 fs-lg-1 lh-sm" style="margin-left: 7%;">전화번호</div>
			            <div class="loginbox-textbox">
										<div class="form-group">
								      <div class="input-group" style="width: 60%;">
									      <div class="input-group-prepend" style="float: left; margin-left: 12%">
											      <select name="tel1" class="form-control custom-select">
													    <option value="010" selected>010</option>
													    <option value="02">02</option>
													    <option value="031">031</option>
													    <option value="032">032</option>
													    <option value="041">041</option>
													    <option value="042">042</option>
													    <option value="043">043</option>
											        <option value="051">051</option>
											        <option value="052">052</option>
											        <option value="061">061</option>
											        <option value="062">062</option>
													  </select>
									      </div>
											      &nbsp;-&nbsp;<input type="text" name="tel2" maxlength=4 class="form-control" style="width: 50px;" required />&nbsp;-&nbsp;
											      <input type="text" name="tel3" maxlength=4 class="form-control" style="width: 10px;" required/>
									    </div> 
								    </div>
			            </div>
			            <div class="loginbox-textbox fw-bold text-danger fs-3 fs-lg-1 lh-sm" style="margin-left: 7%;">주소지</div>
			            <div class="loginbox-textbox input-group" style="width: 85.5%; margin: 0 auto;">
										<input type="text" id="sample5_address" placeholder="오른쪽버튼을 눌러 검색하세요" class="form-control" readonly>
										<input type="button" onclick="sample5_execDaumPostcode()" class="btn btn-secondary ml-2" value="주소 검색"><br>
									</div>
			            <div class="loginbox-textbox input-group" style="width: 85.5%; margin: 0 auto;">
										<input type="text" id="sample5_address2" placeholder="상세주소" class="form-control">
									</div>
									<div id="map" style="width:300px;height:300px;margin-top:10px;display:none; margin-left: 10%;"></div>
									
			            <div class="loginbox-textbox fw-bold text-danger fs-3 fs-lg-1 lh-sm" style="margin-left: 7%;">이메일</div>
			            <div class="loginbox-textbox" style="width: 70%; margin-left: 7%;">
			             	<div class="input-group mb-3">
										  <input type="text" class="form-control" placeholder="Email을 입력하세요." id="email1" name="email1" required />@
										  <div class="input-group-append">
										    <select name="email2" class="form-control">
											    <option value="naver.com" selected>naver.com</option>
											    <option value="hanmail.net">hanmail.net</option>
											    <option value="hotmail.com">hotmail.com</option>
											    <option value="gmail.com">gmail.com</option>
											    <option value="nate.com">nate.com</option>
											    <option value="yahoo.com">yahoo.com</option>
											  </select>
										  </div>
										</div>
			            </div>
			            <div class="loginbox-textbox fw-bold text-danger fs-3 fs-lg-1 lh-sm" style="margin-left: 7%;">메뉴 사진</div>
			            <div class="loginbox-textbox" style="width: 70%; margin-left: 7%;">
			              <div  class="form-group">
								      메뉴 사진(파일용량:2MByte이내) :
								      <input type="file" name="fName" id="fName" class="form-control-file border"/>
								    </div>
							    </div>
			            <div class="loginbox-submit text-center">
			                <input type="button" onclick="JoinCheck()" class="btn btn-success btn-block mt-3" value="회원가입" style="width: 92%">
			            </div>
			            <div class="loginbox-submit text-center">
			                <input type="button" onclick="location.href='${ctp}/member/JoinSelect';" class="btn btn-primary btn-block" value="돌아가기" style="width: 92%">
			            </div>
			        </div>
			        <input type="hidden" name="storeNumber"/>
		    			<input type="hidden" name="storeEmail"/>
		    			<input type="hidden" name="storeLatitude"/>
		    			<input type="hidden" name="storeLongitude"/>
		    			<input type="hidden" name="storeAddress"/>
		    			<input type="hidden" name="logoPhoto"/>
		    			<input type="hidden" name="storeTime"/>
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
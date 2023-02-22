<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<html>

  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>해찬들 | 연습장</title>

    <link rel="apple-touch-icon" sizes="180x180" href="${ctp}/assets/img/favicons/apple-touch-icon.png">
    <link rel="icon" type="image/png" sizes="32x32" href="${ctp}/assets/img/favicons/favicon-32x32.png">
    <link rel="icon" type="image/png" sizes="16x16" href="${ctp}/assets/img/favicons/favicon-16x16.png">
    <link rel="shortcut icon" type="image/x-icon" href="${ctp}/assets/img/favicons/favicon.ico">
    <link rel="manifest" href="${ctp}/assets/img/favicons/manifest.json">
    <meta name="msapplication-TileImage" content="${ctp}/assets/img/favicons/mstile-150x150.png">
    <meta name="theme-color" content="#ffffff">

    <link href="${ctp}/assets/css/theme.css" rel="stylesheet" />
		<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet">
		
		<link rel="stylesheet" type="text/css" href="${ctp}/vendors/styles/core.css">
		<link rel="stylesheet" type="text/css" href="${ctp}/vendors/styles/icon-font.min.css">
		<link rel="stylesheet" type="text/css" href="${ctp}/vendors/styles/style.css">
		
		<style>
			.login-container {
			    position: relative;
			    margin: 5% auto;
			    max-width: 400px;
			}
			.login-container .loginbox {
			    position: relative;
			    width: 400px !important;
			    height: auto !important;
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
			    height: 35px;
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
			/* ============================================ */
			.switch {
			  position: relative;
			  display: inline-block;
			  width: 45px;
			  height: 24px;
			}
			
			.switch input { 
			  opacity: 0;
			  width: 0;
			  height: 0;
			}
			
			.slider {
			  position: absolute;
			  cursor: pointer;
			  top: 0;
			  left: 0;
			  right: 0;
			  bottom: 0;
			  background-color: #ccc;
			  -webkit-transition: .4s;
			  transition: .4s;
			}
			
			.slider:before {
			  position: absolute;
			  content: "";
			  height: 16px;
			  width: 15px;
			  left: 2px;
			  bottom: 4px;
			  background-color: white;
			  -webkit-transition: .4s;
			  transition: .4s;
			}
			
			input:checked + .slider {
			  background-color: #2196F3;
			}
			
			input:focus + .slider {
			  box-shadow: 0 0 1px #2196F3;
			}
			
			input:checked + .slider:before {
			  -webkit-transform: translateX(26px);
			  -ms-transform: translateX(26px);
			  transform: translateX(26px);
			}
			
			/* Rounded sliders */
			.slider.round {
			  border-radius: 34px;
			}
			
			.slider.round:before {
			  border-radius: 50%;
			}
			
		</style>
		<script>
			'use strict';
			
			function loginCheck() {
				let mid = document.getElementById("mid").value;
				let pwd = document.getElementById("pwd").value;
				
				if(mid.trim()==""){
					alert("아이디를 입력하세요");
					LoginForm.mid.focus();
					return false;
				}
				else if(pwd.trim()==""){
					alert("비밀번호를 입력하세요");
					LoginForm.pwd.focus();
					return false;
				}
				else {
					LoginForm.submit();
				}				
			}
			
			function midFind() {
				let name = myform.name.value;
				let email = myform.email.value;
				let options = myform.options.value;
				
				if(name == "") {
					alert("성함을 입력하세요.");
					myform.name.focus();
					return false;
				}
				else if(email == "") {
					alert("이메일을 입력하세요.");
					myform.email.focus();
					return false;
				}
				else if(options == "") {
					alert("수정메뉴을 선택하세요.");
					return false;
				}
				myform.submit();
			}
			
			function pwdFind() {
				let mid = myform2.mid.value;
				let email = myform2.email.value;
				let options = myform2.options.value;
				
				if(mid == "") {
					alert("아이디를 입력하세요.");
					myform2.mid.focus();
					return false;
				}
				else if(email == "") {
					alert("이메일을 입력하세요.");
					myform2.email.focus();
					return false;
				}
				else if(options == "") {
					alert("수정메뉴을 선택하세요.");
					return false;
				}
				myform2.submit();
			}
			
		</script>
  </head>

  <body>
    <main class="main" id="top">
		<jsp:include page="/WEB-INF/views/include/nav.jsp"></jsp:include>		
		<section class="py-5 overflow-hidden bg-primary" style="height: 80%;">
			<div class="login-container animated fadeInDown bootstrap snippets bootdeys">
				<form name="LoginForm" method="post">
	        <div class="loginbox bg-white">
	            <div class="fw-bold text-danger fs-3 fs-lg-5 lh-sm my-2 mt-2 text-center">로그인</div>
	            <div class="loginbox-social">
	                <div class="social-title ">
	                	<a href="">
	                		<img src="${ctp}/images/카카오톡로그인.png"/>
	                	</a>
	                </div>
	            </div>
	            <div class="loginbox-or">
	                <div class="or-line"></div>
	                <div class="or">OR</div>
	            </div>
	            
	            <div class="loginbox-textbox">
		            <div class="form-check-inline ml-4">
						      <label class="form-check-label" for="radio1">
						        <input type="radio" class="form-check-input" name="part" value="member" checked> 일반회원
						      </label>
						    </div>
						    <div class="form-check-inline">
						      <label class="form-check-label" for="radio2">
						        <input type="radio" class="form-check-input" name="part" value="rider"> 라이더
						      </label>
						    </div>
						    <div class="form-check-inline">
						      <label class="form-check-label" for="radio3">
						        <input type="radio" class="form-check-input" name="part" value="store"> 가게
						      </label>
						    </div>
						    <div class="form-check-inline">
						      <label class="form-check-label" for="radio4">
						        <input type="radio" class="form-check-input" name="part" value="admin"> 관리자
						      </label>
						    </div>
	            </div>
	            
	            <div class="loginbox-textbox">
	                <input type="text" class="form-control" id="mid" name="mid" value="${mid}" placeholder="아이디를 입력하세요"  style="width: 85%; margin: 0 auto;">
	            </div>
	            <div class="loginbox-textbox">
	                <input type="password" class="form-control" id="pwd" name="pwd" placeholder="비밀번호를 입력하세요"  style="width: 85%; margin: 0 auto;">
	            </div>
	            <div>
		            <label class="switch" style="float: left; margin-left: 40px; margin-right: 5px;">
								  <input type="checkbox" name="idCheck" checked>
								  <span class="slider round"></span>
								</label>
								<label>아이디 저장</label>
							</div>
	            <div class="loginbox-forgot">
	                <a href="#" data-backdrop="static" data-toggle="modal" data-target="#login-modal" type="button">아이디 찾기</a> /
	                <a href="#" data-backdrop="static" data-toggle="modal" data-target="#login-modal2" type="button">비밀번호 찾기</a>
	            </div>
	            <div class="loginbox-submit">
	                <input type="button" onclick="loginCheck()" class="btn btn-primary btn-block" value="로그인" style="width: 100%">
	            </div>
	            <div class="loginbox-signup">
	                <a href="${ctp}/member/JoinSelect">회원 가입 하기</a>
	            </div>
	        </div>
        </form>
    </div>
		</section>
		
		
		<!-- 아이디 찾기 폼 -->
			<div class="modal fade" id="login-modal" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
				<div class="modal-dialog modal-dialog-centered">
					<div class="modal-content">
						<div class="login-box bg-white box-shadow border-radius-10">
							<div class="login-title">
								<h2 class="text-center text-primary">아이디 찾기</h2>
							</div>
							<form name="myform" method="post" action="${ctp}/member/midFind">
								<div class="select-role">
									<div class="btn-group btn-group-toggle" data-toggle="buttons">
										<label class="btn" style="width: 50px;">
											일반회원
											<input type="radio" name="options" value="member">
										</label>
										<label class="btn" style="width: 50px;">
											<input type="radio" name="options" value="rider">
											라이더
										</label>
										<label class="btn" style="width: 50px;">
											<input type="radio" name="options" value="store">
											가게점주
										</label>
									</div>
								</div>
								<div class="input-group custom">
									<input type="text" id="name" name="name" class="form-control form-control-lg" placeholder="성함을 입력하세요">
									<div class="input-group-append custom">
										<span class="input-group-text"><i class="dw dw-padlock1"></i></span>
									</div>
								</div>
								<div class="input-group custom">
									<input type="text" id="email" name="email" class="form-control form-control-lg" placeholder="해당 이메일을 입력하세요">
									<div class="input-group-append custom">
										<span class="input-group-text"><i class="dw dw-email"></i></span>
									</div>
								</div>
								<div class="row">
									<div class="col-sm-12">
										<div class="input-group mb-0">
											<!--
												use code for form submit
												<input class="btn btn-primary btn-lg btn-block" type="submit" value="Sign In">
											-->
											<input class="btn btn-primary btn-lg btn-block" type="button" onclick="midFind()" value="아이디 찾기">
											<input type="button" value="닫기" class="close btn btn-secondary btn-lg btn-block" data-dismiss="modal" aria-hidden="true">
										</div>
									</div>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
			
		<!-- 비밀번호 찾기 폼 -->
			<div class="modal fade" id="login-modal2" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
				<div class="modal-dialog modal-dialog-centered">
					<div class="modal-content">
						<div class="login-box bg-white box-shadow border-radius-10">
							<div class="login-title">
								<h2 class="text-center text-primary">비밀번호 찾기</h2>
							</div>
							<form name="myform2" method="post" action="${ctp}/member/pwdFind">
								<div class="select-role">
									<div class="btn-group btn-group-toggle" data-toggle="buttons">
										<label class="btn" style="width: 50px;">
											일반회원
											<input type="radio" name="options" value="member">
										</label>
										<label class="btn" style="width: 50px;">
											<input type="radio" name="options" value="rider">
											라이더
										</label>
										<label class="btn" style="width: 50px;">
											<input type="radio" name="options" value="store">
											가게점주
										</label>
									</div>
								</div>
								<div class="input-group custom">
									<input type="text" id="mid" name="mid" class="form-control form-control-lg" placeholder="아이디를 입력하세요">
									<div class="input-group-append custom">
										<span class="input-group-text"><i class="dw dw-padlock1"></i></span>
									</div>
								</div>
								<div class="input-group custom">
									<input type="text" id="email" name="email" class="form-control form-control-lg" placeholder="해당 이메일을 입력하세요">
									<div class="input-group-append custom">
										<span class="input-group-text"><i class="dw dw-email"></i></span>
									</div>
								</div>
								<div class="row">
									<div class="col-sm-12">
										<div class="input-group mb-0">
											<!--
												use code for form submit
												<input class="btn btn-primary btn-lg btn-block" type="submit" value="Sign In">
											-->
											<input class="btn btn-primary btn-lg btn-block" type="button" onclick="pwdFind()" value="임시 비밀번호 발급">
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
    </main>
	
    <script src="${ctp}/vendors/@popperjs/popper.min.js"></script>
    <script src="${ctp}/vendors/bootstrap/bootstrap.min.js"></script>
    <script src="${ctp}/vendors/is/is.min.js"></script>			
    <script src="https://polyfill.io/v3/polyfill.min.js?features=window.scroll"></script>
    <script src="${ctp}/vendors/fontawesome/all.min.js"></script>
    <script src="${ctp}/assets/js/theme.js"></script>

  </body>

</html>

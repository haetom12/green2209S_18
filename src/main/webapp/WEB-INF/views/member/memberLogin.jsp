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
	                <input type="text" class="form-control" id="mid" name="mid" placeholder="아이디를 입력하세요" style="width: 85%; margin: 0 auto;">
	            </div>
	            <div class="loginbox-textbox">
	                <input type="password" class="form-control" id="pwd" name="pwd" placeholder="비밀번호를 입력하세요"  style="width: 85%; margin: 0 auto;">
	            </div>
	            <div class="loginbox-forgot">
	                <a href="">아이디 찾기</a> /
	                <a href="">비밀번호 찾기</a>
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

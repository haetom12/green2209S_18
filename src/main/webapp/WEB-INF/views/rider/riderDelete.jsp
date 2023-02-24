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
				  	url    : "${ctp}/rider/riderDeleteCheck",
				  	data   : {
				  		riderMid : mid,
				  		riderPwd : pwd
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
				  	url    : "${ctp}/rider/riderDeleteCodeCheck",
				  	data   : {
				  		code : code
				  		},
				  	success:function(res) {
				  		if(res == "1") {
				  			alert("탈퇴 인증에 성공하였습니다!");
				  			let ans = confirm("회원탈퇴시 모든 정보가 삭제됩니다. 계속 진행하시겠습니까?");
								if(!ans) return false;
								
								location.href="${ctp}/rider/riderDeleteOk";
								
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
  <body>
	<div class="pre-loader">
		<div class="pre-loader-box">
			<div class='loader-progress' id="progress_div">
				<div class='bar' id='bar1'></div>
			</div>
			<div class='percent' id='percent1'>30%</div>
			<div class="loading-text">
				라이더 로딩중...
			</div>
		</div>
	</div>

	<div class="header">
		<div class="header-left">
			<div class="menu-icon dw dw-menu"></div>
			<div class="search-toggle-icon dw dw-search2" data-toggle="header_search"></div>
		</div>
	</div>

	<div class="right-sidebar">
		<div class="sidebar-title">
			<h3 class="weight-600 font-16 text-blue">
				Layout Settings
				<span class="btn-block font-weight-400 font-12">User Interface Settings</span>
			</h3>
			<div class="close-sidebar" data-toggle="right-sidebar-close">
				<i class="icon-copy ion-close-round"></i>
			</div>
		</div>
		<div class="right-sidebar-body customscroll">
			<div class="right-sidebar-body-content">
				<h4 class="weight-600 font-18 pb-10">Header Background</h4>
				<div class="sidebar-btn-group pb-30 mb-10">
					<a href="javascript:void(0);" class="btn btn-outline-primary header-white active">White</a>
					<a href="javascript:void(0);" class="btn btn-outline-primary header-dark">Dark</a>
				</div>

				<h4 class="weight-600 font-18 pb-10">Sidebar Background</h4>
				<div class="sidebar-btn-group pb-30 mb-10">
					<a href="javascript:void(0);" class="btn btn-outline-primary sidebar-light ">White</a>
					<a href="javascript:void(0);" class="btn btn-outline-primary sidebar-dark active">Dark</a>
				</div>

				<h4 class="weight-600 font-18 pb-10">Menu Dropdown Icon</h4>
				<div class="sidebar-radio-group pb-10 mb-10">
					<div class="custom-control custom-radio custom-control-inline">
						<input type="radio" id="sidebaricon-1" name="menu-dropdown-icon" class="custom-control-input" value="icon-style-1" checked="">
						<label class="custom-control-label" for="sidebaricon-1"><i class="fa fa-angle-down"></i></label>
					</div>
					<div class="custom-control custom-radio custom-control-inline">
						<input type="radio" id="sidebaricon-2" name="menu-dropdown-icon" class="custom-control-input" value="icon-style-2">
						<label class="custom-control-label" for="sidebaricon-2"><i class="ion-plus-round"></i></label>
					</div>
					<div class="custom-control custom-radio custom-control-inline">
						<input type="radio" id="sidebaricon-3" name="menu-dropdown-icon" class="custom-control-input" value="icon-style-3">
						<label class="custom-control-label" for="sidebaricon-3"><i class="fa fa-angle-double-right"></i></label>
					</div>
				</div>

				<h4 class="weight-600 font-18 pb-10">Menu List Icon</h4>
				<div class="sidebar-radio-group pb-30 mb-10">
					<div class="custom-control custom-radio custom-control-inline">
						<input type="radio" id="sidebariconlist-1" name="menu-list-icon" class="custom-control-input" value="icon-list-style-1" checked="">
						<label class="custom-control-label" for="sidebariconlist-1"><i class="ion-minus-round"></i></label>
					</div>
					<div class="custom-control custom-radio custom-control-inline">
						<input type="radio" id="sidebariconlist-2" name="menu-list-icon" class="custom-control-input" value="icon-list-style-2">
						<label class="custom-control-label" for="sidebariconlist-2"><i class="fa fa-circle-o" aria-hidden="true"></i></label>
					</div>
					<div class="custom-control custom-radio custom-control-inline">
						<input type="radio" id="sidebariconlist-3" name="menu-list-icon" class="custom-control-input" value="icon-list-style-3">
						<label class="custom-control-label" for="sidebariconlist-3"><i class="dw dw-check"></i></label>
					</div>
					<div class="custom-control custom-radio custom-control-inline">
						<input type="radio" id="sidebariconlist-4" name="menu-list-icon" class="custom-control-input" value="icon-list-style-4" checked="">
						<label class="custom-control-label" for="sidebariconlist-4"><i class="icon-copy dw dw-next-2"></i></label>
					</div>
					<div class="custom-control custom-radio custom-control-inline">
						<input type="radio" id="sidebariconlist-5" name="menu-list-icon" class="custom-control-input" value="icon-list-style-5">
						<label class="custom-control-label" for="sidebariconlist-5"><i class="dw dw-fast-forward-1"></i></label>
					</div>
					<div class="custom-control custom-radio custom-control-inline">
						<input type="radio" id="sidebariconlist-6" name="menu-list-icon" class="custom-control-input" value="icon-list-style-6">
						<label class="custom-control-label" for="sidebariconlist-6"><i class="dw dw-next"></i></label>
					</div>
				</div>

				<div class="reset-options pt-30 text-center">
					<button class="btn btn-danger" id="reset-settings">Reset Settings</button>
				</div>
			</div>
		</div>
	</div>
		
	<!-- ===========사이드바============ -->
		
	<div class="left-side-bar">
		<div class="brand-logo">
			<a href="index.html">
				<img src="${ctp}/vendors/images/deskapp-logo.svg" alt="" class="dark-logo">
				<img src="${ctp}/vendors/images/deskapp-logo-white.svg" alt="" class="light-logo">
			</a>
			<div class="close-sidebar" data-toggle="left-sidebar-close">
				<i class="ion-close-round"></i>
			</div>
		</div>
		<div class="menu-block customscroll">
			<div class="sidebar-menu">
				<ul id="accordion-menu">
					<li>
						<a href="${ctp}/rider/riderMain" class="dropdown-toggle no-arrow">
							<span class="micon dw dw-house-1"></span><span class="mtext">메인으로</span>
						</a>
					</li>
					<li>
						<a href="${ctp}/rider/orderChat" class="dropdown-toggle no-arrow">
							<span class="micon dw dw-motorcycle"></span><span class="mtext">배달신청</span>
						</a>
					</li>
					<li class="dropdown">
						<a href="javascript:;" class="dropdown-toggle">
							<span class="micon dw dw-calendar1"></span><span class="mtext">마이페이지</span>
						</a>
						<ul class="submenu">
							<li><a href="${ctp}/rider/riderUpdate">내 정보 수정</a></li>
							<li><a href="${ctp}/rider/riderPwdUpdate">비밀번호 변경</a></li>
							<li><a href="${ctp}/rider/riderDeliverList">내 배달 기록</a></li>
							<li><a href="${ctp}/rider/riderDelete">라이더 탈퇴</a></li>
						</ul>
					</li>
					
					<!-- 경계선  -->
					<li>
						<div class="dropdown-divider"></div>
					</li>
					
					
					<li>
						<div class="sidebar-small-cap">Extra</div>
					</li>
					<li>
						<a href="javascript:;" class="dropdown-toggle">
							<span class="micon dw dw-edit-2"></span><span class="mtext">Documentation</span>
						</a>
						<ul class="submenu">
							<li><a href="introduction.html">Introduction</a></li>
							<li><a href="getting-started.html">Getting Started</a></li>
							<li><a href="color-settings.html">Color Settings</a></li>
							<li><a href="third-party-plugins.html">Third Party Plugins</a></li>
						</ul>
					</li>
					<li>
						<a href="https://dropways.github.io/deskapp-free-single-page-website-template/" target="_blank" class="dropdown-toggle no-arrow">
							<span class="micon dw dw-paper-plane1"></span>
							<span class="mtext">Landing Page <img src="${ctp}/vendors/images/coming-soon.png" alt="" width="25"></span>
						</a>
					</li>
				</ul>
			</div>
		</div>
	</div>
	<div class="mobile-menu-overlay"></div>
	
	<!-- =============================================== -->

	<div class="main-container">
	  <div class="container">
			<div class="pd-20 card-box mb-30">
				<div class="clearfix">
					<h3 class="text-blue h3" style="text-align: center;">라이더 탈퇴</h3>
				</div>
				<form name="myform" method="post">
					<div class="form-group">
						<label>아이디</label>
						<input class="form-control" id="mid" name="mid" placeholder="아이디를 입력하세요" type="text">
					</div>
					<div class="form-group">
						<label>비밀번호</label>
						<input class="form-control" id="pwd" name="pwd" placeholder="비밀번호를 입력하세요" type="password">
					</div>
					<div class="form-group" id="codeForm" style="display: none;" >
						<label>인증코드 입력</label>
						<input class="form-control" id="code" name="code" placeholder="인증코드를 입력하세요" type="text">
					</div>
					<div class="form-group">
					<div class="row">
						<input type="button" value="회원인증"  id="checkBtn" name="checkBtn" onclick="memberCheck()" style="float: right;" class="btn btn-success ml-2" />
						<input type="button" value="탈퇴신청" id="deleteBtn" name="deleteBtn" onclick="codeCheck()" style="display: none; float: right;" class="btn btn-success ml-2" />
						<input type="button" value="돌아가기" onclick="location.href='${ctp}/rider/riderMain';"  class="btn btn-secondary ml-3 mr-2" />
					</div>
					</div>
				</form>
	    </div>
    </div>
  </div>
	<!-- js -->
	<script src="${ctp}/vendors/scripts/core.js"></script>
	<script src="${ctp}/vendors/scripts/script.min.js"></script>
	<script src="${ctp}/vendors/scripts/process.js"></script>
	<script src="${ctp}/vendors/scripts/layout-settings.js"></script>
</body>
</html>
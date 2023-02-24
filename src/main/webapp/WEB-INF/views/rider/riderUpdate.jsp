<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<!-- Basic Page Info -->
	<meta charset="utf-8">
	<title>DeskApp - Bootstrap Admin Dashboard HTML Template</title>

	<!-- Site favicon -->
	<link rel="apple-touch-icon" sizes="180x180" href="${ctp}/vendors/images/apple-touch-icon.png">
	<link rel="icon" type="image/png" sizes="32x32" href="${ctp}/vendors/images/favicon-32x32.png">
	<link rel="icon" type="image/png" sizes="16x16" href="${ctp}/vendors/images/favicon-16x16.png">

	<!-- Mobile Specific Metas -->
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">

	<!-- Google Font -->
	<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
	<!-- CSS -->
	<link rel="stylesheet" type="text/css" href="${ctp}/vendors/styles/core.css">
	<link rel="stylesheet" type="text/css" href="${ctp}/vendors/styles/icon-font.min.css">
	<link rel="stylesheet" type="text/css" href="${ctp}/vendors/styles/style.css">

		<script>
			'use strict';
		  let idCheckSw = 0;
		  let nickCheckSw = 0;
		  let emailCheckSw = 0;
		  
			function updateCheck() {
		    	// 폼의 유효성 검사~~~~
		    	let regMid = /^[a-z0-9_]{4,20}$/;
		      // let regPwd = /(?=.*[a-zA-Z])(?=.*?[#?!@$%^&*-]).{4,24}/;
		      let regPwd = /(?=.*[0-9a-zA-Z]).{4,20}$/;
		      let regName = /^[가-힣a-zA-Z]+$/;
		      let regEmail =/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
		      let regTel = /\d{2,3}-\d{3,4}-\d{4}$/g;
		      
		      let submitFlag = 0;		// 전송체크버튼으로 값이 1이면 체크완료되어 전송처리한다.

		      // 유효성검사를 위해 폼안의 내용들을 모두 변수에 담는다.
		    	let riderName = myform.riderName.value;
		    	let riderMid = myform.riderMid.value;
		    	let email1 = myform.email1.value;
		    	let email2 = myform.email2.value;
		      let riderEmail = email1 + '@' + email2;
		      let tel1 = myform.tel1.value;
		      let tel2 = myform.tel2.value;
		      let tel3 = myform.tel3.value;
		    	let riderPhone = tel1 + "-" + tel2 + "-" + tel3;
		    	
		    	// 유효성 검사체크처리한다.(필수 입력필드는 꼭 처리해야 한다.)
		    	if(!regMid.test(riderMid)) {
		        alert("아이디는 영문 소문자와 숫자, 언더바(_)만 사용가능합니다.(길이는 4~20자리까지 허용)");
		        myform.riderMid.focus();
		        return false;
		      }
		      else if(!regName.test(riderName)) {
		        alert("성명은 한글과 영문대소문자만 사용가능합니다.");
		        myform.riderName.focus();
		        return false;
		      }
		      else if(!regEmail.test(riderEmail)) {
		        alert("이메일 형식에 맞지않습니다.");
		        myform.email1.focus();
		        return false;
		      }
		    	
		    	// 선택사항인 전화번호가 입력되어서 전송되었다면 전화번호형식을 체크해 준다.
		      if(tel2 != "" || tel3 != "") {
			      if(!regTel.test(riderPhone)) {
			        alert("전화번호 형식에 맞지않습니다.(000-0000-0000)");
			        myform.riderPhone.focus();
			        return false;
			      }
			      else {
			    	  submitFlag = 1;
			      }
		      }
		    	
		  		// 전송전에 모든 체크가 끝나서 submitFlag가 1이되면 서버로 전송한다.
		    	if(submitFlag == 1) {
		    		if(riderEmail != '${vo.riderEmail}') {
			    		if(emailCheckSw == 0) {
			    			alert("이메일 인증은 필수입니다!");
			    			document.getElementById("email1").focus();
			    			return false;
			    		}
			    		else {
				  			// 묶여진 필드(email/tel)를 폼태그안에 hidden태그의 값으로 저장시켜준다.
				  			myform.riderEmail.value = riderEmail;
				  			myform.riderPhone.value = riderPhone;
				  			
				  			myform.submit();
			    		}
			    	}
		    		else {
		    			myform.riderEmail.value = riderEmail;
			  			myform.riderPhone.value = riderPhone;
			  			
			  			myform.submit();
		    		}
		    	}
		    	else {
		    		alert("회원가입 실패~~");
		    	}
		    }
			
			
			// 닉네임 중복체크
			  function nickNameCheck() {
			  	let memberNickName = myform.memberNickName.value;
			  	
			  	if(memberNickName.trim() == "") {
			  		alert("닉네임를 입력하세요!");
			  		myform.memberNickName.focus();
			  		return false;	
			  	}
			  	else {
				  	$.ajax({
					  	type   : "post",
					  	url    : "${ctp}/member/memNickCheck",
					  	data   : {memberNickName : memberNickName} ,
					  	success:function(res) {
					  		if(res == "1") {
					  			document.getElementById("demo3").innerHTML = "<font color = 'red'> 존재하는 닉네임입니다! </font>"; 
					  			
					  		}
					  		else {
					  			document.getElementById("demo3").innerHTML = "<font color = 'blue'><b>사용가능한 닉네임입니다!</b> </font>";  
					  			$("#memberNickName").attr("readonly","readonly");
					  			nickCheckSw = 1;
					  		}
					  	},
					  	error : function() {
					  		alert("전송 오류~~");
					  	}
					  });	
			    }
			  }
			
			// 이메일로 인증문자보내기
			function mailCheck() {
	    	let email1 = myform.email1.value;
	    	let email2 = myform.email2.value;
	      let riderEmail = email1 + '@' + email2;
	      
	      let oldEmail = '${vo.riderEmail}';
				
				if(email1.trim()=="") {
					alert("이메일을 먼저 입력하세요.");
					return false;	
				}
	      else if(riderEmail == oldEmail) {
					alert("수정 전과 같은 이메일입니다.");
					return false;
				}
				else {
				  	$.ajax({
					  	type   : "post",
					  	url    : "${ctp}/rider/riderUpdateEmailCheck",
					  	data   : {riderEmail : riderEmail} ,
					  	async  : false ,
					  	success:function(res) {
					  		if(res == "1") {
					  			alert("인증 메일이 전송되었습니다.(제한시간 5분)")
									document.getElementById("mCheck").style.display = 'block';
					  		}
					  		else {
					  			alert("다시 시도해주세요");
					  		}								
					  	},
					  	error : function() {
					  		alert("전송 오류~~");
					  	}
					  });	
			    }
			}
			
			// 이메일 인증확인
			function mailCheckOk() {
				
	    	let email1 = myform.email1.value;
	    	let email2 = myform.email2.value;
	      let riderEmail = email1 + '@' + email2;
	      
	      if(email1.trim()=="") {
					alert("이메일을 입력하세요");
					myform.email1.focus();
					return false;
				}
				
				let emailCode = myform.emailCode.value;
			      
				$.ajax({
				  	type   : "post",
				  	url    : "${ctp}/rider/riderUpdateEmailCheckOk",
				  	data   : {emailCode : emailCode} ,
				  	async  : false ,
				  	success:function(res) {
				  		if(res == "0") {
				  			document.getElementById("demo5").innerHTML = "<font color = 'red'> 인증번호가 틀립니다! </font>"; 
				  		}
				  		else {
				  			document.getElementById("demo5").innerHTML = "<font color = 'blue'> 이메일 인증 성공! </font>"; 
								emailCheckSw = 1;
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
				<div class="pd-20 card-box mb-50">
					<div class="clearfix">
						<h3 class="text-blue h3" style="text-align: center;">라이더 정보 수정</h3>
					</div>
					<form name="myform" method="post" >
						<div class="form-group">
							<label>아이디</label>
							<input class="form-control" id="riderMid" name="riderMid" value="${vo.riderMid}" type="text" readonly>
						</div>
						<div class="form-group">
							<label>성명</label>
							<input class="form-control" id="riderName" name="riderName" value="${vo.riderName}" type="text">
						</div>
						<div class="form-group">
							<label>나이</label>
							<input class="form-control" id="age" name="age" value="${vo.age}" type="number">
						</div>
						<div class="row">
							<div class="col-md-2 col-sm-12">
								<div class="form-group">
									<label>전화번호1</label>
									<select class="custom-select col-12" name="tel1">
										<option selected="010">010</option>
									</select>
								</div>
							</div>
							<div class="col-md-2 col-sm-12">
								<div class="form-group">
									<label>전화번호2</label>
									<input type="number" class="form-control" max="9999" value="${tel2}" name="tel2">
								</div>
							</div>
							<div class="col-md-2 col-sm-12">
								<div class="form-group">
									<label>전화번호3</label>
									<input type="number" class="form-control" max="9999"  value="${tel3}" name="tel3">
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-md-2 col-sm-12">
								<div class="form-group">
									<label>이메일1</label>
									<input class="form-control" id="email1" name="email1" value="${email1}" type="text">
								</div>
							</div>
							<div class="">
									<label></label>
									<div></div>
									<p></p>
									<div></div>
									<div>@</div>
							</div>
							<div class="col-md-2 col-sm-12">
								<div class="form-group">
									<label>이메일2</label>
									<select class="custom-select col-12" name="email2">
								    	<option value="naver.com" ${email2=='naver.com'  ? "selected" : ""} >naver.com</option>
									    <option value="hanmail.net" ${email2=='hanmail.net'  ? "selected" : ""} >hanmail.net</option>
									    <option value="hotmail.com" ${email2=='hotmail.com'  ? "selected" : ""} >hotmail.com</option>
									    <option value="gmail.com" ${email2=='gmail.com'  ? "selected" : ""} >gmail.com</option>
									    <option value="nate.com" ${email2=='nate.com'  ? "selected" : ""} >nate.com</option>
									    <option value="yahoo.com" ${email2=='yahoo.com'  ? "selected" : ""} >yahoo.com</option>
									</select>
								</div>
							</div>
							<div class="col-md-2 col-sm-12 ">
								<label></label>
									<div></div>
								<div class="form-group">
									<input type="button" value="인증문자보내기" onclick="mailCheck()" class="btn btn-secondary mt-2"style="width: 150px;"/>
								</div>
							</div>
						</div>
						<div class="row" id="mCheck" style="display: none;" >
							<div class="col-md-2 col-sm-12">
								<div class="form-group">
									<label>이메일 인증</label>
									<input class="form-control" id="emailCode" name="emailCode" type="text">
								</div>
							</div>
							<div class="col-md-2 col-sm-12 ">
								<label></label>
									<div></div>
								<div class="form-group">
									<input type="button" value="인증" onclick="mailCheckOk()" class="btn btn-secondary mt-2"style="width: 150px;"/>
								</div>
							</div>
							<div style="font-size: 10px; margin-left: 9%;" id="demo5"></div>
						</div>
						<div class="row">
							<input type="button" value="돌아가기" onclick="location.href='${ctp}/rider/riderMain';" style="float: right;" class="btn btn-secondary ml-3 mr-2" />
							<input type="button" value="회원정보 수정" onclick="updateCheck()" style="float: right;" class="btn btn-success ml-2" />
						</div>
						<input type="hidden" name="riderEmail" />
						<input type="hidden" name="riderPhone" />
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
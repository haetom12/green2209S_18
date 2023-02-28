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
		<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
		<script src="${ctp}/js/woo.js"></script>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
		
		<style>
			.login-container {
			    position: relative;
			    margin: 5% auto;
			    max-width: 800px;
			}
			.login-container .loginbox {
			    position: relative;
			    width: 100% !important;
			    height: 185% !important;
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
		  let idCheckSw = 0;
		  let nickCheckSw = 0;
		  let emailCheckSw = 0;
		  
			function JoinCheck() {
		    	// 폼의 유효성 검사~~~~
		    	let regMid = /^[a-z0-9_]{4,20}$/;
		      // let regPwd = /(?=.*[a-zA-Z])(?=.*?[#?!@$%^&*-]).{4,24}/;
		      let regPwd = /(?=.*[0-9a-zA-Z]).{4,20}$/;
		      let regName = /^[가-힣a-zA-Z]+$/;
		      let regEmail =/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
		      let regTel = /\d{2,3}-\d{3,4}-\d{4}$/g;
		      
		      let submitFlag = 0;		// 전송체크버튼으로 값이 1이면 체크완료되어 전송처리한다.

		      // 유효성검사를 위해 폼안의 내용들을 모두 변수에 담는다.
		    	let mid = JoinForm.mid.value;
		    	let pwd = JoinForm.pwd.value;
		    	let memberName = JoinForm.memberName.value;
		    	let memberNickName = JoinForm.memberNickName.value;
		    	let email1 = JoinForm.email1.value;
		    	let email2 = JoinForm.email2.value;
		      let email = email1 + '@' + email2;
		      let tel1 = JoinForm.tel1.value;
		      let tel2 = JoinForm.tel2.value;
		      let tel3 = JoinForm.tel3.value;
		    	let tel = tel1 + "-" + tel2 + "-" + tel3;
		    	
		    	// 유효성 검사체크처리한다.(필수 입력필드는 꼭 처리해야 한다.)
		    	if(mid.trim()=="") {
		        alert("아이디를 입력하세요!");
		        JoinForm.mid.focus();
		        return false;
		      }
		    	else if(!regMid.test(mid)) {
		        alert("아이디는 영문 소문자와 숫자, 언더바(_)만 사용가능합니다.(길이는 4~20자리까지 허용)");
		        JoinForm.mid.focus();
		        return false;
		      }
		    	else if(pwd.trim()=="") {
			        alert("비밀번호를 입력하세요!");
			        JoinForm.pwd.focus();
			        return false;
			      }
		      else if(!regPwd.test(pwd)) {
		        alert("비밀번호는 1개이상의 문자와 특수문자 조합의 6~24 자리로 작성해주세요.");
		        JoinForm.pwd.focus();
		        return false;
		      }
		      else if(memberName.trim()=="") {
		        alert("성명을 입력하세요.");
		        JoinForm.memberName.focus();
		        return false;
		      }
		      else if(!regName.test(memberName)) {
		        alert("성명은 한글과 영문대소문자만 사용가능합니다.");
		        JoinForm.memberName.focus();
		        return false;
		      }
		      else if(!regEmail.test(email)) {
		        alert("이메일 형식에 맞지않습니다.");
		        JoinForm.email1.focus();
		        return false;
		      }
		      else if(tel2 == "" || tel3 == "") {
		    	  alert("전화번호를 입력하세요.");
		        JoinForm.tel2.focus();
		        return false;
		    	}
		    	
		    	// 선택사항인 전화번호가 입력되어서 전송되었다면 전화번호형식을 체크해 준다.
		      if(tel2 != "" || tel3 != "") {
			      if(!regTel.test(tel)) {
			        alert("전화번호 형식에 맞지않습니다.(000-0000-0000)");
			        JoinForm.tel2.focus();
			        return false;
			      }
			      else {
			    	  submitFlag = 1;
			      }
		      }
		      else {	// 전화번호를 입력하지 않을시 DB에는 '010- - '의 형태로 저장하고자 한다.
		    	  tel2 = " ";
		    	  tel3 = " ";
		    	  tel = tel1 + '-' + tel2 + '-' + tel3;
		    	  submitFlag = 1;
		      }
		    	
		  		/* // 전송전에 '주소'를 하나로 묶어서 전송처리 준비한다.
		  		let postcode = JoinForm.postcode.value + " ";
		  		let roadAddress = JoinForm.roadAddress.value + " ";
		  		let detailAddress = JoinForm.detailAddress.value + " ";
		  		let extraAddress = JoinForm.extraAddress.value + " ";
		  		JoinForm.address.value = postcode + "/" + roadAddress + "/" + detailAddress + "/" + extraAddress + "/"; */
		  		
		  	// 전송전에 '주소'를 하나로 묶어서 전송처리 준비한다.
		  		let sample5_address = JoinForm.sample5_address.value + " ";
		  		let sample5_address2 = JoinForm.sample5_address2.value + " ";
		  		JoinForm.address.value = sample5_address + "/" + sample5_address2;
		  		
		  		// 전송전에 모든 체크가 끝나서 submitFlag가 1이되면 서버로 전송한다.
		    	if(submitFlag == 1) {
		    		if(idCheckSw == 0) {
		    			alert("아이디 중복체크버튼을 눌러주세요!");
		    			document.getElementById("midBtn").focus();
		    			return false;
		    		}
		    		else if(nickCheckSw == 0) {
		    			alert("닉네임 중복체크버튼을 눌러주세요!");
		    			document.getElementById("memberNickName").focus();
		    			return false;
		    		}
		    		else if(emailCheckSw == 0) {
		    			alert("이메일 인증은 필수입니다!");
		    			document.getElementById("email1").focus();
		    			return false;
		    		}
		    		else {
			  			// 묶여진 필드(email/tel)를 폼태그안에 hidden태그의 값으로 저장시켜준다.
			  			JoinForm.email.value = email;
			  			JoinForm.tel.value = tel;
			  			
			  			JoinForm.submit();
		    		}
		    	}
		    	else {
		    		alert("회원가입 실패~~");
		    	}
		    }
			
			// id 중복체크
			  function idCheck() {
			  	let mid = JoinForm.mid.value;
			  	
			  	if(mid.trim() == "") {
			  		alert("아이디를 입력하세요!");
			  		JoinForm.mid.focus();
			  		return false;
			  	}
			  	else {
				  	$.ajax({
					  	type   : "post",
					  	url    : "${ctp}/member/memIdCheck",
					  	data   : {mid : mid} ,
					  	success:function(res) {
					  		if(res == "1") {
					  			document.getElementById("demo").innerHTML = "<font color = 'red'> 존재하는 아이디입니다! </font>"; 
					  			
					  		}
					  		else {
					  			document.getElementById("demo").innerHTML = "<font color = 'blue'><b>사용가능한 아이디입니다!</b> </font>";  
					  			$("#mid").attr("readonly","readonly");
					  			idCheckSw = 1;
					  		}
					  	},
					  	error : function() {
					  		alert("전송 오류~~");
					  	}
					  });	
			    }
			  }
			
			// 닉네임 중복체크
			  function nickNameCheck() {
			  	let memberNickName = JoinForm.memberNickName.value;
			  	
			  	if(memberNickName.trim() == "") {
			  		alert("닉네임를 입력하세요!");
			  		JoinForm.memberNickName.focus();
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
				let email1 = JoinForm.email1.value;
	    	let email2 = JoinForm.email2.value;
	      let email = email1 + '@' + email2;
	      
				
				if(email1.trim()=="") {
					alert("이메일을 먼저 입력하세요.");
					return false;	
				}
				else {
				  	$.ajax({
					  	type   : "post",
					  	url    : "${ctp}/member/memberEmailCheck",
					  	data   : {email : email} ,
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
				
				let emailCode = JoinForm.emailCode.value;
			      
				$.ajax({
				  	type   : "post",
				  	url    : "${ctp}/member/memberEmailCheckOk",
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
    <main class="main" id="top">
		<jsp:include page="/WEB-INF/views/include/nav.jsp"></jsp:include>		
		<section class="py-5 overflow-hidden" style="background-color: #f4e285">
			<div class="join-form login-container animated fadeInDown bootstrap snippets bootdeys">
				<form name="JoinForm" method="post">
	      	<div class="loginbox bg-white">
            <div class="fw-bold text-danger fs-3 fs-lg-5 lh-sm my-2 mt-2 text-center"><font size="20pt">회원가입</font></div>
            <div class="loginbox-or">
                <div class="or-line"></div>
            </div>
            <div class="loginbox-textbox fw-bold text-danger fs-3 fs-lg-1 lh-sm" style="margin-left: 7%;">아이디</div>
            <div class="loginbox-textbox input-group" style="width: 85.5%; margin: 0 auto;">
                <input type="text" class="form-control rounded" id="mid" name="mid" placeholder="아이디를 입력하세요" style="width: 100px;" required>&nbsp;
                <input type="button" class="btn btn-primary" id="midBtn" onclick="idCheck()" style="width: 20%; text-align: center;"  value="중복체크">
            </div>
            <div style="font-size: 10px; margin-left: 9%;" id="demo"></div>
            <div class="loginbox-textbox fw-bold text-danger fs-3 fs-lg-1 lh-sm" style="margin-left: 7%;">비밀번호</div>
            <div class="loginbox-textbox">
                <input type="password" class="form-control" id="pwd" name="pwd" placeholder="비밀번호를 입력하세요"  style="width: 85%; margin: 0 auto;" required>
            </div>
            <div class="loginbox-textbox fw-bold text-danger fs-3 fs-lg-1 lh-sm" style="margin-left: 7%;">닉네임</div>
            <div class="loginbox-textbox input-group" style="width: 85.5%; margin: 0 auto;">
                <input type="text" class="form-control" id="memberNickName" name="memberNickName" placeholder="닉네임를 입력하세요" style="width: 100px;" required>&nbsp;
                <input type="button" class="btn btn-primary" id="midBtn" onclick="nickNameCheck()" style="width: 20%; text-align: center;"  value="중복체크">
            </div>
            <div style="font-size: 10px; margin-left: 9%;" id="demo3"></div>
            <div class="loginbox-textbox fw-bold text-danger fs-3 fs-lg-1 lh-sm" style="margin-left: 7%;">성명</div>
            <div class="loginbox-textbox">
                <input type="text" class="form-control" id="memberName" name="memberName" placeholder="성명을 입력하세요"  style="width: 85%; margin: 0 auto;" required>
            </div>
            <div class="loginbox-textbox fw-bold text-danger fs-3 fs-lg-1 lh-sm" style="margin-left: 7%;">생년월일</div>
            <div class="container-fluid px-1 px-sm-5 mx-auto">
            	<input type="date" name="birthday" value="<%=java.time.LocalDate.now()%>" class="form-control mb-2" style="width: 30%; margin-left: 3%" >
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
							  <input type="text" class="form-control" placeholder="Email을 입력하세요." id="email1" name="email1" required />&nbsp;<span style="font-size: 1.5rem">@</span>&nbsp;
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
							  &nbsp;
							  <input type="button" value="인증문자보내기" onclick="mailCheck()" class="btn btn-secondary" style="width: 150px;"/>
							</div>
							<div class="loginbox-textbox input-group" id="mCheck" style="margin: 0 auto; display: none;">
								<input type="text" placeholder="이메일을 확인하세요" id="emailCode" name="emailCode" style="width: 150px;" required />
							  <input type="button" value="인증" onclick="mailCheckOk()" class="btn btn-primary" style="width: 70px;"/>
							</div>
							<div style="font-size: 10px; margin-left: 9%;" id="demo5"></div>
            </div>
            
            <div class="loginbox-submit text-center">
                <input type="button" onclick="JoinCheck()" class="btn btn-success btn-block mt-3" value="회원가입" style="width: 92%">
            </div>
            <div class="loginbox-submit text-center">
                <input type="button" onclick="location.href='${ctp}/member/JoinSelect';" class="btn btn-primary btn-block" value="돌아가기" style="width: 92%">
            </div>
	        </div>
	        <input type="hidden" name="tel"/>
    			<input type="hidden" name="email"/>
    			<input type="hidden" name="memberLatitude"/>
    			<input type="hidden" name="memberLongitude"/>
    			<input type="hidden" name="address"/>
        </form>
    </div>
		</section>
		
		<jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>
		
    </main>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
		<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=ac23d1dc8d935cead13bb8f2c930e90f&libraries=services"></script>
		<script>
		    var mapContainer = document.getElementById('map'), // 지도를 표시할 div
		        mapOption = {
		            center: new daum.maps.LatLng(37.537187, 127.005476), // 지도의 중심좌표
		            level: 5 // 지도의 확대 레벨
		        };
		
		    //지도를 미리 생성
		    var map = new daum.maps.Map(mapContainer, mapOption);
		    //주소-좌표 변환 객체를 생성
		    var geocoder = new daum.maps.services.Geocoder();
		    //마커를 미리 생성
		    var marker = new daum.maps.Marker({
		        position: new daum.maps.LatLng(37.537187, 127.005476),
		        map: map
		    });
		
		    function sample5_execDaumPostcode() {
		      new daum.Postcode({
		        oncomplete: function(data) {
		          var addr = data.address; // 최종 주소 변수
		
		          // 주소 정보를 해당 필드에 넣는다.
		          document.getElementById("sample5_address").value = addr;
		          // 주소로 상세 정보를 검색
		          geocoder.addressSearch(data.address, function(results, status) {
	              // 정상적으로 검색이 완료됐으면
	              if (status === daum.maps.services.Status.OK) {
	
                  var result = results[0]; //첫번째 결과의 값을 활용

                  // 해당 주소에 대한 좌표를 받아서
                  var coords = new daum.maps.LatLng(result.y, result.x);
                  
                  // 히든으로 좌표값을 저장한다
                  JoinForm.memberLatitude.value = result.y;
  		    				JoinForm.memberLongitude.value = result.x;
                  
                  // 지도를 보여준다.
                  mapContainer.style.display = "block";
                  map.relayout();
                  // 지도 중심을 변경한다.
                  map.setCenter(coords);
                  // 마커를 결과값으로 받은 위치로 옮긴다.
                  marker.setPosition(coords)
	              }
	            });
	          }
		      }).open();
		    }
		</script>
    
    
    <script src="${ctp}/vendors/@popperjs/popper.min.js"></script>
    <script src="${ctp}/vendors/bootstrap/bootstrap.min.js"></script>
    <script src="${ctp}/vendors/is/is.min.js"></script>
    <script src="https://polyfill.io/v3/polyfill.min.js?features=window.scroll"></script>
    <script src="${ctp}/vendors/fontawesome/all.min.js"></script>
    <script src="${ctp}/assets/js/theme.js"></script>

  </body>

</html>

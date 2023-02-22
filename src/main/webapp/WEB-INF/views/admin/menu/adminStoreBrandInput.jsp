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
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>

		<script>
		  'use strict';
		  let brandCheckSw = 0;
			
			
		  //  체크후 서버로 전송(submit)
		  function fCheck() {
			  let brandName = myform.brandName.value;
			  let storePart = myform.storePart.value;
				
				if(storePart.trim() == "") {
					alert("브랜드 종류를 선택하세요");
					myform.storePart.focus();
					return false;
				}
				else if(brandName.trim() == "") {
					alert("브랜드 명을 입력하세요");
					myform.brandName.focus();
					return false;
				}
				else if(brandCheckSw == 0) {
					alert("브랜드 명 중복체크는 필수입니다!");
					myform.brandName.focus();
					return false;
				}
				else {
					myform.submit();
				}
		  }
		  
			//카테코리 이름 중복체크
		  function brandCheck() {
			  let brandName = myform.brandName.value;
			  let storePart = myform.storePart.value;
			  
		  	if(brandName.trim() == "") {
		  		alert("프랜차이즈명을 입력하세요!");
		  		myform.brandName.focus();
		  		return false;
		  	}
		  	else {
			  	$.ajax({
				  	type   : "post",
				  	url    : "${ctp}/admin/storebrandNameCheck",
				  	data   : {
				  		storePart : storePart,
				  		brandName : brandName
				  		} ,
				  	success:function(res) {
				  		if(res == "1") {
				  			document.getElementById("demo2").innerHTML = "<font color = 'red'> 존재하는 프랜차이즈입니다! </font>"; 
				  			
				  		}
				  		else {
				  			document.getElementById("demo2").innerHTML = "<font color = 'blue'><b>사용가능한 프랜차이즈입니다!</b> </font>";  
				  			$("#brandName").attr("readonly","readonly");
				  			brandCheckSw = 1;
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
<body>

	<jsp:include page="/WEB-INF/views/admin/adminNav.jsp"></jsp:include>
	
	<!-- =============================================== -->

	<div class="main-container">
		<div class="container">
				<div class="pd-20 card-box mb-50">
					<div class="clearfix">
						<h3 class="text-blue h3" style="text-align: center;">브랜드 등록</h3>
					</div>
					<form name="myform" method="post" enctype="multipart/form-data">
						<div class="form-group">
							<label>브랜드 종류</label><br />
							<select class="custom-select col-12" name="storePart" style="width: 300px;">
								<c:forEach var="vo" items="${vos}">
						    	<option value="${vo.storePart}" selected>${vo.storePart}</option>
						    </c:forEach>
							</select>
						</div>
						<div class="form-group">
							<label>브랜드 명</label>
							<input class="form-control mb-2" name="brandName" id="brandName" placeholder="브랜드명을 입력하세요" style="width: 40%;" type="text">
							<div style="font-size: 15px;" id="demo2"></div>
							<input type="button" class="btn btn-primary mb-2"  id="midBtn2" onclick="brandCheck()" style="width: 15%; text-align: center;"  value="중복체크">
						</div>
						<div class="form-group">
							<div class="row">
								<input type="button" value="돌아가기" onclick="location.href='${ctp}/admin/adminShopCategory';"  class="btn btn-secondary ml-3 mr-2" />
								<input type="button" value="카테고리 등록" onclick="fCheck()"  class="btn btn-success ml-2" />
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
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
		  let tagCheckSw = 0;
			
		  //  체크후 서버로 전송(submit)
		  function fCheck() {
			  let foodTag = myform.foodTag.value;
			  let brandName = myform.brandName.value;

				
				if(foodTag.trim() == "") {
					alert("태그를 입력하세요");
					myform.categoryStoreCode.focus();
					return false;
				}
				else if(tagCheckSw == 0) {
					alert("태그 중복체크는 필수입니다!");
					myform.foodTag.focus();
					return false;
				}
				else {
					location.href="${ctp}/admin/adminStoreTagInput2?idx=${vo.idx}&foodTag="+foodTag+"&brandName="+brandName;
				}
		  }
			
			//카테코리 이름 중복체크
		  function tagCheck() {
			  let foodTag = myform.foodTag.value;
			  let brandName = myform.brandName.value;
			  
		  	if(foodTag.trim() == "") {
		  		alert("태그명을 입력하세요!");
		  		myform.foodTag.focus();
		  		return false;
		  	}
		  	else {
			  	$.ajax({
				  	type   : "post",
				  	url    : "${ctp}/admin/adminFoodTagCheck",
				  	data   : {
				  		brandName : brandName,
				  		foodTag : foodTag
				  	} ,
				  	success:function(res) {
				  		if(res == "1") {
				  			document.getElementById("demo2").innerHTML = "<font color = 'red'> 존재하는 태그입니다! </font>"; 
				  			
				  		}
				  		else {
				  			document.getElementById("demo2").innerHTML = "<font color = 'blue'><b>사용가능한 태그입니다!</b> </font>";  
				  			$("#storePart").attr("readonly","readonly");
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
							<label>브랜드 명</label>
							<input class="form-control mb-2" name="brandName" id="brandName" value="${vo.brandName}" style="width: 40%;" type="text" readonly>
						</div>
						<div class="form-group">
							<label>음식 태그</label>
							<input class="form-control mb-2" name="foodTag" id="foodTag" placeholder="음식 태그를 입력하세요" style="width: 40%;" type="text">
							<div style="font-size: 15px;" id="demo2"></div>
							<input type="button" class="btn btn-primary mb-2"  id="midBtn2" onclick="tagCheck()"" style="width: 15%; text-align: center;"  value="중복체크">
						</div>
						<div class="form-group">
							<div class="row">
								<input type="button" value="돌아가기" onclick="location.href='${ctp}/admin/storeTagList?brandName=${vo.brandName}';"  class="btn btn-secondary ml-3 mr-2" />
								<input type="reset" value="다시쓰기" class="btn btn-warning"/>
								<input type="button" value="음식 태그 등록" onclick="fCheck()"  class="btn btn-success ml-2" />
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
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
				else if(foodCheckSw == 0) {
					alert("메뉴명 중복체크는 필수입니다!");
					myform.foodName.focus();
					return false;
				}

				let fileSize = document.getElementById("fName").files[0].size; //자바스크립트 명령어
				
				if(uExt != "JPG" && uExt != "PNG" && uExt != "GIF" && uExt != "ZIP" && uExt != "HWP" &&  uExt != "PPTX" &&  uExt != "PPT" ) {
					alert("업로드 가능한 파일은 'JPG/GIF/PNG/HWP/PPT/PPTX'입니다.");
					return false;
				}
				else if(fileSize > maxSize) {
					alert("업로드할 파일의 최대용량은 2MByte 입니다.");
					return false;
				}
				else {
					myform.submit();
				}
		  }
		  
			//메뉴 이름 중복체크
		  function foodNameCheck() {
			  let foodName = myform.foodName.value;
			  let brandName = myform.brandName.value;
			  
		  	if(foodName.trim() == "") {
		  		alert("메뉴명을 입력하세요!");
		  		myform.foodName.focus();
		  		return false;
		  	}
		  	else {
			  	$.ajax({
				  	type   : "post",
				  	url    : "${ctp}/admin/foodNameCheck",
				  	data   : {
				  		foodName : foodName,
				  		brandName : brandName
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
		</script>
	
</head>
<body>

	<jsp:include page="/WEB-INF/views/admin/adminNav.jsp"></jsp:include>
	
	<!-- =============================================== -->

	<div class="main-container">
		<div class="container">
				<div class="pd-20 card-box mb-50">
					<div class="clearfix">
						<h3 class="text-blue h3" style="text-align: center;">메뉴 등록</h3>
					</div>
					<form name="myform" method="post" enctype="multipart/form-data">
						<div class="form-group">
							<label>브랜드 이름</label>
							<input class="form-control mb-2" name="brandName" id="brandName" value="${vo.brandName}"   type="text" readonly>
						</div>
						<div class="form-group">
							<label>메뉴 명</label>
							<input class="form-control mb-2" name="foodName" id="foodName" placeholder="메뉴명 입력하세요"  type="text">
							<div style="font-size: 15px;" id="demo2"></div>
							<input type="button" class="btn btn-primary mt-1" id="midBtn" onclick="foodNameCheck()" style="width: 15%; text-align: center;"  value="중복체크">
						</div>
						<div class="form-group">
							<label>음식 태그</label><br />
							<select class="custom-select col-12" name="foodTag" style="width: 300px;">
								<c:forEach var="vo" items="${vos}">
						    	<option value="${vo.foodTag}" >${vo.foodTag}</option>
						    </c:forEach>
							</select>
						</div>
						<div class="form-group">
							<label>가격</label>
							<input class="form-control mb-2" name="price" id="price" placeholder="가격을 입력하세요"  type="number">
						</div>
						<div class="form-group">
							<label>추가메뉴</label><br />
							<div class="btn-group btn-group-toggle" data-toggle="buttons">
								<label class="btn btn-outline-secondary">
									<input type="radio" name="subMenu" autocomplete="off" value="X" checked="checked"> 없음
								</label>
								<label class="btn btn-outline-secondary">
									<input type="radio" name="subMenu" autocomplete="off" value="O"> 있음
								</label>
							</div>
						</div>
						<div class="form-group">
							<label>메뉴 설명</label>
							<textarea class="form-control" name="foodInfo" id="foodInfo" placeholder="메뉴 설명을 입력하세요" ></textarea>
						</div>
						<div>
				   		<label for="file">메뉴 이미지</label>
			        <input type="file" name="fName" id="fName" class="form-control-file border" accept=".jpg,.gif,.png,.jpeg" required />
			        (업로드 가능파일:jpg, jpeg, gif, png)
					  </div>
						<div class="form-group mt-4">
							<div class="row">
								<input type="button" value="돌아가기" onclick="location.href='${ctp}/admin/storeMenuList?brandName=${vo.brandName}';"  class="btn btn-secondary ml-3 mr-2" />
								<input type="reset" value="다시쓰기" class="btn btn-warning"/> &nbsp;
								<input type="button" value="메뉴 등록" onclick="fCheck()"  class="btn btn-success ml-2" />
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
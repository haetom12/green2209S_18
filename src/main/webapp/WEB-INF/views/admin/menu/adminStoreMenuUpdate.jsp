<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<% pageContext.setAttribute("newLine", "\n"); %>
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
	  
	  $(document).ready(function(){	    
		  let saleOk = $(sale).val();
			
			if(saleOk == "O") {
				document.getElementById('salePrice').readOnly = false;
			}
			else {
				document.getElementById('salePrice').value = 0;
				document.getElementById('salePrice').readOnly = true;
			}
		});
	  
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
			else if(foodName != '${vo.foodName}') {
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
		  let brandName = myform.brandName.value;
		  let oldName = '${vo.foodName}';
		  
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
<body>

	<jsp:include page="/WEB-INF/views/admin/adminNav.jsp"></jsp:include>
	
	<!-- =============================================== -->

	<div class="main-container">
		<div class="container">
			<div class="pd-20 card-box mb-50">
				<div class="clearfix">
					<h3 class="text-blue h3" style="text-align: center;">메뉴 수정</h3>
				</div>
				<form name="myform" method="post" enctype="multipart/form-data">
					<div class="form-group">
						<label>브랜드 이름</label>
						<input class="form-control mb-2" name="brandName" id="brandName" value="${vo.brandName}"   type="text" readonly>
					</div>
					<div class="form-group">
						<label>메뉴 명</label>
						<input class="form-control mb-2" name="foodName" id="foodName" value="${vo.foodName}"   type="text">
						<div style="font-size: 15px;" id="demo2"></div>
						<input type="button" class="btn btn-primary mt-1" id="midBtn" onclick="foodNameCheck()" style="width: 15%; text-align: center;"  value="중복체크">
					</div>
					<div class="form-group">
						<label>음식 태그</label><br />
						<select class="custom-select col-12" name="foodTag" style="width: 300px;">
							<c:forEach var="cVo" items="${vos}">
					    	<option value="${cVo.foodTag}"  ${cVo.foodTag==vo.foodTag  ? "selected" : ""}  >${cVo.foodTag}</option>
					    </c:forEach>
						</select>
					</div>
					<div class="form-group">
						<label>가격</label>
						<input class="form-control mb-2" name="price" id="price" value="${vo.price}" type="number">
					</div>
					<div class="form-group">
						<label>품절여부</label><br />
						<div class="btn-group btn-group-toggle" data-toggle="buttons">
							<label class="btn btn-outline-secondary">
								<input type="radio" name="runOut" autocomplete="off" value="X" ${vo.runOut == "X"  ? "checked" : ""}> 품절X
							</label>
							<label class="btn btn-outline-secondary">
								<input type="radio" name="runOut" autocomplete="off" value="O" ${vo.runOut == "O"  ? "checked" : ""}> 품절O
							</label>
						</div>
					</div>
					<div class="form-group">
						<label>세일 여부</label><br />
						<select class="custom-select col-12" name="sale" id="sale" onchange="saleCheck(this)" style="width: 300px;">
							<option value="X"  ${vo.sale == "X"  ? "selected" : ""}>X</option>
		    			<option value="O"  ${vo.sale == "O"  ? "selected" : ""}>O</option>
						</select>
					</div>
					<div class="form-group">
						<label>할인가격</label>
						<input class="form-control mb-2" name="salePrice" id="salePrice" value="${vo.salePrice}" placeholder="할인가격을 입력하세요"  min="1"  type="number">
					</div>
					<div class="form-group">
						<label>추가메뉴</label><br />
						<div class="btn-group btn-group-toggle" data-toggle="buttons">
							<label class="btn btn-outline-secondary">
								<input type="radio" name="subMenu" autocomplete="off" value="X" ${vo.subMenu == "X"  ? "checked" : ""}> 없음
							</label>
							<label class="btn btn-outline-secondary">
								<input type="radio" name="subMenu" autocomplete="off" value="O" ${vo.subMenu == "O"  ? "checked" : ""}> 있음
							</label>
						</div>
					</div>
					<div class="form-group">
						<label>메뉴 설명</label>
						<textarea class="form-control" name="foodInfo" id="foodInfo" placeholder="메뉴 설명을 입력하세요" >${fn:replace(vo.foodInfo, '<br/>' , newLine)}</textarea>
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
							<input type="button" value="메뉴 수정" onclick="fCheck()"  class="btn btn-success ml-2" />
						</div>
					</div>
					<input type="hidden" name="menuIdx" value="${vo.menuIdx}" />
				  <input type="hidden" name="pastPhoto" value="${vo.foodPhoto}" />
				  <input type="hidden" name="pastFoodName" value="${vo.foodName}" />
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
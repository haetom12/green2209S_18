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
  let codeCheckSw = 0;
  let categoryCheckSw = 0;
	
	
  //  체크후 서버로 전송(submit)
  function fCheck() {
	  let categoryStoreCode = myform.categoryStoreCode.value;
	  let storePart = myform.storePart.value;
		let fName = myform.fName.value;
		let ext = fName.substring(fName.lastIndexOf(".")+1); // 확장자 발췌
		let uExt = ext.toUpperCase();
		let maxSize = 1024 * 1024 * 2;   // 업로드 가능한 최대파일의 용량은 2MByte로 한다.

		
		if(categoryStoreCode.trim() == "") {
			alert("카테고리 코드를 입력하세요");
			myform.categoryStoreCode.focus();
			return false;
		}
		else if(storePart.trim() == "") {
			alert("카테고리 명을 입력하세요");
			myform.storePart.focus();
			return false;
		}
		else if(categoryStoreCode != '${vo.categoryStoreCode}') {
			if(codeCheckSw == 0) {
				alert("카테고리 코드 중복체크는 필수입니다!");
				myform.categoryStoreCode.focus();
				return false;
			}
		}
		else if(storePart != '${vo.storePart}') {
			if(categoryCheckSw == 0) {
				alert("카테고리 명 중복체크는 필수입니다!");
				myform.storePart.focus();
				return false;
			}
		}
		
		if(fName.trim() != "") {
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
		else {
			myform.submit();
		}
  }
  
	//코드 중복체크
  function CodeCheck() {
	  let categoryStoreCode = myform.categoryStoreCode.value;
	  let storePart = myform.storePart.value;
	  
  	if(categoryStoreCode.trim() == "") {
  		alert("카테코리 코드를 입력하세요!");
  		myform.categoryStoreCode.focus();
  		return false;
  	}
  	else {
	  	$.ajax({
		  	type   : "post",
		  	url    : "${ctp}/admin/categoryCodeCheck",
		  	data   : {categoryStoreCode : categoryStoreCode} ,
		  	success:function(res) {
		  		if(res == "1") {
		  			document.getElementById("demo").innerHTML = "<font color = 'red'> 존재하는 코드입니다! </font>"; 
		  			
		  		}
		  		else {
		  			document.getElementById("demo").innerHTML = "<font color = 'blue'><b>사용가능한 코드입니다!</b> </font>";  
		  			$("#categoryStoreCode").attr("readonly","readonly");
		  			codeCheckSw = 1;
		  		}
		  	},
		  	error : function() {
		  		alert("전송 오류~~");
		  	}
		  });	
    }
  }
	
	//카테코리 이름 중복체크
  function categoryCheck() {
	  let categoryStoreCode = myform.categoryStoreCode.value;
	  let storePart = myform.storePart.value;
	  
  	if(storePart.trim() == "") {
  		alert("카테고리명을 입력하세요!");
  		myform.storePart.focus();
  		return false;
  	}
  	else {
	  	$.ajax({
		  	type   : "post",
		  	url    : "${ctp}/admin/categoryCodeCheck2",
		  	data   : {storePart : storePart} ,
		  	success:function(res) {
		  		if(res == "1") {
		  			document.getElementById("demo2").innerHTML = "<font color = 'red'> 존재하는 카테고리입니다! </font>"; 
		  			
		  		}
		  		else {
		  			document.getElementById("demo2").innerHTML = "<font color = 'blue'><b>사용가능한 카테고리입니다!</b> </font>";  
		  			$("#storePart").attr("readonly","readonly");
		  			categoryCheckSw = 1;
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
						<h3 class="text-blue h3" style="text-align: center;">카테고리 등록</h3>
					</div>
					<form name="myform" method="post" enctype="multipart/form-data" action="${ctp}/admin/adminUpdateCategoryOk" >
						<div class="form-group">
							<label>분류 코드</label>
							<input class="form-control mb-2" name="categoryStoreCode" id="categoryStoreCode" value="${vo.categoryStoreCode}" style="width: 40%;" type="text" >
							<input type="button" class="btn btn-primary mb-2" id="midBtn" onclick="CodeCheck()" style="width: 15%; text-align: center;"  value="중복체크">
							<div style="font-size: 15px;" id="demo"></div>
						</div>
						<div class="form-group">
							<label>카테고리</label>
							<input class="form-control mb-2" name="storePart" id="storePart" value="${vo.storePart}" style="width: 40%;" type="text">
							<input type="button" class="btn btn-primary mb-2"  id="midBtn2" onclick="categoryCheck()" style="width: 15%; text-align: center;"  value="중복체크">
							<div style="font-size: 15px;" id="demo2"></div>
						</div>
						<div class="form-group">
							<label>메인이미지 (업로드 가능파일:jpg, jpeg, gif, png) </label>
							<input type="file" name="fName" id="fName" class="form-control-file form-control height-auto" accept=".jpg,.gif,.png,.jpeg" required>
						</div>
						<div class="form-group">
							<div class="row">
								<input type="button" value="돌아가기" onclick="location.href='${ctp}/admin/adminShopCategory';"  class="btn btn-secondary ml-3 mr-2" />
								<input type="reset" value="다시쓰기" class="btn btn-warning"/> &nbsp;
								<input type="button" value="카테고리 수정" onclick="fCheck()"  class="btn btn-success ml-2" />
							</div>
						</div>
					   <input type="hidden" name="pastPhoto" value="${vo.categoryPhoto}" />
	 					 <input type="hidden" name="pastCode" value="${vo.categoryStoreCode}" />
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
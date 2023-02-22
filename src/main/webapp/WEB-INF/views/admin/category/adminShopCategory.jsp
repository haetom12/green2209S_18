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
	<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
	<link rel="apple-touch-icon" sizes="180x180" href="${ctp}/vendors/images/apple-touch-icon.png">
	<link rel="icon" type="image/png" sizes="32x32" href="${ctp}/vendors/images/favicon-32x32.png">
	<link rel="icon" type="image/png" sizes="16x16" href="${ctp}/vendors/images/favicon-16x16.png">

	<!-- Mobile Specific Metas -->
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">

	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
	<!-- Google Font -->
	<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
	<!-- CSS -->

	<script>
		'use strict';
		
		function drugSearch() {
	    	let searchString = $("#searchString").val();
	    	
	    	if(searchString.trim() == "") {
	    		alert("찾고자 하는 검색어를 입력하세요!");
	    		drugform.searchString.focus();
	    	}
	    	else {
	    		drugform.submit();
	    	}
	    }
		function DelCheck(storePart) {
	    	let ans = confirm("선택된 카테고리를 삭제하시겠습니까?");
	    	if(!ans) return false;
	    	   	
	    	$.ajax({
	    		type   : "post",
	    		url    : "${ctp}/admin/adminCategoryDelete",
	    		data   : {storePart : storePart},
	    		success:function(res) {
	    			if(res == "0") {
	    				alert("하위항목이 있기에 삭제할수 없습니다.\n하위항목을 먼저 삭제해 주세요.");
	    			}
	    			else {
	    				alert("카테고리가 삭제 되었습니다!");
	    				location.reload();
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
	<jsp:include page="/WEB-INF/views/admin/adminNav.jsp"></jsp:include>
	
	<!-- =============================================== -->

	<div class="main-container">
		<div class="pd-ltr-20 xs-pd-20-10">
			<div class="min-height-200px">
				<div class="card-box mb-30">
					<div class="pd-20">
						<h3 class="h3 text-center">카테고리 목록</h3>
					</div>
					<div class="pb-20">
						<button type="button" onclick="location.href='${ctp}/admin/adminCategoryInput';" class="btn btn-primary mb-2 ml-2">새 카테고리 등록</button>
						<table class="table hover">
							<thead>
								<tr class="text-center">
					        <th>카테코리 코드</th>
					        <th>카테고리 분류</th>
					        <th>프랜차이즈 사진</th>
					        <th>비고</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="vo" items="${vos}" varStatus="st">
									<tr class="text-center">
										<td>${vo.categoryStoreCode}</td>
										<td>${vo.storePart}</td>
										<td><img src="${ctp}/data/categoryPhoto/${vo.categoryPhoto}" style="width:100px;"></td>
							    	<td>
							    	  <input type="button" onclick="location.href='${ctp}/admin/adminUpdateCategory?storePart=${vo.storePart}';" class="btn btn-warning" value="수정" />
							    	  <input type="button" onclick="DelCheck('${vo.storePart}')" class="btn btn-danger" value="삭제" />
						    		</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- js -->
</body>
</html>
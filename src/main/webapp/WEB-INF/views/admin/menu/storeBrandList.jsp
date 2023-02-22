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
	function DelCheck(brandName) {
    	let ans = confirm("선택된 브랜드를 삭제하시겠습니까?");
    	if(!ans) return false;
    	   	
    	$.ajax({
    		type   : "post",
    		url    : "${ctp}/admin/adminBrandDelete",
    		data   : {brandName : brandName},
    		success:function(res) {
    			if(res == "0") {
    				alert("브랜드에 속한 메뉴가 있기에 삭제할수 없습니다.\n메뉴를 먼저 삭제해 주세요.");
    			}
    			else {
    				alert("브랜드가 삭제 되었습니다!");
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
						<h3 class="h3 text-center">가게 브랜드 목록</h3>
					</div>
					<div class="pb-20">
						<button type="button" onclick="location.href='${ctp}/admin/adminStoreBrandInput';" class="btn btn-primary mb-2 ml-3">새 브랜드 등록</button>
						<table class="table hover">
							<thead>
								<tr class="text-center">
					        <th>번호</th>
					        <th>브랜드 분류</th>
					        <th>브랜드 이름</th>	
					        <th>비고</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="vo" items="${vos}" varStatus="st">
									<tr class="text-center">
							    	<td>${st.count}</td>
							    	<td>${vo.storePart}</td>
							    	<td>${vo.brandName}</td>
							    	<td>
							    	 <input type="button" onclick="location.href='${ctp}/admin/adminStoreBrandUpdate?brandName=${vo.brandName}';" class="w3-button w3-round-large w3-green" value="수정" />
							    	 <input type="button" onclick="DelCheck('${vo.brandName}')" class="w3-button w3-round-large w3-red" value="삭제" />
							    	</td>
							    </tr>
						    	<c:set var="curScrStartNo" value="${curScrStartNo - 1}"/>
								</c:forEach>
							</tbody>
						</table>
						<div>
							<input type="button" value="뒤로가기" onclick="location.href='${ctp}/admin/adminMain';" class="btn btn-secondary mt-2 ml-3" />
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- js -->
</body>
</html>
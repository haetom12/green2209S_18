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
	
	<script>
		'use strict';
		
		function deleteTag(foodTag, brandName) {
	    	let ans = confirm("선택된 태그 삭제하시겠습니까?");
	    	if(!ans) return false;
	    	   	
	    	$.ajax({
	    		type   : "post",
	    		url    : "${ctp}/admin/adminTagDelete",
	    		data   : {
	    			foodTag : foodTag,
	    			brandName : brandName
	    		},
	    		success:function(res) {
	    			if(res == "0") {
	    				alert("이 태그에 속해있는 메뉴가 있기에 삭제할수 없습니다.\n하위항목을 먼저 삭제해 주세요.");
	    			}
	    			else {
	    				alert("태그가 삭제 되었습니다!");
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
						<h3 class="h3 text-center">${brandName}의 태그 목록</h3>
					</div>
					<div class="pb-20">
						<button type="button" onclick="location.href='${ctp}/admin/adminStoreTagInput?brandName=${brandName}';" class="btn btn-primary ml-3 mb-3">새 태그 등록</button>
						<table class="table hover">
							<thead>
								<tr class="text-center">
					        <th>번호</th>
					        <th>태그 이름</th>	
					        <th>비고</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="vo" items="${vos}" varStatus="st">
									<tr class="text-center">
							    	<td>${st.count}</td>
							    	<td><font color="blue">${vo.foodTag}</font></td>
							    	<td>
											<input type="button" onclick="location.href='${ctp}/admin/adminStoreTagUpdate?brandName=${vo.brandName}&foodTag=${vo.foodTag}';" class="btn btn-warning" value="태그 수정" />
		    						  <input type="button" onclick="deleteTag('${vo.foodTag}','${vo.brandName}')" class="btn btn-danger" value="태그 삭제" />
							    	</td>
							    </tr>
						    	<c:set var="curScrStartNo" value="${curScrStartNo - 1}"/>
								</c:forEach>
							</tbody>
						</table>
						<div>
							<input type="button" value="뒤로가기" onclick="location.href='${ctp}/admin/storeBrandOptionList';" class="btn btn-secondary mt-2 ml-3" />
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- js -->
</body>
</html>
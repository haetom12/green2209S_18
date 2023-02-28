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
	
	function fCheck(brandName) {
		$.ajax({
    		type   : "post",
    		url    : "${ctp}/admin/adminFoodTagCheck",
    		data   : {brandName : brandName},
    		success:function(res) {
    			if(res == "0") {
    				alert("메뉴등록을 위해선 메뉴태그를 입력해야합니다.\n음식태그 입력창으로 이동합니다.");
    				location.href='${ctp}/admin/adminStoreTagInput?brandName='+brandName;
    			}
    			else {
    				location.href='${ctp}/admin/adminStoreMenuInput?brandName='+brandName;
    			}
    		},
    		error : function() {
    			alert("전송 오류~~");
    		}
    	});
  }
	
	
	function DelCheck(foodName,brandName) {
    	let ans = confirm("선택된 메뉴를 삭제하시겠습니까?");
    	if(!ans) return false;
    	   	
    	$.ajax({
    		type   : "post",
    		url    : "${ctp}/admin/adminMenuDelete",
    		data   : {
    			foodName : foodName,
    			brandName : brandName
    			},
    		success:function(res) {
    		  if(res == "2") {
    				alert("제품이 없는곳을 제외한 모든 곳에서 메뉴를 삭제하였습니다.\n확인이 필요합니다.");
    				location.reload();
    			}
    			else {
    				alert("메뉴가 완전히 삭제 되었습니다!");
    				location.reload();
    			}
    		},
    		error : function() {
    			alert("전송 오류~~");
    		}
    	});
    }
	
    function midSearch() {
        let searchString = myform.searchString.value;
        if(searchString.trim() == "") {
      	  alert("검색어를 입력하세요!");
      	  myform.searchString.focus();
        }
        else {
      	  myform.submit();
        }
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
						<h3 class="h3 text-center">${brandName}의 메뉴 목록</h3>
					</div>
					<div class="pb-20">
						<form name="myform">
					  	<div class="row mb-2">
					  	  <div class="col form-inline ml-2">
					  	    <select name="search" style="width:15%;" class="form-control mr-2">
					  	    	<c:forEach var="tVo" items="${tVos}">
								    	<option value="${tVo.foodTag}" ${search==tVo.foodTag ? "selected" : ""}>${tVo.foodTag}</option>
					  	    	</c:forEach>
					        </select>
					  	    <input type="text" name="searchString" class="form-control mr-1" value="${searchString}" autofocus />&nbsp;
					  	    <input type="hidden" name="brandName"value="${brandName}" autofocus />&nbsp;
					  	    <input type="button" value="메뉴검색" onclick="midSearch();" class="btn btn-primary mr-3" />
					  	    <button type="button" onclick="location.href='${ctp}/admin/storeMenuList?brandName=${brandName}';" class="btn btn-success mr-2">전체검색</button>
					  	  </div>
					  	  <div class="col"><button type="button" onclick="fCheck('${brandName}')" style="float: right;" class="btn btn-primary mr-3">새 메뉴 등록</button></div>
					  	</div>
					  </form>
					
						<table class="table hover">
							<thead>
								<tr class="text-center">
					        <th>번호</th>
					        <th>프랜차이즈 이름</th>
					        <th>메뉴 이름</th>
					        <th>메뉴 태그</th>
					        <th>가격</th>
					        <th>품절여부</th>
					        <th>세일여부</th>
					        <th>할인가격</th>
					        <th>음식 사진</th>
					        <th>추가옵션 여부</th>
					        <th>음식설명</th>
					        <th>비고</th>
								</tr>
							</thead>
							<tbody>
								<c:set var="curScrStartNo" value="${pageVo.curScrStartNo}"/>
								<c:forEach var="vo" items="${vos}" varStatus="st">
						   		<tr class="text-center">
							    	<td>${curScrStartNo}</td>
							    	<td>${vo.brandName}</td>
							    	<td>${vo.foodName}</td>
							    	<td>${vo.foodTag}</td>
							    	<td>${vo.price}</td>
							    	<td>${vo.runOut}</td>
							    	<td>${vo.sale}</td>
							    	<td>${vo.salePrice}</td>
							    	<td><img src="${ctp}/data/adminFoodPhoto/${vo.foodPhoto}" style="width:100px;"></td>
							    	<td>${vo.subMenu}</td>
							    	<td>${vo.foodInfo}</td>
							    	<td>
							    	 <input type="button" onclick="location.href='${ctp}/admin/adminStoreMenuUpdate?brandName=${vo.brandName}&foodName=${vo.foodName}';" class="btn btn-warning" value="수정" />
							    	 <input type="button" onclick="DelCheck('${vo.foodName}','${vo.brandName}')" class="btn btn-danger" value="삭제" />
							    	</td>
							    </tr>
						    	<c:set var="curScrStartNo" value="${curScrStartNo - 1}"/>
								</c:forEach>
							</tbody>
						</table>
						
						<div class="col-lg-2 col-md-4 col-sm-4" style="margin: 0 auto;">
	            <div class="btn-group mb-15" style="margin: 0 auto;">
	              <ul>
	              	<c:if test="${pageVo.pag > 1}">
							      <li class="btn btn-light"><a href="${ctp}/admin/storeMenuList?pageSize=${pageVo.pageSize}&pag=1&search=${search}&searchString=${searchString}&brandName=${brandName}">&lt;&lt;</a></li>
							    </c:if>
	                <c:if test="${pageVo.curBlock > 0}">
							      <li><a class="page-link text-secondary" href="${ctp}/admin/storeMenuList?pageSize=${pageVo.pageSize}&pag=${(pageVo.curBlock-1)*pageVo.blockSize + 1}&search=${search}&searchString=${searchString}&brandName=${brandName} ">&lt;</a></li>
							    </c:if>
	                <c:forEach var="i" begin="${(pageVo.curBlock)*pageVo.blockSize + 1}" end="${(pageVo.curBlock)*pageVo.blockSize + pageVo.blockSize}" varStatus="st">
							      <c:if test="${i <= pageVo.totPage && i == pageVo.pag}">
							    		<li class="btn btn-primary"><a href="${ctp}/admin/storeMenuList?pageSize=${pageVo.pageSize}&pag=${i}&search=${search}&searchString=${searchString}&brandName=${brandName} "><font color="white">${i}</font></a></li>
							    	</c:if>
							      <c:if test="${i <= pageVo.totPage && i != pageVo.pag}">
							    		<li class="btn btn-light"><a href="${ctp}/admin/storeMenuList?pageSize=${pageVo.pageSize}&pag=${i}&search=${search}&searchString=${searchString}&brandName=${brandName} ">${i}</a></li>
							    	</c:if>
							    	<c:if test="${pageVo.curBlock < pageVo.lastBlock}">	
								      <li><a class="btn btn-light"href="${ctp}/admin/storeMenuList?pageSize=${pageVo.pageSize}&pag=${(pageVo.curBlock+1)*pageVo.blockSize + 1}&search=${search}&searchString=${searchString}&brandName=${brandName} ">&gt;</a></li>
								    </c:if>
							    </c:forEach>
							     <c:if test="${pageVo.pag < pageVo.totPage}">
							       <li class="btn btn-light"><a href="${ctp}/admin/storeMenuList?pageSize=${pageVo.pageSize}&pag=${pageVo.totPage}&search=${search}&searchString=${searchString}&brandName=${brandName} ">&gt;&gt;</a></li>
							     </c:if>
	              </ul>
	            </div>
	          </div>
						
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
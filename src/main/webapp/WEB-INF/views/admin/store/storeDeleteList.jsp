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
    
    function ordered() {
    	let order = myform.order.value;
    	let search = myform.search.value;
    	let searchString = myform.searchString.value;
    	
			location.href='${ctp}/admin/storeDeleteList?order='+order+'&search='+search+'&searchString='+searchString;
		}
	
	function DelCheck(storeMid) {
    	let ans = confirm("선택된 가게을 탈퇴시키겠습니까?");
    	if(!ans) return false;
    	   	
    	$.ajax({
    		type   : "post",
    		url    : "${ctp}/admin/adminStoreDeleteOk",
    		data   : {
    			storeMid : storeMid
    			},
    		success:function(res) {
    		  if(res == "0") {
    				alert("가게 탈퇴에 실패하였습니다. 다시 시도해주세요.");
    			}
    			else {
    				alert("가게를 탈퇴 처리하었습니다!");
    				location.reload();
    			}
    		},
    		error : function() {
    			alert("전송 오류~~");
    		}
    	});
    }
	
		function restore(storeMid) {
	    	let ans = confirm("선택된 가게를 영업재개 시키겠습니까?");
	    	if(!ans) return false;
	    	   	
	    	$.ajax({
	    		type   : "post",
	    		url    : "${ctp}/admin/adminStoreRestore",
	    		data   : {
	    			storeMid : storeMid
	    			},
	    		success:function(res) {
	    		  if(res == "0") {
	    				alert("탈퇴 취소에 실패하였습니다.");
	    			}
	    			else {
	    				alert("가게를 복구 처리하였습니다!");
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
						<h3 class="h3 text-center">탈퇴 신청 가게 리스트</h3>
					</div>
					<div class="pb-20">
					
						<form name="myform">
					  	<div class="row mb-2">
					  	  <div class="col form-inline">
					  	    <select name="order" style="width:18%;" onchange="ordered()" class="form-control mr-1">
					          <option value="storeName" ${order=='storeName' ? "selected" : ""} >가게명 순</option>
					          <option value="HostName" ${order=='HostName' ? "selected" : ""} >사장님명 순</option>
					          <option value="storePart" ${order=='storePart' ? "selected" : ""}>카테고리 순</option>
					        </select>
					  	    <select name="search" style="width:15%;" class="form-control mr-1">
					          <option value="storeName" ${search=='storeName' ? "selected" : ""} >가게명</option>
					          <option value="HostName" ${search=='HostName' ? "selected" : ""} >사장님명</option>
					          <option value="storePart" ${search=='storePart' ? "selected" : ""}>카테고리</option>
					          <option value="storeNumber" ${search=='storeNumber' ? "selected" : ""}>전화번호</option>
					        </select>
					  	    <input type="text" name="searchString" class="form-control mr-1" value="${searchString}" autofocus />&nbsp;
					  	    <input type="button" value="개별검색" onclick="midSearch();" class="btn btn-primary" />
					  	  </div>
					  	  <div class="col text-right"><button type="button" onclick="location.href='${ctp}/admin/storeDeleteList';" class="btn btn-success mr-2">전체검색</button></div>
					  	</div>
					  </form>
					  
						<table class="table hover">
							<thead>
								<tr class="text-center">
					        <th>번호</th>
					        <th>가게명</th>
					        <th>카테고리</th>
					        <th>아이디</th>
					        <th>사장님명</th>
					        <th>전화번호</th>
					        <th>이메일</th>
					        <th>가게 주소</th>
					        <th>가입 날짜</th>
					        <th>탈퇴 요청</th>
					        <th>비고</th>
								</tr>
							</thead>
							<tbody>
							<c:set var="curScrStartNo" value="${pageVo.curScrStartNo}"/>
								<c:forEach var="vo" items="${vos}" varStatus="st">
						   		<tr class="text-center">
							    	<td>${curScrStartNo}</td>
							    	<td>${vo.storeName}</td>
							    	<td>${vo.storePart}</td>
							    	<td>${vo.storeMid}</td>
							    	<td>${vo.hostName}</td>
							    	<td>${vo.storeNumber}</td>
							    	<td>${vo.storeEmail}</td>
							    	<td>${vo.storeAddress}</td>
							    	<td>${fn:substring(vo.joinDate,0,10)}</td>
							    	<td>${vo.storeDel}</td>
							    	<td>
							    	 <input type="button" onclick="restore('${vo.storeMid}')" class="btn btn-primary" value="영업 재개" />
							    	 <input type="button" onclick="DelCheck('${vo.storeMid}')" class="btn btn-danger" value="탈퇴 처리" />
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
							      <li class="btn btn-light"><a href="${ctp}/admin/storeDeleteList?pageSize=${pageVo.pageSize}&pag=1&search=${search}&searchString=${searchString}&order=${order}">&lt;&lt;</a></li>
							    </c:if>
	                <c:if test="${pageVo.curBlock > 0}">
							      <li><a class="page-link text-secondary" href="${ctp}/admin/storeDeleteList?pageSize=${pageVo.pageSize}&pag=${(pageVo.curBlock-1)*pageVo.blockSize + 1}&search=${search}&searchString=${searchString}&order=${order}">&lt;</a></li>
							    </c:if>
	                <c:forEach var="i" begin="${(pageVo.curBlock)*pageVo.blockSize + 1}" end="${(pageVo.curBlock)*pageVo.blockSize + pageVo.blockSize}" varStatus="st">
							      <c:if test="${i <= pageVo.totPage && i == pageVo.pag}">
							    		<li class="btn btn-primary"><a href="${ctp}/admin/storeDeleteList?pageSize=${pageVo.pageSize}&pag=${i}&search=${search}&searchString=${searchString}&order=${order}"><font color="white">${i}</font></a></li>
							    	</c:if>
							      <c:if test="${i <= pageVo.totPage && i != pageVo.pag}">
							    		<li class="btn btn-light"><a href="${ctp}/admin/storeDeleteList?pageSize=${pageVo.pageSize}&pag=${i}&search=${search}&searchString=${searchString}&order=${order}">${i}</a></li>
							    	</c:if>
							    	<c:if test="${pageVo.curBlock < pageVo.lastBlock}">	
								      <li><a class="btn btn-light"href="${ctp}/admin/storeDeleteList?pageSize=${pageVo.pageSize}&pag=${(pageVo.curBlock+1)*pageVo.blockSize + 1}&search=${search}&searchString=${searchString}&order=${order}">&gt;</a></li>
								    </c:if>
							    </c:forEach>
							     <c:if test="${pageVo.pag < pageVo.totPage}">
							       <li class="btn btn-light"><a href="${ctp}/admin/storeDeleteList?pageSize=${pageVo.pageSize}&pag=${pageVo.totPage}&search=${search}&searchString=${searchString}&order=${order}">&gt;&gt;</a></li>
							     </c:if>
	              </ul>
	            </div>
	          </div>
	          
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
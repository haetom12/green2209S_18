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

	    <style>
        
    	fieldset{
		    display: inline-block;
		    direction: rtl;
		    border:0;
			}
			fieldset legend{
		    text-align: right;
			}
			input[type=radio]{
		    display: none;
			}
			label{
		    font-size: 1em;
		    color: transparent;
		    text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
/* 		    text-shadow: 0 0 0 #808080; */
		    /* text-shadow: 0 0 0 #f0f0f0; */
			}
/* 			label:hover{
		    text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
			}
			label:hover ~ label{
		    text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
			}
			input[type=radio]:checked ~ label{
		    text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
			} */
			
			.goRating:hover {
				text-decoration: underline;
			}
    </style>
	


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
    	
			location.href='${ctp}/admin/ratingList?order='+order+'&search='+search+'&searchString='+searchString;
		}
	
	function DelCheck(idx) {
    	let ans = confirm("선택한 별점을 삭제하겠습니까?");
    	if(!ans) return false;
    	   	
    	$.ajax({
    		type   : "post",
    		url    : "${ctp}/admin/adminRatingDeleteCheck",
    		data   : {
    			idx : idx
    			},
    		success:function(res) {
    		  if(res == "1") {
    				alert("별점을 삭제하였습니다!");
    				location.reload();
    			}
    			else {
    				alert("별점 삭제에 실패하였습니다! 다시 시도하세요.");
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
						<h3 class="h3 text-center">모든 리뷰별점</h3>
					</div>
					<div class="pb-20">
					
						<form name="myform">
					  	<div class="row mb-2">
					  	  <div class="col form-inline">
					  	    <select name="order" style="width:18%;" onchange="ordered()" class="form-control mr-1">
					          <option value="mid" ${order=='mid' ? "selected" : ""} >아이디 순</option>
					          <option value="reviewStar" ${order=='reviewStar' ? "selected" : ""}>별점 순</option>
					          <option value="title" ${order=='title' ? "selected" : ""}>제목 순</option>
					          <option value="storeName" ${order=='storeName' ? "selected" : ""}>가게 순</option>
					          <option value="ratingDate" ${order=='ratingDate' ? "selected" : ""}>작성날짜 순</option>
					        </select>
					  	    <select name="search" style="width:15%;" class="form-control mr-1">
					          <option value="mid" ${search=='mid' ? "selected" : ""} >아이디</option>
					          <option value="reviewStar" ${search=='reviewStar' ? "selected" : ""}>별점</option>
					          <option value="storeName" ${search=='storeName' ? "selected" : ""}>가게</option>
					          <option value="title" ${search=='title' ? "selected" : ""}>제목</option>
					        </select>
					  	    <input type="text" name="searchString" class="form-control mr-1" value="${searchString}" autofocus />&nbsp;
					  	    <input type="button" value="개별검색" onclick="midSearch();" class="btn btn-primary" />
					  	  </div>
					  	  <div class="col text-right"><button type="button" onclick="location.href='${ctp}/admin/ratingList';" class="btn btn-success mr-2">전체검색</button></div>
					  	</div>
					  </form>
					  
						<table class="table hover">
							<thead>
								<tr class="text-center">
					        <th>번호</th>
					        <th>제목</th>
					        <th>작성자</th>
					        <th>별점</th>
					        <th>해당 가게</th>
					        <th>작성 날짜</th>
					        <th>비고</th>
								</tr>
							</thead>
							<tbody>
							<c:set var="curScrStartNo" value="${pageVo.curScrStartNo}"/>
								<c:forEach var="vo" items="${vos}" varStatus="st">
						   		<tr class="text-center">
							    	<td>${curScrStartNo}</td>
							    	<td>${vo.title}</td>
							    	<td>${vo.mid}</td>
							    	<td>
							    	<fieldset style="margin: 0 auto">
			                <c:if test="${vo.reviewStar == 5}">
												<input type="radio" name="reviewStar" value="5" id="rate1"><label
													for="rate1">★</label>
												<input type="radio" name="reviewStar" value="4" id="rate2"><label
													for="rate2">★</label>
												<input type="radio" name="reviewStar" value="3" id="rate3"><label
													for="rate3">★</label>
												<input type="radio" name="reviewStar" value="2" id="rate4"><label
													for="rate4">★</label>
												<input type="radio" name="reviewStar" value="1" id="rate5"><label
													for="rate5">★</label>
											</c:if>
			                <c:if test="${vo.reviewStar == 4}">
												<input type="radio" name="reviewStar" value="4" id="rate2"><label
													for="rate2">★</label>
												<input type="radio" name="reviewStar" value="3" id="rate3"><label
													for="rate3">★</label>
												<input type="radio" name="reviewStar" value="2" id="rate4"><label
													for="rate4">★</label>
												<input type="radio" name="reviewStar" value="1" id="rate5"><label
													for="rate5">★</label>
											</c:if>
			                <c:if test="${vo.reviewStar == 3}">
												<input type="radio" name="reviewStar" value="3" id="rate3"><label
													for="rate3">★</label>
												<input type="radio" name="reviewStar" value="2" id="rate4"><label
													for="rate4">★</label>
												<input type="radio" name="reviewStar" value="1" id="rate5"><label
													for="rate5">★</label>
											</c:if>
			                <c:if test="${vo.reviewStar == 2}">
												<input type="radio" name="reviewStar" value="2" id="rate4"><label
													for="rate4">★</label>
												<input type="radio" name="reviewStar" value="1" id="rate5"><label
													for="rate5">★</label>
											</c:if>
			                <c:if test="${vo.reviewStar == 1}">
												<input type="radio" name="reviewStar" value="1" id="rate5"><label
													for="rate5">★</label>
											</c:if>
											</fieldset>
							    	</td>
							    	<td>${vo.storeName}</td>
							    	<td>${fn:substring(vo.ratingDate,0,10)}</td>
							    	<td>
							    	 <input type="button" onclick="DelCheck('${vo.idx}')" class="btn btn-danger" value="평점 리뷰 삭제" />
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
							      <li class="btn btn-light"><a href="${ctp}/admin/ratingList?pageSize=${pageVo.pageSize}&pag=1&search=${search}&searchString=${searchString}&order=${order}">&lt;&lt;</a></li>
							    </c:if>
	                <c:if test="${pageVo.curBlock > 0}">
							      <li><a class="page-link text-secondary" href="${ctp}/admin/ratingList?pageSize=${pageVo.pageSize}&pag=${(pageVo.curBlock-1)*pageVo.blockSize + 1}&search=${search}&searchString=${searchString}&order=${order}">&lt;</a></li>
							    </c:if>
	                <c:forEach var="i" begin="${(pageVo.curBlock)*pageVo.blockSize + 1}" end="${(pageVo.curBlock)*pageVo.blockSize + pageVo.blockSize}" varStatus="st">
							      <c:if test="${i <= pageVo.totPage && i == pageVo.pag}">
							    		<li class="btn btn-primary"><a href="${ctp}/admin/ratingList?pageSize=${pageVo.pageSize}&pag=${i}&search=${search}&searchString=${searchString}&order=${order}"><font color="white">${i}</font></a></li>
							    	</c:if>
							      <c:if test="${i <= pageVo.totPage && i != pageVo.pag}">
							    		<li class="btn btn-light"><a href="${ctp}/admin/ratingList?pageSize=${pageVo.pageSize}&pag=${i}&search=${search}&searchString=${searchString}&order=${order}">${i}</a></li>
							    	</c:if>
							    	<c:if test="${pageVo.curBlock < pageVo.lastBlock}">	
								      <li><a class="btn btn-light"href="${ctp}/admin/ratingList?pageSize=${pageVo.pageSize}&pag=${(pageVo.curBlock+1)*pageVo.blockSize + 1}&search=${search}&searchString=${searchString}&order=${order}">&gt;</a></li>
								    </c:if>
							    </c:forEach>
							     <c:if test="${pageVo.pag < pageVo.totPage}">
							       <li class="btn btn-light"><a href="${ctp}/admin/ratingList?pageSize=${pageVo.pageSize}&pag=${pageVo.totPage}&search=${search}&searchString=${searchString}&order=${order}">&gt;&gt;</a></li>
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
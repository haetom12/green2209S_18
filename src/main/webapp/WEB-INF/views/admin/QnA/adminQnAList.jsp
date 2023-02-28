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
	
	function DelCheck(idx) {
    	let ans = confirm("선택한 문의을 삭제하겠습니까?");
    	if(!ans) return false;
    	   	
    	$.ajax({
    		type   : "post",
    		url    : "${ctp}/admin/adminDeleteQnA",
    		data   : {
    			idx : idx
    			},
    		success:function(res) {
    		  if(res == "1") {
    				alert("문의를 삭제하였습니다!");
    				location.reload();
    			}
    			else {
    				alert("문의 삭제에 실패하였습니다! 다시 시도하세요.");
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
						<h3 class="h3 text-center">모든 문의</h3>
					</div>
					<div class="pb-20">
					  
						<form name="myform">
					  	<div class="row mb-2">
					  	  <div class="col form-inline ml-2">
					  	    <select name="search" style="width:15%;" class="form-control mr-2">
							    	<option value="title" ${search=='title' ? "selected" : ""}>제목</option>
    						    <option value="nickName" ${search=='nickName' ? "selected" : ""}>닉네임</option>
							    	<option value="part" ${search=='part' ? "selected" : ""}>문의유형</option>
							    	<option value="qnaSw" ${search=='qnaSw' ? "selected" : ""}>상태</option>
					        </select>
					  	    <input type="text" name="searchString" class="form-control mr-1" value="${searchString}" autofocus />&nbsp;
					  	    <input type="button" value="개별검색" onclick="midSearch();" class="btn btn-primary" />
					  	  </div>
					  	  <div class="col text-right"><button type="button" onclick="location.href='${ctp}/admin/QnAList';" class="btn btn-success mr-2">전체검색</button></div>
					  	</div>
					  </form>
					  
						<table class="table hover">
							<thead>
								<tr class="text-center">
					        <th>번호</th>
					        <th>문의유형</th>
					        <th>제목</th>
					        <th>답변상황</th>
					        <th>작성자</th>
					        <th>작성날짜</th>
					        <th>비고</th>
								</tr>
							</thead>
							<tbody>
							<c:set var="curScrStartNo" value="${pageVo.curScrStartNo}"/>
								<c:forEach var="vo" items="${vos}" varStatus="st">
						   		<tr class="text-center">
							    	<td>${curScrStartNo}</td>
							    	<td><font color="orange">${vo.part}</font></td>
							    	<td><font color="blue">${vo.title}</font></td>
							    	<td>
								    	<c:if test="${vo.qnaSw == 'q'}">
								    		<font color="red">답변 대기중</font>
								    	</c:if>
								    	<c:if test="${vo.qnaSw != 'q'}">
								    		<font color="green">답변 완료</font>
								    	</c:if>
							    	</td>
							    	<td>${vo.nickName}</td>
							    	<td>${fn:substring(vo.WDate,0,16)}</td>
							    	<td>
							    	 <c:if test="${vo.qnaSw == 'q'}">
							    	 	<input type="button" onclick="location.href='${ctp}/admin/QnAContent?idx=${vo.idx}';" class="btn btn-primary" value="문의 답변" />
							    	 </c:if>
							    	 <c:if test="${vo.qnaSw != 'q'}">
							    	 	<input type="button" onclick="location.href='${ctp}/admin/QnAContent?idx=${vo.idx}';" class="btn btn-success" value="답변 확인" />
							    	 </c:if>
							    	 <input type="button" onclick="DelCheck('${vo.idx}')" class="btn btn-danger" value="문의 삭제" />
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
							      <li class="btn btn-light"><a href="${ctp}/admin/QnAList?pageSize=${pageVo.pageSize}&pag=1&search=${search}&searchString=${searchString}">&lt;&lt;</a></li>
							    </c:if>
	                <c:if test="${pageVo.curBlock > 0}">
							      <li><a class="page-link text-secondary" href="${ctp}/admin/QnAList?pageSize=${pageVo.pageSize}&pag=${(pageVo.curBlock-1)*pageVo.blockSize + 1}&search=${search}&searchString=${searchString} ">&lt;</a></li>
							    </c:if>
	                <c:forEach var="i" begin="${(pageVo.curBlock)*pageVo.blockSize + 1}" end="${(pageVo.curBlock)*pageVo.blockSize + pageVo.blockSize}" varStatus="st">
							      <c:if test="${i <= pageVo.totPage && i == pageVo.pag}">
							    		<li class="btn btn-primary"><a href="${ctp}/admin/QnAList?pageSize=${pageVo.pageSize}&pag=${i}&search=${search}&searchString=${searchString} "><font color="white">${i}</font></a></li>
							    	</c:if>
							      <c:if test="${i <= pageVo.totPage && i != pageVo.pag}">
							    		<li class="btn btn-light"><a href="${ctp}/admin/QnAList?pageSize=${pageVo.pageSize}&pag=${i}&search=${search}&searchString=${searchString} ">${i}</a></li>
							    	</c:if>
							    	<c:if test="${pageVo.curBlock < pageVo.lastBlock}">	
								      <li><a class="btn btn-light"href="${ctp}/admin/QnAList?pageSize=${pageVo.pageSize}&pag=${(pageVo.curBlock+1)*pageVo.blockSize + 1}&search=${search}&searchString=${searchString} ">&gt;</a></li>
								    </c:if>
							    </c:forEach>
							     <c:if test="${pageVo.pag < pageVo.totPage}">
							       <li class="btn btn-light"><a href="${ctp}/admin/QnAList?pageSize=${pageVo.pageSize}&pag=${pageVo.totPage}&search=${search}&searchString=${searchString} ">&gt;&gt;</a></li>
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
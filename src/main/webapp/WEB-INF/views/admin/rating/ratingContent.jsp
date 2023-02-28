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
			fieldset label{
		    font-size: 3em;
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
    				location.href='${ctp}/admin/ratingList';
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
	<section class="ftco-section testimony-section "  style="margin-top: 5%;">
  	<div class="container">
			<div class="pd-20 card-box mb-30" >
				<div class="clearfix">
					<h3 class="text-blue h3" style="text-align: center;">별점리뷰</h3>
				</div>
					<div class="form-group">
						<label>제목</label>
						<input class="form-control"  value="${vo.title}" type="text" readonly>
					</div>
					<div class="form-group">
						<label>별점</label>
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
					</div>
					<div class="form-group">
						<label>작성 날짜</label>
						<input class="form-control"  value="${vo.ratingDate}" type="text" readonly>
					</div>
					<div class="form-group">
						<label>작성자</label>
						<input class="form-control"  value="${vo.memberNickName}" type="text" readonly>
					</div>
					<div class="form-group">
						<label>별점 내용</label>
						<div class="bg-light" style="height: 500px; overflow: auto;">${vo.content}</div>
					</div>
					<div class="form-group">
						<input type="button" value="평점 삭제" onclick="DelCheck(${vo.idx})" style="float: right;" class="btn btn-danger ml-2" />
						<input type="button" value="돌아가기" onclick="location.href='${ctp}/admin/ratingList';" style="float: right;" class="btn btn-secondary mr-2" />
					</div>
	    </div>
    </div>
  </section>
  
	<!-- js -->
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <title>Vegefoods - Free Bootstrap 4 Template by Colorlib</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    
    <link href="https://fonts.googleapis.com/css?family=Poppins:200,300,400,500,600,700,800&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Lora:400,400i,700,700i&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Amatic+SC:400,700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${ctp}/css/open-iconic-bootstrap.min.css">
    <link rel="stylesheet" href="${ctp}/css/animate.css">
    <link rel="stylesheet" href="${ctp}/css/owl.carousel.min.css">
    <link rel="stylesheet" href="${ctp}/css/owl.theme.default.min.css">
    <link rel="stylesheet" href="${ctp}/css/magnific-popup.css">
    <link rel="stylesheet" href="${ctp}/css/aos.css">
    <link rel="stylesheet" href="${ctp}/css/ionicons.min.css">
    <link rel="stylesheet" href="${ctp}/css/bootstrap-datepicker.css">
    <link rel="stylesheet" href="${ctp}/css/jquery.timepicker.css">
    <link rel="stylesheet" href="${ctp}/css/flaticon.css">
    <link rel="stylesheet" href="${ctp}/css/icomoon.css">
    <link rel="stylesheet" href="${ctp}/css/style.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
    
    <script>
    	'use strict';
   	  
   // 선택항목 가게에 저장하기(ajax처리하기)
	  function deleteCheck(idx) {
	  	let ans = confirm("선택한 문의를 삭제하시겠습니까?");
	  	if(!ans) return false;
	  	
	  	$.ajax({
    		type   : "post",
    		url    : "${ctp}/QnA/QnADelete",
    		data   : {idx : idx},
    		success:function(res) {
    			if(res == "0") {
    				alert("문의 삭제에 실패하였습니다. 다시 시도해주세요.");
    			}
    			else {
    				alert("선택한 문의가 삭제 되었습니다!");
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
  <body class="goto-here">
  
		<jsp:include page="/WEB-INF/views/include/nav.jsp"></jsp:include>		

    <div class="hero-wrap hero-bread" style="background-image: url('${ctp}/images/bg_1.jpg');">
      <div class="container">
        <div class="row no-gutters slider-text align-items-center justify-content-center">
          <div class="col-md-9 ftco-animate text-center">
            <h1 class="mb-0 bread">고객 문의</h1>
<!--           	<p class="breadcrumbs"><span class="mr-2"><a href="index.html">나의</a></span></p>
            <h1 class="mb-0 bread">찜목록</h1> -->
          </div>
        </div>
      </div>
    </div>

			<div class="container" style="margin-top: 5%;">
  			<div class="col-md-12 ftco-animate">
				<h2 class="text-center">내 문의 게시판</h2><br />
					<form name="myform" method="post">
				  </form>
					<input type="button" value="문의 작성" onclick="location.href='${ctp}/QnA/QnAInput';" class="btn btn-secondary mb-1" style="float: right;"/>
  				<table class="table">
				    <thead class="thead-primary">
				      <tr class="text-center">
				        <th>번호</th>
				        <th>제목</th>
				        <th>작성날짜</th>
				        <th>답변상태</th>
				        <th>비고</th>
				      </tr>
				    </thead>
				    <!-- <tbody id="demo"></tbody> -->
				    <c:forEach var="vo" items="${vos}" varStatus="st">
				    	<tr class="text-center">
					    	<td class='image-prod'><b>${st.count}</b></td>
					    	<td class='product-name'><b><a href="${ctp}/QnA/myQnAContent?idx=${vo.idx}">${vo.title}</a></b></td>
					    	<td class='image-prod'>${fn:substring(vo.WDate,0,10)}</td>
					    	<td class='image-prod'>
						    	<c:if test="${vo.qnaSw == 'q'}">
						    		<font color="red">답변 대기중</font>
						    	</c:if>
						    	<c:if test="${vo.qnaSw != 'q'}">
						    		<font color="blue">답변 완료</font>
						    	</c:if>
					    	</td>
					    	<td class='image-prod'>
					    		<c:if test="${vo.qnaSw == 'q'}">
							    	<input type="button" value="수정" onclick="location.href='${ctp}/QnA/QnAUpdate?idx=${vo.idx}';" class="btn btn-warning mb-1" style="margin-left: 5px;"/>
					    		</c:if>
						    	<input type="button" value="삭제" onclick="deleteCheck(${vo.idx})" class="btn btn-danger mb-1" style="margin-left: 5px;"/>
					    	</td>
				    	</tr>
				    </c:forEach>
				  </table>
      		<!-- 페이징 처리 시작 -->
					<div class="row mt-5">
				    <div class="col text-center">
				      <div class="block-27">
				        <ul>
				        	<c:if test="${pageVo.pag > 1}">
							      <li><a href="${ctp}/QnA/QnAList?storePart=${storePart}&pageSize=${pageVo.pageSize}&pag=1">&lt;&lt;</a></li>
							    </c:if>
				          <c:if test="${pageVo.curBlock > 0}">
							      <li><a class="page-link text-secondary" href="${ctp}/QnA/QnAList?storePart=${storePart}&pageSize=${pageVo.pageSize}&pag=${(pageVo.curBlock-1)*pageVo.blockSize + 1}">&lt;</a></li>
							    </c:if>
				          <c:forEach var="i" begin="${(pageVo.curBlock)*pageVo.blockSize + 1}" end="${(pageVo.curBlock)*pageVo.blockSize + pageVo.blockSize}" varStatus="st">
							      <c:if test="${i <= pageVo.totPage && i == pageVo.pag}">
							    		<li class="active"><a href="${ctp}/QnA/QnAList?storePart=${storePart}&pageSize=${pageVo.pageSize}&pag=${i}">${i}</a></li>
							    	</c:if>
							      <c:if test="${i <= pageVo.totPage && i != pageVo.pag}">
							    		<li><a href="${ctp}/QnA/QnAList?storePart=${storePart}&pageSize=${pageVo.pageSize}&pag=${i}">${i}</a></li>
							    	</c:if>
							    	<c:if test="${pageVo.curBlock < pageVo.lastBlock}">
								      <li><a class="page-link text-secondary" href="${ctp}/QnA/QnAList?storePart=${storePart}&pageSize=${pageVo.pageSize}&pag=${(pageVo.curBlock+1)*pageVo.blockSize + 1}">&gt;</a></li>
								    </c:if>
							    </c:forEach>
							     <c:if test="${pageVo.pag < pageVo.totPage}">
							       <li><a href="${ctp}/QnA/QnAList?storePart=${storePart}&pageSize=${pageVo.pageSize}&pag=${pageVo.totPage}">&gt;&gt;</a></li>
							     </c:if>
				        </ul>
				      </div>
				    </div>
				  </div>
					<!-- 페이징 처리 끝 -->
  			</div>
			</div>

		<jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>

  <!-- loader -->
  <div id="ftco-loader" class="show fullscreen"><svg class="circular" width="48px" height="48px"><circle class="path-bg" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke="#eeeeee"/><circle class="path" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke-miterlimit="10" stroke="#F96D00"/></svg></div>


 	<script src="${ctp}/js/jquery.min.js"></script>
  <script src="${ctp}/js/jquery-migrate-3.0.1.min.js"></script>
  <script src="${ctp}/js/popper.min.js"></script>
  <script src="${ctp}/js/bootstrap.min.js"></script>
  <script src="${ctp}/js/jquery.easing.1.3.js"></script>
  <script src="${ctp}/js/jquery.waypoints.min.js"></script>
  <script src="${ctp}/js/jquery.stellar.min.js"></script>
  <script src="${ctp}/js/owl.carousel.min.js"></script>
  <script src="${ctp}/js/jquery.magnific-popup.min.js"></script>
  <script src="${ctp}/js/aos.js"></script>
  <script src="${ctp}/js/jquery.animateNumber.min.js"></script>
  <script src="${ctp}/js/bootstrap-datepicker.js"></script>
  <script src="${ctp}/js/scrollax.min.js"></script>
  <script src="${ctp}/js/main.js"></script>

  <script>
		$(document).ready(function(){
		var quantitiy=0;
		   $('.quantity-right-plus').click(function(e){
		        
		        // Stop acting like a button
		        e.preventDefault();
		        // Get the field name
		        var quantity = parseInt($('#quantity').val());
		        
		        // If is not undefined
		            
		            $('#quantity').val(quantity + 1);
		          
		            // Increment
		        
		    });
		     $('.quantity-left-minus').click(function(e){
		        // Stop acting like a button
		        e.preventDefault();
		        // Get the field name
		        var quantity = parseInt($('#quantity').val());
		        
		        // If is not undefined
		      
		            // Increment
		            if(quantity>0){
		            $('#quantity').val(quantity - 1);
		            }
		    });
		    
		});
	</script>
    
  </body>
</html>
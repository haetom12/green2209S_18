<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
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
    
    <script>
    	'use strict';
    	
    	function ratingDelete(idx) {
				let ans = confirm("해당 별점을 삭제하시겠습니까?");
    		if(!ans) return false;
    		
    		$.ajax({
			  	type   : "post",
			  	url    : "${ctp}/store/ratingDelete",
			  	data   : {
			  		idx : idx
			  	},
	    		success:function(res) {
	    			if(res == "1") {
	    				alert("별점이 삭제되었습니다!");
	    				location.reload();
	    			}
	    			else {
	    				alert("별점 삭제에 실패하였습니다. 다시 시도해주세요.");
	    			}
	    		},
	    		error : function() {
	    			alert("전송 오류~~");
	    		}
	    	});
			}
    	
    
    </script>
    
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
    
  </head>
  <body class="goto-here">
  
		<jsp:include page="/WEB-INF/views/include/nav.jsp"></jsp:include>		

    <div class="hero-wrap hero-bread" style="background-image: url('${ctp}/data/store/${vo.logoPhoto}'); width:40%; margin: 0 auto;">
      <div class="container">
        <div class="row no-gutters slider-text align-items-center justify-content-center">
          <div class="col-md-9 ftco-animate text-center">
          	<!-- <p class="breadcrumbs"><span class="mr-2"><a href="index.html">Home</a></span> <span>Blog</span></p> -->
            <h1 class="mb-0 bread">${vo.storeName}</h1>
          </div>
        </div>
      </div>
    </div>

  	<section class="ftco-section ftco-degree-bg">
      <div class="container">
      	<c:forEach var="rVo" items="${rVos}" varStatus="rSt">
	        <div class="row">
	          <div class="col-lg-12 ftco-animate">
							<table class="table border" style="border: soild 1px black;">
					    <thead class="thead-primary">
							  <tr class="text-center table-bordered" >
							    <th>작성자</th>
							    <th style="background-color:#eee; "><font color="black">${rVo.memberNickName}</font></th>
							    <th>작성날짜</th>
							    <th style="background-color:#eee; "><font color="black">${rVo.ratingDate}</font></th>
							  </tr>
							  <tr class="text-center">
							    <th>제목</th>
							    <th style="background-color:#eee;"><font color="black">${rVo.title}</font></th>
							    <th>별점</th>
							    <th style="background-color:#eee;">
							    	<fieldset style="margin: 0 auto">
			                <c:if test="${rVo.reviewStar == 5}">
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
			                <c:if test="${rVo.reviewStar == 4}">
												<input type="radio" name="reviewStar" value="4" id="rate2"><label
													for="rate2">★</label>
												<input type="radio" name="reviewStar" value="3" id="rate3"><label
													for="rate3">★</label>
												<input type="radio" name="reviewStar" value="2" id="rate4"><label
													for="rate4">★</label>
												<input type="radio" name="reviewStar" value="1" id="rate5"><label
													for="rate5">★</label>
											</c:if>
			                <c:if test="${rVo.reviewStar == 3}">
												<input type="radio" name="reviewStar" value="3" id="rate3"><label
													for="rate3">★</label>
												<input type="radio" name="reviewStar" value="2" id="rate4"><label
													for="rate4">★</label>
												<input type="radio" name="reviewStar" value="1" id="rate5"><label
													for="rate5">★</label>
											</c:if>
			                <c:if test="${rVo.reviewStar == 2}">
												<input type="radio" name="reviewStar" value="2" id="rate4"><label
													for="rate4">★</label>
												<input type="radio" name="reviewStar" value="1" id="rate5"><label
													for="rate5">★</label>
											</c:if>
			                <c:if test="${rVo.reviewStar == 1}">
												<input type="radio" name="reviewStar" value="1" id="rate5"><label
													for="rate5">★</label>
											</c:if>
											</fieldset>
											&nbsp;&nbsp;
											<c:if test="${sMid == 'admin'}">
												<input type="button" value="삭제" onclick="ratingDelete(${rVo.idx})" class="btn btn-danger"  />
											</c:if>
											<c:if test="${sMid == rVo.mid}">
												<input type="button" value="수정" onclick="location.href='${ctp}/store/ratingUpdate?idx=${rVo.idx}';" class="btn btn-warning" />
												<input type="button" value="삭제" onclick="ratingDelete(${rVo.idx})" class="btn btn-danger"  />
											</c:if>
							    </th>
							  </tr>
					    </thead>
					   <!-- 장바구니 목록출력 -->
				   	  <tbody class="m-0 p-0">
					      <tr align="center">
					    	  <td class="m-0 p-0" colspan="4">
								    <!-- 상품 상세설명 보여주기 -->
								    <div id="content" style="background-color:#eee;" class="text-left"><br/>
								      ${rVo.content}
								    </div>					    	
					    	  </td>
						    </tr>
					    </tbody>
						</table>
	          </div> <!-- .col-md-8 -->
	        </div>
	        <br /><hr />
        </c:forEach>
      </div>
    </section> <!-- .section -->

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
    
  </body>

</html>

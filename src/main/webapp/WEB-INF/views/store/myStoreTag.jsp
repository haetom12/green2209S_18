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
    
    <script>
    	'use strict';
    	
    	function deleteCheck(foodTag) {
	    	let ans = confirm("선택된 태그를 삭제하시겠습니까?");
	    	if(!ans) return false;
	    	
	    	let storeName = '${vo.storeName}';
	    	
	    	$.ajax({
	    		type   : "post",
	    		url    : "${ctp}/store/storeTagDeleteOk",
	    		data   : {
	    			foodTag : foodTag,
	    			storeName : storeName
	    			},
	    		success:function(res) {
	    			if(res == "0") {
	    				alert("태그에 속해있는 메뉴가 있습니다. 먼저 메뉴를 삭제해주세요!");
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

    <section class="ftco-section ftco-cart">
			<div class="container" style="width: 50%;">
				<div class="row">
    			<div class="col-md-12 ftco-animate">
    				<div class="cart-list">
    					<h2 class="text-center">내 가게 메뉴 태그</h2><br />
    					<input type="button" value="돌아가기" onclick="location.href='${ctp}/store/myStorePage';" class="btn btn-secondary mb-1" />
    					<input type="button" value="음식 태그 추가" onclick="location.href='${ctp}/store/storeTagInput';" class="btn btn-primary mb-1" style="float: right;"/>
	    				<table class="table">
						    <thead class="thead-primary">
						      <tr class="text-center">
						        <th>번호</th>
						        <th>태그명</th>
						        <th>비고</th>
						      </tr>
						    </thead>
						    <tbody>
						    	<c:forEach var="vo" items="${vos}" varStatus="st">
							      <tr class="text-center">
							        <td class="price">${st.count}</td>
							        <td class="price">${vo.foodTag}</td>
							        <td class="price">
												<input type="button" value="수정" onclick="location.href='${ctp}/store/storeTagUpdate?foodTag=${vo.foodTag}';" class="btn btn-warning"/>
												<input type="button" value="삭제" onclick="deleteCheck('${vo.foodTag}')" class="btn btn-danger"/>
							        </td>
							      </tr><!-- END TR-->
						      </c:forEach>
						    </tbody>
						  </table>
					  </div>
    			</div>
    		</div>
			</div>
		</section>

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
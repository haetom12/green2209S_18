<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
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
    
  </head>
  <body class="goto-here">
  
		<jsp:include page="/WEB-INF/views/include/nav.jsp"></jsp:include>		
    <div class="hero-wrap hero-bread" style="background-image: url('${ctp}/images/bg_1.jpg');">
      <div class="container">
        <div class="row no-gutters slider-text align-items-center justify-content-center">
          <div class="col-md-9 ftco-animate text-center">
            <h1 class="mb-0 bread">마이 페이지</h1>
<!--           	<p class="breadcrumbs"><span class="mr-2"><a href="index.html">나의</a></span></p>
            <h1 class="mb-0 bread">찜목록</h1> -->
          </div>
        </div>
      </div>
    </div>

		<div class="container" style="width: 2500px; margin-top: 5%;">
			<div class="ftco-animate">
				<h2 class="text-center">내 쿠폰</h2><br />
				<form name="myform" method="post">
  				<table class="table">
				    <thead class="thead-primary">
						  <tr class="text-center">
						    <th>QR 코드</th>
						    <th>쿠폰 코드</th>
						    <th>획득 날짜</th>
						    <th>유효 기간</th>
						    <th>사용 여부</th>
						    <th>사용 날짜</th>
						  </tr>
				    </thead>
				   <!-- 장바구니 목록출력 -->
					  <c:forEach var="vo" items="${vos}">
					    <tr align="center">
					    	<td>
				      		<a href="${ctp}/data/qrCode/${vo.qrCode}" class="image-popup"><img src="${ctp}/data/qrCode/${vo.qrCode}" style="width: 100px;" class="img-fluid" alt="Colorlib Template"></a>
					      </td>
					      <td>
					      	<b>${vo.couponName}</b>
					      </td>
					      <td>
					        <div class="text-center">
					        	${fn:substring(vo.receiveDate,0,16)}
					        </div>
					      </td>
					      <td>
					        <div class="text-center">
					        	${fn:substring(vo.expiration,0,16)}
					        </div>
					      </td>
					      <td>
					      	<div class="text-center">
					     			<c:if test="${vo.useDate == vo.receiveDate}">
					      			<b><font color="red">미사용</font></b>
					      		</c:if>
					      		<c:if test="${vo.useDate != vo.receiveDate}">
					      			<b><font color="blue">사용</font></b>
					      		</c:if>
					     		</div>
					      </td>
					      <td>
					      	<div class="text-center">
					      		<c:if test="${vo.useDate == vo.receiveDate}">
					      			<b><font color="red">미사용</font></b>
					      		</c:if>
					      		<c:if test="${vo.useDate != vo.receiveDate}">
					      			<b><font color="green">${fn:substring(vo.useDate,0,16)}</font></b>
					      		</c:if>
					     		</div>
					      </td>
					    </tr>
					  </c:forEach>
					</table>
				</form>
			</div>
			
			
			<!-- 페이징 처리 시작 -->
    		<div class="row mt-5">
          <div class="col text-center">
            <div class="block-27">
              <ul>
              	<c:if test="${pageVo.pag > 1}">
						      <li><a class="" href="${ctp}/order/myCouponList?pageSize=${pageVo.pageSize}&pag=1">&lt;&lt;</a></li>
						    </c:if>
                <c:if test="${pageVo.curBlock > 0}">
						      <li><a class="page-link text-secondary" href="${ctp}/order/myCouponList?pageSize=${pageVo.pageSize}&pag=${(pageVo.curBlock-1)*pageVo.blockSize + 1}">&lt;</a></li>
						    </c:if>
                <c:forEach var="i" begin="${(pageVo.curBlock)*pageVo.blockSize + 1}" end="${(pageVo.curBlock)*pageVo.blockSize + pageVo.blockSize}" varStatus="st">
						      <c:if test="${i <= pageVo.totPage && i == pageVo.pag}">
						    		<li class="active"><a href="${ctp}/order/myCouponList?pageSize=${pageVo.pageSize}&pag=${i}">${i}</a></li>
						    	</c:if>
						      <c:if test="${i <= pageVo.totPage && i != pageVo.pag}">
						    		<li><a href="${ctp}/order/myCouponList?pageSize=${pageVo.pageSize}&pag=${i}">${i}</a></li>
						    	</c:if>
						    	<c:if test="${pageVo.curBlock < pageVo.lastBlock}">
							      <li><a class="page-link text-secondary" href="${ctp}/order/myCouponList?pageSize=${pageVo.pageSize}&pag=${(pageVo.curBlock+1)*pageVo.blockSize + 1}">&gt;</a></li>
							    </c:if>
						    </c:forEach>
						     <c:if test="${pageVo.pag < pageVo.totPage}">
						       <li><a class="" href="${ctp}/order/myCouponList?pageSize=${pageVo.pageSize}&pag=${pageVo.totPage}">&gt;&gt;</a></li>
						     </c:if>
              </ul>
            </div>
          </div>
        </div>
	    	<!-- 페이징 처리 끝 -->
			
			
		</div>

		<jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>

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
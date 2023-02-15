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
    
    <script>
		function orderCancle(orderIdx) {
			let ans = confirm("주문을 취소하시겠습니까?");
			if(!ans) return false;
			
			$.ajax({
			  	type   : "post",
			  	url    : "${ctp}/member/memberOrderCancle",
			  	data   : {
			  		orderIdx : orderIdx
			  	},
	    		success:function(res) {
	    			if(res == "1") {
	    				alert("주문이 취소되었습니다!");
	    				location.reload();
	    			}
	    			else {
	    				alert("이미 배달이 접수되어 취소가 불가능합니다.");
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
            <h1 class="mb-0 bread">마이 페이지</h1>
<!--           	<p class="breadcrumbs"><span class="mr-2"><a href="index.html">나의</a></span></p>
            <h1 class="mb-0 bread">찜목록</h1> -->
          </div>
        </div>
      </div>
    </div>

		<div class="container" style="width: 2500px; margin-top: 5%;">
			<div class="ftco-animate">
				<h2 class="text-center">내 주문 내역</h2><br />
				<form name="myform" method="post">
  				<table class="table">
				    <thead class="thead-primary">
						  <tr class="text-center">
						    <th>주문정보</th>
						    <th>주문정보</th>
						    <th style="width: 130px;">배달요청사항</th>
						    <th>총상품금액</th>
						    <th>배달주소</th>
						    <th>주문 날짜</th>
						    <th>주문 현황</th>
						  </tr>
				    </thead>
				   <!-- 장바구니 목록출력 -->
					  <c:set var="maxIdx" value="0"/>
					  <c:forEach var="vo" items="${vos}">
			      	<c:set var="foodNames" value="${fn:split(vo.foodName,'/')}"/>
			        <c:set var="optionNames" value="${fn:split(vo.subMenuName,'/')}"/>
			        <c:set var="optionPrices" value="${fn:split(vo.optionPrice,'/')}"/>
			        <c:set var="optionNums" value="${fn:split(vo.optionNum,'/')}"/>
			        <c:set var="thumbImgs" value="${fn:split(vo.thumbImg,'/')}"/>
			        <c:set var="orderAddresses" value="${fn:split(vo.orderAddress,'/')}"/>
					    <tr align="center">
					    	<td>
						    	<c:forEach var="i" begin="0" end="${fn:length(foodNames)-1}">
						      	<a href="${ctp}/store/storeMenuInfo?menuIdx=${vo.menuIdx}"><img src="${ctp}/data/orderFoodPhoto/${thumbImgs[i]}" width="100px"/></a><br />
						      </c:forEach>
					      </td>
					      <td align="left">
					        <p class="contFont" style="text-align: left;"><br/>
					        	<c:forEach var="i" begin="0" end="${fn:length(foodNames)-1}">
						          <font size="4px;">메뉴 : <span style="color:orange;font-weight:bold;"><a href="${ctp}/store/storeMenuInfo?menuIdx=${vo.menuIdx}">${foodNames[i]}</a></span><br/></font>
		         				  <span style="color:orange;font-weight:bold;">${optionNames[i]}</span><br/> 
					          </c:forEach>
					        </p>
					      </td>
					      <td>
					      	<c:if test="${vo.orderMessage==''}">
					      		<b>(없음)</b>
					      	</c:if>
					      	<c:if test="${vo.orderMessage!=''}">
					      		<b>${vo.orderMessage}</b>
					      	</c:if>
					      </td>
					      <td>
					        <div class="text-center">
						        <b>총 : <fmt:formatNumber value="${vo.orderTotalPrice}" pattern='#,###원'/></b>
					        </div>
					      </td>
					      <td>
					        <div class="text-center">
					        	<b>${orderAddresses[0]}<br />${orderAddresses[1]}</b>
					        </div>
					      </td>
					      <td>
					      	<div class="text-center">
					     			<b>${fn:substring(vo.orderDate,0,16)}</b>
					     		</div>
					      </td>
					      <td>
					      	<div class="text-center">
										<c:if test="${vo.progress=='배달완료'}">				      		
					     				<b><font color="blue">${vo.progress}</font></b><br />
					     				<c:if test="${vo.ratingOk=='NO'}">		
					     					<input type="button" class="btn btn-primary" value="별점작성" onclick="location.href='${ctp}/order/ratingInput?orderIdx=${vo.orderIdx}';" />
					     				</c:if>
					     				<c:if test="${vo.ratingOk!='NO'}">		
					     					<input type="button" class="btn btn-primary" value="별점보러가기" onclick="location.href='${ctp}/order/myRating?orderIdx=${vo.orderIdx}';" />
					     				</c:if>
					     			</c:if>	
										<c:if test="${vo.progress=='배달채택'}">				      		
					     				<b><font color="green">${vo.progress}</font></b>
					     			</c:if>	
										<c:if test="${vo.progress=='주문취소'}">				      		
					     				<b><font color="red">${vo.progress}</font></b>
					     			</c:if>	
										<c:if test="${vo.progress=='주문완료'}">				      		
					     				<b><font color="orange">${vo.progress}</font></b><br />
					     				<input type="button" value="주문취소" onclick="orderCancle('${vo.orderIdx}')" class="btn btn-warning" />
					     			</c:if>	
					     		</div>
					      </td>
					    </tr>
					    <c:set var="maxIdx" value="${vo.idx}"/>	<!-- 가장 마지막 품목의 idx값이 가장 크다. -->
					  </c:forEach>
					</table>
				  <input type="hidden" id="maxIdx" name="maxIdx" value="${maxIdx}"/>
				  <input type="hidden" name="orderTotalPrice" id="orderTotalPrice"/>
			    <input type="hidden" name="baesong" value="${sVo.deliverCost}"/>
				</form>
			</div>
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
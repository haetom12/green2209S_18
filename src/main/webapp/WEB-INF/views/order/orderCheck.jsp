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
    <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
		<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
		
		
		<script>
			'use strict';
			// 결재하기
		    function order() {
					if(agree.checked == false) {
						alert("결제 시스템 동의를 눌러주세요.");
						return false;
					}
				
		    	var ans = confirm("결재하시겠습니까?");
		    	
		    	let address1 = myform.address1.value;
		    	let address2 = myform.address2.value;
		    	myform.orderAddress.value = address1 + "/" + address2;
		    	let amount = document.getElementById("orderTotalPrice").value;
		    	myform.amount.value = amount;
		    	
		    	if(ans) {
			    	myform.action = "${ctp}/order/payment";
			    	myform.submit();
		    	}
		    }
		
			function cCheck() {
				let cCode = document.getElementById("cCode").value;
				let orderTotalPrice = document.getElementById("orderTotalPrice").value;
				orderTotalPrice = orderTotalPrice.replace(",", "");
	      orderTotalPrice = orderTotalPrice.replace("원", "");
	       
				let ans = confirm("입력하신 쿠폰을 적용하시겠습니까?");
		      if(!ans) return false;
		      
		      $.ajax({
		        type : "post",
		        url  : "${ctp}/order/myCouponCheck",
		        data : {couponName : cCode},
		        success:function(discount) {
		        	if(discount == "0") {
			        	document.getElementById("demo5").innerHTML = "<font color = 'red'> 이미 사용했거나 존재하지않는 쿠폰입니다. </font>"; 
		        	}
		        	else if(parseInt(discount) > orderTotalPrice) {
		        		document.getElementById("demo5").innerHTML = "<font color = 'red'> 총 금액보다 높은 쿠폰은 사용 불가능합니다! </font>"; 
		        		
		        		console.log("가격",orderTotalPrice);
		        		console.log("할인",discount);
		        		
		        	}
		        	else {
		        		
		        	document.getElementById("demo5").innerHTML = "<font color = 'blue'> 쿠폰이 적용되었습니다! </font>"; 
		        	
		        	$("#cCode").attr("readonly","readonly");
		        	
		        	document.getElementById("coupon").value =  numberWithCommas(discount)+"원";
		        	document.getElementById("couponName").value =  cCode;
		        	
		        	let totPrice = orderTotalPrice-parseInt(discount);
		        	document.getElementById("orderTotalPrice").value = numberWithCommas(totPrice)+"원";
		        	
		        	}
		        },
		        error : function() {
		        	alert("전송에러!");
		        }
		      });
			 }
			
			// 천단위마다 쉼표처리
		    function numberWithCommas(x) {
		      return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
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

    <section class="ftco-section">
      <div class="container">
        <div class="row justify-content-center">
          <div class="col-xl-7 ftco-animate">
						<form name="myform" method="post" class="billing-form">
							<h3 class="mb-4 billing-heading">주문 상세 내역</h3>
	          	<div class="row align-items-end">
	          		<div class="col-md-12">
	                <div class="form-group">
	                	<label for="firstname">주문자</label>
	                  <input type="text" name="buyer_name" class="form-control"  value="${memberVo.memberName}"  readonly>
	                </div>
	              </div>
	              <div class="w-100"></div>
		            <div class="col-md-6">
	                <div class="form-group">
	                	<label for="phone">연락처</label>
	                  <input type="text" name="buyer_tel" value="${memberVo.tel}" style="font-weight:bolder; color: black;" class="form-control"/>
	                </div>
	              </div>
	              <div class="col-md-6">
	                <div class="form-group">
	                	<label for="emailaddress">이메일(결제내역 받을 곳)</label>
	                  <input type="text" name="buyer_email" value="${memberVo.email}" style="font-weight:bolder; color: black;" class="form-control"/>
	                </div>
                </div>
		            <div class="w-100"></div>
		            <div class="col-md-6">
		            	<div class="form-group">
	                	<label for="streetaddress">배달 주소</label>
	                  <input type="text" class="form-control"  name="address1" value="${address1}" style="font-weight:bolder; color: black;">
	                </div>
		            </div>
		            <div class="col-md-6">
		            	<div class="form-group">
	                  <input type="text" class="form-control" name="address2" value="${address2}" style="font-weight:bolder; color: black;">
	                </div>
		            </div>
                <div class="w-100"></div>
                <div class="col-md-12">
	                <div class="form-group">
	                	<label for="firstname">배달 요청 사항</label>
	                  <input type="text" name="orderMessage" class="form-control" placeholder="요청사항을 적어주세요">
	                </div>
	              </div>
	            </div>
	            <input type="hidden" id="orderAddress" name="orderAddress" value=""/>
	            <input type="hidden" id="amount" name="amount" value=""/>
	            <input type="hidden" id="couponName" name="couponName" value=""/>
	          </form><!-- END -->
	          
	          
    				<div class="cart-total mb-1">
    					<h2 class="mb-4 billing-heading">쿠폰 등록</h2>
    					<p>보유하고 있는 쿠폰 코드를 입력하세요</p>
  						<form action="couponForm" class="info">
	              <div class="form-group">
	              	<label for="">쿠폰 코드</label>
	                <input type="text" name="cCode" id="cCode" class="form-control text-left px-3" >
	              </div>
	              <div style="font-size: 12px; margin-bottom: 7px;" id="demo5"></div>
    						<p><input type="button" value="쿠폰 적용" class="btn btn-success py-3 px-4" onclick="cCheck()"/></p>
	            </form>
    				</div>
	          
	          
	          
					</div>
					
					<div class="col-xl-5">
	          <div class="row mt-5 pt-3">
	          	<div class="col-md-12 d-flex mb-5">
	          		<div class="cart-detail cart-total p-3 p-md-4">
	          			<h3 class="billing-heading mb-4">결제 금액</h3>
	          			<p class="d-flex">
		    						<span>메뉴값</span>
		    						<span><input type="text" id="total" name="total" value="${su-baesong}원" class="totSubBox form-control" style="width: 100px;" readonly/></span>
		    					</p>
		    					<p class="d-flex">
		    						<span>배달비</span>
		    						<span><input type="text" id="baesong" name="baesong" value="${baesong}원"  class="totSubBox form-control" style="width: 100px;" readonly/></span>
		    						<%-- <span>${sVo.deliverCost}원</span> --%>
		    					</p>
		    					<p class="d-flex">
		    						<span>쿠폰할인</span>
		    						<span><input type="text" id="coupon" name="coupon" value="0"  class="totSubBox form-control" style="width: 100px;" readonly/></span>
		    						<%-- <span>${sVo.deliverCost}원</span> --%>
		    					</p>
		    					<!-- <p class="d-flex">
		    						<span>쿠폰 할인</span>
		    						<span>$3.00</span>
		    					</p>
		    					<hr> -->
		    					<p class="d-flex total-price">
		    						<span>총</span>
		    						<span><input type="text" id="orderTotalPrice" name="orderTotalPrice" value="${orderTotalPrice}원" class="totSubBox form-control" style="width: 100px;" readonly/></span>
		    					</p>
								</div>
	          	</div>
	          	<div class="col-md-12">
	          		<div class="cart-detail p-3 p-md-4">
	          			<h3 class="billing-heading mb-4">결제 진행</h3>
									<div class="form-group">
										<div class="col-md-12">
											<div class="checkbox">
											   <label><input type="checkbox" id="agree" name="agree" class="mr-2"> 결제 시스템 이용약관 대하여 동의합니다</label>
											</div>
										</div>
									</div>
									<input type="button" value="결제하기" class="btn btn-primary py-3 px-4" onClick="order()" />
									<input type="hidden" name="lastPrice" id="lastPrice"/>
								</div>
	          	</div>
	          </div>
          </div> <!-- .col-md-8 -->
        </div>
      </div>
    </section> <!-- .section -->

		<section class="ftco-section ftco-no-pt ftco-no-pb py-5 bg-light">
      <div class="container py-4">
        <div class="row d-flex justify-content-center py-5">
          <div class="col-md-6">
          	<h2 style="font-size: 22px;" class="mb-0">Subcribe to our Newsletter</h2>
          	<span>Get e-mail updates about our latest shops and special offers</span>
          </div>
          <div class="col-md-6 d-flex align-items-center">
            <form action="#" class="subscribe-form">
              <div class="form-group d-flex">
                <input type="text" class="form-control" placeholder="Enter email address">
                <input type="submit" value="Subscribe" class="submit px-3">
              </div>
            </form>
          </div>
        </div>
      </div>
    </section>
    
    
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
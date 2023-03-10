<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
  <head>
    <title>저기요 홈페이지</title>
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
    	
    	function fCheck(storeName, menuIdx) {
    		
				let sPart = '${sPart}';
    		
    		if(sPart == "") {
    			alert("찜하기는 로그인 후 가능합니다!");
    			return false;
    		}
    		
    		let ans = confirm("선택된 메뉴를 찜하시겠습니까?");
	    	if(!ans) return false;
	    	
	    	$.ajax({
	    		type   : "post",
	    		url    : "${ctp}/order/wishListInput",
	    		data   : {
	    			storeName : storeName,
	    			menuIdx : menuIdx
	    			},
	    		success:function(res) {
	    			if(res == "1") {
	    				alert("메뉴가 찜목록에 추가되었습니다!");
	    				location.reload();
	    			}
	    			else {
	    				alert("이미 찜목록에 들어가 있는 제품입니다!");
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

    <section id="home-section" class="hero">
		  <div class="home-slider owl-carousel">
	      <div class="slider-item" style="background-image: url(${ctp}/images/background1.jpg);">
	      	<div class="overlay"></div>
	        <div class="container">
	          <div class="row slider-text justify-content-center align-items-center" data-scrollax-parent="true">

	            <div class="col-md-12 ftco-animate text-center">
	              <h2 class="mb-2"><font size="15pt" color="white">집 근처에 있는 맛집들을 확인해보세요!</font></h2>
	              <h2 class="subheading mb-4">신속하고 빠르게 음식을 &amp; 배달합니다</h2>
	              <p><a href="${ctp}/store/shopNear" class="btn btn-primary">주위 찾아보기</a></p>
	            </div>

	          </div>
	        </div>
	      </div>

	      <div class="slider-item" style="background-image: url(${ctp}/images/background2.jpg);">
	      	<div class="overlay"></div>
	        <div class="container">
	          <div class="row slider-text justify-content-center align-items-center" data-scrollax-parent="true">

	            <div class="col-sm-12 ftco-animate text-center">
	              <h2 class="mb-2"><font size="15pt" color="white">원하는 메뉴를 골라 주문하세요!</font></h2>
	              <h2 class="subheading mb-4">신속하고 빠르게 음식을 &amp; 배달합니다</h2>
	              <p><a href="${ctp}/store/shopCategory" class="btn btn-primary">메뉴 찾기</a></p>
	            </div>

	          </div>
	        </div>
	      </div>
	    </div>
    </section>

    <section class="ftco-section">
			<div class="container">
				<div class="row no-gutters ftco-services">
          <div class="col-md-3 text-center d-flex align-self-stretch ftco-animate">
            <div class="media block-6 services mb-md-0 mb-4">
              <div class="icon bg-color-1 active d-flex justify-content-center align-items-center mb-2">
            		<span class="flaticon-shipped"></span>
              </div>
              <div class="media-body">
                <h3 class="heading">신속배달</h3>
                <span>여러분의 음식을 안전하고 빠르게 배달합니다</span>
              </div>
            </div>      
          </div>
          <div class="col-md-3 text-center d-flex align-self-stretch ftco-animate">
            <div class="media block-6 services mb-md-0 mb-4">
              <div class="icon bg-color-2 d-flex justify-content-center align-items-center mb-2">
            		<span class="flaticon-diet"></span>
              </div>
              <div class="media-body">
                <h3 class="heading">안심 거래</h3>
                <span>저기요는 신뢰가능한 매장입니다</span>
              </div>
            </div>    
          </div>
          <div class="col-md-3 text-center d-flex align-self-stretch ftco-animate">
            <div class="media block-6 services mb-md-0 mb-4">
              <div class="icon bg-color-3 d-flex justify-content-center align-items-center mb-2">
            		<span class="flaticon-award"></span>
              </div>
              <div class="media-body">
                <h3 class="heading">간편한 주문</h3>
                <span>언제/어디에서나 간편하게 메뉴를 주문하세요</span>
              </div>
            </div>      
          </div>
          <div class="col-md-3 text-center d-flex align-self-stretch ftco-animate">
            <div class="media block-6 services mb-md-0 mb-4">
              <div class="icon bg-color-4 d-flex justify-content-center align-items-center mb-2">
            		<span class="flaticon-customer-service"></span>
              </div>
              <div class="media-body">
                <h3 class="heading">고객지원</h3>
                <span>24시간 문의가 대기중입니다</span>
              </div>
            </div>      
          </div>
        </div>
			</div>
		</section>

		<section class="ftco-section ftco-category ftco-no-pt">
			<div class="container">
				<div class="row">
					<h2 class="heading mb-5" >&nbsp;<b>현재 인기 음식점</b></h2>
					<div class="col-md-12">
						<div class="row">
							<c:forEach var="sVo" items="${sVos}" varStatus="st">
								<div class="col-md-6 col-lg-3 ftco-animate">
			    				<div class="product">
			    					<a href="${ctp}/store/storeMenu?idx=${sVo.idx}" class="img-prod"><img class="img-fluid" src="${ctp}/data/store/${sVo.logoPhoto}" alt="Colorlib Template">
			    						<span class="status">${st.count}위</span>
			    						<div class="overlay"></div>
			    					</a>
			    					<div class="text py-3 pb-4 px-3 text-center">
			    						<h3><a href="${ctp}/store/storeMenu?idx=${sVo.idx}">${sVo.storeName}</a></h3>
			    					</div>
			    				</div>
			    			</div>
							</c:forEach>
						</div>
					</div>
				</div>
			</div>
		</section>

    <section class="ftco-section">
    	<div class="container">
				<div class="row justify-content-center mb-3 pb-3">
          <div class="col-md-12 heading-section text-center ftco-animate">
          	<span class="subheading">특가 세일</span>
            <h2 class="mb-4">현재 세일중인 상품들</h2>
            <p>할인된 가격으로 저렴하게 즐겨보세요~</p>
          </div>
        </div>   		
    	</div>
    	<div class="container">
    		<div class="row">
    			<c:forEach var="fVo" items="${fVos}">
	    			<div class="col-md-6 col-lg-3 ftco-animate">
	    				<div class="product">
	    					<a href="${ctp}/store/storeMenuInfo?menuIdx=${fVo.menuIdx}" class="img-prod"><img class="img-fluid" src="${ctp}/data/storeFoodPhoto/${fVo.foodPhoto}" alt="Colorlib Template">
						 <!-- <span class="status">30%</span>
	    						<div class="overlay"></div> -->
	    					</a>
	    					<div class="text py-3 pb-4 px-3 text-center">
	    						<h3><a href="#">${fVo.storeName}</a></h3>
	    						<h4>${fVo.foodName}</h4>
	    						<div class="d-flex">
	    							<div class="pricing">
			    						<p class="price"><span class="mr-2 price-dc">${fVo.price}원</span><span class="price-sale"><fmt:formatNumber value="${fVo.price - fVo.salePrice}" pattern="#,###원" /></span></p>
			    					</div>
		    					</div>
		    					<div class="bottom-area d-flex px-3">
		    						<div class="m-auto d-flex">
		    							<!-- <a href="#" class="buy-now d-flex justify-content-center align-items-center mx-1">
		    								<span><i class="ion-ios-cart"></i></span>
		    							</a> -->
		    							<a href="javascript:fCheck('${fVo.storeName}', '${fVo.menuIdx}');" class="heart d-flex justify-content-center align-items-center ">
		    								<span><i class="ion-ios-heart"></i></span>
		    							</a>
	    							</div>
	    						</div>
	    					</div>
	    				</div>
	    			</div>
    			</c:forEach>
    		</div>
    	</div>
    </section>

    <hr>

		<section class="ftco-section ftco-partner">
    	<div class="container">
    		<div class="row">
    			<div class="col-sm ftco-animate">
    				<a href="#" class="partner"><img src="${ctp}/images/partner-1.png" class="img-fluid" alt="Colorlib Template"></a>
    			</div>
    			<div class="col-sm ftco-animate">
    				<a href="#" class="partner"><img src="${ctp}/images/partner-2.png" class="img-fluid" alt="Colorlib Template"></a>
    			</div>
    			<div class="col-sm ftco-animate">
    				<a href="#" class="partner"><img src="${ctp}/images/partner-3.png" class="img-fluid" alt="Colorlib Template"></a>
    			</div>
    			<div class="col-sm ftco-animate">
    				<a href="#" class="partner"><img src="${ctp}/images/partner-4.png" class="img-fluid" alt="Colorlib Template"></a>
    			</div>
    			<div class="col-sm ftco-animate">
    				<a href="#" class="partner"><img src="${ctp}/images/partner-5.png" class="img-fluid" alt="Colorlib Template"></a>
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
    
  </body>
</html>
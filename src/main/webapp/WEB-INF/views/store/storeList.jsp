<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<html>
  <head>
    <title>해찬들 연습장</title>
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
    	function warning() {
    		alert("서비스 준비중입니다! 이용에 불편함을 드려 죄송합니다.");
    		return false;
    	}
    	
    </script>
    
  </head>
  
  <body class="goto-here">
  	<jsp:include page="/WEB-INF/views/include/nav.jsp"></jsp:include>		
    <div class="hero-wrap hero-bread" style="background-image: url('${ctp}/images/${storePart}.jpg');">
      <div class="container">
        <div class="row no-gutters slider-text align-items-center justify-content-center">
          <div class="col-md-2 ftco-animate text-center">
            <h1 class="mb-0 bread bg-primary">${storePart}</h1>
          </div>
        </div>
      </div>
    </div>

    <section class="ftco-section">
    	<div class="container">
    		<div class="row justify-content-center">
    			<div class="col-md-10 mb-5 text-center">
    				<ul class="product-category">
  						<%-- <li><a href="${ctp}/store/storeList?storePart=${storePart}" class="active">전 체</a></li> --%>
  						<li><a href="${ctp}/store/storeList?storePart=${storePart}" >전 체</a></li>
  						<li><a href="${ctp}/store/storeList?storePart=${storePart}&ordered=rateAvg">별점 높은 순</a></li>
    					<li><a href="javascript:warning()">주문 많은 순</a></li>
    					<li><a href="javascript:warning()">가까운 순</a></li>
    					<li><a href="javascript:warning()">찜 많은 순</a></li>
    				</ul>
    			</div>
    		</div>
    		<div class="row">
    			<%-- <div class="col-md-6 col-lg-3 ftco-animate">
    				<div class="product">
    					<a href="#" class="img-prod"><img class="img-fluid" src="${ctp}/images/product-1.jpg" alt="Colorlib Template">
    						<span class="status">30%</span>
    						<div class="overlay"></div>
    					</a>
    					<div class="text py-3 pb-4 px-3 text-center">
    						<h3><a href="#">Bell Pepper</a></h3>
    						<div class="d-flex">
    							<div class="pricing">
		    						<p class="price"><span class="mr-2 price-dc">$120.00</span><span class="price-sale">$80.00</span></p>
		    					</div>
	    					</div>
	    					<div class="bottom-area d-flex px-3">
	    						<div class="m-auto d-flex">
	    							<a href="#" class="add-to-cart d-flex justify-content-center align-items-center text-center">
	    								<span><i class="ion-ios-menu"></i></span>
	    							</a>
	    							<a href="#" class="buy-now d-flex justify-content-center align-items-center mx-1">
	    								<span><i class="ion-ios-cart"></i></span>
	    							</a>
	    							<a href="#" class="heart d-flex justify-content-center align-items-center ">
	    								<span><i class="ion-ios-heart"></i></span>
	    							</a>
    							</div>
    						</div>
    					</div>
    				</div>
    			</div> --%>
    			<c:forEach var="vo" items="${vos}">
	    			<div class="col-md-6 col-lg-3 ftco-animate">
	    				<div class="product">
	    					<a href="${ctp}/store/storeMenu?idx=${vo.idx}" class="img-prod"><img class="img-fluid" src="${ctp}/data/store/${vo.logoPhoto}" alt="Colorlib Template">
	    						<div class="overlay"></div>
	    					</a>
	    					<div class="text py-3 pb-4 px-3 text-center">
	    					<c:if test="${vo.rateAvg == 0.0}">
	    						<span class="icon-star"></span><h3><a href="#">${vo.rateAvg}</a></h3>
	    					</c:if>
	    					<c:if test="${vo.rateAvg != 0.0}">
	    						<font color="orange"><span class="icon-star"></span></font><h3><a href="#">${vo.rateAvg}</a></h3>
	    					</c:if>
	    						<h3><a href="#">${vo.storeName}</a></h3>
	    						<div class="d-flex">
		    					</div>
	    					</div>
	    				</div>
	    			</div>
					</c:forEach>
    		</div>
    		
    		
    		<!-- 페이징 처리 시작 -->
    		<div class="row mt-5">
          <div class="col text-center">
            <div class="block-27">
              <ul>
              	<c:if test="${pageVo.pag > 1}">
						      <li><a href="${ctp}/store/storeList?storePart=${storePart}&pageSize=${pageVo.pageSize}&pag=1">&lt;&lt;</a></li>
						    </c:if>
                <c:if test="${pageVo.curBlock > 0}">
						      <li><a class="page-link text-secondary" href="${ctp}/store/storeList?storePart=${storePart}&pageSize=${pageVo.pageSize}&pag=${(pageVo.curBlock-1)*pageVo.blockSize + 1}">&lt;</a></li>
						    </c:if>
                <c:forEach var="i" begin="${(pageVo.curBlock)*pageVo.blockSize + 1}" end="${(pageVo.curBlock)*pageVo.blockSize + pageVo.blockSize}" varStatus="st">
						      <c:if test="${i <= pageVo.totPage && i == pageVo.pag}">
						    		<li class="active"><a href="${ctp}/store/storeList?storePart=${storePart}&pageSize=${pageVo.pageSize}&pag=${i}">${i}</a></li>
						    	</c:if>
						      <c:if test="${i <= pageVo.totPage && i != pageVo.pag}">
						    		<li><a href="${ctp}/store/storeList?storePart=${storePart}&pageSize=${pageVo.pageSize}&pag=${i}">${i}</a></li>
						    	</c:if>
						    	<c:if test="${pageVo.curBlock < pageVo.lastBlock}">
							      <li><a class="page-link text-secondary" href="${ctp}/store/storeList?storePart=${storePart}&pageSize=${pageVo.pageSize}&pag=${(pageVo.curBlock+1)*pageVo.blockSize + 1}">&gt;</a></li>
							    </c:if>
						    </c:forEach>
						     <c:if test="${pageVo.pag < pageVo.totPage}">
						       <li><a href="${ctp}/store/storeList?storePart=${storePart}&pageSize=${pageVo.pageSize}&pag=${pageVo.totPage}">&gt;&gt;</a></li>
						     </c:if>
              </ul>
            </div>
          </div>
        </div>
	    	<!-- 페이징 처리 끝 -->
        
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

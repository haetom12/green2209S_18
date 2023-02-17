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
		<c:if test="${vSize == 0}">
     		<div class="container">
       		<div class="row">
      			<img src="${ctp}/images/NotReady.jpg" style="margin: 0 auto;" />
        	</div>
      	</div>
  	</c:if>

  	<c:if test="${vSize != 0}">
	    <section class="ftco-section ftco-degree-bg">
	      <div class="container">
	        <div class="row">
		          <div class="col-lg-8 ftco-animate">
								<div class="row">
		              <c:forEach var="vo" items="${vos}" varStatus="st">
										<div class="col-md-12 d-flex ftco-animate">
					            <div class="blog-entry align-self-stretch d-md-flex">
					              <a href="${ctp}/store/storeMenuInfo?menuIdx=${vo.menuIdx}" class="block-20" style="background-image: url('${ctp}/data/storeFoodPhoto/${vo.foodPhoto}');"></a>
						              <div class="text d-block pl-md-4 ml-3">
						              	<div class="meta mb-3">
						                  <div><a href="#">July 20, 2019</a></div>
						                  <div><a href="#">Admin</a></div>
						                  <div><a href="#" class="meta-chat"><span class="icon-chat"></span> 3</a></div>
						                </div>
						                <h3 class="heading"><a href="#">${vo.foodName}</a></h3>
						                <p>${vo.foodInfo}</p>
						                <c:if test="${vo.sale == 'O'}">
									    				<font style="text-decoration: line-through red; font-size: 15pt;">${vo.price}원</font>&nbsp;<font style="font-size: 20pt; color: green;">${vo.salePrice}원</font>
						                </c:if>
						                <c:if test="${vo.sale != 'O'}">
									    				<font style="font-size: 20pt;">${vo.price}원</font>
						                </c:if>
						                <p></p>
						                <p>
						                <a href="${ctp}/store/storeMenuInfo?menuIdx=${vo.menuIdx}" class="btn btn-primary py-2 px-3">주문하기</a>
						                <a href="javascript:fCheck('${vo.storeName}', '${vo.menuIdx}');"><i class="icon-shopping-cart btn btn-warning">찜하기</i></a>
						                </p>
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
										      <li><a href="${ctp}/store/storeMenu?foodTag=${foodTag}&idx=${idx}&pageSize=${pageVo.pageSize}&pag=1">&lt;&lt;</a></li>
										    </c:if>
				                <c:if test="${pageVo.curBlock > 0}">
										      <li><a class="page-link text-secondary" href="${ctp}/store/storeMenu?foodTag=${foodTag}&idx=${idx}&pageSize=${pageVo.pageSize}&pag=${(pageVo.curBlock-1)*pageVo.blockSize + 1}">&lt;</a></li>
										    </c:if>
				                <c:forEach var="i" begin="${(pageVo.curBlock)*pageVo.blockSize + 1}" end="${(pageVo.curBlock)*pageVo.blockSize + pageVo.blockSize}" varStatus="st">
										      <c:if test="${i <= pageVo.totPage && i == pageVo.pag}">
										    		<li class="active"><a href="${ctp}/store/storeMenu?foodTag=${foodTag}&idx=${idx}&pageSize=${pageVo.pageSize}&pag=${i}">${i}</a></li>
										    	</c:if>
										      <c:if test="${i <= pageVo.totPage && i != pageVo.pag}">
										    		<li><a href="${ctp}/store/storeMenu?foodTag=${foodTag}&idx=${idx}&pageSize=${pageVo.pageSize}&pag=${i}">${i}</a></li>
										    	</c:if>
										    	<c:if test="${pageVo.curBlock < pageVo.lastBlock}">
											      <li><a class="page-link text-secondary" href="${ctp}/store/storeMenu?foodTag=${foodTag}&idx=${idx}&pageSize=${pageVo.pageSize}&pag=${(pageVo.curBlock+1)*pageVo.blockSize + 1}">&gt;</a></li>
											    </c:if>
										    </c:forEach>
										     <c:if test="${pageVo.pag < pageVo.totPage}">
										       <li><a href="${ctp}/store/storeMenu?foodTag=${foodTag}&idx=${idx}&pageSize=${pageVo.pageSize}&pag=${pageVo.totPage}">&gt;&gt;</a></li>
										     </c:if>
				              </ul>
				            </div>
				          </div>
				        </div>
					    	<!-- 페이징 처리 끝 -->
					    	
		          </div> <!-- .col-md-8 -->
	          
		          <div class="col-lg-4 sidebar ftco-animate">
		            <div class="sidebar-box">
		              <form action="#" class="search-form">
		                <div class="form-group">
		                  <span class="icon ion-ios-search"></span>
		                  <input type="text" class="form-control" placeholder="검색">
		                </div>
		              </form>
		            </div>
		            <div class="sidebar-box ftco-animate">
		            	<h3 class="heading">카테고리</h3>
		              <ul class="categories">
		                <!-- <li><a href="#">Vegetables <span>(12)</span></a></li>
		                <li><a href="#">Fruits <span>(22)</span></a></li>
		                <li><a href="#">Juice <span>(37)</span></a></li>
		                <li><a href="#">Dries <span>(42)</span></a></li> -->
		                <c:forEach var="tVo" items="${tVos}" varStatus="tSt">
		                	<li><a href="${ctp}/store/storeMenu?idx=${vo.idx}&foodTag=${tVo.foodTag}">${tVo.foodTag}<span></span></a></li>
		                </c:forEach>
		              </ul>
		            </div>
		
		            <div class="sidebar-box ftco-animate">
		              <h3 class="heading">최근 별점&nbsp;<font size="2pt"><a href="${ctp}/store/storeRatingList?storeName=${vo.storeName}" class="goRating">(모든 별점 보러가기)</a></font></h3>
		              <c:forEach var="rVo" items="${rVos}">
			              <div class="block-21 mb-4 d-flex">
			                <!-- <a class="blog-img mr-4" style="background-image: url(images/image_2.jpg);"></a> -->
			                <div class="text">
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
			                  <h3 class="heading-1"><a href="#">${rVo.title}</a></h3>
			                  <div class="meta">
			                    <div><a href="#"><span class="icon-calendar"></span></a>&nbsp;${fn:substring(rVo.ratingDate,0,fn:length(rVo.ratingDate)-5)}</div>
			                    <div><a href="#"><span class="icon-person"></span></a>&nbsp;${rVo.mid}</div>
			                  </div>
			                </div>
			              </div>
			              <hr />
		              </c:forEach>
		            </div>
		
		            <div class="sidebar-box ftco-animate">
		              <h3 class="heading">Tag Cloud</h3>
		              <div class="tagcloud">
		                <a href="#" class="tag-cloud-link">fruits</a>
		                <a href="#" class="tag-cloud-link">tomatoe</a>
		                <a href="#" class="tag-cloud-link">mango</a>
		                <a href="#" class="tag-cloud-link">apple</a>
		                <a href="#" class="tag-cloud-link">carrots</a>
		                <a href="#" class="tag-cloud-link">orange</a>
		                <a href="#" class="tag-cloud-link">pepper</a>
		                <a href="#" class="tag-cloud-link">eggplant</a>
		              </div>
		            </div>
		
		            <div class="sidebar-box ftco-animate">
		              <h3 class="heading">Paragraph</h3>
		              <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Ducimus itaque, autem necessitatibus voluptate quod mollitia delectus aut, sunt placeat nam vero culpa sapiente consectetur similique, inventore eos fugit cupiditate numquam!</p>
		            </div>
		          </div>
						
	        </div>
	        
	      </div>
	    </section> <!-- .section -->
		</c:if>

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

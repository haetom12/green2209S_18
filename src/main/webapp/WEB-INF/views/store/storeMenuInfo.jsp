<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<% pageContext.setAttribute("newLine", "\n"); %>
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
    	
    	
    	let idxArray = new Array();		/* 배열의 개수 지정없이 동적배열로 설정하고있다. */
        
      	// 옵션박스에서, 옵션항목을 선택하였을때 처리하는 함수
        $(function(){
        	$("#selectOption").change(function(){
        		let selectOption = $(this).val();
        		let idx = selectOption.substring(0,selectOption.indexOf(":"));					// 현재 옵션의 고유번호
        		let subMenuName = selectOption.substring(selectOption.indexOf(":")+1,selectOption.indexOf("_"));	// 옵션명
        		let optionPrice = selectOption.substring(selectOption.indexOf("_")+1);	// 옵션가격
        		let commaPrice = numberWithCommas(optionPrice);			// 콤마붙인 가격
        		
        		// 선택박스의 내용을 한개라도 선택하게된다면 선택된 옵션의 '고유번호/옵션명/콤마붙인가격'을 화면에 출력처리해준다.
        		if($("#layer"+idx).length == 0 && selectOption != "") {		// 옵션이 하나라도 있으면 처리하게 된다.
        		  idxArray[idx] = idx;
        		  
    	    		let str = '';
    	    		str += '<div class="layer row mb-1" id="layer'+idx+'"><div class="col">'+subMenuName+'</div>';
    	    		str += '<input type="number" class="text-center numBox" id="numBox'+idx+'" name="optionNum" onchange="numChange('+idx+')" style="width:50px;" value="1" min="1"/>개 &nbsp;';
    	    		str += '<input type="text" id="imsiPrice'+idx+'" class="price"  value="'+commaPrice+'" style="width:80px;" readonly />';
    	    		str += '<input type="hidden" id="price'+idx+'" value="'+optionPrice+'"/> &nbsp;';			/* 변동되는 가격을 재계산하기위해 price+idx 아이디를 사용하고 있다. */
    	    		str += '<input type="button" class="btn btn-outline-danger btn-sm" onclick="remove('+idx+')" value="삭제"/>';
    	    		str += '<input type="hidden" name="statePrice" id="statePrice'+idx+'" value="'+optionPrice+'"/>';		/* 현재상태에서의 변경된 상품(옵션)의 가격이다. */
    	    		str += '<input type="hidden" name="optionIdx" value="'+idx+'"/>';
    	    		str += '<input type="hidden" name="subMenuName" value="'+subMenuName+'"/>';
    	    		str += '<input type="hidden" name="optionPrice" value="'+optionPrice+'"/>';
    	    		str += '</div>';
    	    		$("#product1").append(str);
    	    		onTotal();
        	  }
        	  else {
        		  alert("이미 선택한 옵션입니다.");
        	  }
        	});
        });

    	
    	
     // 등록(추가)시킨 옵션 상품 삭제하기
        function remove(idx) {
      	  $("div").remove("#layer"+idx);
      	  onTotal();
        }
        
        // 상품의 총 금액 (재)계산하기
        function onTotal() {
      	  let total = 0;
      	  for(let i=0; i<idxArray.length; i++) {
      		  if($("#layer"+idxArray[i]).length != 0) {
      		  	total +=  parseInt(document.getElementById("price"+idxArray[i]).value);
      		  	document.getElementById("totalPriceResult").value = total;
      		  }
      	  }
      	  document.getElementById("totalPrice").value = numberWithCommas(total);
        }
        
        
        // 수량 변경시 처리하는 함수
        function numChange(idx) {
        	let price = document.getElementById("statePrice"+idx).value * document.getElementById("numBox"+idx).value;
        	document.getElementById("imsiPrice"+idx).value = numberWithCommas(price);
        	document.getElementById("price"+idx).value = price;
        	onTotal();
        }
        
        
        // 장바구니 호출시 수행함수
        function cart() {
	    		let sPart = '${sPart}';
	    		
	    		if(sPart == "") {
	    			alert("장바구니는 로그인 후 가능합니다!");
	    			return false;
	    		}
        	
        	if(document.getElementById("totalPrice").value==0) {
        		alert("옵션을 선택해주세요");
        		return false;
        	}
        	else {
        		console.log("mid : " + myform.mid.value);
        		console.log("menuIdx : " + myform.menuIdx.value);
        		console.log("foodName : " + myform.foodName.value);
        		console.log("mainPrice : " + myform.mainPrice.value);
        		console.log("thumbImg : " + myform.thumbImg.value);
        		console.log("storeName : " + myform.storeName.value);
        		console.log("flag : " + myform.flag.value);
        		console.log("totalPrice : " + myform.totalPrice.value);
        		document.myform.submit(); 
        	}
        }
        
        
        // 직접 주문하기
        function order() {
        	
	    		let sPart = '${sPart}';
	    		
	    		if(sPart == "") {
	    			alert("주문은 로그인 후 가능합니다!");
	    			return false;
	    		}
        	
        	let totalPrice = document.getElementById("totalPrice").value;
        	if('${sMid}' == "") {
        		alert("로그인 후 이용 가능합니다.");
        		location.href = "${ctp}/member/memLogin";
        	}
        	else if(totalPrice=="" || totalPrice==0) {
        		alert("옵션을 선택해주세요");
        		return false;
        	}
        	else {
        		document.getElementById("flag").value = "order";
        		document.myform.submit();
        	}
        }
        
        
        // 천단위마다 콤마를 표시해 주는 함수
        function numberWithCommas(x) {
        	return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g,",");
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

    <section class="ftco-section">
    	<div class="container">
    		<div class="row">
    			<div class="col-lg-6 mb-5 ftco-animate">
    				<a href="${ctp}/data/storeFoodPhoto/${fVo.foodPhoto}" class="image-popup"><img src="${ctp}/data/storeFoodPhoto/${fVo.foodPhoto}" style="width: 500px;" class="img-fluid" alt="Colorlib Template"></a>
    			</div>
    			<div class="col-lg-6 product-details pl-md-5 ftco-animate">
    				<h3>${fVo.foodName}</h3>
    				<div class="rating d-flex">
							<p class="text-left mr-4">
								<a href="#" class="mr-2">5.0</a>
								<a href="#"><span class="ion-ios-star-outline"></span></a>
								<a href="#"><span class="ion-ios-star-outline"></span></a>
								<a href="#"><span class="ion-ios-star-outline"></span></a>
								<a href="#"><span class="ion-ios-star-outline"></span></a>
								<a href="#"><span class="ion-ios-star-outline"></span></a>
							</p>
							<p class="text-left mr-4">
								<a href="#" class="mr-2" style="color: #000;">100 <span style="color: #bbb;">Rating</span></a>
							</p>
							<p class="text-left">
								<a href="#" class="mr-2" style="color: #000;">500 <span style="color: #bbb;">Sold</span></a>
							</p>
						</div>
    				<c:if test="${fVo.sale == 'O'}">
	    				<font style="text-decoration: line-through red; font-size: 15pt;">${fVo.price}원</font>&nbsp;<font style="font-size: 20pt; color: green;">${fVo.salePrice}원</font>
            </c:if>
            <c:if test="${fVo.sale != 'O'}">
	    				<font style="font-size: 20pt;">${fVo.price}원</font>
            </c:if>
    				<p>${fVo.foodInfo}</p>
						<div class="row mt-4">
							<div class="col-md-6">
								<div class="form-group d-flex">
		              <div class="select-wrap">
	                  <div class="icon"><span class="ion-ios-arrow-down"></span></div>
	                  <form name="optionForm">  <!-- 옵션의 정보를 보여주기위한 form -->
		                  <select name="selectOption" id="selectOption" class="form-control">
		                  	<option value="" disabled selected>추가옵션</option>
		                  	<c:if test="${fVo.sale == 'O'}">
		                  		<option value="0:${fVo.foodName}_${fVo.salePrice}">기본메뉴(${fVo.foodName}) + ${fVo.salePrice}</option>
		                  	</c:if>
		                  	<c:if test="${fVo.sale != 'O'}">
		                  		<option value="0:${fVo.foodName}_${fVo.price}">기본메뉴(${fVo.foodName}) + ${fVo.price}</option>
		                  	</c:if>
				                  <c:forEach var="pVo" items="${vos}" varStatus="st">
														<option value="${pVo.subMenuIdx}:${pVo.subMenuName}_${pVo.price}">${pVo.subMenuName} + ${pVo.price}원</option>
				                  </c:forEach>
		                  </select>
                  	</form>
	                </div>
		            </div>
							</div>
							<div class="w-100"></div>
							<!-- <div class="input-group col-md-6 d-flex mb-3">
	             	<span class="input-group-btn mr-2">
	                	<button type="button" class="quantity-left-minus btn"  data-type="minus" data-field="">
	                   <i class="ion-ios-remove"></i>
	                	</button>
	            		</span>
	             	<input type="number" id="amount" name="amount" class="form-control input-number" value="1" min="1" max="100">
	             	<span class="input-group-btn ml-2">
	                	<button type="button" class="quantity-right-plus btn" data-type="plus" data-field="">
	                     <i class="ion-ios-add"></i>
	                 </button>
	             	</span>
	          	</div> -->
	          	<div class="col-md-12">
	          		<div class="cart-total mb-3">
	    					<h3>총 가격</h3>
	    					<%-- <p class="d-flex">
	    						<span>${fVo.foodName}</span>
	    						<span>${fVo.price}</span>
	    					</p> --%>
	    					<form name="myform" method="post" action="${ctp}/order/addCart">  <!-- 실제 상품의 정보를 넘겨주기 위한 form -->
							    <input type="hidden" name="mid" value="${sMid}"/>
							    <input type="hidden" name="menuIdx" value="${fVo.menuIdx}"/>
							    <input type="hidden" name="foodName" value="${fVo.foodName}"/>
							    <input type="hidden" name="mainPrice" value="${fVo.price}"/>
							    <input type="hidden" name="thumbImg" value="${fVo.foodPhoto}"/>
							    <input type="hidden" name="storeName" value="${fVo.storeName}"/>
							    <input type="hidden" name="sale" value="${fVo.sale}"/>
							    <input type="hidden" name="salePrice" value="${fVo.salePrice}"/>
							    <input type="hidden" name="totalPrice" id="totalPriceResult"/>
							    <input type="hidden" name="flag" id="flag"/>
				        	<!-- <a href="cart.html" class="btn btn-black py-3 px-4">장바구니에 담기</a> -->
    							<p id="product1"></p>
				    			<a href="javascript:fCheck('${fVo.storeName}', '${fVo.menuIdx}');"><i class="btn py-3 px-3 icon-shopping-cart btn btn-warning">찜하기</i></a>
				        	<input type="button" value="장바구니담기" onclick="cart()" class="btn btn-black py-3 px-4"/>
				        	<input type="button" value="주문하기" onclick="order()" class="btn btn-primary py-3 px-4"/>
							  </form>
	    					<hr>
	    					<p class="d-flex total-price" style="margin: 0 auto;">
	    						<%-- <span style="font-size: 20pt; width:100px; text-align: center;">총</span>
	    						<span><input type="text" class="totalPrice text-primary" id="totalPrice" value="<fmt:formatNumber value='0'/>" style="width: 125px; font-size: 20pt;" readonly />원</span> --%>
	    						<span><font size="5pt">총&nbsp;</font><input type="text" class="totalPrice text-primary" id="totalPrice" value="<fmt:formatNumber value='0'/>" style="width: 125px; font-size: 20pt;" readonly /><font size="5pt">&nbsp;원</font></span>
	    					</p>
	    				</div>
	          	</div>
          	</div>
          	<div class="col-lg-4 mt-5 cart-wrap ftco-animate">
	    				
	    			</div>
	    			<p>
    			</div>
    		</div>
    	</div>
    </section>

		<section class="ftco-section testimony-section">
      <div class="container">
        <div class="row justify-content-center mb-5 pb-3">
          <div class="col-md-7 heading-section ftco-animate text-center">
            <h2 class="mb-4">이런 메뉴는 어떠세요?</h2>
          </div>
        </div>
        <div class="row ftco-animate">
          <div class="col-md-12">
            <div class="carousel-testimony owl-carousel">
            	<c:forEach var="rVo" items="${rVos}">
	              <div class="item">
	                <div class="testimony-wrap p-4 pb-5">
		                <a href="${ctp}/store/storeMenuInfo?menuIdx=${rVo.menuIdx}">
		                	<img src="${ctp}/data/storeFoodPhoto/${rVo.foodPhoto}" style="width: 200px; margin: 0 auto;" />
		                  <%-- <div class="user-img mb-5" style="background-image: url(${ctp}/data/storeFoodPhoto/${rVo.foodPhoto})">
		                    <span class="quote d-flex align-items-center justify-content-center">
		                      <i class="icon-quote-left"></i>
		                    </span>
		                  </div> --%>
		                  <div class="text text-center">
		                    <p class="name">${rVo.foodName}</p>
		                    <c:if test="${rVo.sale == 'O'}">
		                    	<span class="position"><font style="text-decoration: line-through red; font-size: 7pt;">${rVo.price}원</font><br /><font style="font-size: 10pt; color: green;">${rVo.salePrice}원</font></span>
		                    </c:if>
		                    <c:if test="${rVo.sale != 'O'}">
		                    	<span class="position">${rVo.price}원</span>
		                    </c:if>
		                  </div>
	                  </a>
	                </div>
	              </div>
              </c:forEach>
            </div>
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
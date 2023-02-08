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
    	/* 
        $(document).ready(function() {
        	
        });
    	 */
    	// 음식 브랜드 선택시 리스트에 해당 음식 뿌리기
        function categoryCheck() {
        	let brandName = myform.brandName.value;
        	let storeName = '${vo.storeName}';
        	
    			/* location.href="${ctp}/store/adminBrandMenu?brandName="+brandName+"&storeName="+storeName; */
    			location.href="${ctp}/store/storeMenuInput2?brandName="+brandName+"&storeName="+storeName;
      	}
    	 
    	 
    	 /* 
        function categoryCheck() {
        	let brandName = myform.brandName.value;
        	let storeName = '${vo.storeName}';
        	
    			$.ajax({
    				type : "post",
    				url  : "${ctp}/store/adminBrandMenu",
    				data : {
    					brandName : brandName,
    					storeName : storeName
    					},
    				success:function(data) {
    					var str = "";
     					for(var i=0; i<data.length; i++) {
    						str += "<tr class='price'>";
    						str += "<td><input type='checkbox' name='chk' class='chk' value='"+data[i].menuIdx+"'/></td>";
    						str += "<td class='image-prod'><div class='img' style='background-image:url(${ctp}/data/adminFoodPhoto/"+data[i].foodPhoto+");'></td>";
    						str += "<td class='product-name'>"+data[i].foodName+"</td>";
    						str += "<td class='image-prod'>"+data[i].foodTag+"</td>";
    						str += "<td class='total'>"+data[i].price+"</td>";
    						str += "</tr>";
    					} 
     					
    					$("#demo").html(str);
    				},
    				error : function() {
    					alert("전송오류!");
    				}
    			});
      	}
    	  */
        
        
   	  // 전체선택
   	  $(function(){
   	  	$("#checkAll").click(function(){
   	  		if($("#checkAll").prop("checked")) {
   		    		$(".chk").prop("checked", true);
   	  		}
   	  		else {
   		    		$(".chk").prop("checked", false);
   	  		}
   	  	});
   	  });
   	  
   	  
   // 선택항목 가게에 저장하기(ajax처리하기)
	  function selectSaveCheck() {
	  	let ans = confirm("선택된 메뉴를 저장 하시겠습니까?");
	  	if(!ans) return false;
	  	let chkLength = $("input:checkbox[name=chk]").length;
	  	//alert($("input:checkbox[name=chk]:checked").length);
	  	
	  	let delItems = "";
	  	let storeName = '${vo.storeName}';
	  	for(let i=0; i<chkLength; i++) {
	  		if($('#chk'+i).is(':checked')) {
	  			delItems += $('#chk'+i).val() + "/";
	  		}
	  	}
	  	
	  	if(delItems == "") {
	  		alert("저장할 메뉴를 선택하세요.");
	  		return false;
	  	}
	  	
	  	location.href="${ctp}/store/adminMenuInputOk?delItems="+delItems+"&storeName="+storeName;
	  	
	  	
	  	/* 
	  	if(delItems == "") {
	  		alert("저장할 메뉴를 선택하세요.");
	  		return false;
	  	}
			
	  	$.ajax({
	  		type : "post",
	  		url  : "${ctp}/store/adminMenuInputOk	",
	  		data : {
	  			delItems : delItems,
	  			storeName : storeName
	  			},
	  		success:function(res) {
	  			if(res == "1") {
	  				alert("선택된 메뉴를 저장 하였습니다.");
	  			  location.reload();
	  			}
	  		},
	  		error  :function() {
	  			alert("전송오류!!");
	  		}
	  	});
			 */
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
			<div class="container">
				<div class="row">
    			<div class="col-md-12 ftco-animate">
    				<div class="cart-list">
    					<h2 class="text-center">메뉴 리스트</h2><br />
    					<form name="myform" method="post">
						    <select name="brandName" id="brandName" onchange="categoryCheck()" style="width: 12%;">
						    	<option value="" >프랜차이즈 선택</option>
		    		    	<c:forEach var="vo" items="${vos}">
						    		<option value="${vo.brandName}" ${vo.brandName==brandName  ? "selected" : ""} >${vo.brandName}</option>
						    	</c:forEach>
							  </select>
	    					<input type="button" value="메뉴 추가" onclick="selectSaveCheck()" class="btn btn-primary mb-1" style="float: right;"/>
		    				<table class="table">
							    <thead class="thead-primary">
							      <tr class="text-center">
							        <th><input type="checkbox" id="checkAll" />&nbsp;전체선택</th>
							        <th>카테고리</th>
							        <th>음식사진</th>
							        <th>음식이름</th>
							        <th>가격</th>
							      </tr>
							    </thead>
							    <!-- <tbody id="demo"></tbody> -->
							    <c:forEach var="mVo" items="${mVos}" varStatus="st">
							    	<tr class="text-center">
								    	<td><input type='checkbox' name='chk' class='chk' id="chk${st.index}" value='${mVo.menuIdx}'/></td>
								    	<%-- <td class='image-prod'><div class='img' style='background-image:url(${ctp}/data/adminFoodPhoto/${mVo.foodPhoto});'></div></td> --%>
								    	<td><img src="${ctp}/data/adminFoodPhoto/${mVo.foodPhoto}" style="width:150px; margin: 0px; padding: 0px;"></td>
								    	<td class='product-name'>${mVo.foodName}</td>
								    	<td class='image-prod'>${mVo.foodTag}</td>
								    	<td class='total'>${mVo.price}</td>
							    	</tr>
							    </c:forEach>
							  </table>
						  </form>
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
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
    'use strict';
    
    let couponUse = 0;
    
    function onTotal(){
      let total = 0;
      let maxIdx = document.getElementById("maxIdx").value;
      
      for(let i=1;i<=maxIdx;i++){
        if($("#totalPrice"+i).length != 0 && document.getElementById("idx"+i).checked){  
          total = total + parseInt(document.getElementById("totalPrice"+i).value); 
        }
      }
      document.getElementById("total").value=numberWithCommas(total);
      
      document.getElementById("baesong").value=${sVo.deliverCost};
      
      let lastPrice=parseInt(document.getElementById("baesong").value)+total;
      document.getElementById("lastPrice").value = numberWithCommas(lastPrice);
      document.getElementById("orderTotalPrice").value = numberWithCommas(lastPrice);
    }

		// ?????? ??????????????? ??????????????? ???????????? ??????
    function onCheck(){
      let maxIdx = document.getElementById("maxIdx").value;				// ?????????????????? ??????????????? ?????? ??? idx?????? maxIdx????????? ????????????.

      let cnt=0;
      for(let i=1;i<=maxIdx;i++){
        if($("#idx"+i).length != 0 && document.getElementById("idx"+i).checked==false){
          cnt++;
          break;
        }
      }
      if(cnt!=0){
        document.getElementById("allcheck").checked=false;
      } 
      else {
        document.getElementById("allcheck").checked=true;
      }
      onTotal();	// ??????????????? ??????????????? ?????? ??????????????? ??????.
    }
    
		// allCheck ??????????????? ??????/???????????? ???????????? ??????
    function allCheck(){
      let maxIdx = document.getElementById("maxIdx").value;
      if(document.getElementById("allcheck").checked){
        for(let i=1;i<=maxIdx;i++){
          if($("#idx"+i).length != 0){
            document.getElementById("idx"+i).checked=true;
          }
        }
      }
      else {
        for(let i=1;i<=maxIdx;i++){
          if($("#idx"+i).length != 0){
            document.getElementById("idx"+i).checked=false;
          }
        }
      }
      onTotal();	// ??????????????? ??????????????? ?????? ??????????????? ??????.
    }
    
		// ?????????????????? ????????? ????????? ?????? '??????'??????...
    function cartDelete(idx){
      let ans = confirm("???????????? ??????????????? ?????????????????? ?????? ???????????????????");
      if(!ans) return false;
      
      $.ajax({
        type : "post",
        url  : "${ctp}/order/myCartDelete",
        data : {idx : idx},
        success:function() {
          location.reload();
        },
        error : function() {
        	alert("????????????!");
        }
      });
    }
    
		// ?????????????????? ????????? ????????? '??????'????????????
    function order(){
			
			let minPrice = document.getElementById("minPrice").value;
			
			let orderTotalPrice = document.getElementById("orderTotalPrice").value;
			
			/* alert("?????? : " + orderTotalPrice); 
			alert("?????? : " + minPrice);  */
			
      for(let i=1; i<=maxIdx; i++){
        if($("#idx"+i).length != 0 && document.getElementById("idx"+i).checked){
          document.getElementById("checkItem"+i).value="1";
        }
      }

      if(document.getElementById("lastPrice").value==0){
        alert("?????????????????? ??????????????? ????????? ??????????????????!");
        return false;
      } 
      else if(minPrice > orderTotalPrice)    {
    	  alert("??????????????? ?????? ?????? ???????????? ????????????. \n ?????????????????? : " + minPrice + "???");
        return false;
      }   
      else {
        document.myform.submit();
      }
    }
    
		// ??????????????? ????????????
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
            <h1 class="mb-0 bread">????????????</h1>
<!--           	<p class="breadcrumbs"><span class="mr-2"><a href="index.html">??????</a></span></p>
            <h1 class="mb-0 bread">?????????</h1> -->
          </div>
        </div>
      </div>
    </div>

    <section class="ftco-section ftco-cart">
			<div class="container">
				<div class="row">
    			<div class="col-md-12 ftco-animate">
    				<div class="cart-list">
    					<h2 class="text-center">?????? ????????????</h2><br />
    					<form name="myform" method="post">
	    					<!-- <input type="button" value="????????????" onclick="deleteCheck()" class="btn btn-danger mb-1" style="float: right;"/> -->
		    				<table class="table">
							    <thead class="thead-primary">
									  <tr class="text-center">
									    <th><input type="checkbox" id="allcheck" onClick="allCheck()" class="m-2"/>????????????</th>
									    <th colspan="3">??????</th>
									    <th colspan="2">???????????????</th>
									  </tr>
							    </thead>
							   <!-- ???????????? ???????????? -->
								  <c:set var="maxIdx" value="0"/>
								  <c:forEach var="vo" items="${vos}">
								    <tr align="center">
								      <td><input type="checkbox" name="idxChecked" id="idx${vo.idx}" value="${vo.idx}" onClick="onCheck()" /></td>
								      <td><a href="${ctp}/store/storeMenuInfo?menuIdx=${vo.menuIdx}"><img src="${ctp}/data/storeFoodPhoto/${vo.thumbImg}" width="150px"/></a></td>
								      <td align="left">
								        <p class="contFont"><br/>
								          ?????? : <span style="color:orange;font-weight:bold;"><a href="${ctp}/store/storeMenuInfo?menuIdx=${vo.menuIdx}">${vo.foodName}</a></span><br/>
								        </p>
								        <c:set var="optionNames" value="${fn:split(vo.subMenuName,',')}"/>
								        <c:set var="optionPrices" value="${fn:split(vo.optionPrice,',')}"/>
								        <c:set var="optionNums" value="${fn:split(vo.optionNum,',')}"/>
								        <p style="font-size:12px">
								          - ?????? ??????
								          <c:if test="${fn:length(optionNames) > 1}">(???????????? ${fn:length(optionNames)-1}??? ??????)</c:if><br/>
								          <c:forEach var="i" begin="0" end="${fn:length(optionNames)-1}">
								            &nbsp;&nbsp;???${optionNames[i]} / <fmt:formatNumber value="${optionPrices[i]}"/>??? / ${optionNums[i]}???<br/>
								          </c:forEach> 
								        </p>
								      </td>
								      <td>${vo.storeName}</td>
								      <td>
								        <div class="text-center">
									        <b>??? : <fmt:formatNumber value="${vo.totalPrice}" pattern='#,###???'/></b><br/><br/>
									        <span style="color:#270;font-size:12px" class="buyFont">???????????? : ${fn:substring(vo.cartDate,0,10)}</span>
									        <input type="hidden" id="totalPrice${vo.idx}" value="${vo.totalPrice}"/>
								        </div>
								      </td>
								      <td>
								        <button type="button" onClick="cartDelete(${vo.idx})" class="btn btn-danger btn-sm m-1" style="border:0px;">????????????</button>
								        <input type="hidden" name="checkItem" value="0" id="checkItem${vo.idx}"/>	<!-- ??????????????? ?????? ?????? ????????? '0'?????? ??????????????? '1'??? ??????????????? ??????. -->
								        <input type="hidden" id="idx" name="idx" value="${vo.idx}"/>
								        <input type="hidden" id="thumbImg" name="thumbImg" value="${vo.thumbImg}"/>
								        <input type="hidden" id="foodName" name="foodName" value="${vo.foodName}"/>
								        <input type="hidden" id="mainPrice" name="mainPrice" value="${vo.mainPrice}"/>
								        
								        <input type="hidden" id="subMenuName" name="subMenuName" value="${optionNames}"/>
								        <input type="hidden" id="optionPrice"  name="optionPrice" value="${optionPrices}"/>
								        <input type="hidden" id="optionNum"  name="optionNum" value="${optionNums}"/>
								        <input type="hidden" id="totalPrice" name="totalPrice" value="${vo.totalPrice}"/>
								        <input type="hidden" id="notTotal" name="notTotal" value=""/>
								        <input type="hidden" id="orderAddress" name="orderAddress" value=""/>
								        <input type="hidden" id="mid" name="mid" value="${sMid}"/> 
								      </td>
								    </tr>
								    <c:set var="maxIdx" value="${vo.idx}"/>	<!-- ?????? ????????? ????????? idx?????? ?????? ??????. -->
								  </c:forEach>
								</table>
							  <input type="hidden" id="maxIdx" name="maxIdx" value="${maxIdx}"/>
							  <input type="hidden" name="orderTotalPrice" id="orderTotalPrice"/>
						    <input type="hidden" name="baesong" value="${sVo.deliverCost}"/>
						    <input type="hidden" id="minPrice" name="minPrice" value="${cVo.minPrice}"/>
							</form>
					  </div>
    			</div>
    		</div>
    		
    		
    		<div class="row justify-content-end">
    			<div class="col-lg-4 mt-5 cart-wrap ftco-animate">
    				<div class="cart-total mb-3">
    					<h3><b>?????? ??????</b></h3>
    					<p class="d-flex">
    						<span>?????????</span>
    						<span><input type="text" id="total" value="0" class="totSubBox form-control" style="width: 100px;" readonly/></span>
    					</p>
    					<p class="d-flex">
    						<span>?????????</span>
    						<span><input type="text" id="baesong" value="${sVo.deliverCost}"  class="totSubBox form-control" style="width: 100px;" readonly/></span>
    						<%-- <span>${sVo.deliverCost}???</span> --%>
    					</p>
    				<!-- 	<p class="d-flex">
    						<span>Discount</span>
    						<span>$3.00</span>
    					</p> -->
    					<hr>
    					<div>
    						<span>??????????????????</span>&nbsp;&nbsp;&nbsp;<span>:</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    						<span><fmt:formatNumber value="${cVo.minPrice}" pattern='#,###???'/></span>
    					</div>
    					<div>
	    					<p class="d-flex total-price mt-2">
	    						<span>???</span>
	    						<span><input type="text" id="lastPrice" value="0" class="totSubBox form-control" style="width: 100px;" readonly/></span>
	    					</p>
    					</div>
    				</div>
    				<p><input type="button" value="????????????" class="btn btn-primary py-3 px-4" onClick="order()"/></p>
    				<!-- <p><a href="#" onClick="order()" class="btn btn-primary py-3 px-4">????????????</a></p> -->
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
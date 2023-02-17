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
    <script src="${ctp}/ckeditor/ckeditor.js"></script>
    
    <style>
    	#myform fieldset{
			    display: inline-block;
			    direction: rtl;
			    border:0;
			}
			#myform fieldset legend{
			    text-align: right;
			}
			#myform input[type=radio]{
			    display: none;
			}
			#myform label{
			    font-size: 3em;
			    color: transparent;
			    text-shadow: 0 0 0 #808080;
			    /* text-shadow: 0 0 0 #f0f0f0; */
			}
			#myform label:hover{
			    text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
			}
			#myform label:hover ~ label{
			    text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
			}
			#myform input[type=radio]:checked ~ label{
			    text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
			}

    </style>
    
    <script>
    'use strict';
    
    const rating_input = document.querySelector('.rating input');
    const rating_star = document.querySelector('.rating_star');

    // 별점 드래그 할 때
    rating_input.addEventListener('input', () => {
      rating_star.style.width = `${rating_input.value * 10}%`;
    });
    
    function fCheck() {
			let title = myform.title.value;
			
			if(title.trim()=="") {
				alert("제목 입력은 필수입니다!");
				myform.title.focus();
				return false;
			}
			else {
				myform.submit();
			}
    	
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

		<section class="ftco-section contact-section bg-white">
      <div class="container">
        <div class="row block-9">
          <div class="col-md-12 order-md-last d-flex">
            <form name="myform" id="myform" action="${ctp}/store/ratingUpdate" method="post" class="bg-light p-5 contact-form">
	          	<div class="text-primary text-center"><font size="6pt">별점 수정(${vo.storeName})</font></div>
	          	<font size="5pt">음식은 어떠셨나요?</font>
           	  <fieldset style="margin: 0 auto">
								<input type="radio" name="reviewStar" ${vo.reviewStar==5  ? "checked" : ""} value="5" id="rate1"><label
									for="rate1">★</label>
								<input type="radio" name="reviewStar" ${vo.reviewStar==4  ? "checked" : ""} value="4" id="rate2"><label
									for="rate2">★</label>
								<input type="radio" name="reviewStar" ${vo.reviewStar==3  ? "checked" : ""} value="3" id="rate3"><label
									for="rate3">★</label>
								<input type="radio" name="reviewStar" ${vo.reviewStar==2  ? "checked" : ""} value="2" id="rate4"><label
									for="rate4">★</label>
								<input type="radio" name="reviewStar" ${vo.reviewStar==1  ? "checked" : ""} value="1" id="rate5"><label
									for="rate5">★</label>
							</fieldset>
              <div class="form-group">
              	<div class="input-group mb-3">
							    <div class="input-group-prepend">
							      <span class="input-group-text">리뷰제목</span>
							    </div>
							    <input type="text" name="title" class="form-control" value="${vo.title}">
							  </div>
                <textarea rows="6" name="content" id="CKEDITOR" class="form-control" required>${vo.content}</textarea>
                <script>
				          CKEDITOR.replace("content",{
				        	  height:500,
				        	  filebrowserUploadUrl:"${ctp}/order/imageUpload",
				        	  uploadUrl : "${ctp}/order/imageUpload"
				          });
				        </script>
              </div>
              <input type="hidden" name="idx"  value="${vo.idx}"/>
              <input type="hidden" name="orderIdx"  value="${vo.orderIdx}"/>
              <input type="hidden" name="mid"  value="${vo.mid}"/>
              <input type="hidden" name="storeName"  value="${vo.storeName}"/>
              <input type="hidden" name="memberNickName"  value="${vo.memberNickName}"/>
          		<input type="button" value="별점 수정" style="float: right;" onclick="fCheck()" class="btn btn-primary mb-1 ml-3" />
          		<input type="button" value="돌아가기" style="float: right;" onclick="location.href='${ctp}/store/storeRatingList?storeName=${vo.storeName}';" class="btn btn-secondary mb-1 ml-3" />
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
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
    
		<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
		<link rel="stylesheet" href="https://www.w3schools.com/lib/w3-theme-blue.css">
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.3.0/css/font-awesome.min.css">
		
		<link rel="stylesheet" type="text/css" href="${ctp}/vendors/styles/core.css">
		<link rel="stylesheet" type="text/css" href="${ctp}/vendors/styles/icon-font.min.css">
		<link rel="stylesheet" type="text/css" href="${ctp}/vendors/styles/style.css">

		<script>
			'use strict';
			function memberCheck() {
				let mid = myform.mid.value;
				let pwd = myform.pwd.value;
				let sMid = '${sMid}';
				
				if(mid == "") {
					alert("???????????? ???????????????.");
					myform.mid.focus();
					return false;
				}
				else if(mid != sMid) {
					alert("???????????? ???????????? ????????????.");
					myform.mid.focus();
					return false;
				}
				else if(pwd == "") {
					alert("??????????????? ???????????????.");
					myform.pwd.focus();
					return false;
				}
				
				$.ajax({
				  	type   : "post",
				  	url    : "${ctp}/member/memberDeleteCheck",
				  	data   : {
				  		mid : mid,
				  		pwd : pwd
				  		} ,
				  	success:function(res) {
				  		if(res == "1") {
				  			alert("??????????????? ???????????? ?????????????????????. 5????????? ???????????????!");
								document.getElementById("checkBtn").style.display = 'none';
				       	document.getElementById("deleteBtn").style.display = 'block'; 	
				       	document.getElementById("codeForm").style.display = 'block'; 	
				  		}
				  		else {
				  			alert("????????? ?????? ??????????????? ????????????!");
				  		}
				  	},
				  	error : function() {
				  		alert("?????? ??????~~");
				  	}
				  });	
				
			}
			
			function codeCheck() {
				let code = myform.code.value;
				
				if(code == "") {
					alert("????????? ???????????????.");
					myform.code.focus();
					return false;
				}
				
				$.ajax({
				  	type   : "post",
				  	url    : "${ctp}/member/memberDeleteCodeCheck",
				  	data   : {
				  		code : code
				  		},
				  	success:function(res) {
				  		if(res == "1") {
				  			alert("?????? ????????? ?????????????????????!");
				  			let ans = confirm("??????????????? ?????? ????????? ???????????????. ?????? ?????????????????????????");
								if(!ans) return false;
								
								location.href="${ctp}/member/memberDeleteOk";
								
				  		}
				  		else {
				  			alert("????????? ????????????!");
				  		}
				  	},
				  	error : function() {
				  		alert("?????? ??????~~");
				  	}
			  });	
			}
			
		</script>

		
  </head>
  <body class="goto-here">
  
		<jsp:include page="/WEB-INF/views/include/nav.jsp"></jsp:include>		

	<!-- Header -->
	<header class="w3-container w3-padding bg-primary" id="myHeader">
	  <div class="w3-center mt-3">
		  <h4>???????????????!</h4>
		  <h1 class="w3-xxxlarge w3-animate-bottom w3-text-white">${vo.memberNickName} ???</h1>
	  </div>
	</header>

    <section class="ftco-section testimony-section" >
    	<div class="container">
				<div class="pd-20 card-box mb-30">
					<div class="clearfix">
						<h3 class="text-blue h3" style="text-align: center;">?????? ??????</h3>
						<p class="mb-30" style="text-align: center;"><b>????????? ?????????????????? ???????????? ??????????????? ???????????????</b></p>
					</div>
					<form name="myform" method="post">
						<div class="form-group">
							<label>?????????</label>
							<input class="form-control" id="mid" name="mid" placeholder="????????? ???????????????" type="text">
						</div>
						<div class="form-group">
							<label> ????????????</label>
							<input class="form-control" id="pwd" name="pwd" placeholder="??????????????? ???????????????" type="password">
						</div>
						<div class="form-group" id="codeForm" style="display: none;">
							<label>???????????? ??????</label>
							<input class="form-control" id="code" name="code" placeholder="??????????????? ???????????????" type="password">
						</div>
						<input type="button" value="????????????"  id="checkBtn" name="checkBtn" onclick="memberCheck()" style="float: right;" class="btn btn-success ml-2" />
						<input type="button" value="????????????" id="deleteBtn" name="deleteBtn" onclick="codeCheck()" style="display: none; float: right;" class="btn btn-success ml-2" />
						<input type="button" value="????????????" onclick="location.href='${ctp}/member/myPage';" style="float: right;" class="btn btn-secondary mr-2" />
					</form>
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
		<!-- js -->
	<script src="${ctp}/vendors/scripts/core.js"></script>
	<script src="${ctp}/vendors/scripts/script.min.js"></script>
	<script src="${ctp}/vendors/scripts/process.js"></script>
	<script src="${ctp}/vendors/scripts/layout-settings.js"></script>
    
  </body>
</html>
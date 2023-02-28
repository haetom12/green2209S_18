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
   	  
   // 선택항목 가게에 저장하기(ajax처리하기)
	  function deleteCheck(idx) {
	  	let ans = confirm("선택한 문의를 삭제하시겠습니까?");
	  	if(!ans) return false;
	  	
	  	$.ajax({
    		type   : "post",
    		url    : "${ctp}/QnA/QnADelete",
    		data   : {idx : idx},
    		success:function(res) {
    			if(res == "0") {
    				alert("문의 삭제에 실패하였습니다. 다시 시도해주세요.");
    			}
    			else {
    				alert("선택한 문의가 삭제 되었습니다!");
    				location.href='${ctp}/QnA/QnAList';
    			}
    		},
    		error : function() {
    			alert("전송 오류~~");
    		}
    	});
	  }
   
   	// 댓글 입력
	  function replyCheck(idx) {
		  let content = $("#content").val();
		  let title = '${vo.title}';
		  let part = '${vo.part}';
		  
	  	if(content.trim() == "") {
	  		alert("댓글을 입력하세요");
	  		$("#content").focus();
	  		return false;
	  	}
	  	
	  	let ans = confirm("댓글을 입력하시겠습니까?");
	  	if(!ans) return false;
	  	
	  	
	  	let query = {
				idx  : idx,
				title  : title,
				part  : part,
				content  : content
	  	}
	  	
	  	$.ajax({
	  		type : "post",
	  		url  : "${ctp}/admin/adminQnAInput",
	  		data : query,
	  		success:function(res) {
	  			if(res == "1") {
	  				alert("답변이 입력되었습니다.");
	  				location.reload();
	  			}
	  			else {
	  				alert("답변 입력 실패~~~");
	  			}
	  		},
				error  : function() {
					alert("전송 오류!!");
				}
	  	});
		}	
   
   
	// 답글 삭제
		function answerDelete(idx) {
	    	let ans = confirm("선택한 답글을 삭제하겠습니까?");
	    	if(!ans) return false;
	    	
	    	$.ajax({
	    		type   : "post",
	    		url    : "${ctp}/admin/QnAnwerDelete",
	    		data   : {
	    			idx : idx
	    			},
	    		success:function(res) {
	    		  if(res == "1") {
	    				alert("답글을 삭제하였습니다!");
	    				location.reload();
	    		  }
	    			else {
	    				alert("답글 삭제에 실패하였습니다! 다시 시도하세요.");
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

	<!-- =============================================== -->
	<section class="ftco-section testimony-section "  style="margin-top: 5%;">
  	<div class="container">
			<div class="pd-20 card-box mb-30">
				<div class="clearfix">
					<h3 class="text-blue h3" style="text-align: center;">내 문의</h3>
				</div>
				<form name="myform" method="post">
					<div class="form-group">
						<label>문의 제목</label>
						<input class="form-control" value="${vo.title}" type="text" readonly>
					</div>
					<div class="form-group">
						<label>문의 유형</label>
						<input class="form-control" value="${vo.part}" type="text" readonly>
					</div>
					<div class="form-group">
						<label>문의 내용</label>
						<div class="bg-light" style="height: 500px; overflow: auto;">${vo.content}</div>
					</div>
				</form>
				
				<div class="form-group">
			    <hr />
			    <h4>댓글 목록</h4>
			    <br />
					<div>
						<c:forEach var="cVo" items="${vos}">
							<span>${cVo.nickName}(${fn:substring(cVo.WDate,0,16)})</span>
							<c:if test="${cVo.mid==sMid}">
								<a href="javascript:answerDelete(${cVo.idx})"><font color="red">&nbsp;(삭제)</font></a>
							</c:if>
							
							<br />
							<div>${cVo.content}</div>
							<hr />
						</c:forEach>
					</div>
			    <form name="replyForm" id="replyForm">
					  <table class="table" style="background-color:#eee;">
					    <tr>
					      <td style="text-align:left;" >
					        <textarea name="content" id="content" class="form-control"></textarea>
					      </td>
					      <td style="width:15%">
					        <br/>
					        <p>
					          <input type="button" value="답변달기" onclick="replyCheck(${vo.idx})" class="btn btn-info btn-sm"/>
					        </p>
					      </td>
					    </tr>
					  </table>
					</form>
		    </div>
				    
				<input type="button" value="문의글 삭제" onclick="fCheck()" style="float: right;" class="btn btn-danger ml-2" />
				<input type="button" value="돌아가기" onclick="location.href='${ctp}/QnA/QnAList;" style="float: right;" class="btn btn-secondary mr-2" />
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
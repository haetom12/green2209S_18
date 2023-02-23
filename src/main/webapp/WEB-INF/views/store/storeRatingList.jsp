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
    
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">
    
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
    
    <script>
    	'use strict';
    	
    	function ratingDelete(idx) {
				let ans = confirm("해당 별점을 삭제하시겠습니까?");
    		if(!ans) return false;
    		
    		$.ajax({
			  	type   : "post",
			  	url    : "${ctp}/store/ratingDelete",
			  	data   : {
			  		idx : idx
			  	},
	    		success:function(res) {
	    			if(res == "1") {
	    				alert("별점이 삭제되었습니다!");
	    				location.reload();
	    			}
	    			else {
	    				alert("별점 삭제에 실패하였습니다. 다시 시도해주세요.");
	    			}
	    		},
	    		error : function() {
	    			alert("전송 오류~~");
	    		}
	    	});
			}
    	
    	// 댓글 달기
        function replyCheck(idx) {
        	let content = $("#content"+idx).val();
        	let storePart = '${vo.storePart}';
        	
        	if(content.trim() == "") {
        		alert("댓글을 입력하세요");
        		$("#content").focus();
        		return false;
        	}
        	
        	let query = {
        			ratingIdx  : idx,
        			mid				: '${sMid}',
        			nickName  : '${sNickName}',
        			content   : content
        	}
        	
        	$.ajax({
        		type : "post",
        		url  : "${ctp}/store/storeReplyInput",
        		data : query,
        		success:function(res) {
        			if(res == "1") {
        				alert("댓글이 입력되었습니다.");
        				location.reload();
        			}
        			else {
        				alert("댓글 입력 실패~~~");
        			}
        		},
      			error  : function() {
      				alert("전송 오류!!");
      			}
        	});
        }
    	
    	var resVos = '';
    	
		  let nickName = '${sNickName}';
    	
		  function getCommentList(idx) {
    		
    		/* if($("#demo"+idx)[0].style.display = 'none'){ 		
    			$("#demo"+idx)[0].style.display = 'block'; 	
    	  }		
    		 */
    			
	    		$.ajax({
	        		type : "post",
	        		url  : "${ctp}/store/getCommentList",
	        		data   : {
				  			idx : idx
				  		},
				  		//async: false,
	        		success:function(vos) {
		            let html = "";
		            console.log("길이", vos.length);
		            console.log("idx", idx);
	
		            resVos = vos;
		            
		            if (vos.length > 0) {
			               for (let i = 0; i < vos.length; i++) {
			            	   
			            	   if(vos[i].replylevel != 3){
			                   html += "<li class='comment'>";
			                   html += "<div class='mb-2'>";
			                /* html += "<b id='commentWriter_" + vos[i].nickName + "'>" + vos[i].nickName + "</b>" + "  " + "<a href='javascript:replydelete("+vos[i].idx+", \'"+vos[i].nickName+"\')'><font color='red'>(X)</font></a>"; */
			                   html += "<b id='commentWriter_" + vos[i].nickName + "'>" + vos[i].nickName + "</b>";
			                   
			                   /* html += '<span style="float:right;" align="right" id="writeDate'+ vos[i].nickName +'"> ' + vos[i].writeDate  +  '  <a href="#"  onclick="modalView('+i+')" data-toggle="modal" data-target="#myModal"><font color="orange">(수정)</font></a> / <a href="javascript:replydelete('+vos[i].idx+')"><font color="red">(삭제)</font></a></span>'; */
			                   
			                   if(nickName != vos[i].nickName) {
				                   html += "<span style='float:right;' align='right' id='writeDate"+ vos[i].nickName +"'> " + vos[i].writeDate + "</span>";
			                   }
			                   else {
			                	   html += '<span style="float:right;" align="right" id="writeDate'+ vos[i].nickName +'"> ' + vos[i].writeDate  +  '  <a href="#"  onclick="modalView('+i+')" data-toggle="modal" data-target="#myModal"><font color="orange">(수정)</font></a> / <a href="javascript:replydelete('+vos[i].idx+')"><font color="red">(삭제)</font></a></span>';
			                   } 
			                   
			                   
			                   html += "<div class='mb-1 comment_container' >"
			                   html += "<h5 id='commentText_" + vos[i].nickName + "' style='display: inline'>" + vos[i].content +"</h5>";
			                   html += "</div>"
			                   html += "<span style='cursor: pointer; color: blue' onclick='rereply("+ idx +","+ vos[i].idx +")'; class='reCommentBtn' id='reCommentBtn_"+ vos[i].idx +"'>댓글 보기 </span>";
			                   html += "<span style='display:none; cursor: pointer;' onclick='rereplyClose("+ vos[i].idx +")';  color: blue' class='reCommentCloseBtn' id='reCommentCloseBtn_"+ vos[i].idx +"'>답글 닫기 </span>";
			                   
			                   html += "<hr>";
			                   html += "<ul class='children' id='demoo" + vos[i].idx + "'></ul></div></li>";
			            	   }
			            	   else {
			            		   html += "<li class='comment'>";
				                   html += "<div class='mb-2'>";
				                   html += "<b id='commentWriter_" + vos[i].nickName + "'>" + vos[i].nickName + "</b>";
				                   html += "<div class='mb-1 comment_container' >"
				                   html += "<h5 id='commentText_" + vos[i].nickName + "' style='display: inline; color=\"blue\"; '>" + vos[i].content +"</h5>";
				                   html += "</div>"
				                   html += "<span style='cursor: pointer; color: blue' onclick='rereply("+ idx +","+ vos[i].idx +")'; class='reCommentBtn' id='reCommentBtn_"+ vos[i].idx +"'>댓글 보기 </span>";
				                   html += "<span style='display:none; cursor: pointer;' onclick='rereplyClose("+ vos[i].idx +")';  color: blue' class='reCommentCloseBtn' id='reCommentCloseBtn_"+ vos[i].idx +"'>답글 닫기 </span>";
				                   
				                   html += "<hr>";
				                   html += "<ul class='children' id='demoo" + vos[i].idx + "'></ul></div></li>";
			            	   }
			               }
			           } else {
			               html += "<li class='comment'>";
			               html += "<div class='mb-2'>";
			               html += "<h6><strong>등록된 댓글이 없습니다.</strong></h6>";
			               html += "</div></li>";
			           }
			            

			           $("#demo"+idx).html(html);
			           /* document.getElementById("openC")[0].style.display = 'none'; */
			           $("#openC"+idx)[0].style.display = 'none';
			           document.getElementById("closeC"+idx).style.display = 'block'; 	
			           $("#demo"+idx)[0].style.display = 'block';
	      		},
	    			error  : function() {
	    				alert("전송 오류!!");
	    			}
	      	});
			}
    	
    	// 해당 댓글 삭제하기
    	function replydelete(idx) {
    		console.log("idx",idx);
				/* 
				if('${sNickName}' != nickName) {
					alert("관리자 또는 글쓴이만 삭제가능합니다!");
					return false;		
				}
				 */
				let ans = confirm("댓글을 삭제하시겠습니까?");

				if(!ans) return false;				
				
    		$.ajax({
        		type : "post",
        		url  : "${ctp}/store/storeReplydelete",
        		data   : {
			  			idx : idx
			  		},
        		success:function(res) {
        			if(res == "1") {
        				alert("댓글이 삭제되었습니다!");
        				location.reload();
        			}
        			else {
        				alert("댓글 삭제에 실패하였습니다. 다시 시도해주세요.");
        			}
        		},
      			error  : function() {
      				alert("전송 오류!!");
      			}
      	});
			}
    	
    	function rereply(ratingIdx, idx) {
    		$.ajax({
        		type : "post",
        		url  : "${ctp}/store/getCommentList2",
        		data   : {
        			ratingIdx : ratingIdx,
			  			idx : idx
			  		},
        		success:function(vos) {
        			
        			resVos = vos;
        			
	            let html = "";
	            console.log("대댓글길이", vos.length);
	            console.log("idx", idx);
	            
	            $("#demoo"+idx)[0].style.display = 'block';
	            
	            /* html += "<ul class='children'>"; */
	            if (vos.length > 0) {
		               for (let i = 0; i < vos.length; i++) {
		            	   
		                   html += "<li class='comment'>";
		                   html += "<div class='mb-2'>";
		                   html += "<b id='commentWriter_" + vos[i].nickName + "'>" + vos[i].nickName + "</b>";
		                   
		                   if(nickName != vos[i].nickName) {
			                   html += '<span style="float:right;" align="right" id="writeDate'+ vos[i].nickName +'"> ' + vos[i].writeDate  +  '</span>';
		                   }
		                   else {
			                   html += '<span style="float:right;" align="right" id="writeDate'+ vos[i].nickName +'"> ' + vos[i].writeDate  +  '  <a href="#"  onclick="modalView('+i+')" data-toggle="modal" data-target="#myModal"><font color="orange">(수정)</font></a> / <a href="javascript:replydelete('+vos[i].idx+')"><font color="red">(삭제)</font></a></span>';
		                   }
		                   
		                   
		                   html += "<div class='mb-1 comment_container' >"
		                   html += "<h5 id='commentText_" + vos[i].nickName + "' style='display: inline'>" + vos[i].content +"</h5>";
		                   html += "</div></div></li>"
		               }
		           } else {
		        	   	 html += "<ul class='children'>";
		               html += "<li class='comment'>";
		               html += "<div class='mb-2'>";
		               html += "<h6><strong>등록된 댓글이 없습니다.</strong></h6>";
		               html += "</div></li></ul>";
		           }
		            html += "<input type='text' style='width: 90%' id='reComment_"+idx+"' name='reComment' class='form-control' placeholder='댓글을 입력해 주세요'>";
		            html += "<button type='button' onclick='rereplyInput("+ ratingIdx +","+ idx +")' class='btn btn-primary mx-2 reCommentSubmit'>등록</button>";
	            
		           $("#demoo"+idx).html(html);
		           /* document.getElementById("openC")[0].style.display = 'none'; */
		           $("#reCommentBtn_"+idx)[0].style.display = 'none';
		           /* document.getElementById("closeC"+idx).style.display = 'block'; 	 */
		           $("#reCommentCloseBtn_"+idx)[0].style.display = 'block';
      		},
    			error  : function() {
    				alert("전송 오류!!");
    			}
      	});
			}
    	
    	// 대 댓글 입력
    	function rereplyInput(ratingIdx, replyIdx) {
				
    		let nickName = '${sNickName}';
    		let content = $("#reComment_"+replyIdx).val();
    		
    		if(content == "") {
    			alert("댓글 내용을 입력하세요.");
    			return false;
    		}
    		
    		let query = {
        			ratingIdx  : ratingIdx,
        			mid				: '${sMid}',
        			nickName  : '${sNickName}',
        			content   : content,
        			replyIdx  : replyIdx
        }
    		
    		if(nickName == ""){
    			alert("로그인 후 이용가능합니다.");
    			return false;
    		}
    		
    		$.ajax({
        		type : "post",
        		url  : "${ctp}/store/storeReReplyInput",
        		data : query,
        		success:function(res) {
        			if(res == "1") {
        				alert("댓글이 입력되었습니다.");
        				location.reload();
        			}
        			else if(res == "3") {
        				alert("커뮤니티 활동이 정지되어 댓글 기능을 사용할 수 없습니다.");
        			}
        			else {
        				alert("댓글 입력 실패~~~");
        			}
        		},
      			error  : function() {
      				alert("전송 오류!!");
      			}
      	});
			}
    	
    	
    	function closeCommentList(idx) {
    		$("#demo"+idx).html("");
    		$("#demo"+idx)[0].style.display = 'none';
    		document.getElementById("openC"+idx).style.display = 'block';
       	document.getElementById("closeC"+idx).style.display = 'none'; 	
			}
    	
    	function rereplyClose(idx) {
    		
    		$("#demoo"+idx).html("");
    		$("#demoo"+idx)[0].style.display = 'none';
    		
	      $("#reCommentBtn_"+idx)[0].style.display = 'block';
	      $("#reCommentCloseBtn_"+idx)[0].style.display = 'none'; 
    		
			}
    	
    	
    	// 모달창
    	function modalView(i) {
    			/* console.log("시파" , idx);
    			console.log("name" , name); */
    			
    			let strVos = JSON.stringify(resVos[i]);
    			let jsonVos = JSON.parse(strVos);
    			
        	$("#myModal").on("show.bs.modal", function(e){
        		$(".modal-body #mNickName").val(jsonVos.nickName);
        		$(".modal-body #content").val(jsonVos.content);
        		$(".modal-body #idx").val(jsonVos.idx);
        	});
        	
      }
    	
	  	function replyUpdate() {
				
	  		let nickName = $(".modal-body #mNickName").val();
	  		let content = $(".modal-body #content").val();
	  		let idx = $(".modal-body #idx").val();
	  		
	  		let query = {
	  			nickName  : nickName,
	  			content  : content,
	  			idx  : idx
    		}
	  		
	  		if(content == "") {
	  			alert("수정할 내용을 입력하세요.");
	  			return false;
	  		}
	  		
	  		$.ajax({
        		type : "post",
        		url  : "${ctp}/store/storeReplyUpdate",
        		data : query,
        		success:function(res) {
        			if(res == "1") {
        				alert("댓글이 수정되었습니다.");
        				location.reload();
        			}
        			else {
        				alert("댓글 수정에 실패하였습니다. 다시 시도해주세요. ");
        			}
        		},
      			error  : function() {
      				alert("전송 오류!!");
      			}
      	});
			}
		function reportRating(idx) {
			let ans = confirm("선택한 리뷰를 신고하시겠습니까? 허위 신고는 불이익이 생길수 있습니다.");
			if(!ans) return false;
			
			$.ajax({
        		type : "post",
        		url  : "${ctp}/store/reportRating",
        		data : {
    	  			idx  : idx
        		},
        		success:function(res) {
        			if(res == "1") {
        				alert("리뷰를 신고하였습니다.");
        				location.reload();
        			}
        			else if(res == "3") {
        				alert("이미 신고하였습니다.");
        			}
        			else {
        				alert("리뷰 신고에 실패하였습니다. 다시 시도해주세요. ");
        			}
        		},
      			error  : function() {
      				alert("전송 오류!!");
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
          <div class="col-md-9 ftco-animate text-center bg-primary">
          	<!-- <p class="breadcrumbs"><span class="mr-2"><a href="index.html">Home</a></span> <span>Blog</span></p> -->
            <h1 class="mb-0 bread">${vo.storeName}</h1>
          </div>
        </div>
      </div>
    </div>

  	<section class="ftco-section ftco-degree-bg">
      <div class="container" >
      	<c:forEach var="rVo" items="${rVos}" varStatus="rSt">
	        <div class="row" style="background-color:#eee;">
	          <div class="col-lg-12 ftco-animate">
							<table class="table border" style="border: soild 1px black;">
					    <thead class="thead-primary">
							  <tr class="text-center table-bordered" >
							    <th>작성자</th>
							    <th style="background-color:#eee; "><font color="black">${rVo.memberNickName}</font></th>
							    <th>작성날짜</th>
							    <th style="background-color:#eee; "><font color="black">${rVo.ratingDate}</font></th>
							  </tr>
							  <tr class="text-center">
							    <th>제목</th>
							    <th style="background-color:#eee;"><font color="black">${rVo.title}</font></th>
							    <th>별점</th>
							    <th style="background-color:#eee;">
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
											&nbsp;&nbsp;
											<c:if test="${sMid != 'admin' && sMid != rVo.mid}">
												<a href="javascript:reportRating(${rVo.idx})"><font color="red">신고하기</font></a>
											</c:if>
											<c:if test="${sMid == 'admin'}">
												<input type="button" value="삭제" onclick="ratingDelete(${rVo.idx})" class="btn btn-danger"  />
											</c:if>
											<c:if test="${sMid == rVo.mid}">
												<input type="button" value="수정" onclick="location.href='${ctp}/store/ratingUpdate?idx=${rVo.idx}';" class="btn btn-warning" />
												<input type="button" value="삭제" onclick="ratingDelete(${rVo.idx})" class="btn btn-danger"  />
											</c:if>
							    </th>
							  </tr>
					    </thead>
					    
				   	  <tbody class="m-0 p-0">
					      <tr align="center">
					    	  <td class="m-0 p-0" colspan="4">
								    <!-- 상품 상세설명 보여주기 -->
								    <div id="content" style="background-color:#eee; height: 500px; overflow: auto;" class="text-left"><br/>
								      ${rVo.content}
								    </div>		
								    <hr />
								    <form name="replyForm">
										  <table class="table" style="background-color:#eee;">
										    <tr>
										      <td style="width:85%; text-align:left;" >
										        <textarea rows="4" name="content" id="content${rVo.idx}" class="form-control"></textarea>
										      </td>
										      <td style="width:15%">
										        <br/>
										        <p>작성자 : ${sNickName}</p>
										        <p>
										          <input type="button" value="댓글달기" onclick="replyCheck(${rVo.idx})" class="btn btn-info btn-sm"/>
										        </p>
										      </td>
										    </tr>
										  </table>
										</form>
								    
								    <div style="text-align: left;" >
								    	<div class="mt-1">
					              <input type="button" value="댓글보기" id="openC${rVo.idx}" onclick="getCommentList(${rVo.idx})" class="btn btn-info mb-5"/>
					              <input type="button" value="댓글닫기" id="closeC${rVo.idx}" onclick="closeCommentList(${rVo.idx})" class="btn btn-info mb-5" style="display: none;"/>
					              <ul class="comment-list" style="background-color:#eee;">
					              <div id="demo${rVo.idx}">
					              </div>
					               <%-- 
					                <li class="comment">
					                  <div class="comment-body">
					                    <h3>${rrVo.rSt.count.nickName}</h3>
					                    <div class="meta"><b>${rrVo.rSt.index.writeDate}</b></div>
					                    <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Pariatur quidem laborum necessitatibus, ipsam impedit vitae autem, eum officia, fugiat saepe enim sapiente iste iure! Quam voluptas earum impedit necessitatibus, nihil?</p>
					                    <p><a href="#" class="reply">Reply</a></p>
					                  </div>
					                  
						                <!-- 대 댓글 -->
					                  <ul class="children">
					                    <li class="comment">
					                      <div class="comment-body">
					                        <h3>John Doe</h3>
					                        <div class="meta">June 27, 2018 at 2:21pm</div>
					                        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Pariatur quidem laborum necessitatibus, ipsam impedit vitae autem, eum officia, fugiat saepe enim sapiente iste iure! Quam voluptas earum impedit necessitatibus, nihil?</p>
					                        <p><a href="#" class="reply">Reply</a></p>
					                      </div>
					                    </li>
					                    <li class="comment">
					                      <div class="comment-body">
					                        <h3>John Doe</h3>
					                        <div class="meta">June 27, 2018 at 2:21pm</div>
					                        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Pariatur quidem laborum necessitatibus, ipsam impedit vitae autem, eum officia, fugiat saepe enim sapiente iste iure! Quam voluptas earum impedit necessitatibus, nihil?</p>
					                        <p><a href="#" class="reply">Reply</a></p>
					                      </div>
					                    </li>
					                  </ul> 
					                </li>
					                 --%>
					              </ul>
					            </div>
								    </div>			    	
					    	  </td>
						    </tr>
					    </tbody>
						</table>
	          </div> <!-- .col-md-8 -->
	        </div>
	        <br /><hr />
        </c:forEach>
      </div>
    </section> <!-- .section -->
    
    <!-- The Modal(모달창 클릭시 자료실의 내용을 모달창에 출력한다. -->
		<div class="modal fade mt-5" id="myModal">
		  <div class="modal-dialog">
		    <div class="modal-content">
		      <!-- Modal Header -->
		      <div class="modal-header">
		        <h4 class="modal-title"><span id="title"></span>(댓글 수정)</h4>
		        <button type="button" class="close" data-dismiss="modal">&times;</button>
		      </div>
		      <!-- Modal body -->
		      <form>
			      <div class="modal-body">
			        - 올린이 : 	<input type="text" id="mNickName" name="mNickName" class="form-control" readonly/>	<!-- <span id="nickName"></span> -->
			        <hr/>
			        - 작성내용 : <span id="context"></span><br/>
				      <textarea rows="3" name="content" id="content" class="form-control mt-2 mb-2"></textarea>
				      <input type="hidden" name="idx" id="idx"/>
				      <button type="button" class="btn btn-danger w3-right" data-dismiss="modal">닫기</button>
				      <button type="button" class="btn btn-primary w3-right w3-margin-right" onclick="replyUpdate()">댓글 수정</button>
			      </div>
			      
			      
			      
		      </form>
		      <!-- Modal footer -->
		      <div class="modal-footer">
		      </div>
		      
		    </div>
		  </div>
		</div>

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

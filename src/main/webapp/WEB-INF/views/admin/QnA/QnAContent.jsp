<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<!-- Basic Page Info -->
	<meta charset="utf-8">
	<title>DeskApp - Bootstrap Admin Dashboard HTML Template</title>

	<!-- Site favicon -->
	<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
	<link rel="apple-touch-icon" sizes="180x180" href="${ctp}/vendors/images/apple-touch-icon.png">
	<link rel="icon" type="image/png" sizes="32x32" href="${ctp}/vendors/images/favicon-32x32.png">
	<link rel="icon" type="image/png" sizes="16x16" href="${ctp}/vendors/images/favicon-16x16.png">

	<!-- Mobile Specific Metas -->
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">

	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
	<!-- Google Font -->
	<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">

	<script>
	'use strict';
	
	function DelCheck(idx) {
    	let ans = confirm("선택한 문의를 삭제하겠습니까?");
    	if(!ans) return false;
    	   	
    	$.ajax({
    		type   : "post",
    		url    : "${ctp}/admin/adminRatingDeleteCheck",
    		data   : {
    			idx : idx
    			},
    		success:function(res) {
    		  if(res == "1") {
    				alert("별점을 삭제하였습니다!");
    				location.href='${ctp}/admin/ratingList';
    		  }
    			else {
    				alert("별점 삭제에 실패하였습니다! 다시 시도하세요.");
    			}
    		},
    		error : function() {
    			alert("전송 오류~~");
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
    
</script>

</head>
<body>
	<jsp:include page="/WEB-INF/views/admin/adminNav.jsp"></jsp:include>
	
	<!-- =============================================== -->
	<section class="ftco-section testimony-section "  style="margin-top: 5%;">
    	<div class="container">
				<div class="pd-20 card-box mb-30">
					<div class="clearfix">
						<h3 class="text-blue h3" style="text-align: center;">1:1 문의 작성</h3>
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
								<span>${cVo.nickName}(${fn:substring(cVo.WDate,0,16)})</span><a href="javascript:answerDelete(${cVo.idx})"><font color="red">&nbsp;(삭제)</font></a>
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
  	    </div>
      </div>
  </section>
  
	<!-- js -->
</body>
</html>
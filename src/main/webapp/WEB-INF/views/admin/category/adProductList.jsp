<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<title>W3.CSS Template</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<style>
	html,body,h1,h2,h3,h4,h5 {font-family: "Raleway", sans-serif}
	
	body {
				margin-top: 5%;
			  font-family: "Lato", sans-s;
			}
		
		.sidebar {
		  height: 100%;
		  width: 0;
		  position: fixed;
		  z-index: 1;
		  top: 0;
		  left: 0;
		  background-color: #4e148c;
		  overflow-x: hidden;
		  transition: 0.5s;
		  padding-top: 60px;
		}
		
		.sidebar a {
		  padding: 8px 8px 8px 32px;
		  text-decoration: none;
		  font-size: 25px;
		  color: white;
		  display: block;
		  transition: 0.3s;
		}
		
		.sidebar a:hover {
		  color: #fcf300;
		}
		
		.sidebar .closebtn {
		  position: absolute;
		  top: 0;
		  right: 25px;
		  font-size: 36px;
		  margin-left: 50px;
		}
		
		.openbtn {
		  font-size: 20px;
		  cursor: pointer;
		  background-color: #9600ff;
		  color: white;
		  padding: 10px 15px;
		  border: none;
		}
		
		.openbtn:hover {
		  background-color: #444;
		}
		.topbar {
		  background-color: #b892ff;			
		}
		
		#main {
		  transition: margin-left .5s;
		  padding: 16px;
		}
		
		/* On smaller screens, where height is less than 450px, change the style of the sidenav (less padding and a smaller font size) */
		@media screen and (max-height: 450px) {
		  .sidebar {padding-top: 15px;}
		  .sidebar a {font-size: 18px;}
		}
	 .w3-container {
			text-align: center; 
			width: 50%;
			margin: 0 auto;
		}
		select {
		  width: 15%;
		  border-radius: 4px;
		  background-color: white;
		  border: 2px solid skyblue;
		  height: 38px;	
		  font-size: 15px;
		}
		
</style>
<script>
	'use strict';
	
	function drugSearch() {
    	let searchString = $("#searchString").val();
    	
    	if(searchString.trim() == "") {
    		alert("찾고자 하는 검색어를 입력하세요!");
    		drugform.searchString.focus();
    	}
    	else {
    		drugform.submit();
    	}
    }
	function DelCheck(mCode,fSName) {
    	let ans = confirm("선택된 상품을 삭제하시겠습니까?");
    	if(!ans) return false;
    	   	
    	$.ajax({
    		type   : "post",
    		url    : "${ctp}/adProductDelete.ad",
    		data   : { mCode : mCode,
    							fSName : fSName
    							},
    		success:function(res) {
    			if(res == "1") {
    				alert("삭제되었습니다.");
    				location.reload();
    			}
    			else {
    				alert("삭제 실패~~");
    			}
    		},
    		error : function() {
    			alert("전송 오류~~");
    		}
    	});
    }
	
</script>

</head>
<body class="w3-light-grey">
	<div id="mySidebar" class="sidebar">
	  <a href="javascript:void(0)" class="closebtn" onclick="closeNav()">×</a>
	  <a href="${ctp}/homePage.ad">홈페이지로</a>
	  <a href="${ctp}/adMain.ad">관리자 홈으로</a>
	  <a href="${ctp}/adProductList.ad">상품관리</a>
	  <a href="${ctp}/adOrderList.ad">거래요청</a>
	  <a href="${ctp}/adMemList.ad">회원관리</a>
	  <a href="${ctp}/adRequestList.ad">회원가입요청</a>
	  <a href="${ctp}/adMemDeleteList.ad">회원탈퇴요청</a>
	  <a href="${ctp}/adBoList.ad">문의/답변</a>
	</div>

<!-- Top container -->
<div id="main" style="margin-left : 0; padding-left: 0px;">
	<div class="w3-bar w3-top w3-large topbar" style="z-index:4">
	<button class="openbtn"  onclick="openNav()">☰ 관리자 메뉴</button>
	  <!-- <button class="w3-bar-item w3-button w3-hide-large w3-hover-none w3-hover-text-light-grey" onclick="w3_open();"><i class="fa fa-bars"></i>  Menu</button> -->
	  <span class="w3-bar-item w3-right">Logo</span>
	</div>
	<!-- Overlay effect when opening sidebar on small screens -->
	<div class="w3-overlay w3-hide-large w3-animate-opacity" onclick="w3_close()" style="cursor:pointer" title="close side menu" id="myOverlay"></div>
	
	<!-- !PAGE CONTENT! -->
	<div class="w3-container" style="width:70%;">
	  <h2>상품 리스트</h2><br />
	   <form name="drugform" method="post" action="${ctp}/adDrugSearch.ad">
		  	<div class="row mb-2">
		  	  <div class="col form-inline">
			  	  <select name="search"  class="w3-input w3-border w3-round w3-left w3-margin-bottom w3-margin-right " style="width:12%;">
				      <option value="mName">약 품 명</option>
				      <option value="ingredient">약 성 분</option>
				      <option value="mCompany">제 조 회 사</option>
				      <option value="useFor">분 류</option>
				    </select>
		  	    <input type="text" name="searchString"  id="searchString" class="w3-input w3-border w3-round w3-left w3-margin-bottom w3-margin-right" style="width:20%;" autofocus />&nbsp;
		  	    <input type="button" value="상품검색" onclick="drugSearch();" class="w3-left w3-button w3-round-large w3-blue" />
		  	  	<button type="button" onclick="location.href='${ctp}/adPdInput.ad';" class="w3-right w3-button w3-round-large w3-blue">상품 등록</button>
		  	  	<input type="hidden" name="pag" id="pag" value="${pag}"/>
					  <input type="hidden" name="pageSize" id="pageSize" value="${pageSize}"/>
		  	  </div>
		  	</div>
		 </form>
	  <table class="w3-table-all memtable w3-centered">
	    <thead>
	      <tr class="w3-blue">
	        <th>번호</th>
	        <th>약코드</th>
	        <th>약품명</th>
	        <th>제조회사</th>
	        <th>분류</th>
	        <th>약성분</th>
	        <th>가격</th>        
	        <th>사진</th>
	        <th>비고</th>
	      </tr>
	    </thead>
	    <c:forEach var="vo" items="${vos}" varStatus="st">
	   		<tr>
		    	<td>${curScrStartNo}</td>
		    	<td>${vo.mCode}</td>
		    	<td>${vo.name}</td>
		    	<td>${vo.mCompany}</td>
		    	<td>${vo.useFor}</td>
		    	<td style="width: 35%;"><font size="2px">${vo.ingredient}</font></td>
		    	<td>${vo.price}원</td>
		    	<td><img src="${ctp}/data/medicine/${vo.fSName}" style="width:100px; cursor:zoom-in"
	  							onclick="document.getElementById('${st.count}').style.display='block'"></td>
		    	<td>
		    	 <input type="button" onclick="location.href='${ctp}/adPdUpdate.ad?mCode=${vo.mCode}';" class="w3-button w3-round-large w3-green" value="수정" />
		    	 <input type="button" onclick="DelCheck('${vo.mCode}','${vo.fSName}')" class="w3-button w3-round-large w3-red" value="삭제" />
		    	</td>
		    </tr>
		    <div id="${st.count}" class="w3-modal" onclick="this.style.display='none'">
			    <span class="w3-button w3-hover-red w3-xlarge w3-display-topright">&times;</span>
			    <div class="w3-modal-content w3-animate-zoom">
			      <img src="${ctp}/data/medicine/${vo.fSName}" style="width:60%; height:70%">
			    </div>
			  </div>
	    	<c:set var="curScrStartNo" value="${curScrStartNo - 1}"/>
	    </c:forEach>
	  </table>
		<!-- 블록 페이지 시작 -->
		<div class="w3-center w3-margin-top">
		  <div class="w3-bar w3-border w3-round">
		    <c:if test="${pag > 1}">
		      <a class="w3-bar-item w3-button" href="${ctp}/adProductList.ad?pag=1">첫페이지</a>
		    </c:if>
		    <c:if test="${curBlock > 0}">
		     <a class="w3-bar-item w3-button" href="${ctp}/adProductList.ad?pag=${(curBlock-1)*blockSize + 1}">이전블록</a>
		    </c:if>
		    <c:forEach var="i" begin="${(curBlock)*blockSize + 1}" end="${(curBlock)*blockSize + blockSize}" varStatus="st">
		      <c:if test="${i <= totPage && i == pag}">
		    		<a class="w3-bar-item w3-button" href="${ctp}/adProductList.ad?pag=${i}">${i}</a>
		    	</c:if>
		      <c:if test="${i <= totPage && i != pag}">
		    		<a class="w3-bar-item w3-button" href="${ctp}/adProductList.ad?pag=${i}">${i}</a>
		    	</c:if>
		    </c:forEach>
		    <c:if test="${curBlock < lastBlock}">
		      <a class="w3-bar-item w3-button" href="${ctp}/adProductList.ad?pag=${(curBlock+1)*blockSize + 1}">다음블록</a>
		    </c:if>
		    <c:if test="${pag < totPage}">
		      <a class="w3-bar-item w3-button" href="${ctp}/adProductList.ad?pag=${totPage}">마지막페이지</a>
		    </c:if>
		  </div>
		</div>
		<!-- 블록 페이지 끝 -->
		<div>
			<input type="button" value="뒤로가기" onclick="location.href='${ctp}/adMain.ad';" class="w3-center w3-button w3-round-large w3-blue" />
		</div>
		   
	</div>
	<br />
	
	<!-- Footer -->
	<footer class="w3-container w3-padding-16 w3-light-grey">
	  <h4>FOOTER</h4>
	  <p>Powered by <a href="https://www.w3schools.com/w3css/default.asp" target="_blank">w3.css</a></p>
 </footer>

  <!-- End page content -->
</div>

<script>

// Get the DIV with overlay effect

	function openNav() {
	  document.getElementById("mySidebar").style.width = "250px";
	  document.getElementById("main").style.marginLeft = "250px";
	}

	function closeNav() {
	  document.getElementById("mySidebar").style.width = "0";
	  document.getElementById("main").style.marginLeft= "0";
	}
</script>

</body>
</html>

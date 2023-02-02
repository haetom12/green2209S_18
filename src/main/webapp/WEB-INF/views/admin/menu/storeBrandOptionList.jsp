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
	
	#main {
				margin-top: 5%;
				transition: margin-left .5s;
		  	padding: 16px;
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
	function DelCheck(brandName) {
    	let ans = confirm("선택된 브랜드를 삭제하시겠습니까?");
    	if(!ans) return false;
    	   	
    	$.ajax({
    		type   : "post",
    		url    : "${ctp}/admin/adminBrandDelete",
    		data   : {brandName : brandName},
    		success:function(res) {
    			if(res == "0") {
    				alert("하위항목이 있기에 삭제할수 없습니다.\n하위항목을 먼저 삭제해 주세요.");
    			}
    			else {
    				alert("카테고리가 삭제 되었습니다!");
    				location.reload();
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

<jsp:include page="/WEB-INF/views/admin/adminNav.jsp"></jsp:include>	

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
	<div class="w3-container" style="width:40%;">
	  <h2>메뉴 수정을 위한 가게 프랜차이즈 목록</h2><br />
	  <table class="w3-table-all memtable w3-centered">
	    <thead>
	      <tr class="w3-blue">
	        <th>번호</th>
	        <th>프랜차이즈 이름</th>
	        <th>카테고리 분류</th>
	        <th>비고</th>
	      </tr>
	    </thead>
	    <c:forEach var="vo" items="${vos}" varStatus="st">
	   		<tr>
		    	<td>${st.count}</td>
		    	<td><font color="blue";>${vo.brandName}</font></td>
		    	<td>${vo.storePart}</td>
		    	<td>
		    	 <input type="button" onclick="location.href='${ctp}/admin/storeTagList?brandName=${vo.brandName}';" class="w3-button w3-round-large w3-blue" value="태그 추가/수정" />
		    	 <input type="button" onclick="location.href='${ctp}/admin/storeMenuList?brandName=${vo.brandName}';" class="w3-button w3-round-large w3-green" value="메뉴 추가/수정" />
		    	</td>
		    </tr>
	    	<c:set var="curScrStartNo" value="${curScrStartNo - 1}"/>
	    </c:forEach>
	  </table>
	  <%-- 
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
		 --%>
		<div>
			<input type="button" value="뒤로가기" onclick="location.href='${ctp}/admin/adminStoreMenu';" class="w3-center w3-button w3-margin-top w3-round-large w3-blue" />
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
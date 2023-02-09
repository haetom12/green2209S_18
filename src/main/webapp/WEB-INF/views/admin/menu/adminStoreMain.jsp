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
	<div class="w3-main" id="main" style="margin-top:100px;">
	  <div class="w3-row-padding w3-center w3-margin-top">
			<div class="w3-third" style="margin-left: 30%;">
			  <div class="w3-card w3-container" style="min-height:460px">	
				  <br><h2>메뉴 설정</h2><br>
				  <h4><a href="${ctp}/admin/storeBrandList">프랜차이즈 목록 추가/수정 <i class="fa fa-wrench" aria-hidden="true"></i></a></h4>
				  <h4><a href="${ctp}/admin/storeBrandOptionList">프랜차이즈  메뉴 추가/수정 <i class="fa fa-hospital-o" aria-hidden="true"></i></a></h4>
				  <h4><a href="#">가게 삭제 요청 <i class="fa fa-hospital-o" aria-hidden="true"></i></a></h4>
				  <%-- <h4><a href="${ctp}/admin/adminStoreSubMenuOption">음식 태그별 추가 메뉴 추가/수정<i class="fa fa-trash"></i></a></h4> --%>
			  </div>
			</div>
		</div>
	</div>
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

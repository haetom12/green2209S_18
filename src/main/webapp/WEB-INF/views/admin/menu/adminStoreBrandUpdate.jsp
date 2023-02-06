<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<style>
	html,body,h1,h2,h3,h4,h5 {font-family: "Raleway", sans-serif}
	
	body {
				
			  font-family: "Lato", sans-serif;
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
			margin-top: 5%;
		  transition: margin-left .5s;
		  padding: 16px;
		}
		
		/* On smaller screens, where height is less than 450px, change the style of the sidenav (less padding and a smaller font size) */
		@media screen and (max-height: 450px) {
		  .sidebar {padding-top: 15px;}
		  .sidebar a {font-size: 18px;}
		}
		.memtable {
		}
	 .w3-container {
			width: 40%;
			margin: 0 auto;
		}
		
</style>

<script>
  'use strict';
  let brandCheckSw = 0;
	
  //  체크후 서버로 전송(submit)
  function fCheck() {
	  let storePart = $("#storePart").val();
	  let brandName = $("#brandName").val();
	  let oldBrandName = '${vo.brandName}';
	  
		if($.trim(storePart) == "") {
			alert("프랜차이즈 종류를 선택하세요");
			myform2.storePart.focus();
			return false;
		}
		else if($.trim(brandName) == "") {
			alert("프랜차이즈 명을 입력하세요");
			myform2.brandName.focus();
			return false;
		}
		else if(brandName != '${vo.brandName}') {
			if(brandCheckSw == 0) {
				alert("프랜차이즈 명 중복체크는 필수입니다!");
				myform2.brandName.focus();
				return false;
			}
			else {
			  location.href="${ctp}/admin/adminStoreBrandUpdate2?idx=${vo.idx}&storePart="+storePart+"&brandName="+brandName+"&oldBrandName="+oldBrandName;
			}
		}
		else {
			location.href="${ctp}/admin/adminStoreBrandUpdate2?idx=${vo.idx}&storePart="+storePart+"&brandName="+brandName;
		}
  }
  
	//카테코리 이름 중복체크
  function brandCheck() {
	  let storePart = $("#storePart").val();
	  let brandName = $("#brandName").val();
	  let oldName = '${vo.brandName}';
	  
  	if(brandName.trim() == "") {
  		alert("프랜차이즈명을 입력하세요!");
  		myform2.brandName.focus();
  		return false;
  	}
  	else if(brandName.trim() == oldName) {
  		alert("수정전과 동일한 브랜드명입니다!");
  		myform2.brandName.focus();
  		return false;
  	}
  	else {
	  	$.ajax({
		  	type   : "post",
		  	url    : "${ctp}/admin/storebrandNameCheck",
		  	data   : {
		  		storePart : storePart,
		  		brandName : brandName
		  		} ,
		  	success:function(res) {
		  		if(res == "1") {
		  			document.getElementById("demo2").innerHTML = "<font color = 'red'> 존재하는 프랜차이즈입니다! </font>"; 
		  			
		  		}
		  		else {
		  			document.getElementById("demo2").innerHTML = "<font color = 'blue'><b>사용가능한 프랜차이즈입니다!</b> </font>";  
		  			$("#brandName").attr("readonly","readonly");
		  			brandCheckSw = 1;
		  		}
		  	},
		  	error : function() {
		  		alert("전송 오류~~");
		  	}
		  });	
    }
  }

</script>
</head>
<body class="w3-light-grey">

<jsp:include page="/WEB-INF/views/admin/adminNav.jsp"></jsp:include>	

<!-- Top container 	-->
<div id="main" style="margin-left : 0; padding-left: 0px;">
<div class="w3-bar w3-top w3-large topbar" style="z-index:4">
<button class="openbtn"  onclick="openNav()">☰ 관리자 메뉴</button>
  <!-- <button class="w3-bar-item w3-button w3-hide-large w3-hover-none w3-hover-text-light-grey" onclick="w3_open();"><i class="fa fa-bars"></i>  Menu</button> -->
  <span class="w3-bar-item w3-right">Logo</span>
</div>
<!-- Overlay effect when opening sidebar on small screens -->
<div class="w3-overlay w3-hide-large w3-animate-opacity" onclick="w3_close()" style="cursor:pointer" title="close side menu" id="myOverlay"></div>

<!-- !PAGE CONTENT! -->
<div class="w3-container">
  <form name="myform2" method="post" >
	  <h2 class="text-center">프랜차이즈 수정</h2>
	  <br/>
	  <div id="fileBoxAppend"></div>
	  <div class="mb-2">
	  프랜차이즈 종류 :
	  	<div class="loginbox-textbox input-group" style="margin: 0 auto;">
		    <select id="storePart" name="storePart" class="form-control">
		    	<c:forEach var="cVo" items="${vos}">
			    	<option value="${cVo.storePart}" ${cVo.storePart==vo.storePart  ? "selected" : ""}>${cVo.storePart}</option>
			    </c:forEach>
				</select>
	  	</div>
	  </div>
	  <div style="font-size: 10px;" id="demo"></div>
	  프랜차이즈 명 :
	  <div class="loginbox-textbox input-group" style="margin: 0 auto;">
       <input type="text" name="brandName" id="brandName" value="${vo.brandName}" class="form-control" style="width: 200px;" required />
       <input type="button" class="btn btn-primary" id="midBtn2" onclick="brandCheck()" style="width: 15%; text-align: center;"  value="중복체크">
    </div>
    <div style="font-size: 10px; margin-bottom: 5px;" id="demo2"></div>
	  <div class="mb-2">
	    <input type="button" value="프렌차이즈 수정" onclick="fCheck()" class="btn btn-primary"/> &nbsp;
	    <input type="reset" value="다시쓰기" class="btn btn-warning"/> &nbsp;
	    <input type="button" value="돌아가기" onclick="location.href='${ctp}/admin/storeBrandList';" class="btn btn-secondary"/> &nbsp;    
	    <input type="hidden" name="idx" value="${vo.idx}" />
	  </div>
  </form>
</div>
<br />


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

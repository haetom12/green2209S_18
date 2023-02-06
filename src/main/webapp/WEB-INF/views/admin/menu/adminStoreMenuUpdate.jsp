<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<% pageContext.setAttribute("newLine", "\n"); %>
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
  let foodCheckSw = 0;
	
	
  //  체크후 서버로 전송(submit)
  function fCheck() {
	  let foodName = myform.foodName.value;
	  let price = myform.price.value;
	  
		let fName = myform.fName.value;
		let ext = fName.substring(fName.lastIndexOf(".")+1); // 확장자 발췌
		let uExt = ext.toUpperCase();
		let maxSize = 1024 * 1024 * 2;   // 업로드 가능한 최대파일의 용량은 2MByte로 한다.

		
		if(foodName.trim() == "") {
			alert("메뉴명을 입력하세요");
			myform.foodName.focus();
			return false;
		}
		else if(price.trim() == "") {
			alert("가격을 입력하세요");
			myform.price.focus();
			return false;
		}
		else if(foodName != '${vo.foodName}') {
		  if(foodCheckSw == 0) {
				alert("메뉴명 중복체크는 필수입니다!");
				myform.foodName.focus();
				return false;
			}
		  else {
				myform.submit();
		  }
		}
		else {
			myform.submit();
		}
  }
  
	//메뉴 이름 중복체크
  function foodNameCheck() {
	  let foodName = myform.foodName.value;
	  let brandName = myform.brandName.value;
	  let oldName = '${vo.foodName}';
	  
  	if(foodName.trim() == "") {
  		alert("메뉴명을 입력하세요!");
  		myform.foodName.focus();
  		return false;
  	}
  	else if(foodName.trim() == oldName) {
  		alert("수정전과 동일한 메뉴명입니다!");
  		myform.foodName.focus();
  		return false;
  	}
  	else {
	  	$.ajax({
		  	type   : "post",
		  	url    : "${ctp}/admin/foodNameCheck",
		  	data   : {
		  		foodName : foodName,
		  		brandName : brandName
		  		} ,
		  	success:function(res) {
		  		if(res == "1") {
		  			document.getElementById("demo2").innerHTML = "<font color = 'red'> 존재하는 메뉴입니다! </font>"; 
		  			
		  		}
		  		else {
		  			document.getElementById("demo2").innerHTML = "<font color = 'blue'><b>사용가능한 메뉴입니다!</b> </font>";  
		  			$("#foodName").attr("readonly","readonly");
		  			foodCheckSw = 1;
		  		}
		  	},
		  	error : function() {
		  		alert("전송 오류~~");
		  	}
		  });	
    }
  }
	
	function saleCheck(check) {
		let saleOk = $(sale).val();
		
		if(saleOk == "O") {
			document.getElementById('salePrice').readOnly = false;
		}
		else {
			document.getElementById('salePrice').value = 0;
			document.getElementById('salePrice').readOnly = true;
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
  <form name="myform" method="post" enctype="multipart/form-data">
	  <h2 class="text-center">메뉴 등록</h2>
	  <br/>
	  <div id="fileBoxAppend"></div>
	  <div class="mb-2">
	  프랜차이즈 이름 :
	  	<div class="loginbox-textbox input-group" style="margin: 0 auto;">
		    <input type="text" name="brandName" id="brandName" value="${vo.brandName}" class="form-control" style="width: 100px;" readonly />
	  	</div>
	  </div>
	  <div style="font-size: 10px;" id="demo"></div>
	  메뉴명 :
	  <div class="loginbox-textbox input-group" style="margin: 0 auto;">
       <input type="text" name="foodName" id="foodName"  value="${vo.foodName}" class="form-control" style="width: 200px;" required />
       <input type="button" class="btn btn-primary" id="midBtn2" onclick="foodNameCheck()" style="width: 15%; text-align: center;"  value="중복체크">
    </div>
    <div style="font-size: 10px;" id="demo2"></div>
    음식 태그 :
    <div class="input-group-append" style="width: 25%;">
	    <select name="foodTag" class="form-control">
	    	<c:forEach var="cVo" items="${vos}">
		    	<option value="${vo.foodTag}"  ${cVo.foodTag==vo.foodTag  ? "selected" : ""}  >${vo.foodTag}</option>
		    </c:forEach>
		  </select>
	  </div>
	  가격 :
	  <div class="loginbox-textbox input-group" style="margin: 0 auto;">
       <input type="number" name="price" id="price"  value="${vo.price}" class="form-control" style="width: 200px;" required />
    </div>
    품절여부 :
	  <input class="w3-radio" type="radio" name="runOut" value="X"  ${vo.subMenu == "X"  ? "checked" : ""}  >
	  <label>품절X</label>&nbsp;
	  <input class="w3-radio" type="radio" name="runOut" value="O"  ${vo.subMenu == "O"  ? "checked" : ""}  >
	  <label>품절O</label>
	  <p></p>
	  세일여부 :
    <div class="input-group-append" style="width: 25%;">
	    <select name="sale" id="sale" onchange="saleCheck(this)" class="form-control">
		    	<option value="X"  ${vo.sale == "X"  ? "selected" : ""}>X</option>
		    	<option value="O"  ${vo.sale == "O"  ? "selected" : ""}>O</option>
		  </select>
	  </div>
	  <p></p>
	  할인율 :
	  <div class="loginbox-textbox input-group" style="margin: 0 auto;">
       <input type="number" name="salePrice" id="salePrice"  class="form-control" value="${vo.salePrice}" min="0" max="100" style="width: 200px;" readonly/>
    </div>
	  <p></p>
    추가메뉴 :
	  <input class="w3-radio" type="radio" name="subMenu" value="X"  ${vo.subMenu == "X"  ? "checked" : ""}  >
	  <label>없음</label>&nbsp;
	  <input class="w3-radio" type="radio" name="subMenu" value="O"  ${vo.subMenu == "O"  ? "checked" : ""}  >
	  <label>있음</label>
	  <p></p>
	  메뉴 설명 :
	  <textarea rows="6" name="foodInfo" id="foodInfo" class="form-control mb-2" >${fn:replace(vo.foodInfo, newLine, '<br/>')}</textarea>
    <div>
   		<label for="file">메뉴이미지 :</label>
      <input type="file" name="fName" id="fName" class="form-control-file border" accept=".jpg,.gif,.png,.jpeg" required />
      (업로드 가능파일:jpg, jpeg, gif, png)
	  </div>
	  <div class="mb-2 mt-2">
	    <input type="button" value="메뉴 수정" onclick="fCheck()" class="btn btn-primary"/> &nbsp;
	    <input type="reset" value="다시쓰기" class="btn btn-warning"/> &nbsp;
	    <input type="button" value="돌아가기" onclick="location.href='${ctp}/admin/storeMenuList?brandName=${vo.brandName}';" class="btn btn-secondary"/> &nbsp;    
	  </div>
	  <input type="hidden" name="menuIdx" value="${vo.menuIdx}" />
	  <input type="hidden" name="pastPhoto" value="${vo.foodPhoto}" />
	  <input type="hidden" name="pastFoodName" value="${vo.foodName}" />
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

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
		  transition: margin-left .5s;
		  padding: 16px;
		}
		
		/* On smaller screens, where height is less than 450px, change the style of the sidenav (less padding and a smaller font size) */
		@media screen and (max-height: 450px) {
		  .sidebar {padding-top: 15px;}
		  .sidebar a {font-size: 18px;}
		}
		
		.w3-twothird {
			width: 800px;
		}
		a {
			text-decoration: none;
		}
		a:hover {
			text-decoration: underline;
		}
		
</style>
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
	<div class="w3-main" id="main" style="margin-top:43px;">
	
	  <!-- Header -->
	  <header class="w3-container" style="padding-top:22px">
	    <h5><b><i class="fa fa-dashboard"></i> 나의 대쉬보드</b></h5>
	  </header>
	
	  <div class="w3-row-padding w3-margin-bottom">
	    <div class="w3-quarter">
	      <div class="w3-container w3-red w3-padding-16">
	        <div class="w3-left"><i class="fa fa-comment w3-xxxlarge"></i></div>
	        <div class="w3-right">
	          <h4><a href="${ctp}/adRequestList.ad"><i class="fa fa-arrow-right">&nbsp;</i>가입요청대기(${requestMemCnt})</a></h4>
	        </div>
	        <div class="w3-clear"></div>
	        <h3>회원가입요청</h3>
	      </div>
	    </div>
	    <div class="w3-quarter">
	      <div class="w3-container w3-blue w3-padding-16">
	        <div class="w3-left"><i class="fa fa-eye w3-xxxlarge"></i></div>
	        <div class="w3-right">
	          <h4><a href="${ctp}/adProductList.ad"><i class="fa fa-arrow-right">&nbsp;</i>상품수(${totRecCnt})</a></h4>
	        </div>
	        <div class="w3-clear"></div>
	        <h3>상품관리</h3>
	      </div>
	    </div>
	    <div class="w3-quarter">
	      <div class="w3-container w3-teal w3-padding-16">
	        <div class="w3-left"><i class="fa fa-share-alt w3-xxxlarge"></i></div>
	        <div class="w3-right">
	          <h4><a href="${ctp}/adOrderList.ad"><i class="fa fa-arrow-right">&nbsp; </i>요청거래수(${waitOrderCnt})</a></h4>
	        </div>
	        <div class="w3-clear"></div>
	        <h3>약품요청</h3>
	      </div>
	    </div>
	    <div class="w3-quarter">
	      <div class="w3-container w3-orange w3-text-white w3-padding-16">
	        <div class="w3-left"><i class="fa fa-users w3-xxxlarge"></i></div>
	        <div class="w3-right">
	          <h4><a href="${ctp}/adMemList.ad"><i class="fa fa-arrow-right">&nbsp; </i>현재회원수(${totmemCnt})</a>&nbsp;&nbsp;&nbsp;
	          <a href="${ctp}/adMemDeleteList.ad"><font color="red"><i class="fa fa-arrow-right"></i>탈퇴요청(${totmemDelCnt})</font></a></h4>
	        </div>
	        <div class="w3-clear"></div>
	        <h3>회원관리</h3>
	      </div>
	    </div>
	  </div>
	
	  <div class="w3-panel">
	    <div class="w3-row-padding" style="margin:0 -16px">
	      <div class="w3-third">
	        <h5><b><i class="fa fa-dashboard"></i>새로운 문의 <font color="blue" size="5pt"><a href="${ctp}/adBoList.ad">[${waitboardCnt}]</a></font>개가 있습니다!</b></h5>
	        <table class="w3-table w3-striped w3-bordered w3-border w3-hoverable w3-white w3-margin-bottom">
	          <tr class="w3-blue">
	            <th><i class="fa fa-user w3-text-white w3-large"></i>작성자</th>
	            <th>제목</th>
	            <th>문의유형</th>
	            <th>작성날짜</th>
	          </tr>
	          <c:forEach var="vo" items="${vos}" varStatus="st">
	          	<tr>
	          		<td>${vo.mid}</td>
	          		<td>${vo.title}</td>
	          		<td>${vo.part}</td>
	          		<td>
		          		<c:if test="${vo.hour_diff >= 24}">${fn:substring(vo.wDate,0,10)}</c:if>
				          <c:if test="${vo.hour_diff < 24}">	
				    	      ${vo.day_diff > 0 ? fn:substring(vo.wDate,0,16) : fn:substring(vo.wDate,11,19)}
				    	    </c:if>
	          		</td>
	          	</tr>
	          </c:forEach>
	        </table>
	       <button class="w3-button w3-small w3-right w3-blue" onclick="location.href='${ctp}/adBoList.ad';">문의목록 확인하기<i class="fa fa-arrow-right w3-blue"></i></button>
	      </div>
	      <div class="w3-third">
	        <h5><b><i class="fa fa-dashboard"></i>새로운 거래신청 <font color="blue" size="5pt"><a href="${ctp}/adOrderList.ad">[${waitOrderCnt}]</a></font>건이 있습니다!</b></h5>   		
	            <table class="w3-table w3-striped w3-bordered w3-border w3-hoverable w3-white">
					      <tr class="w3-green">
					        <th>지점명</th>
					        <th>신청자명</th>
					        <th>약품명</th>
					        <th>수량</th>
					        <th>요청날짜</th>
					      </tr>
					      <c:forEach var="Ovo" items="${Ovos}" varStatus="sts">
					      <tr>
					        <td>${Ovo.pHosName}</td>
					        <td>${Ovo.pName}</td>
					        <td>${Ovo.pMName}</td>
					        <td>${Ovo.amount}</td>
					        <td>
						        <c:if test="${Ovo.hour_diff > 24}">${fn:substring(Ovo.buyDate,0,10)}</c:if>
					          <c:if test="${Ovo.hour_diff < 24}">	
					    	      ${Ovo.day_diff > 0 ? fn:substring(Ovo.buyDate,0,16) : fn:substring(Ovo.buyDate,11,19)}
					    	    </c:if>
					        </td>
					      </tr>
					      </c:forEach>
					    </table><br>
	    		<button class="w3-button w3-green w3-small w3-right" onclick="location.href='${ctp}/adOrderList.ad';">거래목록 확인하기<i class="fa fa-arrow-right"></i></button>
	      </div>
	      <div class="w3-third">
	        <h5><b><i class="fa fa-dashboard"></i>탈퇴 신청<font color="blue" size="5pt"><a href="${ctp}/adMemDeleteList.ad">[${totmemDelCnt}]</a></font>건이 있습니다!</b></h5>   		
	            <table class="w3-table w3-striped w3-bordered w3-border w3-hoverable w3-white">
					      <tr class="w3-red">
					        <th>지점명</th>
					        <th>신청자명</th>
					        <th>담당업무</th>
					      </tr>
					      <c:forEach var="vo2" items="${vos2}" varStatus="sts">
					      <tr>
					        <td>${vo2.hosName}</td>
					        <td>${vo2.name}</td>
					        <td>${vo2.job}</td>
					      </tr>
					      </c:forEach>
					    </table><br>
	    		<button class="w3-button w3-small w3-right w3-red" onclick="location.href='${ctp}/adMemDeleteList.ad';">탈퇴목록 확인하기<i class="fa fa-arrow-right w3-red"></i></button>
	      </div>
	    </div>
	  </div>
	  <div class="w3-panel">
	    <h5>Countries</h5>
	    <table class="w3-table w3-striped w3-bordered w3-border w3-hoverable w3-white">
	      <tr>
	        <td>United States</td>
	        <td>65%</td>
	      </tr>
	      <tr>
	        <td>UK</td>
	        <td>15.7%</td>
	      </tr>
	      <tr>
	        <td>Russia</td>
	        <td>5.6%</td>
	      </tr>
	      <tr>
	        <td>Spain</td>
	        <td>2.1%</td>
	      </tr>
	      <tr>
	        <td>India</td>
	        <td>1.9%</td>
	      </tr>
	      <tr>
	        <td>France</td>
	        <td>1.5%</td>
	      </tr>
	    </table><br>
	    <button class="w3-button w3-dark-grey">More Countries  <i class="fa fa-arrow-right"></i></button>
	  </div>
	  <hr>
	  <!--   <hr>
	  <div class="w3-container">
	    <h5>General Stats</h5>
	    <p>New Visitors</p>
	    <div class="w3-grey">
	      <div class="w3-container w3-center w3-padding w3-green" style="width:25%">+25%</div>
	    </div>
	
	    <p>New Users</p>
	    <div class="w3-grey">
	      <div class="w3-container w3-center w3-padding w3-orange" style="width:50%">50%</div>
	    </div>
	
	    <p>Bounce Rate</p>
	    <div class="w3-grey">
	      <div class="w3-container w3-center w3-padding w3-red" style="width:75%">75%</div>
	    </div>
	  </div>
	  <hr> -->
	  
	  
	  <br>
<!-- 	  <div class="w3-container w3-dark-grey w3-padding-32">
	    <div class="w3-row">
	      <div class="w3-container w3-third">
	        <h5 class="w3-bottombar w3-border-green">Demographic</h5>
	        <p>Language</p>
	        <p>Country</p>
	        <p>City</p>
	      </div>
	      <div class="w3-container w3-third">
	        <h5 class="w3-bottombar w3-border-red">System</h5>
	        <p>Browser</p>
	        <p>OS</p>
	        <p>More</p>
	      </div>
	      <div class="w3-container w3-third">
	        <h5 class="w3-bottombar w3-border-orange">Target</h5>
	        <p>Users</p>
	        <p>Active</p>
	        <p>Geo</p>
	        <p>Interests</p>
	      </div>
	    </div>
	  </div> -->
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

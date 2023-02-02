<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
    
  </head>
  
  <body class="goto-here">
  	<jsp:include page="/WEB-INF/views/include/nav.jsp"></jsp:include>		
    <div class="container">
	 		<div id="map" style="width:100%;height:500px;"></div>
		
			<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=ac23d1dc8d935cead13bb8f2c930e90f"></script>
			<script>
				
				var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
				    mapOption = { 
				        center: new kakao.maps.LatLng(${mVo.memberLatitude}, ${mVo.memberLongitude}), // 지도의 중심좌표
				        level: 6 // 지도의 확대 레벨
				    };
				
				var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
				
				window.onload=function(){
				    charMarker();
				}
				
				function charMarker() {
			        <c:forEach var="vo" items="${vos}">
			            // 마커를 표시할 위치입니다
			            var position =  new kakao.maps.LatLng(${vo.storeLatitude}, ${vo.storeLongitude});

			            // 마커를 생성합니다
			            var marker = new kakao.maps.Marker({
			                position: position,
			                clickable: true // 마커를 클릭했을 때 지도의 클릭 이벤트가 발생하지 않도록 설정합니다
			            });

			            // 마커를 지도에 표시합니다.
			            marker.setMap(map);

			            // 마커를 클릭했을 때 마커 위에 표시할 인포윈도우를 생성합니다
			            var iwContent = '<div><table>' +
			                    '<tr><th style="width:160px;">가게 이름</th><td style="width:250px;"><a href="${ctp}/store/storeMenu?idx=${vo.idx}">${vo.storeName}</a></td></tr><tr><th>가게 전화번호</th><td>${vo.storeNumber}</td></tr><tr><th>가게 주소</th><td><a>${vo.storeAddress}</a></td></tr></table> </div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
			                iwRemoveable = true; // removeable 속성을 ture 로 설정하면 인포윈도우를 닫을 수 있는 x버튼이 표시됩니다

			            // 인포윈도우를 생성합니다
			            var infowindow = new kakao.maps.InfoWindow({
			                content : iwContent,
			                removable : iwRemoveable
			            });

			            kakao.maps.event.addListener(marker, 'click', function(info, mark) {
			                return function() {
			                    info.open(map, mark);
			                }
			            }(infowindow, marker));
			        </c:forEach>
			    }
				
					
					
				// 아래 코드는 지도 위의 마커를 제거하는 코드입니다
				// marker.setMap(null);    
			</script>
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

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
    
    <script>
    	'use strict';
    	
    	
    	function distanceCheck() {
	    	let distance = document.getElementById("distance").value;
	    	let storePart = document.getElementById("storePart").value;
    		
				location.href="${ctp}/store/shopNear?distance="+distance+"&storePart="+storePart;
				
			}

    	/* function storePartCheck() {
    		
				location.href="${ctp}/store/shopNear?storePart="+storePart;
				
			} */
    	
    	
    
    </script>
    
    
  </head>
  
  <body class="goto-here">
  	<jsp:include page="/WEB-INF/views/include/nav.jsp"></jsp:include>		
    <div class="container">
    <h2 style="text-align: center;">?????? ?????? ??????</h2>
    <div class="loginbox-textbox input-group" style="width: 50%; margin: 0 auto;">
    	<select name="distance" id="distance" onchange="distanceCheck()" class="form-control" >
	    	<option value="" >????????? ???????????????</option>
	    	<option value="1"  ${distance == 1  ? "selected" : ""} >1KM ??????</option>
	    	<option value="3"  ${distance == 3  ? "selected" : ""} >3KM ??????</option>
	    	<option value="5"  ${distance == 5  ? "selected" : ""} >5KM ??????</option>
	    	<option value="10"  ${distance == 10  ? "selected" : ""} >10KM ??????</option>
	    	<option value="20"  ${distance == 20  ? "selected" : ""} >20KM ??????</option>
	    	<option value="50"  ${distance == 50  ? "selected" : ""} >50KM ??????</option>
	    	<option value="100"  ${distance == 100  ? "selected" : ""} >100KM ??????</option>
	    	<option value="1000"  ${distance == 1000  ? "selected" : ""} >??????</option>
		  </select>
		  
    	<select name="storePart" id="storePart" onchange="distanceCheck()"  class="form-control">
		    <option value="">??????????????? ???????????????</option>
	    	<c:forEach var="cVo" items="${Cvos}">
		    	<option value="${cVo.storePart}" ${storePart == cVo.storePart  ? "selected" : ""} >${cVo.storePart}</option>
		    </c:forEach>
		  </select>
	  </div>
		  
	 		<div id="map" style="width:100%; height:500px; margin-top: 10px;"></div>
		
			<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=ac23d1dc8d935cead13bb8f2c930e90f"></script>
			<script>
				
				var mapContainer = document.getElementById('map'), // ????????? ????????? div 
				    mapOption = { 
				        center: new kakao.maps.LatLng(${mVo.memberLatitude}, ${mVo.memberLongitude}), // ????????? ????????????
				        level: 6 // ????????? ?????? ??????
				    };
				
				var map = new kakao.maps.Map(mapContainer, mapOption); // ????????? ???????????????
				
				window.onload=function(){
				    charMarker();
				}
				
				function charMarker() {
	        <c:forEach var="vo" items="${Mvos}">
	        
		      if("${vo.storePart}" == "??????") {
		        var imageSrc = 'https://cdn-icons-png.flaticon.com/512/6679/6679109.png'; // ?????????????????? ??????????????? 
		      }
		      else if("${vo.storePart}" == "??????") {
		        var imageSrc = 'https://cdn-icons-png.flaticon.com/512/1404/1404945.png'; 
		      }
		      else if("${vo.storePart}" == "??????") {
		        var imageSrc = 'https://cdn-icons-png.flaticon.com/512/8269/8269658.png'; 
		      }
		      else if("${vo.storePart}" == "???????????????") {
		        var imageSrc = 'https://cdn-icons-png.flaticon.com/512/1046/1046784.png'; 
		      }
		      else if("${vo.storePart}" == "??????/??????") {
		        var imageSrc = 'https://cdn-icons-png.flaticon.com/512/8740/8740559.png'; 
		      }
		      else if("${vo.storePart}" == "??????") {
		        var imageSrc = 'https://cdn-icons-png.flaticon.com/512/3480/3480720.png'; 
		      }
		      else if("${vo.storePart}" == "??????") {
		        var imageSrc = 'https://cdn-icons-png.flaticon.com/512/3925/3925263.png'; 
		      }
		      else if("${vo.storePart}" == "??????") {
		        var imageSrc = 'https://cdn-icons-png.flaticon.com/512/6609/6609199.png'; 
		      }
		      else if("${vo.storePart}" == "??????") {
		        var imageSrc = 'https://cdn-icons-png.flaticon.com/512/5025/5025158.png'; 
		      }
		     
	        imageSize = new kakao.maps.Size(35, 35), // ?????????????????? ???????????????
	        imageOption = {offset: new kakao.maps.Point(27, 69)}; // ?????????????????? ???????????????. ????????? ????????? ???????????? ????????? ???????????? ????????? ???????????????.
      
          // ????????? ????????? ???????????????
          var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption),
          position =  new kakao.maps.LatLng(${vo.storeLatitude}, ${vo.storeLongitude});

          // ????????? ???????????????
          var marker = new kakao.maps.Marker({
              position: position,
              image: markerImage,
              clickable: true // ????????? ???????????? ??? ????????? ?????? ???????????? ???????????? ????????? ???????????????
          });

          // ????????? ????????? ???????????????.
          marker.setMap(map);

          // ????????? ???????????? ??? ?????? ?????? ????????? ?????????????????? ???????????????
          var iwContent = '<div><table>' +
                  '<tr><th style="width:160px;">?????? ??????</th><td style="width:250px;"><a href="${ctp}/store/storeMenu?idx=${vo.idx}">${vo.storeName}</a></td></tr><tr><th>?????? ????????????</th><td>${vo.storeNumber}</td></tr><tr><th>?????? ??????</th><td><a>${vo.storeAddress}</a></td></tr></table> </div>', // ?????????????????? ????????? ???????????? HTML ??????????????? document element??? ???????????????
              iwRemoveable = true; // removeable ????????? ture ??? ???????????? ?????????????????? ?????? ??? ?????? x????????? ???????????????

          // ?????????????????? ???????????????
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
      
      
      // ??? ?????? ??????
      
      var imageSrc = 'https://cdn-icons-png.flaticon.com/512/2536/2536611.png', // ?????????????????? ???????????????    
      imageSize = new kakao.maps.Size(35, 35), // ?????????????????? ???????????????
      imageOption = {offset: new kakao.maps.Point(27, 69)}; // ?????????????????? ???????????????. ????????? ????????? ???????????? ????????? ???????????? ????????? ???????????????.
        
		  // ????????? ?????????????????? ????????? ?????? ?????????????????? ???????????????
		  var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption),
		      markerPosition = new kakao.maps.LatLng(${mVo.memberLatitude}, ${mVo.memberLongitude}); // ????????? ????????? ???????????????
		
		  // ????????? ???????????????
		  var marker = new kakao.maps.Marker({
		      position: markerPosition, 
		      image: markerImage // ??????????????? ?????? 
		  });
		
		  // ????????? ?????? ?????? ??????????????? ???????????????
		  marker.setMap(map); 
      
      
	    }
				
					
					
				// ?????? ????????? ?????? ?????? ????????? ???????????? ???????????????
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

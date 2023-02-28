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
	<link rel="apple-touch-icon" sizes="180x180" href="${ctp}/vendors/images/apple-touch-icon.png">
	<link rel="icon" type="image/png" sizes="32x32" href="${ctp}/vendors/images/favicon-32x32.png">
	<link rel="icon" type="image/png" sizes="16x16" href="${ctp}/vendors/images/favicon-16x16.png">

	<!-- Mobile Specific Metas -->
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">

	<!-- Google Font -->
	<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
	<!-- CSS -->
	<link rel="stylesheet" type="text/css" href="${ctp}/vendors/styles/core.css">
	<link rel="stylesheet" type="text/css" href="${ctp}/vendors/styles/icon-font.min.css">
	<link rel="stylesheet" type="text/css" href="${ctp}/vendors/styles/style.css">


	<!-- Global site tag (gtag.js) - Google Analytics -->
	<script async src="https://www.googletagmanager.com/gtag/js?id=UA-119386393-1"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
	<script>
		/* window.dataLayer = window.dataLayer || [];
		function gtag(){dataLayer.push(arguments);}
		gtag('js', new Date());

		gtag('config', 'UA-119386393-1'); */
		
		<c:if test="${empty sMid}">location.href="${ctp}/member/memberLogin";</c:if>
		
		// 웹 소켓
		let ws;
		
		 /*  $(document).ready(function(){
			  
			  $.ajax({
				  type : 'post',
				  url : '${ctp}/order/orderChatList',
			  	success:function(vos) {
						let add
			  		
			  	},
			  	error : function() {
			  		alert("전송 오류~~");
			  	}
			  });	
				  
			  }); */
		
	  $(document).ready(function(){
		  
			//채팅 서버 주소
		  /* let url = "ws://localhost:9090/green2209S_18/chatserverDb"; */
		 let url = "ws://49.142.157.251:9090/green2209S_18/chatserverDb"; 
		
		  // 연결하기
		  $('#btnConnect').click(function() {
		  	// 유저명 확인
	     	if ($('#user').val().trim() != '') {
	     		// 연결
	  	   	ws = new WebSocket(url);
	  	   			
	  	   	// 소켓 이벤트 매핑(연결되면 'onopen'메소드가 수행된다.)
	  	   	ws.onopen = function (evt) {
	  	   		console.log('서버 연결 성공');
	  	   		print($('#user').val(), $('#user').val()+'님 입장했습니다.');
	  	   				
	  	   		// 현재 사용자가 입장했다고 서버에게 통지(유저명 전달)
	  	   		// -> 1#유저명
		  			ws.send('1#' + $('#user').val() + '#');
		  			
		  			$('#chatStatus').html('${sMid}님 접속중');
	  	   		
		  			$('#user').attr('readonly', true);
		  			$('#btnConnect').attr('disabled', true);
		  			$('#btnDisconnect').attr('disabled', false);
		  			$('#msg').attr('disabled', false);
		  			$('#msg').focus();
		  		};
	        
		  		// 메세지를 보내면 서버에 다녀온후(getBasicRemote().sendText()에서 보낸 메세지가져옴) onmessage메소드가 실행됨. 서버에서 넘긴값은 'data'변수에 담아오게된다.
	  			ws.onmessage = function (evt) {		// 서버에서 넘어온값이 '2# user명 : 메세지' 라고 한다면...(앞의 ''안의 내용은 data변수에 담겨온다.')
		  			// print('', evt.data);
		  			let index = evt.data.indexOf("#", 2);
		  			//alert("index : " + index);
		  			let no = evt.data.substring(0, 1); // '1'은 최초 접속시 user명, '2'는 메세지 보내는것, '3'은 새로운 user가 접속시..
		  			let user = evt.data.substring(2, index);
		  			
		  			// index값이 -1일 경우는 처음 접속시일 경우이다.
		  			// 메세지가 올경우는 '2#user명:메세지'로 전송되어 온다.
		  			if(index == -1) user = evt.data.substring(evt.data.indexOf("#")+1, evt.data.indexOf(":"));
		  			//alert("user : " + user);
		  			let txt = evt.data.substring(evt.data.indexOf(":")+1);
		  			
		  			//alert("txt : " + txt);
		  	   				
		  			if (no == '1') {		// 처음 접속시에는 'user'명만 들어온다.
		  				print2(user);
		  			} 
		  			else if (no == '2') {	// 접속후부터는 '메세지'를 입력하고 전송할때는 '메세지'와 'user'가 함께 넘어온다.('2user명#메세지')
		  				//alert("txt : " + txt);
		  				if (txt != '') print(user, txt);	// 메세지의 내용이 있을때만 상대방의 채팅창에 출력시키게 한다.
		  			} 
		  			else if (no == '4') {	
		  				//alert("txt : " + txt);
			  			const arr = txt.split("@");
			  			let idx = arr[0];
			  			let mid = arr[1];
			  			let food = arr[2];
			  			let store = arr[3];
			  			let orderPrice = arr[4];
			  			
		  				if (txt != '') print4(idx, mid, food, store, orderPrice);	
					 /* 	if (txt != '') print4(user, txt);	 */
		  			} 
		  			else if (no == '5') {	
		  				
		  				const arr = txt.split("_")
			  			let idx = arr[0];
			  			let riderMid = arr[1];
			  			let time = arr[2];
			  			
		  				if (txt != '') print5(idx, riderMid, time);	
					 /* 	if (txt != '') print4(user, txt);	 */
		  			} 
		  			else if (no == '3') {	// 채팅중 또 다른 사용자가 접속했을때.. '3#user'명  으로 접속된다.
		  				print3(user);
		  			}
		  			$('#list2').scrollTop($('#list2').prop('scrollHeight'));	// 스크롤바 가장 아래쪽으로 내리기
		  		};
	  	   	
		  		// 웹소켓이 종료될때 수행되는 메소드
		  		ws.onclose = function (evt) {
		  			console.log('소켓이 닫힙니다.');
		  		};
	
		  		// 웹소켓 에러시에 수행되는 메소드
		  		ws.onerror = function (evt) {
		  			console.log(evt.data);
		  		};
		  	} else {
		  		alert('유저명을 입력하세요.');
		  		$('#user').focus();
		  	}
		  });
		
		  // 메세지 전송 및 아이디
		  function print(user, txt) {
		  	let temp = '';
		  	if('${sMid}'!=user) {
		  		temp += '<li class="clearfix">';
		  	}
		  	else {
		  		/* temp += '<div style="margin-bottom:3px;" class="text-right ml-5">'; */
		  		temp += '<li class="clearfix admin_chat">';
		  	}
	  		temp += '<div class="chat-body clearfix">';
		  	temp += '<font size="0.9em">[' + user + ']</font> ';
		  	if('${sMid}'!=user) {
	  			temp += '<p>'+txt+'</p>';
		  	}
		  	else {
	  			temp += '<p class="bg-warning">'+txt+'</p>';
		  	}
	  		temp += '<div class="chat_time">' + new Date().toLocaleTimeString() + '</div>';
	  		temp += '</div>';
		  	temp += '</li>';
			  temp = temp.replace(/\n/gi,"<br/>");	// replaceAll함수가 없기에 정규식으로 대체함.
		  	
			  
			  /* const element = document.getElementById("box");
				element.scrollIntoView();	 */
		  	$('#list').append(temp);
				$('#list').scrollTop($('#list').prop('scrollHeight'));	// 스크롤바 가장 아래쪽으로 내리기
		  }
		  
		
		  // 배달 시킨 정보를 채팅창에 입력
		  function print4(idx, mid, food, store, orderPrice) {
		  	let temp = '';
		  		/* temp += '<div style="margin-bottom:3px;" class="text-right ml-5">'; */
	  		temp += '<li class="clearfix">';
	  		temp += '<div class="chat-body clearfix" style="max-width:300px;">';
	  		temp += '<p>';
	  		temp += '주문이 접수되었습니다!<br />';
	  		temp += '배달번호 : '+idx+'<br />';
	  		temp += '주문자 : '+mid+'<br />';
	  		temp += '메뉴명 : '+food+'<br />';
	  		temp += '음식점 : '+store+'<br />';
	  		temp += '금액 : '+orderPrice+'<br />';
	  		temp += '<input type="button" value="배달받기" class="btn btn-success" onclick="riderCheck(\''+idx+'\',\''+mid+'\',\''+store+'\',\''+food+'\')" />';
	  		temp += '</p>';
	  		temp += '<div class="chat_time">' + new Date().toLocaleTimeString() + '</div>';
	  		temp += '</div>';
		  	temp += '</li>';
			  temp = temp.replace(/\n/gi,"<br/>");	// replaceAll함수가 없기에 정규식으로 대체함.
		  	
		  	$('#list').append(temp);
			  $('#list').scrollTop($('#list').prop('scrollHeight'));	// 스크롤바 가장 아래쪽으로 내리기
		  }
		  
		
		  // 배달 접수 받은 배달원의 정보를 뿌림
		  function print5(idx, riderMid, time) {
		  	let temp = '';
		  		/* temp += '<div style="margin-bottom:3px;" class="text-right ml-5">'; */
	  		temp += '<li class="clearfix">';
	  		temp += '<div class="chat-body clearfix" style="max-width:300px;">';
	  		temp += '<p>';
	  		temp += '배달이 접수되었습니다!<br />';
	  		temp += '배달번호 : '+idx+'<br />';
	  		temp += '배달원 : '+riderMid+'<br />';
	  		temp += '예상배달시간 : '+time+'분<br />';
	  		temp += '</p>';
	  		temp += '<div class="chat_time">' + new Date().toLocaleTimeString() + '</div>';
	  		temp += '</div>';
		  	temp += '</li>';
			  temp = temp.replace(/\n/gi,"<br/>");	// replaceAll함수가 없기에 정규식으로 대체함.
		  	
		  	$('#list').append(temp);
			  $('#list').scrollTop($('#list').prop('scrollHeight'));	// 스크롤바 가장 아래쪽으로 내리기
		  }
		  
		  
		  // 다른 client 접속		
		  function print2(user) {
		  	let temp = '';
		  	temp += '<li class="clearfix">';
		  	temp += '<div class="chat-body clearfix" style="max-width:400px;">';
		  	temp += "<p>" + user + "이(가) 접속했습니다.</p>" ;
		  	temp += '<div class="chat_time">' + new Date().toLocaleTimeString() + '</div>';
		  	temp += '</div>';
		  	temp += '</li>';
		  	
		  	$('#list').append(temp);
		  	$('#list').scrollTop($('#list').prop('scrollHeight'));	// 스크롤바 가장 아래쪽으로 내리기
		  }
		
		  // client 접속 종료
		  function print3(user) {
		  	let temp = '';
		  	temp += '<li class="clearfix">';
		  	temp += '<div class="chat-body clearfix" style="max-width:400px;">';
		  	temp += "<p>" + user + "이(가) 종료했습니다.</p>" ;
		  	temp += '<div class="chat_time">' + new Date().toLocaleTimeString() + '</div>';
		  	temp += '</div>';
		  	temp += '</li>';
		  			
		  	$('#list').append(temp);
		  	$('#list').scrollTop($('#list').prop('scrollHeight'));	// 스크롤바 가장 아래쪽으로 내리기
		  }
		  
	
		  // user명 입력후 연결버튼 누를때 수행
		  $('#user').keydown(function() {
		  	if (event.keyCode == 13) {
		  		$('#btnConnect').click();
		  	}
		  });
		  
		  
		  // 메세지 입력후 엔터키를 누를때 수행(Shift Enter키는 다음줄로 이동)
		  $('#msg').keydown(function() {
		  	if (event.keyCode == 13) {
		  		if(!event.shiftKey) {
			  		if($('#msg').val().trim() == '') return false;  // 메세지의 내용이 있을때만 수행시키게 한다.
			  		//서버에게 메시지 전달
			  		//2#유저명#메시지
			  		ws.send('2#' + $('#user').val() + '#' + $(this).val()); //서버에게 'user명'과 '메세지'와 '컬러' 전달
			  		/* print($('#user').val(), $(this).val()); */ //본인 대화창에 'user명'과 '메세지' 출력하기
			  		print($('#user').val(), $(this).val()); //본인 대화창에 'user명'과 '메세지'와 '색상' 출력하기
			  		
			  		event.preventDefault();	// 커서를 원래 위치로 복원하기
			      $('#msg').val('');  		// 메세지창 청소하고 다음메세지를 준비
			  		$('#msg').focus();
			  		$('#list').scrollTop($('#list').prop('scrollHeight'));	// 스크롤바 가장 아래쪽으로 내리기
		  		}
		  	}
		  });
		  		
		  // '종료'버튼 클릭시 수행..
		  $('#btnDisconnect').click(function() {
		  	ws.send('3#' + $('#user').val() + '#');
		  	ws.close();
		  			
		  	$('#user').attr('readonly', false);
		  	
		    $('#user').val('${sMid}');
		  	$('#user').attr('disabled', true);
		  	$('#chatStatus').html('${sMid}님 <font color="red">접속대기</font>상태');
		  			
		  	$('#btnConnect').attr('disabled', false);
		  	$('#btnDisconnect').attr('disabled', true);
		  			
		  	$('#msg').val('');
		  	$('#msg').attr('disabled', true);
		  });
		  
	  });
	  
	  
	  // 주문완료후 호출되는 함수..print1
	  function print1(user, txt) {
	  	let temp = '';
	  	/* 자신이 아닐때 */
	  	if('${sNickName}'!=user) {
	  		temp += '<div style="margin-bottom:3px;margin-right:100px">';
	  	}
	  	/* 자신일때 */
	  	else {
	  		temp += '<div style="margin-bottom:3px;margin-left:100px" class="text-right">';
	  	}
	  	
	  	temp += '<font size="0.9em">[' + user + ']</font> ';
	  	temp += '<span style="font-size:11px;color:#777;">' + new Date().toLocaleTimeString() + '</span><br/>';
	  	if('${sNickName}'!=user) {
	  		temp += '<div style="background-color:#CEF6EC;border:1px solid #fff; border-radius:4px; padding:5px; text-align:left;width:auto;">'+txt+'</div>';
	  	}
	  	else {
	  		temp += '<div style="background-color:#ff0;border:1px solid #ccc;border-radius:4px;padding:5px;text-align:left;width:auto;">'+txt+'</div>';
	  	}
	  	temp += '</div>';
		  temp = temp.replace(/\n/gi,"<br/>");	// replaceAll함수가 없기에 정규식으로 대체함.
	  			
	  	$('#list').append(temp);
	  }
	  
	  // 라이더가 배달미정인 물품 선택하기
	  function riderSelect(idx, product) {
		  $.ajax({
			  type : "post",
			  url  : "${ctp}/webSocket/webSocketDb/riderOk",
			  data : {
				  idx : idx,
				  nickName : '${sNickName}',
				  product : product
				},
			  success:function(user) {
				  if(user == "") {
					  alert("이미 배달선정이 완료되었습니다.");
					  return false;
				  }
				  let temp = user.split("_");
				  user = temp[0];
				  product = temp[1];
				  alert("배달자("+user+") 채택완료!");
				  
				  let chatColor = "#0000FF";
		  		//서버에게 메시지 전달
		  		//2#유저명#메시지
		  		ws.send('2#${sNickName}#배달채택완료:'+product+' 라이더:<b>'+user+'</b>@'); //서버에게 'user명'과 '메세지'와 '컬러' 전달
		  		let msg = '배달채택완료:'+product+' : 라이더:<b>'+user+'</b>';
		  		print1('${sNickName}', msg); //본인 대화창에 'user명'과 '메세지'와 '색상' 출력하기
		  		
		  		$('#list').scrollTop($('#list').prop('scrollHeight'));	// 스크롤바 가장 아래쪽으로 내리기
			  },
			  error : function() {
				  alert("전송오류!");
			  }
		  });
	  }
	  
	  // 현재 배달상황 모달창으로 조회하기
	  function productProgressCheckModal() {
		  let productProgress = $("#productProgress").val();
		  if(productProgress=="") {
			  alert("조회할 배달상황을 선택하세요.");
			  return false;
		  }
		  $.ajax({
			  type : "post",
			  url  : "${ctp}/webSocket/webSocketDb/productProgress",
			  data : {progress : productProgress},
			  async: false,
			  success:function(vos) {
					let temp = '';
	    		temp += '<table class="table table-hover">';
	    		temp += '<tr class="table-dark text-dark text-center">';
	    		temp += '<th>번호</th><th>닉네임</th><th>상품명</th><th>배달상태</th><th>배달자</th><th>주문날짜</th>';
	    		temp += '</tr>';
	    		for(let i=0; i<vos.length; i++) {
		    		/* temp += '<tr onclick="location.href=\'${ctp}/study/mail/mailForm?email=${vos}\';" class="text-center">'; */
		    		temp += '<tr class="text-center">';
		    		temp += '<td>'+(i+1)+'</td>';
		    		temp += '<td>'+vos[i].nickName+'</td>';
		    		temp += '<td>'+vos[i].product+'</td>';
		    		temp += '<td>'+vos[i].progress+'</td>';
		    		temp += '<td>'+vos[i].rider+'</td>';
		    		temp += '<td>'+vos[i].orderDate.substring(0,16)+'</td>';
		    		temp += '</tr>';
	    		}
	    		temp += '</table>';
	    		if(vos.length != 0) {
		    		$("#progress").html(vos[0].progress);
		    		$("#cnt").html(vos.length);
		    		$("#webOrder").html(temp);
					  $("#myModal").show();
					  
					  $("#productStatus").html(temp);
	    		}
	    		else {
					  $("#productStatus").html('<font color="red">검색된 자료가 없습니다.</font>');	    			
	    		}
			  },
			  error: function() {
				  alert("전송오류!");
			  }
  		});
	  }
		
	// 키보드 눌렀을때
	  function msgCheck() {
		  if($('#msg').val().trim() == '') return false;  // 메세지의 내용이 있을때만 수행시키게 한다.
	  		//서버에게 메시지 전달
	  		//2#유저명#메시지
	  		ws.send('2#' + $('#user').val() + '#' + $(this).val()); //서버에게 'user명'과 '메세지'와 '컬러' 전달
	  		/* print($('#user').val(), $(this).val()); */ //본인 대화창에 'user명'과 '메세지' 출력하기
	  		print($('#user').val(), $(this).val()); //본인 대화창에 'user명'과 '메세지'와 '색상' 출력하기
	  		
	  		event.preventDefault();	// 커서를 원래 위치로 복원하기
	      $('#msg').val('');  		// 메세지창 청소하고 다음메세지를 준비
	  		$('#msg').focus();
	  		$('#list').scrollTop($('#list').prop('scrollHeight'));	// 스크롤바 가장 아래쪽으로 내리기
		}
		
		function riderCheck(idx,mid,store,food) {
			let riderMid = '${sMid}';
      let ans = confirm("선택하신 주문을 배달하시겠습니까?");
      if(!ans) return false;
			
			$.ajax({
			  	type   : "post",
			  	url    : "${ctp}/rider/riderOrderCheck",
			  	data   : {
			  		idx : idx,
			  		mid : mid,
			  		store : store,
			  		food : food,
			  		riderMid : riderMid
			  	},
		  		success:function(user) {
			  		if(user == "") {
						  alert("이미 배달선정이 완료된 주문이거나 취소된 주문입니다!");
						  return false;
				  	}
			  		else if(user == "1") {
			  			alert("라이더님이 아직 배달중인 주문이 있습니다!");
						  return false;
			  		}
 					  let temp = user.split("_");
					  idx = temp[0];
					  riderMid = temp[1];
					  time = temp[2];
					  alert("배달자("+riderMid+") 채택완료!");
					  
					  let chatColor = "#0000FF";
			  		//서버에게 메시지 전달
			  		//2#유저명#메시지
			  		ws.send('5#${sMid}#'+user); //서버에게 'user명'과 '메세지'와 '컬러' 전달
			  		let msg = '배달채택완료:'+product+' : 라이더:<b>'+user+'</b>';
			  		print1(riderMid, msg); //본인 대화창에 'user명'과 '메세지'와 '색상' 출력하기
			  		
			  		$('#list').scrollTop($('#list').prop('scrollHeight'));	// 스크롤바 가장 아래쪽으로 내리기 	
			  	},
			  	error : function() {
			  		alert("전송 오류~~");
			  	}
			  });	
		}
	
	
	</script>
</head>
<body>
	<div class="pre-loader">
		<div class="pre-loader-box">
			<div class="loader-logo"><img src="${ctp}/vendors/images/deskapp-logo.svg" alt=""></div>
			<div class='loader-progress' id="progress_div">
				<div class='bar' id='bar1'></div>
			</div>
			<div class='percent' id='percent1'>30%</div>
			<div class="loading-text">
				라이더 로딩중...
			</div>
		</div>
	</div>

	<div class="header">
		<div class="header-left">
			<div class="menu-icon dw dw-menu"></div>
			<div class="search-toggle-icon dw dw-search2" data-toggle="header_search"></div>
			<div class="header-search">
				<form>
					<div class="form-group mb-0">
						<i class="dw dw-search2 search-icon"></i>
						<input type="text" class="form-control search-input" placeholder="Search Here">
						<div class="dropdown">
							<a class="dropdown-toggle no-arrow" href="#" role="button" data-toggle="dropdown">
								<i class="ion-arrow-down-c"></i>
							</a>
							<div class="dropdown-menu dropdown-menu-right">
								<div class="form-group row">
									<label class="col-sm-12 col-md-2 col-form-label">From</label>
									<div class="col-sm-12 col-md-10">
										<input class="form-control form-control-sm form-control-line" type="text">
									</div>
								</div>
								<div class="form-group row">
									<label class="col-sm-12 col-md-2 col-form-label">To</label>
									<div class="col-sm-12 col-md-10">
										<input class="form-control form-control-sm form-control-line" type="text">
									</div>
								</div>
								<div class="form-group row">
									<label class="col-sm-12 col-md-2 col-form-label">Subject</label>
									<div class="col-sm-12 col-md-10">
										<input class="form-control form-control-sm form-control-line" type="text">
									</div>
								</div>
								<div class="text-right">
									<button class="btn btn-primary">Search</button>
								</div>
							</div>
						</div>
					</div>
				</form>
			</div>
		</div>
		<div class="header-right">
			<div class="dashboard-setting user-notification">
				<div class="dropdown">
					<a class="dropdown-toggle no-arrow" href="javascript:;" data-toggle="right-sidebar">
						<i class="dw dw-settings2"></i>
					</a>
				</div>
			</div>
			<div class="user-notification">
				<div class="dropdown">
					<a class="dropdown-toggle no-arrow" href="#" role="button" data-toggle="dropdown">
						<i class="icon-copy dw dw-notification"></i>
						<span class="badge notification-active"></span>
					</a>
					<div class="dropdown-menu dropdown-menu-right">
						<div class="notification-list mx-h-350 customscroll">
							<ul>
								<li>
									<a href="#">
										<img src="${ctp}/vendors/images/img.jpg" alt="">
										<h3>John Doe</h3>
										<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed...</p>
									</a>
								</li>
								<li>
									<a href="#">
										<img src="${ctp}/vendors/images/photo1.jpg" alt="">
										<h3>Lea R. Frith</h3>
										<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed...</p>
									</a>
								</li>
								<li>
									<a href="#">
										<img src="${ctp}/vendors/images/photo2.jpg" alt="">
										<h3>Erik L. Richards</h3>
										<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed...</p>
									</a>
								</li>
								<li>
									<a href="#">
										<img src="${ctp}/vendors/images/photo3.jpg" alt="">
										<h3>John Doe</h3>
										<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed...</p>
									</a>
								</li>
								<li>
									<a href="#">
										<img src="${ctp}/vendors/images/photo4.jpg" alt="">
										<h3>Renee I. Hansen</h3>
										<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed...</p>
									</a>
								</li>
								<li>
									<a href="#">
										<img src="${ctp}/vendors/images/img.jpg" alt="">
										<h3>Vicki M. Coleman</h3>
										<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed...</p>
									</a>
								</li>
							</ul>
						</div>
					</div>
				</div>
			</div>
			<div class="user-info-dropdown">
				<div class="dropdown">
					<a class="dropdown-toggle" href="#" role="button" data-toggle="dropdown">
						<span class="user-icon">
							<img src="${ctp}/vendors/images/photo1.jpg" alt="">
						</span>
						<span class="user-name">Ross C. Lopez</span>
					</a>
					<div class="dropdown-menu dropdown-menu-right dropdown-menu-icon-list">
						<a class="dropdown-item" href="profile.html"><i class="dw dw-user1"></i> Profile</a>
						<a class="dropdown-item" href="profile.html"><i class="dw dw-settings2"></i> Setting</a>
						<a class="dropdown-item" href="faq.html"><i class="dw dw-help"></i> Help</a>
						<a class="dropdown-item" href="login.html"><i class="dw dw-logout"></i> Log Out</a>
					</div>
				</div>
			</div>
			<div class="github-link">
				<a href="https://github.com/dropways/deskapp" target="_blank"><img src="${ctp}/vendors/images/github.svg" alt=""></a>
			</div>
		</div>
	</div>

	<div class="right-sidebar">
		<div class="sidebar-title">
			<h3 class="weight-600 font-16 text-blue">
				Layout Settings
				<span class="btn-block font-weight-400 font-12">User Interface Settings</span>
			</h3>
			<div class="close-sidebar" data-toggle="right-sidebar-close">
				<i class="icon-copy ion-close-round"></i>
			</div>
		</div>
		<div class="right-sidebar-body customscroll">
			<div class="right-sidebar-body-content">
				<h4 class="weight-600 font-18 pb-10">Header Background</h4>
				<div class="sidebar-btn-group pb-30 mb-10">
					<a href="javascript:void(0);" class="btn btn-outline-primary header-white active">White</a>
					<a href="javascript:void(0);" class="btn btn-outline-primary header-dark">Dark</a>
				</div>

				<h4 class="weight-600 font-18 pb-10">Sidebar Background</h4>
				<div class="sidebar-btn-group pb-30 mb-10">
					<a href="javascript:void(0);" class="btn btn-outline-primary sidebar-light ">White</a>
					<a href="javascript:void(0);" class="btn btn-outline-primary sidebar-dark active">Dark</a>
				</div>

				<h4 class="weight-600 font-18 pb-10">Menu Dropdown Icon</h4>
				<div class="sidebar-radio-group pb-10 mb-10">
					<div class="custom-control custom-radio custom-control-inline">
						<input type="radio" id="sidebaricon-1" name="menu-dropdown-icon" class="custom-control-input" value="icon-style-1" checked="">
						<label class="custom-control-label" for="sidebaricon-1"><i class="fa fa-angle-down"></i></label>
					</div>
					<div class="custom-control custom-radio custom-control-inline">
						<input type="radio" id="sidebaricon-2" name="menu-dropdown-icon" class="custom-control-input" value="icon-style-2">
						<label class="custom-control-label" for="sidebaricon-2"><i class="ion-plus-round"></i></label>
					</div>
					<div class="custom-control custom-radio custom-control-inline">
						<input type="radio" id="sidebaricon-3" name="menu-dropdown-icon" class="custom-control-input" value="icon-style-3">
						<label class="custom-control-label" for="sidebaricon-3"><i class="fa fa-angle-double-right"></i></label>
					</div>
				</div>

				<h4 class="weight-600 font-18 pb-10">Menu List Icon</h4>
				<div class="sidebar-radio-group pb-30 mb-10">
					<div class="custom-control custom-radio custom-control-inline">
						<input type="radio" id="sidebariconlist-1" name="menu-list-icon" class="custom-control-input" value="icon-list-style-1" checked="">
						<label class="custom-control-label" for="sidebariconlist-1"><i class="ion-minus-round"></i></label>
					</div>
					<div class="custom-control custom-radio custom-control-inline">
						<input type="radio" id="sidebariconlist-2" name="menu-list-icon" class="custom-control-input" value="icon-list-style-2">
						<label class="custom-control-label" for="sidebariconlist-2"><i class="fa fa-circle-o" aria-hidden="true"></i></label>
					</div>
					<div class="custom-control custom-radio custom-control-inline">
						<input type="radio" id="sidebariconlist-3" name="menu-list-icon" class="custom-control-input" value="icon-list-style-3">
						<label class="custom-control-label" for="sidebariconlist-3"><i class="dw dw-check"></i></label>
					</div>
					<div class="custom-control custom-radio custom-control-inline">
						<input type="radio" id="sidebariconlist-4" name="menu-list-icon" class="custom-control-input" value="icon-list-style-4" checked="">
						<label class="custom-control-label" for="sidebariconlist-4"><i class="icon-copy dw dw-next-2"></i></label>
					</div>
					<div class="custom-control custom-radio custom-control-inline">
						<input type="radio" id="sidebariconlist-5" name="menu-list-icon" class="custom-control-input" value="icon-list-style-5">
						<label class="custom-control-label" for="sidebariconlist-5"><i class="dw dw-fast-forward-1"></i></label>
					</div>
					<div class="custom-control custom-radio custom-control-inline">
						<input type="radio" id="sidebariconlist-6" name="menu-list-icon" class="custom-control-input" value="icon-list-style-6">
						<label class="custom-control-label" for="sidebariconlist-6"><i class="dw dw-next"></i></label>
					</div>
				</div>

				<div class="reset-options pt-30 text-center">
					<button class="btn btn-danger" id="reset-settings">Reset Settings</button>
				</div>
			</div>
		</div>
	</div>

	<!-- ===========사이드바============ -->
		
	<div class="left-side-bar">
		<div class="brand-logo">
			<a href="index.html">
				<img src="${ctp}/vendors/images/deskapp-logo.svg" alt="" class="dark-logo">
				<img src="${ctp}/vendors/images/deskapp-logo-white.svg" alt="" class="light-logo">
			</a>
			<div class="close-sidebar" data-toggle="left-sidebar-close">
				<i class="ion-close-round"></i>
			</div>
		</div>
		<div class="menu-block customscroll">
			<div class="sidebar-menu">
				<ul id="accordion-menu">
					<li>
						<a href="${ctp}/rider/riderMain" class="dropdown-toggle no-arrow">
							<span class="micon dw dw-house-1"></span><span class="mtext">메인으로</span>
						</a>
					</li>
					<li>
						<a href="${ctp}/rider/orderChat" class="dropdown-toggle no-arrow">
							<span class="micon dw dw-motorcycle"></span><span class="mtext">배달신청</span>
						</a>
					</li>
					<li class="dropdown">
						<a href="javascript:;" class="dropdown-toggle">
							<span class="micon dw dw-calendar1"></span><span class="mtext">마이페이지</span>
						</a>
						<ul class="submenu">
							<li><a href="${ctp}/rider/riderUpdate">내 정보 수정</a></li>
							<li><a href="${ctp}/rider/riderPwdUpdate">비밀번호 변경</a></li>
							<li><a href="${ctp}/rider/riderDeliverList">내 배달 기록</a></li>
							<li><a href="${ctp}/rider/riderDelete">라이더 탈퇴</a></li>
						</ul>
					</li>
					
					<li>
						<div class="dropdown-divider"></div>
					</li>
					<li>
						<a href="${ctp}/member/memberLogout" class="dropdown-toggle no-arrow">
							<span class="micon dw dw-house-1"></span><span class="mtext">로그아웃</span>
						</a>
					</li>
				</ul>
			</div>
		</div>
	</div>
	<div class="mobile-menu-overlay"></div>
	
	<!-- =============================================== -->
	
	<div class="main-container">
		<div class="pd-ltr-20 xs-pd-20-10">
			<div class="min-height-200px">
				<div class="page-header">
					<div class="row">
						<div class="col-md-6 col-sm-12">
							<div class="title">
								<h4>배달주문</h4>
							</div>
							<nav aria-label="breadcrumb" role="navigation">
								<ol class="breadcrumb">
									<li class="breadcrumb-item"><a href="index.html">홈</a></li>
									<li class="breadcrumb-item active" aria-current="page">배달주문</li>
								</ol>
							</nav>
						</div>
					</div>
				</div>
				<div class="bg-white border-radius-4 box-shadow mb-30">
					<div class="row no-gutters">
						<div class="col-lg-12 col-md-8 col-sm-12">
							<div class="chat-detail">
								<div class="chat-profile-header clearfix">
									<div class="left">
										<div class="clearfix">
											<div class="chat-profile-name">
												<h3>주문 배달 현황</h3>
												<!-- <span>현재 접속자수()</span> -->
											</div>
										</div>
									</div>
									<div class="right text-right">
										<div>
											<input type="text" name="user" value="${sMid}" style="width:100px;" id="user" class="form-control" readonly />
										  <input type="button" value="연결" id="btnConnect" class="btn btn-success btn-sm "/>
										  <input type="button" value="종료" id="btnDisconnect" class="btn btn-warning btn-sm" disabled />
										</div>
									</div>
								</div>
								
								<div class="chat-box">
									<div class="chat-desc" > <!-- customscroll -->
										<ul id="list" style="overflow: auto; height: 440px;">
											<li id="list2"></li>
										</ul>
										<div id="box"></div>
									</div>
									<div class="chat-footer">
										<div class="file-upload"><a href="#"><i class="fa fa-paperclip"></i></a></div>
										<div class="chat_text_area">
											<textarea name="msg" id="msg" placeholder="메세지를 입력하세요"></textarea>
										</div>
										<div class="chat_send">
											<button class="btn btn-link" onclick="msgCheck()"><i class="icon-copy ion-paper-airplane"></i></button>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="footer-wrap pd-20 mb-20 card-box">
				DeskApp - Bootstrap 4 Admin Template By <a href="https://github.com/dropways" target="_blank">Ankit Hingarajiya</a>
			</div>
		</div>
	</div>
	<!-- js -->
	<script src="${ctp}/vendors/scripts/core.js"></script>
	<script src="${ctp}/vendors/scripts/script.min.js"></script>
	<script src="${ctp}/vendors/scripts/process.js"></script>
	<script src="${ctp}/vendors/scripts/layout-settings.js"></script>
</body>
</html>
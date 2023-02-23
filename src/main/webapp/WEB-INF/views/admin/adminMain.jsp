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

  <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
  <script type="text/javascript">
    google.charts.load('current', {'packages':['bar']});
    google.charts.setOnLoadCallback(drawChart);
    google.charts.setOnLoadCallback(drawChart2);

    function drawChart() {
      var data = google.visualization.arrayToDataTable([
        ['음식명', '판매횟수', { role: 'style' }],
       /*  <c:forEach var="i" begin="0" end="3" varStatus="st">
				  ['${foodName[3-i]}', ${orderCnt[3-i]}],
				</c:forEach> */
        ['${foodName[3]}', ${orderCnt[3]},'red' ],
        ['${foodName[2]}', ${orderCnt[2]},'#b87333' ],
        ['${foodName[1]}', ${orderCnt[1]},'color: #e5e4e2' ],
        ['${foodName[0]}', ${orderCnt[0]},'gold' ]
				
      ]);

      var options = {
        chart: {
          title: '가장 많이 팔린 음식',
          subtitle: '많이 팔린 음식 4종'
        }
      };
      var chart = new google.charts.Bar(document.getElementById('adminChart1'));
      chart.draw(data, google.charts.Bar.convertOptions(options));
    }
    
    
    function drawChart2() {
      var data = google.visualization.arrayToDataTable([
        ['가게명', '판매횟수'],
        <c:forEach var="i" begin="0" end="3" varStatus="st">
				  ['${storeName[3-i]}', ${storeOrderCnt[3-i]}],
				</c:forEach>
      ]);

      var options = {
        chart: {
          title: '가장 많이 판매한 가맹점',
          subtitle: '최고 매출 가게'
        }
      };
      var chart = new google.charts.Bar(document.getElementById('adminChart2'));
      chart.draw(data, google.charts.Bar.convertOptions(options));
    }
    
    /* ================================================= */
    
    
      google.charts.load('current', {'packages':['corechart']});
      google.charts.setOnLoadCallback(drawChart3);

      function drawChart3() {

          var data = google.visualization.arrayToDataTable([
              ['카테고리명', '판매횟수'],
              <c:forEach var="vo" items="${kVos}" varStatus="st">
      				  ['${vo.storePart}', ${vo.cnt}],
      				</c:forEach>
            ]);

        var options = {
          title: '카테고리 판매 분포'
        };

        var chart = new google.visualization.PieChart(document.getElementById('piechart'));

        chart.draw(data, options);
      }
    
    
	</script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/admin/adminNav.jsp"></jsp:include>
	
	<!-- =============================================== -->

	<div class="main-container">
		<div class="pd-ltr-20">
			<div class="card-box pd-20 height-100-p mb-30">
				<div class="row align-items-center">
					<div class="col-md-4">
						<img src="vendors/images/banner-img.png" alt="">
					</div>
					<div class="col-md-8">
						<h4 class="font-20 weight-500 mb-10 text-capitalize">
							환영합니다! <div class="weight-600 font-30 text-blue">관리자님</div>
						</h4>
						<p class="font-18 max-width-600">쓸내용이 없음</p>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-xl-3 mb-30">
					<div class="card-box height-100-p widget-style1">
						<div class="d-flex flex-wrap align-items-center">
							<div class="progress-data">
								<div id="chart"></div>
							</div>
							<div class="widget-data">
								<div class="weight-600 font-14">등록된 총 회원수</div>
								<div class="h4 mb-0">${totMember}명</div>
							</div>
						</div>
					</div>
				</div>
				<div class="col-xl-3 mb-30">
					<div class="card-box height-100-p widget-style1">
						<div class="d-flex flex-wrap align-items-center">
							<div class="progress-data">
								<div id="chart2"></div>
							</div>
							<div class="widget-data">
								<div class="weight-600 font-14">등록된 총 라이더 수</div>
								<div class="h4 mb-0">${totRider}명</div>
							</div>
						</div>
					</div>
				</div>
				<div class="col-xl-3 mb-30">
					<div class="card-box height-100-p widget-style1">
						<div class="d-flex flex-wrap align-items-center">
							<div class="progress-data">
								<div id="chart3"></div>
							</div>
							<div class="widget-data">
								<div class="weight-600 font-14">등록된 총 가게수</div>
								<div class="h4 mb-0">${totStore}개</div>
							</div>
						</div>
					</div>
				</div>
				<div class="col-xl-3 mb-30">
					<div class="card-box height-100-p widget-style1">
						<div class="d-flex flex-wrap align-items-center">
							<div class="progress-data">
								<div id="chart4"></div>
							</div>
							<div class="widget-data">
								<div class="weight-600 font-14">총 거래량</div>
								<div class="h4 mb-0">${totOrder}건</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			
			<div class="row" >
				<div class="col-xl-6 mb-30">
					<div class="bg-white pd-20 card-box mb-30" >
						<h4 class="h4 text-blue">메뉴 순위</h4>
						<div id="adminChart1" style="width: 700px; height: 500px;"></div>
					</div>
				</div>
				<div class="col-xl-6 mb-30">
					<div class="bg-white pd-20 card-box mb-30" >
						<h4 class="h4 text-blue">가게 순위</h4>
						<div id="adminChart2" style="width: 700px; height: 500px;"></div>
					</div>
				</div>
			</div>
			
			<div class="row" >
				<div class="col-xl-6 mb-30">
					<div class="bg-white pd-20 card-box mb-30" >
						<h4 class="h4 text-blue">메뉴 순위</h4>
						<div id="piechart" style="width: 700px; height: 500px;"></div>
					</div>
				</div>
				<div class="col-xl-6 mb-30">
					<div class="bg-white pd-20 card-box mb-30" >
						<h4 class="h4 text-blue">가게 순위</h4>
						<div id="adminChart4" style="width: 700px; height: 500px;"></div>
					</div>
				</div>
			</div>
			
			<div class="row" >
				<div class="col-xl-4 mb-30 bg-white">
					<h2 class="h4 pd-20">이번달 VIP 고객</h2>
					<table class="data-table table nowrap">
						<thead>
							
								<tr>
									<th>순위</th>
									<th class="table-plus datatable-nosort">닉네임</th>
									<th>주문횟수</th>
									<th>총 지출액</th>
								</tr>
							
						</thead>
						<tbody>
							<tr>
								<c:forEach var="vo" items="${VIPMemberVos}" varStatus="st">
									<td>${st.count}</td>
									<td>${vo.nickName}</td>
									<td>${vo.orderCnt}</td>
									<td>${vo.totalProfit}</td>
									<!-- 
									<td>
										<div class="dropdown">
											<a class="btn btn-link font-24 p-0 line-height-1 no-arrow dropdown-toggle" href="#" role="button" data-toggle="dropdown">
												<i class="dw dw-more"></i>
											</a>
											<div class="dropdown-menu dropdown-menu-right dropdown-menu-icon-list">
												<a class="dropdown-item" href="#"><i class="dw dw-eye"></i> View</a>
												<a class="dropdown-item" href="#"><i class="dw dw-edit2"></i> Edit</a>
												<a class="dropdown-item" href="#"><i class="dw dw-delete-3"></i> Delete</a>
											</div>
										</div>
									</td>
									 -->
								</tr>
								</c:forEach>
						</tbody>
					</table>
				</div>
				
				<div class="col-xl-4 mb-30 bg-white">
					<h2 class="h4 pd-20">이번달 최고 지점</h2>
					<table class="data-table table nowrap">
						<thead>
							<tr>
								<th>순위</th>
								<th>지점명</th>
								<th>거래량</th>
								<th>매출액</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="vo" items="${bestStoreVos}" varStatus="st">
								<tr>
									<td>${st.count}등</td>
									<td>${vo.storeName}</td>
									<td>${vo.orderCnt}건</td>
									<td>${vo.totalProfit}원</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
				
				<div class="col-xl-4 mb-30 bg-white">
					<h2 class="h4 pd-20">이번달 베스트 드라이버</h2>
					<table class="data-table table nowrap">
						<thead>
							<tr>
								<th>순위</th>
								<th class="table-plus datatable-nosort">성명</th>
								<th>배달횟수</th>
								<th>총 지출액</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="vo" items="${bestRiderVos}" varStatus="st">
								<tr>
									<td>${st.count}등</td>
									<td>${vo.rider}</td>
									<td>${vo.orderCnt}건</td>
									<td>${vo.totalProfit}원</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
				
			</div>
			<div class="footer-wrap pd-20 mb-20 card-box">
				DeskApp - Bootstrap 4 Admin Template By <a href="https://github.com/dropways" target="_blank">Ankit Hingarajiya</a>
			</div>
		</div>
	</div>
	<!-- js -->
</body>
</html>
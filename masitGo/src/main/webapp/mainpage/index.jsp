<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"    
    import="java.util.*"
    import="vo.*"
    import="database.*"
    %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<fmt:requestEncoding value="utf-8"/>     
<!DOCTYPE html>
<html lang="en">

<head>
  <!-- Required meta tags -->
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <title>맛있GO</title>
  <!-- plugins:css -->
  <link rel="stylesheet" href="${path}/com/vendors/feather/feather.css">
  <link rel="stylesheet" href="${path}/com/vendors/ti-icons/css/themify-icons.css">
  <link rel="stylesheet" href="${path}/com/vendors/css/vendor.bundle.base.css">
  <!-- endinject -->
  <!-- Plugin css for this page -->
  <link rel="stylesheet" href="${path}/com/vendors/datatables.net-bs4/dataTables.bootstrap4.css">
  <link rel="stylesheet" href="${path}/com/vendors/ti-icons/css/themify-icons.css">
  <link rel="stylesheet" type="text/css" href="${path}/com/js/select.dataTables.min.css">
  <!-- End plugin css for this page -->
  <!-- inject:css -->
  <link rel="stylesheet" href="${path}/com/css/vertical-layout-light/style.css">
  <link rel="stylesheet" href="${path}/com/css/vertical-layout-light/custom_style.css">
  <!-- endinject -->
  <link rel="shortcut icon" href="${path}/com/images/favicon.png" />
  <!-- 구글맵 스크립트주소 -->
  <script async src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCNEqzC1ob7IT42fO1ZcvYbqMc0aC_36wU&callback=initMap&libraries=maps,marker&v=beta"></script>
</head>
<style>
    #mpostTable th, #mpostTable td {
        max-width: 150px; /* 셀의 최대 너비, 필요에 따라 조정 */
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
    }
    
    .post-id {
        width: 10%; /* 게시글 번호 칸의 너비를 10%로 설정 */
    }
    .title {
        width: 50%; /* 제목 칸의 너비를 50%로 설정 */
    }
    .likes, .views, .link {
        width: 10%; /* 나머지 칼럼의 너비를 동일하게 설정 */
    }
    
    #map {
        width: 100%; /* 지도 너비 */
        height: 500px; /* 지도 높이, 필요에 따라 조정 */
    }
</style>
<body>
  <div class="container-scroller">
    <!-- 헤더 모듈 -->
	<%@ include file = "/module/header.jsp" %>
    <!-- 바디 partial start-->
    <div class="container-fluid page-body-wrapper">
 
      <!-- partial -->
      <!-- 왼쪽 사이드바 모듈 -->
      <%@ include file = "/module/left_sidebar.jsp" %>

      <!-- partial -->
      <div class="main-panel">
        <div class="content-wrapper">
			<div class="col-md-12 grid-margin">
				<div class="row">
					<div class="col-12 col-xl-8 mb-4 mb-xl-0">
						<ul class="navbar-nav mr-lg-2">
							<li class="nav-item nav-search d-none d-lg-block">
								<div class="input-group">
									<div class="input-group-prepend hover-cursor"
										id="navbar-search-icon">
										<span class="input-group-text" id="search"> <i
											class="icon-search"></i>
										</span>
									</div>
									 <input type="text" class="form-control" id="navbar-search-input" placeholder="회원이 추천하는 맛집 탐색" aria-label="search">
								</div>
							</li>
						</ul>
					</div>
				</div>
			</div>
		
					<div class="row">
						<div class="table-responsive col-md-6">
							<table class="table table-hover center">
								<thead>
									<tr>
										<th class="post-id">게시글 번호</th>
								        <th class="title">제목</th>
								        <th class="likes">좋아요</th>
								        <th class="views">조회수</th>
								        <th class="link">링크</th>
									</tr>
								</thead>
								<tbody id="mpostTable">
									<!-- AJAX로 채울 부분 -->
								</tbody>
							</table>
						</div>
						    <div class="col-md-6">
						        <div id="map" style="height: 500px;"></div>
						    </div>
					</div>
				</div>
        <!-- content-wrapper ends -->
        
        <!-- partial:partials/풋터. 별로 안중요 -->
		<%@ include file = "/module/footer.jsp" %>
        <!-- partial -->
        
      </div>
      <!-- main-panel ends -->
      
    </div>   
    <!-- 바디 partial end (page-body-wrapper ends) -->
    
  </div>
  <!-- container-scroller end-->
<!-- jQuery -->
<script src="${path}/com/jquery-3.6.0.js"></script>
<script type="text/javascript">
var map, marker;

function initMap() {
    map = new google.maps.Map(document.getElementById('map'), {
        center: {lat: 37.566535, lng: 126.97796919999996},
        zoom: 13
    });
}

function showOnMap(lat, lng) {
    var position = new google.maps.LatLng(lat, lng);
    if (!marker) {
        marker = new google.maps.Marker({
            position: position,
            map: map,
            title: 'Selected Location'
        });
    } else {
        marker.setPosition(position);
    }
    map.setCenter(marker.getPosition());
}

// 검색 기능 구현
$("#navbar-search-input").on("keyup", function() {
    var value = $(this).val().toLowerCase();
    $("#mpostTable tr").filter(function() {
        $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
    });
});

$(document).ready(function(){
    $.ajax({
        url: 'z00_main.jsp',
        type: 'GET',
        dataType: 'json',
        success: function(response) {
            console.log(response); // 데이터 확인용
            var tableContent = '';
            $.each(response, function(i, post) {
                tableContent += '<tr onclick="showOnMap(' + post.latitude + ', ' + post.longitude + ')">';
                tableContent += '<td>' + post.post_id + '</td>';
                tableContent += '<td>' + post.title + '</td>';
                tableContent += '<td>' + post.like_cnt + '</td>';
                tableContent += '<td>' + post.views + '</td>';
                tableContent += '<td><a href="${path}/Board_okw/readBoard_Map.jsp?post_id=' + post.post_id + '">Go</a></td>';
                tableContent += '</tr>';
            });
            $('#mpostTable').html(tableContent);
        },
        error: function(xhr, status, error) {
            console.log('Error:', xhr, status, error); // 오류 확인용
            alert('데이터 로드 실패');
        }
    });
});
</script>
  <!-- plugins:js -->
  <script src="${path}/com/vendors/js/vendor.bundle.base.js"></script>
  <!-- endinject -->
  <!-- Plugin js for this page -->
  <script src="${path}/com/vendors/chart.js/Chart.min.js"></script>
  <script src="${path}/com/vendors/datatables.net/jquery.dataTables.js"></script>
  <script src="${path}/com/vendors/datatables.net-bs4/dataTables.bootstrap4.js"></script>
  <script src="${path}/com/js/dataTables.select.min.js"></script>

  <!-- End plugin js for this page -->
  <!-- inject:js -->
  <script src="${path}/com/js/off-canvas.js"></script>
  <script src="${path}/com/js/hoverable-collapse.js"></script>
  <script src="${path}/com/js/template.js"></script>
  <script src="${path}/com/js/settings.js"></script>
  <script src="${path}/com/js/todolist.js"></script>
  <!-- endinject -->
  <!-- Custom js for this page-->
  <script src="${path}/com/js/dashboard.js"></script>
  <script src="${path}/com/js/Chart.roundedBarCharts.js"></script>
 
  <!-- End custom js for this page-->
</body>

</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"    
    import="java.util.*"
    import="vo.*"
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
  <title>맛있GO - 맛집정보공유</title>
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
  
<!-- jQuery -->
<script src="${path}/com/jquery-3.6.0.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		$.ajax({
	        url: "z01_mpostList.jsp", // 서버의 URL을 적어주세요
	        type: "GET", // 또는 POST, 데이터를 가져오는 방식에 따라
	        dataType: "json", // 서버에서 반환되는 데이터 형식
	        success: function(mpostList) {
	            var html = '';
	            $(mpostList).each(function(index, mpost){
	            	html += '<tr data-post-id="' + mpost.post_id + '">';
	                html += '<td>' + mpost.post_id + '</td>';
	                html += '<td>' + mpost.board_name + '</td>';
	                html += '<td>' + mpost.title + '</td>';
	                html += '<td>' + mpost.name + '</td>';
	                html += '<td>' + mpost.post_date + '</td>';
	                html += '<td>' + mpost.like_cnt + '</td>';
	                html += '<td>' + mpost.views + '</td>';
	                html += '</tr>';
	            });
	            $('#mpostList').html(html);
	            
                // DataTables 초기화
                $('.table').DataTable({
                    "paging": true,
                    "searching": true,
                    "ordering": true,
                    "info": true,
                    "autoWidth": false
                });
	        },
	        error: function(error) {
	            console.log("Error:", error);
	        }
	    });
		
		$('#mpostList').on('click', 'tr', function() {
			var postId = $(this).data('post-id');
		    console.log(postId)
		    if(postId) {
		        window.location.href = 'readBoard_Map.jsp?post_id=' + postId;
		    } else {
		        alert("게시글 ID를 찾을 수 없습니다.");
		    }
		});
		
	});
</script>
<style type="text/css">
    .dataTables_wrapper .dataTables_filter input {
        width: 300px !important; /* 너비 변경 */
    }
</style>
</head>
<body>
  <div class="container-scroller">
    <!-- 헤더 모듈 -->
	<%@ include file = "/module/header.jsp" %>
    <!-- 바디 partial start-->
    <div class="container-fluid page-body-wrapper">
    
      <!-- 왼쪽 사이드바 모듈 -->
      <%@ include file = "/module/left_sidebar.jsp" %>

      <!-- partial -->
      <div class="main-panel">
        <div class="content-wrapper">
			<!--  이곳에 코드를 작성해주세요!-->
			<div class="row">
		    <div class="col-lg-12 grid-margin stretch-card">
		        <div class="card">
		            <div class="card-body">
		                <h4 class="card-title">맛집 정보공유 게시판</h4>
		                <div class="table-responsive">
		                    <table class="table table-striped">
		                        <thead>
		                            <tr>
		                                <th>No.</th>
		                                <th>유형</th>
		                                <th>제목</th>
		                                <th>작성자</th>
		                                <th>등록일</th>
		                                <th>추천수</th>
		                                <th>조회수</th>
		                            </tr>
		                        </thead>
		                        <tbody id="mpostList">
		                            <!-- AJAX를 통해 게시글 데이터가 여기에 삽입됩니다 -->
		                        </tbody>
		                    </table>
		                </div>
		            </div>
		        </div>
		    </div>
		</div>
			
        </div>
        <!-- content-wrapper ends -->
        
        <!-- partial:partials/_footer.html -->
		<%@ include file = "/module/footer.jsp" %>
        
      </div>
      <!-- main-panel ends -->
      
    </div>   
    <!-- 바디 partial end (page-body-wrapper ends) -->
    
  </div>
  <!-- container-scroller end-->

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
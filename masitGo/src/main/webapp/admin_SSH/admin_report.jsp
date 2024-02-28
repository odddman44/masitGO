<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"      
    %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<fmt:requestEncoding value="utf-8"/>     
<!DOCTYPE html>
<html lang="en">
<style>
	.lil{
		margin-top: 5%;
		margin-left: 60%;	
	}
</style>
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

<body>
  <div class="container-scroller">
    <!-- 헤더 모듈 -->
	<%@ include file = "/admin_SSH/admin_header.jsp" %>
    <!-- 바디 partial start-->
    <div class="container-fluid page-body-wrapper">
 
      <!-- partial -->
      <!-- 왼쪽 사이드바 모듈 -->
      <%@ include file = "/admin_SSH/admin_sidebar.jsp" %>

      <!-- partial -->
      <div class="main-panel">
        <div class="content-wrapper">
			<div class="col-md-12 grid-margin">
				<div class="row">
					<div class="col-12 col-xl-8 mb-4 mb-xl-0">
						<ul class="navbar-nav mr-lg-2">
							<div class="lil">
							<h2><strong>신고글 관리</strong></h2>	
						</div>
						</ul>
					</div>
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
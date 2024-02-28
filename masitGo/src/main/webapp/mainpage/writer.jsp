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
  <title>맛있GO - 글쓰기</title>
  <!-- plugins:css -->
  <link rel="stylesheet" href="${path}/com/vendors/feather/feather.css">
  <link rel="stylesheet" href="${path}/com/vendors/ti-icons/css/themify-icons.css">
  <link rel="stylesheet" href="${path}/com/vendors/css/vendor.bundle.base.css">
  <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet">
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
  <%
    boolean isLoggedIn = (session.getAttribute("m01") != null);
%>
<!-- jQuery -->
<script src="${path}/com/jquery-3.6.0.js"></script>
<script type="text/javascript">
var isLoggedIn = <%= isLoggedIn %>; // 로그인 상태를 JavaScript 변수로 전달

	$(document).ready(function(){
		if (!isLoggedIn) {
            $('#boardType').attr('disabled', 'disabled'); // 비로그인 상태면 옵션 선택 비활성화
        }
	});
    function handleBoardSelection() {
    	if (!isLoggedIn) {
            alert('로그인이 필요합니다.');
            return;
        }
        var boardType = document.getElementById('boardType').value;
        switch(boardType) {
            case 'general':
                window.location.href = '${path}/UserCommunity_cms/posting.jsp'; // '일반게시판' 페이지로 이동
                break;
            case 'restaurant':
                window.location.href = '${path}/Board_okw/writer_withMap.jsp'; // '맛집 정보공유 게시판' 페이지로 이동
                break;
            default:
                // 기본 동작 또는 아무 것도 하지 않음
        }
    }
</script>  
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
					<select id="boardType" onchange="handleBoardSelection()">
						<option value="">게시판 선택</option>
						<option value="general">일반 게시판</option>
						<option value="restaurant">맛집 정보공유 게시판</option>
					</select>
				</div>
				<!-- content-wrapper ends -->

				<!-- partial:partials/_footer.html -->
				<%@ include file="/module/footer.jsp"%>
				<!-- partial -->

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
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
  <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
  <!-- End custom js for this page-->
</body>

</html>
<%@page import="database.UserDao"%>
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

<!-- jQuery -->
<script type="text/javascript">
	$(document).ready(function(){
	
	});
</script>
</head>
<body>
  <div class="container-scroller">
    <!-- 헤더 모듈 -->
	<%@ include file = "/module/header.jsp" %>
    <!-- 바디 partial start-->
    <div class="container-fluid page-body-wrapper">
 
      <!-- partial -->
      <!-- 왼쪽 사이드바 모듈 -->
      <%@ include file = "left_sidebarMy.jsp" %>

      <!-- partial -->
      <div class="main-panel">
        <div class="content-wrapper">
        	<!-- 원본에 있던 메인부분 내용물입니다.  -->
        	<%--@ include file = "/module/z01_origin.jsp" --%>
			<!--  이곳에 코드를 작성해주세요! 
			(div class="row" 등을 잘 활용하면 이쁘게 구성할 수 있긴 함. 자세한건 샘플 html 참조.) -->
		      <!-- partial -->
      <div class="main-panel">
				<div class="content-wrapper">
					<!-- 원본에 있던 메인부분 내용물입니다.  -->
					<%--@ include file = "/module/z01_origin.jsp" --%>
					<!--  이곳에 코드를 작성해주세요! 
			(div class="row" 등을 잘 활용하면 이쁘게 구성할 수 있긴 함. 자세한건 샘플 html 참조.) -->

					<!-- partial -->
					<div class="main-panel">
						<div class="content-wrapper">
							<!--  이곳에 코드를 작성해주세요!-->
							<div class="row">
								<div class="col-lg-12 grid-margin stretch-card">
									<div class="card">
										<div class="card-body">
											<h4 class="card-title">나의 댓글</h4>
											<div class="table-responsive">
												<table class="table table-striped">
													<thead>
														<tr>
															<th>No.</th>
															<th>작성자</th>
															<th>내용</th>
															<th>등록일</th>
														</tr>
													</thead>
													<tbody id="mpostList">
													<%
													int cnt=1;
													UserDao dao = new UserDao();
													List<Comment> clist=dao.getMycomment(member.getId());
													for(Comment comment:clist){
													%>
														<tr>
															<td><%=cnt++%></td>
															<td><%=comment.getUserId() %></td>
															<td><%=comment.getContent() %></td>
															<td><%=comment.getRegDate() %></td>
														</tr>
														<%} %>
													</tbody>
												</table>
											</div>
										</div>
									</div>
								</div>
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
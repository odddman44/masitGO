<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="database.AdminDao"  
    import="java.util.List"    
    %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<fmt:requestEncoding value="utf-8"/>     
<!DOCTYPE html>
<html lang="en">
<style>
	.lead{
		margin-top: 5%;
		margin-left: 60%;	
	}
</style>
<head>
  <!-- Required meta tags -->
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <title>맛있GO-관리자페이지-회원정보 조회</title>
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
  
</head>

<%
AdminDao dao = new AdminDao();
String id = request.getParameter("id");
String name = request.getParameter("name");
if(id ==null) id="";
if(name == null) name="";
List<Member> mem = dao.schMember(id, name);
request.setAttribute("mem", mem); // JSP에 데이터 전달

%>

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
							<div class="lead">
							<h2><strong>회원정보 조회</strong></h2>	
							<form action="admin_members.jsp" method="get" class="form-inline">
						            <div class="row">
						                <div>
						                    <input type="text" class="form-control mb-2 mr-sm-2" id="id" name="id" placeholder="아이디 입력">
						                </div>
						                <div>
						                    <input type="text" class="form-control mb-2 mr-sm-2" id="name" name="name" placeholder="이름 입력">
						                </div>
						                <div >
						                    <button type="submit" class="btn btn-primary mb-2">검색</button>
						                </div>
						            </div>
						        </form>											        
			                    <table border=1 class="">
				                    <col width="10%">
									<col width="50%">
									<col width="15%">
									<col width="15%">
									<col width="10%">
			                        <thead>
			                            <tr>
			                                <th>이름</th>
			                                <th>아이디</th>
			                                <th>비밀번호</th>
			                                <th>생년월일</th>
			                                <th>이메일</th>
			                                <th>전화번호</th>
			                                <th>권한</th>
			                            </tr>
			                        </thead>
			                        
			                        <tbody>
			                            <!-- jstl 예습 겸 사용해봤음.. -->
									    <c:forEach var="mem" items="${mem}">
									        <tr>
									            <td><c:out value="${mem.name}"/></td>
									            <td><c:out value="${mem.id}"/></td>
									            <td><c:out value="${mem.password}"/></td>
									            <td><c:out value="${mem.birthday}"/></td>
									            <td><c:out value="${mem.email}"/></td>
									            <td><c:out value="${mem.hp}"/></td>
									            <td><c:out value="${mem.auth}"/></td>
									        </tr>
									    </c:forEach>
			                        </tbody>
			                    </table>							
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
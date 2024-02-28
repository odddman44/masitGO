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
			<div class="card">
			<div class="card-body">
	<div class="container mt-5">
    <h2>나의 정보</h2>
	 <!-- Bootstrap CSS -->
      <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	  <style>
	    .container {
	      max-width: 400px;
	    }
	    .profile-image {
	      width: 100px;
	      height: 100px;
	      border-radius: 50%;
	      object-fit: cover;
	    }
	    .card {
	      max-width: 600px;
	      margin: auto; /* 중앙 정렬을 위한 추가 스타일 */
	    }
	    h2 {
	      text-align: center;
	    }
	  </style>
      <div class="form-group">
      <div class="nav-item nav-profile dropdown">
	   <img src="${path}/com/images/faces/face30.png" alt="profile" /><!-- 로그인 이미지 첨부 -->
		</div>
	</div>
    <form class="pt-3" id="signupForm">
      <div class="form-group">
        <label for="inputName">이름</label>
        <input type="text" class="form-control mr-sm-2" name="name" value="<%=member.getName() %>">
      </div>
      <div class="form-group">
        <label for="inputBirthdate">생년월일</label>
        <input type="text" class="form-control mr-sm-2" name="birthday" placeholder="<%=member.getBirthday() %>" readonly>
      </div>
      <div class="form-group">
        <label for="inputUsername">아이디</label>
        <input type="text" class="form-control mr-sm-2" name="id" value="<%=member.getId() %>" readonly>
      </div>
      <div class="form-group">
        <label for="inputUsername">비밀번호</label>
        <input type="text" class="form-control mr-sm-2" name="password" value="<%=member.getPassword() %>">
      </div>
      <div class="form-group">
        <label for="inputEmail">이메일</label>
        <input type="email" class="form-control mr-sm-2" name="email" 
        <%if(member.getEmail()!=null){ %>value="<%=member.getEmail() %>"<%}else{ %>value=""<%} %>>
      </div>
      <div class="form-group">
        <label for="inputPhone">전화번호</label>
        <input type="tel" class="form-control mr-sm-2" name="hp" 
       <%if(member.getHp()!=null){ %>value="<%=member.getHp() %>"<%}else{ %>value=""<%} %>>
      </div>
      <button type="submit" class="btn btn-primary">수정 완료</button>
      <br>
      <br>
      <br>
    </form>
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
 <script type="text/javascript">
	$(document).ready(function(){
	
		$("#signupForm").submit(function(e) {
			 e.preventDefault();// 기본 양식 제출 동작 방지
		      $.ajax({
		        url: "updateMem.jsp",
		        data: $("#signupForm").serialize(),
		        datatype: "text",
		        success: function(rs) {

		        	window.location.href = "mypage.jsp";
		        	
		        },
		        error: function(error) {
		          console.log(error);
		        }
		      });
		    });
		
	});
</script>
  <!-- End custom js for this page-->
</body>

</html>
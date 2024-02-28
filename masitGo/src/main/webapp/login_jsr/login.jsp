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
  <!-- End plugin css for this page -->
  <!-- inject:css -->
  <link rel="stylesheet" href="${path}/com/css/vertical-layout-light/style.css">
  <!-- endinject -->
  <link rel="shortcut icon" href="${path}/com/images/favicon.png" />
</head>
<%
String id = request.getParameter("id");
String password = request.getParameter("password");
if(id != null && password != null){
	UserDao dao = new UserDao();
	Member member = dao.login(id, password);

	if (member != null) {
	    // 로그인 성공
	    session.setAttribute("m01", member);
	    String contextPath = request.getContextPath();
	    out.print("<script>location.href='" + contextPath + "/mainpage/index.jsp';</script>");
	} else {
	    // 로그인 실패
	    out.print("<script>alert('아이디 또는 비밀번호를 확인해주세요.'); location.href='login.jsp';</script>");
	}
}
%>
<body>
  <div class="container-scroller">
    <div class="container-fluid page-body-wrapper full-page-wrapper">
      <div class="content-wrapper d-flex align-items-center auth px-0">
        <div class="row w-100 mx-0">
          <div class="col-lg-4 mx-auto">
            <div class="auth-form-light text-left py-5 px-4 px-sm-5">
              <div class="brand-logo" style="background-color: #003ea8;">
				  <a href="${path}/mainpage/index.jsp">
				    <img src="${path}/com/images/masitGO_long.png" alt="logo">
				  </a>
				</div>
              <h6 class="font-weight-light"></h6>
              <form class="pt-3" id=frm01>
                <div class="form-group">
                  <input type="text" class="form-control mr-sm-2" name="id" placeholder="아이디">
                </div>
                <div class="form-group">
                  <input type="password" class="form-control mr-sm-2" name="password" placeholder="비밀번호">
                </div>
                <div class="mt-3">
                  <button class="btn btn-block btn-primary btn-lg font-weight-medium auth-form-btn" type="submit">로그인</button>
                </div>
                <div class="my-2 d-flex justify-content-between align-items-center">
                  <div class="form-check">
                  </div>
                  <a href="${path}/login_jsr/searchPwd.jsp" class="auth-link text-black">비밀번호를 잊으셨나요?</a>
                </div>
                <div class="text-center mt-4 font-weight-light">
                  회원가입이 필요하신가요? <a href="register.jsp" class="text-primary"> 회원가입</a>
                </div>
              </form>
            </div>
          </div>
        </div>
      </div>
      <!-- content-wrapper ends -->
    </div>
    <!-- page-body-wrapper ends -->
  </div>
  <!-- container-scroller -->
  <!-- plugins:js -->
  <script src="${path}/com/vendors/js/vendor.bundle.base.js"></script>
  <!-- endinject -->
  <!-- Plugin js for this page -->
  <!-- End plugin js for this page -->
  <!-- inject:js -->
  <script src="${path}/com/js/off-canvas.js"></script>
  <script src="${path}/com/js/hoverable-collapse.js"></script>
  <script src="${path}/com/js/template.js"></script>
  <script src="${path}/com/js/settings.js"></script>
  <script src="${path}/com/js/todolist.js"></script>
  <script type="text/javascript">
  
</script>
  <!-- endinject -->
</body>

</html>

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

<body>
  <div class="container-scroller">
    <div class="container-fluid page-body-wrapper full-page-wrapper">
      <div class="content-wrapper d-flex align-items-center auth px-0">
        <div class="row w-100 mx-0">
          <div class="col-lg-4 mx-auto">
            <div class="auth-form-light text-left py-5 px-4 px-sm-5">
              <div class="brand-logo" style="background-color:  #003ea8;">
                <img src="${path}/com/images/masitGO_long.png" alt="logo">
              </div>
              <h6 class="font-weight-light"></h6>
              <form class="pt-3" id="signupForm">
                <div class="form-group">
                  <input type="text" class="form-control mr-sm-2" name="id" placeholder="아이디">
                </div>
                <div class="form-group">
                  <input type="text" class="form-control mr-sm-2" placeholder="이름" name="name">
                </div>
                <div class="mt-3" style="display: flex; width: 100%;">
				    <a class="btn btn-inverse-danger btn-primary btn-lg font-weight-medium" href="${path}/login_jsr/login.jsp" style="flex: 1; margin-right: 5px;">취소</a>
				    <button class="btn btn-primary btn-primary btn-lg font-weight-medium" style="flex: 1; margin-left: 5px;" id="search" type="button">비밀번호 찾기</button>
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
  $(document).ready(function(){
	  $("#search").click(function(){
	  var id = $("#signupForm [name=id]").val()
	  var name = $("#signupForm [name=name]").val()
			if(id!="" && name!=""){
			$.ajax({
				url:"search.jsp",
				data:"id="+id+"&name="+name,
				dataType:"text",
				success:function(rs){
					rs = rs.replace(/\'/g, '\"'); // 작은 따옴표를 큰 따옴표로 바꾸기
			        var jsonData = JSON.parse(rs);
					if(jsonData.searchPwd!=""){
			        alert(id+"의 비밀번호는 ["+jsonData.searchPwd+"]입니다.");
			        window.location.href = "${path}/login_jsr/login.jsp";
					}else{
						alert("존재하지 않는 아이디 또는 이름입니다.")
					}
				},
				error:function(err){
					console.log(err)
				}
			})
			}else if(id === ""){
				alert("아이디를 입력하세요.")
			}else{
				alert("이름을 입력하세요.")
			}
		})
	});
	</script>
  <!-- endinject -->
</body>

</html>

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
                <a href="${path}/mainpage/index.jsp">
				    <img src="${path}/com/images/masitGO_long.png" alt="logo">
				  </a>
              </div>
              <h4>회원가입</h4>
              <h6 class="font-weight-light">*는 필수입력사항입니다.</h6>
              <form class="pt-3" id="signupForm">
                <div class="form-group">
                   <input type="text" class="form-control mr-sm-2" placeholder="*이름" name="name"/>
    				<div id="usernameError" class="error-message"></div>
                </div>
                <div class="form-group">
                  <input type="text" class="form-control mr-sm-2" placeholder="*생년월일(0000-00-00)" name="birthday">
                  <div id="userbirthdayError" class="error-message"></div>
                </div>
                <div class="form-group">
                  <input type="text" class="form-control mr-sm-2" placeholder="*아이디" name="id">
                  <div id="useridError" class="error-message"></div>
                  <button type="button" class="btn btn-block btn-facebook auth-form-btn" id="check">중복확인</button>
					<input type="hidden" name="ckId" value="N"/>                
                </div>
                <div class="form-group">
                  <input type="password" class="form-control mr-sm-2" placeholder="*비밀번호" name="password">
                  <div id="userpasswordError" class="error-message"></div>
                </div>
               
                <div class="form-group">
                  <input type="email" class="form-control mr-sm-2" placeholder="이메일" name="email">
                </div>
                <div class="form-group">
                  <input type="phone" class="form-control mr-sm-2" placeholder="전화번호" name="hp">
                </div>
                <div class="mt-3">
                  <button class="btn btn-block btn-primary btn-lg font-weight-medium auth-form-btn" type="submit">회원가입</button>
                </div>
                <div class="text-center mt-4 font-weight-light">
                  로그인하시겠습니까? <a href="login.jsp" class="text-primary">로그인</a>
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
  <script src="${path}/coms/js/todolist.js"></script>
  <script type="text/javascript">
	$(document).ready(function(){
		$("#check").click(function(){
			var id = $("#signupForm [name=id]").val()
			if(id!=""){
			$.ajax({
				url:"check.jsp",
				data:"id="+id,
				dataType:"json",
				success:function(rs){
					console.log("진행결과")
					//alert(rs.checkId)
					if(rs.checkId){
						alert("이미 등록된 아이디입니다.")
						$("#signupForm [name=id]").val("").focus()
					}else{
						alert("사용 가능한 아이디입니다.")
						$("[name=ckId]").val("Y")
						$("#signupForm [name=id]").attr("readonly",true)
					}
				},
				error:function(err){
					console.log(err)
				}
			})
			}else{
				alert("아이디를 입력하세요.")
			}
		})
	});
</script>
    <script>
    document.getElementById("signupForm").addEventListener("submit", function (event) {
      // 이름 검사
     if($("[name=ckId]").val()!="Y"){
			alert("아이디 중복 체크 하셔야 등록가능합니다.")
			event.preventDefault();
		}
      
      
      var name = document.getElementsByName("name")[0].value;
      if (name.trim() === "") {
          usernameError.innerText = "이름을 입력해주세요.";
          usernameError.style.color = "red"; // 빨간색으로 변경
          event.preventDefault(); // 폼 제출 방지
        } else {
          usernameError.innerText = "";
        }

      // 생년월일 검사
      var birthday = document.getElementsByName("birthday")[0].value;
      if (birthday.trim() === "" || !isValidDate(birthday)) {
          userbirthdayError.innerText = "생일을 올바를 형식으로 입력해주세요.(0000-00-00)";
          userbirthdayError.style.color = "red"; // 빨간색으로 변경
          event.preventDefault(); // 폼 제출 방지
        } else {
          userbirthdayError.innerText = "";
        }

      // 아이디 검사
      var id = document.getElementsByName("id")[0].value;
      if (id.trim() === "") {
          useridError.innerText = "아이디를 입력해주세요.";
          useridError.style.color = "red"; // 빨간색으로 변경
          event.preventDefault(); // 폼 제출 방지
        } else {
          useridError.innerText = "";
        }

      // 비밀번호 검사
      var password = document.getElementsByName("password")[0].value;
      if (password.trim() === "") {
    	  userpasswordError.innerText = "비밀번호를 입력해주세요.";
    	  userpasswordError.style.color = "red"; // 빨간색으로 변경
          event.preventDefault(); // 폼 제출 방지
        } else {
        	userpasswordError.innerText = "";
        }
      if(name.trim() !== "" && birthday.trim() !== "" && id.trim() !== "" 
    		  && password.trim() !== "" && isValidDate(birthday) && $("[name=ckId]").val()!="N"){
      $.ajax({
			url:"insertMem.jsp",
			data:$("#signupForm").serialize(),
			dataType:"json",
			success:function(rs){
				var rcnt = rs.insMember
				if(rcnt>0){
					alert("가입 성공!")
					window.location.href = "${path}/mainpage/login.jsp";	
				}
			},
			error:function(err){
				console.log(err)
			}
		})

      }

    });

    // 생년월일 형식 검사 함수
    function isValidDate(dateString) {
      var regex = /^\d{4}-\d{2}-\d{2}$/;
      return regex.test(dateString);
    }
  </script>
  <!-- endinject -->  
</body>

</html>


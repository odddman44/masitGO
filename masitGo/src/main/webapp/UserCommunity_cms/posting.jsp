<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*" import="vo.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<fmt:requestEncoding value="utf-8" />
<!DOCTYPE html>
<html lang="en">

<head>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>맛있GO</title>
<!-- plugins:css -->


<!-- Google Fonts -->
<link href="https://fonts.gstatic.com" rel="preconnect">
<link
	href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Nunito:300,300i,400,400i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i"
	rel="stylesheet">

<!-- Vendor CSS Files -->


<!-- Template Main CSS File -->
<link rel="stylesheet" href="${path}/com/vendors/feather/feather.css">
<link rel="stylesheet"
	href="${path}/com/vendors/ti-icons/css/themify-icons.css">
<link rel="stylesheet"
	href="${path}/com/vendors/css/vendor.bundle.base.css">
<!-- endinject -->
<!-- Plugin css for this page -->
<link rel="stylesheet"
	href="${path}/com/vendors/datatables.net-bs4/dataTables.bootstrap4.css">
<link rel="stylesheet"
	href="${path}/com/vendors/ti-icons/css/themify-icons.css">
<link rel="stylesheet" type="text/css"
	href="${path}/com/js/select.dataTables.min.css">
<!-- End plugin css for this page -->
<!-- inject:css -->
<link rel="stylesheet"
	href="${path}/com/css/vertical-layout-light/style.css">
<link rel="stylesheet"
	href="${path}/com/css/vertical-layout-light/custom_style.css">
<!-- endinject -->
<link rel="shortcut icon" href="${path}/com/images/favicon.png" />
</head>
<%
	// member session 가져오기
	Member m01 = (Member)session.getAttribute("m01");
	// 로그인한 member session이 존재하면
	 String id = (m01 != null) ? m01.getId() : null; // 로그인한 객체가 없으면 id는 member
	 String jsVariable = (id != null) ? "'" + id + "'" : "null";
%>
<style>
td {
	text-align: center;
}

thead td {
	font-weight: bold
}

.button {
	position: fixed;
	bottom: 100px;
	right: 150px;
	margin: 10px; /* 여유 여백을 주세요 */
}
textarea{
	width:100%;
	height: 800px;
	border: 1px solid lightgray;
	text-align:left;
}
}
</style>
<script src="jquery-3.6.0.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	var id = <%=jsVariable%>; // member session에서 전달 받은 id값
	if(id == null){
		alert("로그인이 필요한 서비스입니다.");
		location.href = "userIndex.jsp"; // 메인 페이지로 이동
	}
	else{
		$("#cancleBtn").click(function(){
			// 취소 버튼 이벤트 처리
			if(confirm("정말로 글쓰기를 중단하시겠습니까?")){
				location.href = "userIndex.jsp";
			}
		});

		$("#regBtn").click(function(){
			// 등록버튼 이벤트
			var title = $("#postForm [name=title]").val(); // 내용값
			$("#postForm [name=id]").val(id); // 아이디값
			console.log($("#postForm [name=id]").val());
			var board = $("#postForm [name=board]").val(); // 게시판 선택값
			console.log("게시판 종류: "+board)
			console.log("제목:"+ title);

			if(title.length > 0 && board != -1 ){
				// 제목도 있고, 게시판도 선택했을 때
				$.ajax({
					// 글쓰기 기능 수행
					url: "z01_insertPost.jsp",
					data: $("#postForm").serialize(),
					dataType: "json",
					success: function(data){
						var isWrite = data.insPost;
						if(isWrite > 0){
							alert("게시글 등록 완료!");
							// 게시글 목록 페이지로 이동
							location.href = "userIndex.jsp";
						}
					},
					error: function(err){
						console.log(err);
					}
				});
			}
			else if(title.length == 0){
				// 제목 입력 안하면
				alert("제목을 입력하십시오.");
			}
			else if(boardType == -1){
				// 게시판 선택 안하면
				alert("게시판을 선택하십시오.");
			}
		});
	}
});
</script>
<%--
	사용자 커뮤니티 글쓰기 jsp
 --%>
<body>
	<div class="container-scroller">
		<!-- 헤더 모듈 -->
		<%@ include file="/module/header.jsp"%>
		<!-- 바디 partial start-->
		<div class="container-fluid page-body-wrapper">
			<!-- 옵션 : UI 컬러 세팅패널 & to-do list & 채팅 (필요하면 주석해제후 쓸것)
			((참고)) to-do List & 채팅의 경우, header에서 주석해제해서 써야할 버튼 있음.->
      <%--@ include file = "/module/optional_setting.jsp" --%>
 
      <!-- partial -->
			<!-- 왼쪽 사이드바 모듈 -->
			<%@ include file="/module/left_sidebar.jsp"%>

			<!-- partial -->
			<div class="main-panel">
				<div class="content-wrapper">
					<div class="container">
						<div class="card">
							<div class="card-body">
									<%-- 사용자 입력 form 시작 --%>
								<form id="postForm" method="post" class="form">
									<div class="col-4 offset-md-8">
										<select name="board" class="form-control form-control-sm"
											id="exampleFormControlSelect1">
											<option value="-1">게시판 선택</option>
											<option value="지역별 커뮤니티(서울)">지역별 커뮤니티(서울)</option>
											<option value="지역별 커뮤니티(경기/인천)">지역별 커뮤니티(경기/인천)</option>
											<option value="지역별 커뮤니티(충청/강원/제주)">지역별 커뮤니티(충청/강원/제주)</option>
											<option value="지역별 커뮤니티(전라/경상)">지역별 커뮤니티(전라/경상)</option>
											<option value="잡담">잡담</option>
										</select>
									</div>
									<br>
									<div class="col-sm-12">
										<input class="form-control" name="file" type="file"
											id="formFile">
									</div>
									<div class="col-sm-12">
										<input type="text" class="form-control" name="title"
											placeholder="제목">
									</div>
									<%-- 게시물 내용 입력 --%>
									<div class="col-sm-12">
									<textarea name="content">
								
									</textarea>
									<input type="hidden" name="id"> <%-- session id값으로 전달할 예정 --%>
									
									</div>
									<div class="col-sm-12 text-right">
										<button class="btn btn-primary" id="regBtn" type="button">등록</button>
										<button class="btn btn-info" id="cancleBtn" type="button">취소</button>
									</div>
								</form>
								<!-- End TinyMCE Editor -->

							</div>
						</div>


					</div>

					<!-- 원본에 있던 메인부분 내용물입니다.  -->
					<%--@ include file = "/module/z01_origin.jsp" --%>


					<!--  이곳에 코드를 작성해주세요! 
			(div class="row" 등을 잘 활용하면 이쁘게 구성할 수 있긴 함. 자세한건 샘플 html 참조.) -->


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
	<script
		src="${path}/com/vendors/datatables.net-bs4/dataTables.bootstrap4.js"></script>
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
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
</style>
<%
	// member session 가져오기
	Member m01 = (Member)session.getAttribute("m01");
	// 로그인한 member session이 존재하면
	 String id = (m01 != null) ? m01.getId() : null; // 로그인한 객체가 없으면 id는 member
	 String jsVariable = (id != null) ? "'" + id + "'" : "null";
%>
<script src="jquery-3.6.0.js"></script>
<script type="text/javascript">
	var id = <%=jsVariable%> // id 가져오기
	// url에서 특정 요소 찾아오는 함수
	function getParameterByName(name) {
	    var url = new URL(window.location.href);
	    return url.searchParams.get(name);
	}
	var board = getParameterByName("board")
	
	$(document).ready(function() {
		
		$("#postBtn").click(function() {
			if(id==null){
				alert("로그인이 필요한 서비스입니다.")
			}else{ // 로그인했으면 글쓰기 페이지로 이동
				location.href = "posting.jsp";
			}
			// 글쓰기 버튼 이벤트
			
		})
		$("#sortSel").change(function(){
			//  정렬방식 선택하기
			// alert("이벤트 발생")
			var value = $(this).val() // 입력된 값 가져오기
			var board = getParameterByName("board")
			if(board==null) board=""
			getPost(board, value)
			console.log(board)
		})
		
		if(board===null){
			console.log(board)
			$("#board_name").text("전체글");
		}else{
			$("#board_name").text(board);
		}
	
	});
	// 글목록 불러오기
	function getPost(board,sort) { // board는 게시판 종류, sort는 정렬방식
		this.board = board;
		console.log(board)
		$.ajax({
			url : "z02_readPost.jsp", // 요청할 jsp
			data : "board="+board+"&sort="+sort, // 보낼 데이터 (현재 요소의 값으로 가정)
			dataType : "json",
			success : function(postList) {
				var postHTML = "";
				$(postList).each(function(idx, post) {
					postHTML += "<tr onclick='detail(" + post.post_id + ")' >";
					postHTML += "<td>" + post.board_name + "</td>";
					postHTML += "<td>" + post.title + "</td>";
					postHTML += "<td>" + post.id + "</td>";
					postHTML += "<td>" + post.post_date + "</td>";
					postHTML += "<td>" + post.views + "</td></tr>";
				});
				var postCont = postList.length

				$("#postList").html(postHTML);
				$("#cnt").text(postCont + "개의 글")
			},
			error : function(err) {
				console.log(err);
			}
		});
	}
	



	
	function detail(post_id) { // 게시판 상세 화면으로 이동
		location.href = "readPost.jsp?post_id=" + post_id;
	}
	getPost(board,"") // 게시글 목록 불러오기 함수 실행
	if(board == null){ // jsp?board=null이면 ""로 설정하기
		board = ""; // board가 ""이면 전체조회
		getPost(board,"") // sort는 기본적으로 최신순으로 설정해놓음
	}

	
</script>
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
						<div class="row">
							<div class="col-4 offset-md-0">
								<h6 id="board_name">전체글</h6>
								<h6 id="cnt">글 갯수</h6>
							</div>
							<div class="col-4 offset-md-8">
								<div class="input-group">
									<input type="text" class="form-control"
										id="navbar-search-input" placeholder="제목 입력"
										aria-label="search" aria-describedby="search">
									<div class="input-group-prepend hover-cursor"
										id="navbar-search-icon">
										<span class="input-group-text" id="search"> <i
											class="icon-search"></i>
										</span>
									</div>
								</div>
							</div>
						</div>
						<br>
						<div class="row">
							<div class="col-4 offset-md-8">
								<select id="sortSel" class="form-control form-control-sm"
									id="exampleFormControlSelect1">
									<option value="0">정렬방식 선택</option>
									<option value="1">최신순</option>
									<option value="2">과거순</option>
								</select>
							</div>
						</div>

						<table class="table table-hover">
							<col width="15%">
							<col width="40%">
							<col width="15%">
							<col width="15%">
							<col width="15%">
							<thead>
								<tr>
									<td>게시판명</td>
									<td>제목</td>
									<td>작성자</td>
									<td>작성일</td>
									<td>조회수</td>
								</tr>
							</thead>
							<tbody id="postList">

							</tbody>
						</table>

						<nav aria-label="Page navigation example">
							<ul class="pagination justify-content-center">
								<li class="page-item disabled"><a class="page-link"
									href="#" tabindex="-1">Previous</a></li>
								<li class="page-item"><a class="page-link" href="#">1</a></li>
								<li class="page-item"><a class="page-link" href="#">2</a></li>
								<li class="page-item"><a class="page-link" href="#">3</a></li>
								<li class="page-item"><a class="page-link" href="#">Next</a>
								</li>
							</ul>
						</nav>


						<button class="btn btn-primary" id="postBtn" type="button">글쓰기</button>
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
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
<link href="assets/css/style.css" rel="stylesheet">
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

hr {
	background: blue;
}

#post {
	background-color: #fff; /* 하얀색 배경으로 설정 */
	padding: 20px; /* 내용과 테두리 간격 설정 */
	margin: 10px; /* 페이지와의 간격 설정 */
	border-radius: 8px; /* 테두리를 둥글게 만듭니다. */
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); /* 그림자 효과 추가 */
}

#profile {
	height: 50px;
	weight: 50px;
}

#comment {
	width: "100%"
}

#like {
	height: 30px;
	width: 30px;
}
</style>
<%
// member session 가져오기
Member m01 = (Member) session.getAttribute("m01");
// 로그인한 member session이 존재하면
String id = (m01 != null) ? m01.getId() : null; // 로그인한 객체가 없으면 id는 member
String jsVariable = (id != null) ? "'" + id + "'" : "null";

Member loggedInUser = (Member) session.getAttribute("m01");
String userId = loggedInUser != null ? loggedInUser.getId() : null;
boolean isLoggedIn = loggedInUser != null; // 로그인 상태 확인
%>
<script
	src="https://developers.google.com/web/ilt/pwa/working-with-the-fetch-api"
	type="text/javascript"></script>
<script src="jquery-3.6.0.js"></script>
<script type="text/javascript">
// URL에서 post_id 파라미터 값을 가져오는 함수
var isLoggedIn = <%= isLoggedIn %>;
var userId = '<%= userId != null ? userId : "" %>';
	var id = <%=jsVariable%>
	var post_id = getParameterByName("post_id"); // url에서 post_id만 가져오기
	 
	function createDeleteButton() {
         var deleteButton = $("<h6>")
             .attr("id", "delete")
             .text("삭제하기")
             .click(function() {
                 // 삭제하기 버튼 클릭 시 처리 로직 추가
                 // 예: confirm 창을 띄워 사용자에게 확인 후 삭제 여부 물어보기
                 var confirmDelete = confirm("정말로 삭제하시겠습니까?");
                 if (confirmDelete) {
                     // 삭제 로직 추가
                     // 예: $.ajax를 사용하여 서버에 삭제 요청 보내기 등
                     	$.ajax({
						url : "z05_deletePost.jsp",
						data : "post_id=" + post_id,
						dataType : "json",
						success : function(isDel) {
							if(isDel.delPost>0){
								 alert("게시글이 정상적으로 삭제되었습니다.");
								 location.href = "userIndex.jsp"
								 
								
							}
						}
					})
                    
                 }
             });

         return deleteButton;
     }
	$(document).ready(

			function() {

				$("#goReport").click( // 신고하기 버튼 누르면

						function(e) {
							if (!id) {
								// id가 존재하면
								alert("로그인이 필요한 서비스입니다.");
								e.preventDefault(); // 기본 이벤트(링크 이동)를 막는다.
							} else {
								if (confirm("해당 게시글을 신고하시겠습니까?")) {

									e.preventDefault(); // 바로 이동하는 것을 막는다.
									var newWindow = window.open(
											"report.jsp?post_id=" + post_id,
											"_blank", "width=600, height=600");

								}
							}
						});
				
				if (post_id){ // 포스트 아이디가 존재하면 post 정보 불러오기

					loadComments(); // 댓글 불러오기
					$.ajax({
						url:"z06_increaseViews.jsp",
						data : "post_id=" + post_id,
						dataType : "json",
						success : function(data){
							console.log("조회수 상승완료!")
						}
						
					})
					
					$.ajax({
						url : "z03_detailPost.jsp",
						data : "post_id=" + post_id,
						dataType : "json",
						success : function(post) {
							$("#board").text(post.board_name);
							$("#writer").text(post.id); 
							  if (id === post.id) { // 작성자의 아이디와 현재 session id가 일치하면
			                        var deleteButton = createDeleteButton(); // delete버튼을 생성한다. 기존에는 그냥 삭제하기 text 상태
			                        $("#delete").replaceWith(deleteButton);
			                    }
							$("#title").text(post.title);
							$("#content").html(post.content);
						}
					})
					$("#writer").click(function(){ // 작성자 아이디 클릭하면
						var writer_id = $(this).text(); // 작성자 id 가져오기
						location.href = "otherPost.jsp?writer_id="+writer_id; // 요청값으로 보내기
						
						
					})
				}
			
<%-- 
		
		--%>
	});
	// url에서 post_id 가져올 때 사용할 함수
	function getParameterByName(name) {
		var url = new URL(window.location.href);
		return url.searchParams.get(name);
	}
	// console.log(getParameterByName("post_id"))
	// 댓글 불러오는 함수 선언
	    function loadComments() {
        var postId = getParameterByName('post_id');
        // 'getComments.jsp'는 댓글 목록을 반환하는 서버 측 JSP 파일입니다.
        $.ajax({
            url: '${path}/Board_okw/z04_getComments.jsp',
            type: 'GET',
            data: { postId: postId },
            success: function(response) {
            	var comments = JSON.parse(response);
                var commentsHtml = '';
                for (var i = 0; i < comments.length; i++) {
                    commentsHtml += "<div class='comment-item'>";
                    commentsHtml += "<p class='comment-author'>" + comments[i].userId + "</p>";
                    commentsHtml += "<p class='comment-content'>" + comments[i].content + "</p>";
                    commentsHtml += "<p class='comment-date'>" + comments[i].regDate + "</p>";
                    commentsHtml += "</div>";
                }
                $('#commentsContainer').html(commentsHtml);
                $('#commentCount').text(comments.length > 0 ? "댓글"+comments[0].totalComments+"개" : "댓글"+0+"개");
            },
            error: function(error) {
                console.error('댓글 로드 실패: ', error);
            }
        });
    }
    function submitComment() {
    	if (!isLoggedIn) {
            alert("로그인이 필요한 기능입니다.");
            return; // 함수 실행 중단
        }
    	
        var postId = getParameterByName('post_id');
        var userId = "<%= userId %>";
        var content = $("#newComment").val();

        // 'addComment.jsp'는 댓글을 데이터베이스에 저장하는 서버 측 JSP 파일입니다.
        $.ajax({
            url: '${path}/Board_okw/z04_addComment.jsp',
            type: 'POST',
            data: {
                postId: postId,
                userId: userId,
                content: content
            },
            success: function(response) {
                if(response.success) {
                    alert("댓글이 성공적으로 등록되었습니다.");
                    $("#newComment").text(''); // 댓글 창 비우기
                    loadComments(); // 댓글 목록 다시 로드
                } else {
                    alert("댓글 등록 실패");
                }
            },
            error: function(error) {
                alert("오류 발생: " + error);
            }
        });
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
							<div class="col-10">
								<h6 id="board">
									<strong>현재 게시판명</strong>
								</h6>
							</div>
							<div class="col-2">
								
								<h6 id="delete">삭제하기</h6>
								<i id="commentCount" class="mdi mdi-message-text-outline">댓글 0</i>

							</div>
						</div>
						<div class="row">
							<div class="col">
								<h6 id="writer">작성자 닉네임</h6>
							</div>
						</div>
						<br>
						<hr>
						<h4 id="title">제목</h4>

						<div class="row" id="post">
							<p id="content">내용</p>
						</div>
						<div class="row">

							<div class="col-6 text-left">
								<i id="like" class="mdi mdi-heart-outline">좋아요</i>
								<%-- 하트 : mdi mdi-heart 비어있는 하트 : mdi mdi-heart-outline--%>
							</div>
							<div class="col-6 text-right">
								<a id="goReport">신고하기</a>
							</div>

						</div>
						<div id="commet">
							<form method="post" class="form">
								<br> <br>
										
										<hr>
										<div class="comment-write-section">
										    <h5>댓글 작성하기</h5>
										    <div class="d-flex justify-content-between">
										        <textarea class="form-control me-2" id="newComment" rows="3" style="width: 70%;" placeholder="댓글을 입력하세요..."></textarea>
										        <button type="button" id="submitCommentBtn" class="btn btn-primary" onclick="submitComment()">작성</button>
										    </div>
										    <h5>댓글</h5>
										<br>
										<hr>
										<br>
										<div id="commentsContainer">
											<!-- 댓글이 여기에 표시됩니다 -->
										</div>
										</div>
							</form>
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
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
  <!-- CKEditor 게시판 스타일시트 -->
  <script src="https://cdn.ckeditor.com/4.16.1/standard/ckeditor.js"></script>

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

<%
    // 세션에서 로그인한 사용자의 정보를 가져옵니다.
    Member loggedInUser = (Member) session.getAttribute("m01");

    String userId = "";
    String authority = "";
    if (loggedInUser != null) {
        // 로그인한 사용자의 ID와 권한을를 가져옵니다.
        userId = loggedInUser.getId();
        authority = loggedInUser.getAuth();
    }
%>

 <!-- jQuery -->
<script src="${path}/com/jquery-3.6.0.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		$("form").on("keypress", function(e){
			if(e.keyCode==13){	// enter키의 keycode는 13
				e.preventDefault() // enter키의 기본 동작을 중단 처리
			}
		})
		var postId = getParameterByName('post_id'); // URL에서 post_id 값 추출
        var userId = "<%= userId %>";
        if (postId) {
            $.ajax({
                url: "z02_mpostDetail.jsp",
                type: "GET",
                data: {post_id: postId},
                dataType: "json",
                success: function(response) {
                    // 서버로부터 받은 데이터로 페이지 요소들을 채웁니다
                    $('#postTitle').val(response.title);
                    $('#postAuthor').text(''+response.name);
                    $('#userRole').text(response.authority);
                    $('#postContent').html(response.content);
                    $('#likeCount').text(response.like_cnt);
                    $('#likeCount2').text(response.like_cnt);
                    $('#viewCount').text(response.views);

                 	// 지도 정보가 있다면 지도를 표시합니다
                    if (response.latitude && response.longitude) {
                        $('#mapContainer').attr('data-lat', response.latitude);
                        $('#mapContainer').attr('data-lng', response.longitude);
                        $('#mapContainer').show(); // 지도 컨테이너를 표시합니다
                        initMap(response.latitude, response.longitude); // 지도 초기화 함수를 호출합니다
                    }
                 	// 글 작성자와 로그인한 사용자가 동일한 경우 수정 및 삭제 버튼 표시
                 	console.log(userId);
                    if(response.id === userId) {
                        $("#editButton").show();
                        $("#deleteButton").show();
                    }
                },
                error: function(xhr, status, error) {
                    console.log("Error occurred: " + error);
                    alert("게시글 정보를 불러오는 데 실패했습니다.");
                }
            });
        } else {
            alert("잘못된 접근입니다.");
            goBack();
        }

	});
	
    
</script>	
</head>
<style>
    .controls {
        width: 300px; /* 검색바 너비 조정 */
        margin-bottom: 10px;
    }
</style>
<body>
  <div class="container-scroller">
    <!-- 헤더 모듈 -->
	<%@ include file = "/module/header.jsp" %>
    <!-- 바디 partial start-->
    <div class="container-fluid page-body-wrapper">
      <!-- partial -->
      <!-- 왼쪽 사이드바 모듈 -->
      <%@ include file = "/module/left_sidebar.jsp" %>
      <!-- partial -->
      <div class="main-panel">
        <div class="content-wrapper">
			<div class="container">
				<div class="card">
					<div class="card-body">
						<form id="postForm"  method="post" class="form" action="PostServlet">
						<!-- 게시판 유형 선택 드롭다운 -->
							<div class="col-sm-12">
							
							</div>
							<br>
							<!-- 작성자 ID 입력 필드 -->
                            <div class="col-sm-12">
                                <input type="text" class="form-control" id="userId" value="<%= userId %>" name="userId" placeholder="작성자 ID" readonly>
                            </div>
                            <br>
							
		                  	<div class="col-sm-12">
								<input type="text" class="form-control" id="postTitle" name="title" placeholder="제목">
							</div>
								<%-- 게시물 내용 입력 --%>
                                <div class="col-sm-12">
                                    <textarea name="content" id="postContent">내용 입력</textarea>
                                </div>
		              			<div class="col-sm-12 text-right">
		              				<button class="btn btn-primary" type="submit">등록</button>
		              				<button class="btn btn-info" type="button">취소</button>
		              			</div>
              			</form>
						<!-- End TinyMCE Editor -->
					</div>
				</div>
			</div>
        </div>
        <!-- content-wrapper ends -->
        
        <!-- partial:partials/_footer.html -->
		<%@ include file = "/module/footer.jsp" %>
        <!-- partial -->
        
      </div>
      <!-- main-panel ends -->
      
    </div>   
    <!-- 바디 partial end (page-body-wrapper ends) -->
    
  </div>
  <!-- container-scroller end-->
  
	<!-- CKEditor 초기화 -->
	<script>
	    CKEDITOR.replace('editor');
	</script>
	


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
	
	<!-- 지도 API 스크립트 -->
  <script async src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCNEqzC1ob7IT42fO1ZcvYbqMc0aC_36wU&callback=initMap&libraries=places"></script>
</body>
</html>
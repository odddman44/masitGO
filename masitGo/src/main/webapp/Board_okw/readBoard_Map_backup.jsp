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
<%
//세션에서 로그인한 사용자의 정보를 가져옵니다.
Member loggedInUser = (Member) session.getAttribute("m01");
String userId = loggedInUser != null ? loggedInUser.getId() : null;
boolean isLoggedIn = loggedInUser != null; // 로그인 상태 확인
%>

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
  
  <!-- 구글맵API -->
  <script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCNEqzC1ob7IT42fO1ZcvYbqMc0aC_36wU"></script>
<!-- jQuery -->
<script src="${path}/com/jquery-3.6.0.js"></script>
<script type="text/javascript">
	// URL에서 post_id 파라미터 값을 가져오는 함수
		var isLoggedIn = <%= isLoggedIn %>;
		var userId = '<%= userId != null ? userId : "" %>';
		var postId;
	$(document).ready(function(){
        var postId = getParameterByName('post_id'); // URL에서 post_id 값 추출
        var userId = "<%= userId %>";
        if (postId) {
        	$.ajax({
                url:"${path}/UserCommunity_cms/z06_increaseViews.jsp",
                data : "post_id=" + postId,
                dataType : "json",
                success : function(data){
                   console.log("조회수 상승완료!")
                }
                
             })
             
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
        loadStarRating(postId); // 별점 로드
        loadComments(); // 페이지 로드 시 댓글 목록 로드 
        
	});
	
	function getParameterByName(name, url = window.location.href) {
	    name = name.replace(/[\[\]]/g, '\\$&');
	    var regex = new RegExp('[?&]' + name + '(=([^&#]*)|&|#|$)'),
	        results = regex.exec(url);
	    if (!results) return null;
	    if (!results[2]) return '';
	    return decodeURIComponent(results[2].replace(/\+/g, ' '));
	}
	
    function goBack() {
        window.history.back();
    }
    function initMap(latitude, longitude) {
        var mapContainer = document.getElementById('mapContainer');
        if (!mapContainer) return;

        var myLatLng = new google.maps.LatLng(latitude, longitude);

        var mapOptions = {
            center: myLatLng,
            zoom: 21,
            mapTypeId: google.maps.MapTypeId.ROADMAP
        };

        var map = new google.maps.Map(mapContainer, mapOptions);

        var marker = new google.maps.Marker({
            position: myLatLng,
            map: map,
            title: '여기입니다!'
        });

        // InfoWindow 생성 및 설정
        var infoWindow = new google.maps.InfoWindow({
            content: '<div><strong>위치 정보</strong><br>Latitude: ' + latitude + '<br>Longitude: ' + longitude + '</div>'
        });

        // 마커 클릭 시 InfoWindow 표시
        marker.addListener('click', function() {
            infoWindow.open(map, marker);
        });

        // 페이지 로드 시 정보창을 바로 표시하려면 다음 코드 주석 해제
        infoWindow.open(map, marker);
    }
    
    function openReportPopup(url) {
    	var postId = getParameterByName('post_id');
        var width = 600; // 팝업 창의 너비
        var height = 800; // 팝업 창의 높이
        var left = (screen.width / 2) - (width / 2);
        var top = (screen.height / 2) - (height / 2);

        window.open(url+postId, 'ReportPopup', 'width=' + width + ',height=' + height + ',top=' + top + ',left=' + left);
    }
    function openRatingPopup(url) {
    	var postId = getParameterByName('post_id');
        var width = 800; // 팝업 창의 너비
        var height = 800; // 팝업 창의 높이
        var left = (screen.width / 2) - (width / 2);
        var top = (screen.height / 2) - (height / 2);

        window.open(url+postId, 'RatingPopup', 'width=' + width + ',height=' + height + ',top=' + top + ',left=' + left);
    }
    
    function loadComments() {
        var postId = getParameterByName('post_id');
        // 'getComments.jsp'는 댓글 목록을 반환하는 서버 측 JSP 파일입니다.
        $.ajax({
            url: 'z04_getComments.jsp',
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
                $('#commentCount').text(comments.length > 0 ? comments[0].totalComments : 0);
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
            url: 'z04_addComment.jsp',
            type: 'POST',
            data: {
                postId: postId,
                userId: userId,
                content: content
            },
            success: function(response) {
                if(response.success) {
                    alert("댓글이 성공적으로 등록되었습니다.");
                    loadComments(); // 댓글 목록 다시 로드
                    $("#newComment").val(''); 
                } else {
                    alert("댓글 등록 실패");
                }
  
            },
            error: function(error) {
                alert("오류 발생: " + error);
            }
        });
    }
    // 좋아요 카운트 
    function increaseLike(postId) {
    	var postId = getParameterByName('post_id');
	    $.ajax({
	        url: 'z05_increaseLike.jsp',
	        type: 'POST',
	        data: { postId: postId },
	        success: function(response) {
	            if(response.success) {
	                // 좋아요 수 갱신
	                var newLikeCount = parseInt($('#likeCount').text()) + 1;
	                $('#likeCount').text(newLikeCount);
	            } else {
	                alert("좋아요 처리에 실패했습니다.");
	            }
	        },
	        error: function(error) {
	            alert("오류 발생: " + error);
	        }
	    });
	}
    function deletePost() {
    	var postId = getParameterByName('post_id');
        if (confirm('정말 삭제하시겠습니까?')) {
            $.ajax({
                url: 'z06_mpostDel.jsp',
                type: 'POST',
                data: { postId: postId },
                success: function(response) {
                    if(response.delCnt > 0) {
                        alert("게시글이 삭제되었습니다.");
                        window.location.href = 'onBoard_Map.jsp'; 
                    } else {
                        alert("게시글 삭제에 실패했습니다.");
                    }
                },
                error: function(error) {
                    alert("오류 발생: " + error.statusText);
                }
            });
        }
    }
    function loadStarRating(postId) {
        $.ajax({
            url: 'z07_ratings.jsp',
            type: 'GET',
            data: { post_id: postId },
            dataType: 'json',
            success: function(response) {
                var avgRating = response.averageRating.toFixed(1); // 소수점 한 자리까지 표시
                $('#starRating').text(avgRating);
            },
            error: function(xhr, status, error) {
                console.error('별점 불러오기 실패: ', error);
            }
        });
    }

</script>
</head>
<body>
  <div class="container-scroller">
    <!-- 헤더 모듈 -->
	<%@ include file = "/module/header.jsp" %>
    <!-- 바디 partial start-->
    <div class="container-fluid page-body-wrapper">
    
      <!-- 왼쪽 사이드바 모듈 -->
      <%@ include file = "/module/left_sidebar.jsp" %>

      <!-- partial -->
			<div class="main-panel">
				<div class="content-wrapper">
					<div class="row">
						<div class="col-lg-12 grid-margin stretch-card">
							<div class="card">
								<div class="card-body">
									<h4 class="card-title">맛집 정보공유 게시판</h4>
										<div class="form-group row">
										    <div class="col-sm-12 d-flex align-items-center justify-content-between">
										        <div class="d-flex align-items-center">
										            <label class="col-form-label me-1">작성자:</label>
										            <span id="postAuthor" class="font-weight-bold">[작성자 이름]</span>
										            <div class="badge bg-secondary ms-1" id="userRole"></div>
										        </div>
										        <div class="post-stats">
										            <span>조회수:</span><span id="viewCount"></span> | 
										            <span>추천수:</span><span id="likeCount2"></span> | 
										            <span>별점:</span><span id="starRating"></span>
										        </div>
										    </div>
										</div>
									<form>
										<div class="form-group">
											<label for="postTitle">제목</label> <input type="text"
												class="form-control" id="postTitle" readonly>
										</div>
										<div id="mapContainer"
											style="width: 100%; height: 400px; display: none;">
											<!-- 지도를 표시할 영역 -->
										</div>
										<div class="form-group">
										    <label for="postContent">내용</label>
										    <div id="postContent" class="form-control" style="height:auto;"></div>
										</div>
										<div class="d-flex justify-content-between">
											<div>
												<button type="button" class="btn btn-outline-primary" onclick="increaseLike(postId)">
												    <i class="ti-heart"></i> 좋아요 <span id="likeCount"></span>
												</button>
												<button type="button" class="btn btn-outline-secondary">
													<i class="ti-comment"></i> 댓글 <span id="commentCount"></span>
												</button>
											</div>
											<div>
												<button type="button" class="btn btn-outline-success"
													onclick="openRatingPopup('${path}/UserCommunity_cms/rating.jsp?post_id=');">
													<i class="ti-star"></i> 별점 주기
												</button>
												<a href="#"
													onclick="openReportPopup('${path}/UserCommunity_cms/report.jsp?post_id=');"
													class="link">신고</a>
												<button id="editButton" class="btn btn-success" style="display: none;">수정</button>
												<button id="deleteButton" class="btn btn-danger" style="display: none;" onclick="deletePost()">삭제</button>
											</div>
										</div>
										<div class="mt-3">
											<button type="button" class="btn btn-primary"
												onclick="goBack()">게시글 목록으로</button>
										</div>
										<br> <br>
										<h5>댓글</h5>
										<br>
										<div id="commentsContainer">
											<!-- 댓글이 여기에 표시됩니다 -->
										</div>
										<hr>
										<div class="comment-write-section">
										    <h5>댓글 작성하기</h5>
										    <div class="d-flex justify-content-between">
										        <textarea class="form-control me-2" id="newComment" rows="3" style="width: 70%;" placeholder="댓글을 입력하세요..."></textarea>
										        <button type="button" id="submitCommentBtn" class="btn btn-primary" onclick="submitComment()">작성</button>
										    </div>
										</div>
									</form>
								</div>
							</div>
						</div>
					</div>
				</div>
				<!-- content-wrapper ends -->

				<!-- partial:partials/_footer.html -->
				<%@ include file="/module/footer.jsp"%>

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
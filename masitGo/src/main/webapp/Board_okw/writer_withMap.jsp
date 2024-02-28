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

		$("#postForm").submit(function(event) {
	           event.preventDefault();

	           var formData = {
	        	        "userId": $("#userId").val(), // 현재 로그인 된 유저아이디
	        	        "title": $("#formtitle").val(),
	        	        "content": CKEDITOR.instances.editor.getData(),
	        	        "board_name": $("#board_name").val(),
	        	        "latitude": $("#latitude").val(),
	        	        "longitude": $("#longitude").val()
	           };
	           $.ajax({
	               type: "POST",
	               url: "z03_mpostInsert.jsp",
	               data: formData,
	               dataType: "json",
	               success: function(response) {
	                   alert("게시글이 성공적으로 등록되었습니다.");
	                   window.location.href = '${path}/Board_okw/onBoard_Map.jsp'
	               },
	               error: function(xhr, status, error) {
	                   alert("게시글 등록에 실패했습니다.");
	               }
	            });
	        });
        // 'board_name'이 변경될 때 실행되는 함수
        $("#board_name").change(function() {
            var selectedOption = $(this).val();
            // '공지'가 선택되면 지도를 숨깁니다.
            if(selectedOption === "공지") {
                $("#map").hide();
            } else {
                $("#map").show();
            }
        });

        // 페이지 로딩 시 초기 설정
        $("#board_name").trigger('change');
	});
	
	function initMap() {
	    var mapElement = document.getElementById('map');
	    if (mapElement) {
	        var map = new google.maps.Map(mapElement, {
	            center: {lat: 37.499272, lng: 127.033142},
	            zoom: 18
	        });

	    var input = document.getElementById('map-search'); // 사용자 정의 검색바
	    var searchBox = new google.maps.places.SearchBox(input);
	    map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);

	    // 지도의 뷰포트가 변경될 때 검색 결과 업데이트
	    map.addListener('bounds_changed', function() {
	        searchBox.setBounds(map.getBounds());
	    });

	    var markers = [];
	    // 검색바 이벤트 리스너
	    searchBox.addListener('places_changed', function() {
	        var places = searchBox.getPlaces();

	        if (places.length == 0) {
	            return;
	        }

	        // 기존 마커 삭제
	        markers.forEach(function(marker) {
	            marker.setMap(null);
	        });
	        markers = [];

	        // 검색 결과로 지도 이동 및 마커 추가
	        var bounds = new google.maps.LatLngBounds();
	        places.forEach(function(place) {
	            if (!place.geometry) {
	                console.log("Returned place contains no geometry");
	                return;
	            }
	            var icon = {
	                url: place.icon,
	                size: new google.maps.Size(71, 71),
	                origin: new google.maps.Point(0, 0),
	                anchor: new google.maps.Point(17, 34),
	                scaledSize: new google.maps.Size(25, 25)
	            };

	         	// 마커 생성 및 위치 변경 리스너 추가
	            var marker = new google.maps.Marker({
	                map: map,
	                icon: icon,
	                title: place.name,
	                position: place.geometry.location,
	                draggable: true // 마커를 드래그 가능하게 설정
	            });
	         	
	            // 폼 필드에 초기 위치 설정
	            document.getElementById('latitude').value = place.geometry.location.lat();
	            document.getElementById('longitude').value = place.geometry.location.lng();
	         
	            // 마커에 대한 정보 창 생성
	            var infowindow = new google.maps.InfoWindow({
	                content: '<div><strong>' + place.name + '</strong><br>' +
	                         '주소: ' + (place.formatted_address || '주소 정보 없음') + '</div>'
	            });

	            // 마커 클릭 시 정보 창 표시
	            marker.addListener('click', function() {
	                infowindow.open(map, marker);
	            });
	            
	            // 마커 위치 변경 리스너
	            google.maps.event.addListener(marker, 'position_changed', function() {
	                document.getElementById('latitude').value = marker.getPosition().lat();
	                document.getElementById('longitude').value = marker.getPosition().lng();
	            });

	            markers.push(marker);
	            if (place.geometry.viewport) {
	                bounds.union(place.geometry.viewport);
	            } else {
	                bounds.extend(place.geometry.location);
	            }
	        });
	        map.fitBounds(bounds);
	    });
	    
	    }else {
	    	console.error('Map element not found');
	    }
	}
	
	/* 파일 업로드 스크립트 */
	function previewImage(input) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();
            reader.onload = function(e) {
                $('#imagePreview').attr('src', e.target.result);
                $('#imagePreview').show();
                $('#uploadButton').show(); // 업로드 버튼 표시
            };
            reader.readAsDataURL(input.files[0]);
        }
    }

    function uploadImage() {
        // 이미지 업로드 로직을 여기에 구현
        alert("이미지가 업로드되었습니다.");
        // 필요한 경우 form을 제출하거나 AJAX 요청을 수행
    }

    function cancelImage() {
        $('#formFile').val(''); // 파일 입력 필드 초기화
        $('#imagePreview').hide(); // 이미지 미리보기 숨기기
        $('#uploadButton').hide(); // 업로드 버튼 숨기기
    }

    $(document).ready(function() {
        $('#uploadButton').hide(); // 페이지 로드 시 업로드 버튼 숨기기
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
							    <select class="form-control" id="board_name" name="board_name">
							        <option value="맛집정보공유">맛집정보공유</option>
							        <%-- 'admin' 사용자만 '공지' 옵션을 볼 수 있습니다. --%>
                                    <% if(authority != null && authority.equals("admin")) { %>
							            <option value="공지">공지</option>
							        <% } %>
							    </select>
							</div>
							<br>
							<!-- 작성자 ID 입력 필드 -->
                            <div class="col-sm-12">
                                <input type="text" class="form-control" id="userId" value="<%= userId %>" name="userId" placeholder="작성자 ID" readonly>
                            </div>
                            <br>
                            
                            <!-- 파일업로드 필드 -->
		                  	<div class="col-sm-12">
							    <input class="form-control" name="file" type="file" id="formFile" onchange="previewImage(this);">
							</div>

							
		                  	<div class="col-sm-12">
								<input type="text" class="form-control" id="formtitle" name="title" placeholder="제목">
							</div>
								<!-- 구글 지도 컨테이너 -->
							    <div class="col-sm-12">
									<input id="map-search" class="controls" type="text" placeholder="장소 검색">
							        <div id="map" style="height: 400px;"></div>
							    </div>
							    <!-- 위치 데이터를 위한 숨겨진 입력 필드 -->
							    <input type="hidden" name="latitude" id="latitude">
							    <input type="hidden" name="longitude" id="longitude">
							    
								<%-- 게시물 내용 입력 --%>
                                <div class="col-sm-12">
                                    <textarea name="content" id="editor">내용 입력</textarea>
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